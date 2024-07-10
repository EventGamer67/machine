import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_page_view_indicator/flutter_page_view_indicator.dart';
import 'package:machine/presentation/colors.dart';
import 'package:machine/presentation/fonts.dart';
import 'package:machine/presentation/shared/blur.dart';
import 'package:machine/presentation/widgets/triangle_painter.dart';
import 'package:octo_image/octo_image.dart';

class ProductsBlock extends StatefulWidget {
  const ProductsBlock({
    super.key,
  });

  @override
  State<ProductsBlock> createState() => _ProductsBlockState();
}

class _ProductsBlockState extends State<ProductsBlock> {
  final PageController pageController = PageController();
  final int _currentIndex2 = 0;
  late final Timer pageSwitcher;

  List<(String, String)> images = [
    ("https://i.imgur.com/StTQTb8.png", "L8EVyrI8k?xV009ax^-:?w?HxUM|"),
    ("https://imgur.com/xX2Lnoj.png", "L9E.;FwG0LM{00t7D*NH~U-;Iqt7"),
    ("https://imgur.com/74wzzXI.png", "LAE{X@~TMxD*00?H?F-:-ls+%3f4"),
    ("https://imgur.com/m3jni6v.png", "L4CZY7Q,4TITICRS9F-o08Dio,%1"),
    ("https://imgur.com/zxYyhLM.png", "LADvvL00EknhD4_44oW8?bIUtR-q"),
  ];

  @override
  void initState() {
    super.initState();
    pageSwitcher = Timer.periodic(const Duration(seconds: 4), (timer) {
      pageController.animateToPage(
          _currentIndex2 + 1 > 4 ? 0 : _currentIndex2 + 1,
          duration: const Duration(seconds: 1),
          curve: Curves.easeInOutSine);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 1100,
      width: double.infinity,
      decoration: const BoxDecoration(color: Colors.black),
      child: Stack(
        children: [
          SizedBox(
              height: double.infinity,
              child: Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(80),
                child: GridView.builder(
                    shrinkWrap: true,
                    itemCount: 10,
                    gridDelegate:
                        const SliverGridDelegateWithMaxCrossAxisExtent(
                            mainAxisSpacing: 20,
                            crossAxisSpacing: 20,
                            maxCrossAxisExtent: 400),
                    itemBuilder: (context, index) {
                      return Container(
                        width: 200,
                        height: 200,
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: Colors.white)),
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            const Align(alignment: Alignment.topCenter,child: Text("Масло", style: TextStyle(color: Colors.white, fontSize: 30 ), ),),
                            const Align(alignment: Alignment.bottomRight,child: Text("459₽", style: TextStyle(color: Colors.white, fontSize: 30 ), ),),
                            Container(
                              width: 250,
                              height: 250,
                              alignment: Alignment.center,
                              child: CachedNetworkImage(
                                  alignment: Alignment.center,
                                  imageUrl:
                                      "https://static.insales-cdn.com/images/products/1/5569/637908417/SUPREME_SYNTHETIC_PRO_SAE_0W-30_1_%D0%BB%D0%B8%D1%82%D1%80.png"),
                            )
                          ],
                        ),
                      );
                    }),
              )),
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
          Container(
            margin: const EdgeInsets.only(top: 40),
            alignment: Alignment.topCenter,
            child: Text(
              "Наши товары",
              style: MyFonts.catalog,
            ),
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
