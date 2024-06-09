
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:machine/presentation/fonts.dart';


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
                        child: Image.asset(
                          'marker.png',
                          width: 200,
                          height: 200,
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
          )
        ],
      ),
    );
  }
}