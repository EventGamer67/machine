import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:machine/presentation/colors.dart';
import 'package:machine/presentation/logic/home_provider.dart';
import 'package:machine/presentation/screens/catalog/catalog_screen.dart';
import 'package:machine/presentation/shared/blur.dart';
import 'package:machine/presentation/widgets/triangle_painter.dart';
import 'package:octo_image/octo_image.dart';

class MainBlock extends ConsumerWidget {
  const MainBlock({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      height: MediaQuery.sizeOf(context).height-60,
      child: Stack(
        children: [
          OctoImage(
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  color: Colors.black,
                );
              },
              fit: BoxFit.cover,
              height: MediaQuery.sizeOf(context).height-60,
              placeholderBuilder:
                  blurHashPlaceholderBuilder("LFD]rG^+M{M{0000xu-;~q~qWBD%"),
              width: MediaQuery.of(context).size.width,
              image: const CachedNetworkImageProvider(
                  "https://regionavto164.ru/wp-content/uploads/2021/04/w_f994e09b.jpg")),
          Align(
            alignment: Alignment.center,
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 2200),
              child: Container(
                margin: EdgeInsets.only(
                    top:( (MediaQuery.sizeOf(context).height-60)/2)-200,
                    left: MediaQuery.sizeOf(context).width < 900 ? 50 : 100),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SvgPicture.asset(
                      "assets/vdetalax.svg",
                      height:
                          MediaQuery.sizeOf(context).width < 900 ? 100 : 200,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      'г. Саратов, ул. Астраханская 47',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize:
                              MediaQuery.sizeOf(context).width < 900 ? 20 : 50),
                    ),
                    GestureDetector(
                      onTap: () {
                        ref
                            .watch(homeScreenProvider)
                            .scrollController
                            .animateTo(
                              2200,
                              duration: const Duration(seconds: 1),
                              curve: Curves.easeInOut,
                            );
                      },
                      child: Align(
                          alignment: Alignment.topLeft,
                          child: Container(
                            margin: const EdgeInsets.only(top: 30),
                            decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            padding: const EdgeInsets.all(16),
                            child:  Text(
                              'Отправить заявку',
                              style:
                                  GoogleFonts.raleway(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold ),
                            ),
                          )),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>const CatalogScreen()));
                      },
                      child: Align(
                          alignment: Alignment.topLeft,
                          child: Container(
                            margin: const EdgeInsets.only(top: 30),
                            decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            padding: const EdgeInsets.all(16),
                            child:  Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(Icons.menu, color: Colors.white, ),
                                const SizedBox(width:10),
                                Text(
                                  'Каталог',
                                  style:
                                      GoogleFonts.raleway(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold ),
                                ),
                              ],
                            ),
                          )),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: CustomPaint(
              size: const Size(double.infinity, 120),
              painter: TrianglePainter(
                  color: MyColors.primary,
                  flipVertical: false,
                  flipHorizontal: false),
            ),
          ),
        ],
      ),
    );
  }
}
