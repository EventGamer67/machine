import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_page_view_indicator/flutter_page_view_indicator.dart';
import 'package:machine/presentation/colors.dart';
import 'package:machine/presentation/fonts.dart';
import 'package:machine/presentation/logic/products_provider.dart';
import 'package:machine/presentation/shared/blur.dart';
import 'package:machine/presentation/widgets/product_tile.dart';
import 'package:machine/presentation/widgets/triangle_painter.dart';
import 'package:octo_image/octo_image.dart';

class ProductsBlock extends StatefulWidget {
  final List<Product> products;
  const ProductsBlock({super.key, required this.products});

  @override
  State<ProductsBlock> createState() => _ProductsBlockState();
}

class _ProductsBlockState extends State<ProductsBlock> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(color: Colors.black),
      child: Stack(
        children: [
          Align(
            alignment: Alignment.topRight,
            child: CustomPaint(
              size: const Size(double.infinity, 60),
              painter: TrianglePainter(
                  color: MyColors.primary,
                  flipVertical: true,
                  flipHorizontal: true),
            ),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: CustomPaint(
              size: const Size(double.infinity, 60),
              painter: TrianglePainter(
                  color: MyColors.primary,
                  flipVertical: false,
                  flipHorizontal: false),
            ),
          ),
          // Align(
          //   alignment: Alignment.bottomCenter,
          //   child: PageViewIndicator(
          //     length: images.length,
          //     currentIndex: _currentIndex2,
          //     currentSize: 30,
          //     otherSize: 20,
          //     margin: const EdgeInsets.all(10),
          //     currentColor: Colors.white,
          //     otherColor: Colors.black,
          //   ),
          // ),
          Column(
            children: [
              const SizedBox(
                height: 80,
              ),
              Container(
                alignment: Alignment.topCenter,
                child: Text(
                  "Наши товары",
                  style: MyFonts.catalog,
                ),
              ),
              ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 1800),
                child: GridView.builder(
                    shrinkWrap: true,
                    itemCount: widget.products.length,
                    gridDelegate:
                        const SliverGridDelegateWithMaxCrossAxisExtent(
                            mainAxisSpacing: 20,
                            crossAxisSpacing: 20,
                            maxCrossAxisExtent: 400),
                    itemBuilder: (context, index) {
                      return ProductTile(
                        product: widget.products[index],
                      );
                    }),
              ),
              const SizedBox(height: 80,)
            ],
          ),

          const Padding(
            padding: EdgeInsets.all(20),
            child: Stack(
              children: [],
            ),
          )
        ],
      ),
    );
  }
}
