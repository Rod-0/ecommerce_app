import 'package:ecommerce_app/models/product.dart';
import 'package:ecommerce_app/repositories/products_repository.dart';
import 'package:ecommerce_app/widgets/products_detail.dart';
import 'package:flutter/material.dart';

class ProductList extends StatefulWidget {
  const ProductList({super.key, required this.products});
  final List products;

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        gridDelegate:const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.7,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10
        ),
        itemCount: widget.products.length,
        itemBuilder: (context, index) {
          return ProductItem(product: widget.products[index]);
        });
  }
}

class ProductItem extends StatefulWidget {
  const ProductItem({super.key, required this.product});
  final Product product;

  @override
  State<ProductItem> createState() => _ProductItemState();
}

class _ProductItemState extends State<ProductItem> {
  bool isFavorite = false;
  

  @override
  void initState() {
    initialize();
    super.initState();
  }

  initialize() async {
    isFavorite = await ProductsRepository().isFavorite(widget.product);
    if (mounted) {
      setState(() {
        isFavorite = isFavorite;
      });
    }
    
  }



  @override
  Widget build(BuildContext context) {
    final icon =
        Icon(Icons.favorite, color: isFavorite ? Colors.red : Colors.grey);
    final products = widget.product;

    return GestureDetector(
      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context)=> ProductsDetail(id: products.id))),
      child: Column(children: [
        SizedBox(
          height: 250,
          child: Stack(children: [
            
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                color: Colors.black.withOpacity(0.8),
                padding: const EdgeInsets.all(3),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        widget.product.name,
                        style: const TextStyle(
                          fontSize: 15,
                          color: Colors.white,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    IconButton(
                      onPressed: () async {
                        setState(() {
                          isFavorite = !isFavorite;
                        });
                        isFavorite
                            ? ProductsRepository().insert(products)
                            : ProductsRepository().delete(products);
                      },
                      icon: icon,
                    )
                  ],
                ),
              ),
            )
          ]),
        )
      ]),
    );
  }
}
