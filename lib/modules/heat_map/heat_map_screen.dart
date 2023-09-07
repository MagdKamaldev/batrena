import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'dart:typed_data';
import 'package:batrena/main.dart';
import 'package:batrena/shared/networks/remote/dio_helper.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HeatMapScreen extends StatefulWidget {
  const HeatMapScreen({super.key});

  @override
  State<HeatMapScreen> createState() => HeatMapScreenState();
}

Color increaseColorSaturation(Color color, double increment) {
  var hslColor = HSLColor.fromColor(color);
  hslColor = hslColor.withSaturation(0.5);
  var newValue = min(max(hslColor.saturation + increment, 0.0), 1.0);
  return hslColor.withSaturation(newValue).toColor();
}



class HeatMapScreenState extends State<HeatMapScreen> {
  static GoogleMapController? _controller;
  double _radius = 0;
  int zoomLevel = 3;
  late CameraPosition _kGooglePlex;
  late List<dynamic> branches;
  Set<Marker> markers = {};
  Set<Circle> circles = {};
  Future<bool> get loadData async {
  await  DioHelper.getData(url: "FetchBranchesHeatData").then((value) => branches = value.data);

    for (var branch in branches) {
      final Color fillColor =  Color.fromRGBO(224, 11, 11, branch["heat_map"]["value"] / 150);
      final Color markerColor =  increaseColorSaturation(Colors.red.shade300, branch["heat_map"]["value"]/200);
      var data = await rootBundle.load("assets/images/branch_location.png");
      final Uint8List templateMarkerBytes = data.buffer.asUint8List();
      final Uint8List branchMarkerBytes = await impl.replacePixels(imageBytes: templateMarkerBytes, hexColor: "#${markerColor.value.toRadixString(16).substring(2)}");
      markers.add(
        Marker(
            markerId: MarkerId(branch["ID"].toString()),
            position: LatLng(
              branch["lat_lng"]["lat"],
              branch["lat_lng"]["lng"],
            ),
            icon: BitmapDescriptor.fromBytes(branchMarkerBytes)
        ),
      );
      circles.add(
        Circle(
          circleId: CircleId(
            branch["ID"].toString(),
          ),
          center: LatLng(
            branch["lat_lng"]["lat"],
            branch["lat_lng"]["lng"],
          ),
          radius: _radius,
          fillColor:
          fillColor,
          strokeColor: Colors.transparent,
        ),
      );
    }
    return true;
  }


  Future<void> updateRadius() async {
    double zoomValue = await _controller!.getZoomLevel();
    _radius =  pow(21-zoomValue, 4).toDouble()/2;
    if (_radius < 20) {
      _radius = 20;
    }
    setState(() {});
  }

  void _onCameraMove(CameraPosition position) async {
    try {
      await updateRadius();
    } catch (_) {}
  }

  void _onMapCreated(GoogleMapController controller) async {
    _controller = controller;
    try {
      await updateRadius();
    } catch (_) {}
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: loadData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            _kGooglePlex = CameraPosition(
              target: LatLng(markers.first.position.latitude, markers.first.position.longitude),
              zoom: 14.4746,
            );
            return GoogleMap(
              circles: circles,
              markers: markers,
              initialCameraPosition: _kGooglePlex,
              onMapCreated: _onMapCreated,
              onCameraMove: _onCameraMove,
            );
          } else {
            return Center(child: CircularProgressIndicator(),);
          }
        },
      ),
    );
  }
}
