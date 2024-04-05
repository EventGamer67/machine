import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:machine/presentation/colors.dart';
import 'package:machine/presentation/fonts.dart';
import 'package:machine/presentation/shared/blur.dart';
import 'package:machine/presentation/widgets/triangle_painter.dart';
import 'package:octo_image/octo_image.dart';
import 'package:latlong2/latlong.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      scrollBehavior: MyCustomScrollBehavior(),
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late ScrollController _scrollController;
  @override
  void initState() {
    _scrollController = ScrollController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        controller: _scrollController,
        scrollBehavior: MyCustomScrollBehavior(),
        slivers: [
          SliverToBoxAdapter(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  height: 1350,
                  child: Stack(
                    children: [
                      OctoImage(
                          fit: BoxFit.cover,
                          height: 1350,
                          placeholderBuilder: blurHashPlaceholderBuilder(
                              "LFD]rG^+M{M{0000xu-;~q~qWBD%"),
                          width: MediaQuery.of(context).size.width,
                          image: const CachedNetworkImageProvider(
                              "https://regionavto164.ru/wp-content/uploads/2021/04/w_f994e09b.jpg")),
                      Align(
                        alignment: Alignment.center,
                        child: ConstrainedBox(
                          constraints: BoxConstraints(maxWidth: 2000),
                          child: Container(
                            margin: EdgeInsets.only(top: 120),
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: Padding(
                                padding: EdgeInsets.all(30),
                                child: Text(
                                  "Первый блок",
                                  style: MyFonts.catalog,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomLeft,
                        child: CustomPaint(
                          size: Size(double.infinity, 120),
                          painter: TrianglePainter(
                              color: MyColors.primary,
                              flipVertical: false,
                              flipHorizontal: false),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 600,
                  width: double.infinity,
                  decoration: const BoxDecoration(color: MyColors.primary),
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      children: [
                        Text(
                          "Второй блок",
                          style: MyFonts.catalog,
                        )
                      ],
                    ),
                  ),
                ),
                Container(
                  height: 1350,
                  child: Stack(
                    children: [
                      OctoImage(
                          fit: BoxFit.cover,
                          height: 1350,
                          width: MediaQuery.of(context).size.width,
                          placeholderBuilder: blurHashPlaceholderBuilder(
                              "LFD]rG^+M{M{0000xu-;~q~qWBD%"),
                          image: const CachedNetworkImageProvider(
                              "https://regionavto164.ru/wp-content/uploads/2021/04/w_f994e09b.jpg")),
                      Container(
                        margin: EdgeInsets.only(top: 120),
                        child: Align(
                          alignment: Alignment.topCenter,
                          child: Text(
                            "Третий блок",
                            style: MyFonts.catalog,
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.topRight,
                        child: CustomPaint(
                          size: const Size(double.infinity, 120),
                          painter: TrianglePainter(
                              flipVertical: true,
                              flipHorizontal: true,
                              color: MyColors.primary),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 720,
                  child: Stack(
                    children: [
                      IgnorePointer(
                        child: FlutterMap(
                            options: MapOptions(
                                initialCenter: LatLng(
                                    54.7352526406467, 55.958523199814756),
                                initialZoom: 16.0),
                            children: [
                              TileLayer(
                                urlTemplate:
                                    "https://tile-c.openstreetmap.fr/hot/{z}/{x}/{y}.png",
                              ),
                              MarkerLayer(markers: [
                                Marker(
                                    point: LatLng(54.7349, 55.9604),
                                    child: Container(
                                      width: 20,
                                      height: 20,
                                      color: Colors.red,
                                    ))
                              ])
                            ]),
                      ),
                      Padding(
                        padding: EdgeInsets.all(20),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            "Блок карты",
                            style:
                                MyFonts.catalog.copyWith(color: Colors.black),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  height: 315,
                  color: MyColors.footerBackground,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class MyCustomScrollBehavior extends MaterialScrollBehavior {
  // Override behavior methods and getters like dragDevices
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
        // etc.
      };
}
