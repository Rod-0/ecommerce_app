import 'package:ecommerce_app/models/product.dart';
import 'package:ecommerce_app/services/product_service.dart';
import 'package:flutter/material.dart';

class ProductsDetail extends StatefulWidget {
  const ProductsDetail({super.key, required this.id});
  final int id;

  @override
  State<ProductsDetail> createState() => _ProductsDetailState();
}

class _ProductsDetailState extends State<ProductsDetail> {
  ProductService? _productService;
  ProductsInfo? _productInfo;

  @override
  void initState() {
    _productService = ProductService();
    initialize();
    super.initState();
  }

  Future initialize() async {
    _productInfo = await _productService!.getById(widget.id);
    setState(() {
      _productInfo = _productInfo;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Product Detail')),
      body: Center(
          child: Column(children: [
        Text(_productInfo?.name ?? ''),
        Text(_productInfo?.category ?? ''),
        Text(_productInfo?.currentPrice.toString() ?? ''),
        //size
        Column(
          children: _productInfo?.size
                  .map((e) => Text(e))
                  .toList()
                  .cast<Widget>() ??
              [],
        ),
        
        //type
        Text(_productInfo?.type ?? ''),
        //availabecolors
        Text(_productInfo?.availableColors.toString() ?? ''),
      ])),
    );
  }
}
