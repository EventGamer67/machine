
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:machine/presentation/logic/products_provider.dart';

class ProductTile extends StatelessWidget {
  final Product product;
  const ProductTile({
    super.key,
    required this.product
  });

  @override
  Widget build(BuildContext context) {
    
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.grey.withOpacity(0.1),),
      child: Column(
        children: [
          Container(
            width: 190,
            height: 190,
            alignment: Alignment.center,
            child: CachedNetworkImage(
                alignment: Alignment.center,
                fit: BoxFit.scaleDown,
                imageUrl:
                    product.url),
          ),
           Align(alignment: Alignment.centerLeft,child: Text(product.name, style: const TextStyle(color: Colors.white, fontSize: 30 ),  )),
           Align(alignment: Alignment.centerLeft,child: Text(product.desc, style: const TextStyle(color: Colors.white, fontSize: 16 ), maxLines: 1,  )),
          const Expanded(child: SizedBox()),
           Align(alignment: Alignment.bottomRight,child: Text("${product.price}₽", style: const TextStyle(color: Colors.white, fontSize: 30 )))
        ],
      ),
    );
  }
}
