import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_page_view_indicator/flutter_page_view_indicator.dart';
import 'package:machine/presentation/colors.dart';
import 'package:machine/presentation/fonts.dart';
import 'package:machine/presentation/shared/blur.dart';
import 'package:machine/presentation/widgets/triangle_painter.dart';
import 'package:octo_image/octo_image.dart';

class GalleryBlock extends StatefulWidget {
  const GalleryBlock({
    super.key,
  });

  @override
  State<GalleryBlock> createState() => _GalleryBlockState();
}

class _GalleryBlockState extends State<GalleryBlock> {
  final PageController pageController = PageController();
  int _currentIndex2 = 0;
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
      height: 1000,
      width: double.infinity,
      decoration: const BoxDecoration(color: MyColors.primary),
      child: Stack(
        children: [
          SizedBox(
            height: double.infinity,
            child: PageView(
                controller: pageController,
                onPageChanged: (page) {
                  setState(() {
                    _currentIndex2 = page;
                  });
                },
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                children: List.generate(images.length, (index) {
                  final image = images[index];
                  return OctoImage(
                      errorBuilder: (context, error, stackTrace) {
                        return const SizedBox();
                      },
                      fit: BoxFit.cover,
                      height: 1350,
                      width: MediaQuery.of(context).size.width,
                      placeholderBuilder: blurHashPlaceholderBuilder(image.$2),
                      image: CachedNetworkImageProvider(image.$1));
                })),
          ),
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
          Container(
            alignment: Alignment.bottomLeft,
            child: CustomPaint(
              size: const Size(double.infinity, 60),
              painter: TrianglePainter(
                  color: MyColors.primary,
                  flipVertical: false,
                  flipHorizontal: false),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: PageViewIndicator(
              length: images.length,
              currentIndex: _currentIndex2,
              currentSize: 30,
              otherSize: 20,
              margin: const EdgeInsets.all(10),
              currentColor: Colors.white,
              otherColor: Colors.black,
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 40),
            alignment: Alignment.topCenter,
            child: Text(
              "НАШ КАТАЛОГ",
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
