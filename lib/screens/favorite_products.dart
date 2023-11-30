import 'package:ecommerce_app/models/product.dart';
import 'package:ecommerce_app/repositories/products_repository.dart';
import 'package:ecommerce_app/widgets/products_detail.dart';
import 'package:flutter/material.dart';

class FavoriteProducts extends StatefulWidget {
  const FavoriteProducts({super.key});

  @override
  State<FavoriteProducts> createState() => _FavoriteProductsState();
}

class _FavoriteProductsState extends State<FavoriteProducts> {
  ProductsRepository? _productsRepository;
  List<Product>? _favoriteProducts = [];

  @override
  void initState() {
    _productsRepository = ProductsRepository();
    initialize();
    super.initState();
  }

  initialize() async {
    _favoriteProducts = await _productsRepository?.getAll() ?? [];
    setState(() {
      _favoriteProducts = _favoriteProducts;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(itemCount: _favoriteProducts?.length ?? 0 ,itemBuilder: ((context,index){
        return GestureDetector(
          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context)=> ProductsDetail(id: _favoriteProducts?[index].id ?? 1))),
          child: ListTile(
            title: Text(_favoriteProducts?[index].name ?? ""),
          
            trailing: IconButton(onPressed: () async{
              await _productsRepository?.delete(_favoriteProducts![index]);
              initialize();
            }, icon: const Icon(Icons.delete)),
          ),
        );
      })),
    );
  }
}