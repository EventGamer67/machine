import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:latlong2/latlong.dart';
import 'package:machine/presentation/fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class MapBlock extends StatelessWidget {
  const MapBlock({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 720,
      child: Stack(
        children: [
          IgnorePointer(
            child: FlutterMap(
                options: const MapOptions(
                    initialCenter: LatLng(51.532201, 46.005061),
                    initialZoom: 16.0),
                children: [
                  TileLayer(
                    urlTemplate:
                        "https://tile-c.openstreetmap.fr/hot/{z}/{x}/{y}.png",
                  ),
                  MarkerLayer(markers: [
                    Marker(
                        point: const LatLng(51.532201, 46.005061),
                        child: GestureDetector(
                          onTap: () {
                            launchUrl(
                              Uri.parse(
                                  "http://maps.yandex.ru/?rtext=~51.532201%2C46.005061&rtm=atm&source=route&l=map&rtm=atm&source=route&l=map&z=14&ll=46.005061%2C51.532201"),
                            );
                          },
                          child: Image.asset(
                            'assets/marker.png',
                            width: 300,
                            height: 300,
                            fit: BoxFit.fitWidth,
                          ),
                        ))
                  ])
                ]),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Align(
              alignment: Alignment.topLeft,
              child: FittedBox(
                fit: BoxFit.fitWidth,
                child: Text(
                  "НАШЕ МЕСТОПОЛОЖЕНИЕ",
                  maxLines: 1,
                  style: MyFonts.catalog.copyWith(color: Colors.black),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Align(
                alignment: Alignment.bottomCenter,
                child: GestureDetector(
                  onTap: () {
                    launchUrl(
                      Uri.parse(
                          "http://maps.yandex.ru/?rtext=~51.532201%2C46.005061&rtm=atm&source=route&l=map&rtm=atm&source=route&l=map&z=14&ll=46.005061%2C51.532201"),
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 33, 150, 243),
                        borderRadius: BorderRadius.circular(20)),
                    padding: const EdgeInsets.all(10),
                    width: 150,
                    height: 60,
                    child: Center(
                      child: Text(
                        "Перейти",
                        style: GoogleFonts.roboto(
                            color: Colors.white, fontSize: 20),
                      ),
                    ),
                  ),
                )),
          ),
        ],
      ),
    );
  }
}
