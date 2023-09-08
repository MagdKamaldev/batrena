import 'dart:math';
import 'package:batrena/main.dart';
import 'package:batrena/shared/networks/remote/dio_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
part 'heat_map_state.dart';

Set<Marker> markers = {};
Set<Circle> circles = {};

void clearData() {
  markers.clear();
  circles.clear();
}

class HeatMapCubit extends Cubit<HeatMapStates> {
  HeatMapCubit() : super(HeatMapInitial()){

  }
  static HeatMapCubit get(context) => BlocProvider.of(context);

  Color increaseColorSaturation(Color color, double increment) {
    var hslColor = HSLColor.fromColor(color);
    hslColor = hslColor.withSaturation(0.5);
    var newValue = min(max(hslColor.saturation + increment, 0.0), 1.0);
    return hslColor.withSaturation(newValue).toColor();
  }

  static GoogleMapController? googleController;
  double radius = 0;
  int zoomLevel = 3;
  late CameraPosition kGooglePlex;
  late List<dynamic> branches;


  Future<bool> get loadData async {
      await DioHelper.getData(url: "FetchBranchesHeatData")
          .then((value) => branches = value.data);
      for (var branch in branches) {
        double circleOpacity = branch["heat_map"]["value"] / 150;
        if (circleOpacity < 0.20) {
          circleOpacity = 0.20;
        }
        final Color fillColor =
        Color.fromRGBO(224, 11, 11, circleOpacity);
        final Color markerColor = increaseColorSaturation(
            Colors.red.shade300, branch["heat_map"]["value"] / 200);
        var data = await rootBundle.load("assets/images/branch_location.png");
        final Uint8List templateMarkerBytes = data.buffer.asUint8List();
        final Uint8List branchMarkerBytes = await impl.replacePixels(
            imageBytes: templateMarkerBytes,
            hexColor: "#${markerColor.value.toRadixString(16).substring(2)}");
        markers.add(
          Marker(
            markerId: MarkerId(branch["ID"].toString()),
            position: LatLng(
              branch["lat_lng"]["lat"],
              branch["lat_lng"]["lng"],
            ),
            icon: BitmapDescriptor.fromBytes(branchMarkerBytes),
            infoWindow: InfoWindow(title: branch["name"],
                snippet: "Sales: ${branch["heat_map"]["total_sold"]}"),),
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
            radius: radius,
            fillColor: fillColor,
            strokeColor: Colors.transparent,
          ),
        );
      }
      kGooglePlex = CameraPosition(
        target: LatLng(markers.first.position.latitude,
            markers.first.position.longitude),
        zoom: 14.4746,
      );
    return true;
  }

  Future<void> updateRadius() async {
    double zoomValue = await googleController!.getZoomLevel();
    radius = pow(26 - zoomValue, 3).toDouble() / 3.4;
    if (radius < 20) {
      radius = 20;
    }
    emit(UpdateRadiusSuccessState());
  }

  void onCameraMove(CameraPosition position) async {
    try {
      await updateRadius();
    } catch (_) {}
  }

  void onMapCreated(GoogleMapController controller) async {
    googleController = controller;
    try {
      await updateRadius();
    } catch (_) {}
  }
}
