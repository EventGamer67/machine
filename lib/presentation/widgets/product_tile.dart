import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:machine/presentation/logic/products_provider.dart';

class ProductTile extends StatelessWidget {
  final Product product;
  const ProductTile({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.grey.withOpacity(0.1),
      ),
      child: Stack(
        children: [
          Align(
              alignment: Alignment.bottomRight,
              child: Text("${product.price}₽",
                  style: const TextStyle(color: Colors.black, fontSize: 28))),
          Column(
            children: [
              Expanded(
                flex: 4,
                child: Container(
                  alignment: Alignment.center,
                  child: CachedNetworkImage(
                      alignment: Alignment.center,
                      fit: BoxFit.scaleDown,
                      imageUrl: product.url),
                ),
              ),
              Expanded(
                flex: 3,
                child: Column(
                  children: [
                    Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          product.name,
                          style: const TextStyle(
                              color: Colors.black, fontSize: 28),
                        )),
                    Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          product.desc,
                          style: const TextStyle(
                              color: Colors.black, fontSize: 16),
                          maxLines: 1,
                        )),
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
