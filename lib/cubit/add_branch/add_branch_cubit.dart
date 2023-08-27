import 'package:batrena/cubit/home_cubit/app_cubit.dart';
import 'package:batrena/main.dart';
import 'package:batrena/shared/colors.dart';
import 'package:batrena/shared/components/components.dart';
import 'package:batrena/shared/networks/remote/dio_helper.dart';
import 'package:batrena/shared/networks/remote/end_points.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
part 'add_branch_state.dart';

class AddBranchCubit extends Cubit<AddBranchState> {
  AddBranchCubit() : super(AddBranchInitial()) {
    requestPermission();
  }
  static AddBranchCubit get(context) => BlocProvider.of(context);

  bool? servicesEnabled;
  LocationPermission? permission;

  Future requestPermission() async {
    emit(ResquestPermissionLoadingState());

    servicesEnabled = await Geolocator.isLocationServiceEnabled();
    permission = await Geolocator.checkPermission();

    permission = await Geolocator.requestPermission().then((value) {
      if (permission != LocationPermission.denied) {
        getLatLong();
        emit(ResquestPermissionSuccessState());
      } else {
        emit(ResquestPermissionWarningState());
      }
    }).catchError((error) {
      emit(ResquestPermissionErrorState());
    });
  }

  Position? currentLatLong;

  late CameraPosition myPosition;

  void getLatLong() async {
    emit(GetLatLongLoadingState());
    currentLatLong = await Geolocator.getCurrentPosition().then(
      (value) => value,
    );
    //print(currentLatLong!.latitude);
    emit(GetLatLongSuccessState());

    myPosition = CameraPosition(
        target: LatLng(currentLatLong!.latitude, currentLatLong!.longitude),
        zoom: 17.4746);
  }

  Set<Marker> myMarkers = {};

  void setBranchMarkerCustomImage(context) async {
    emit(SetMarkerLoadingState());
    myMarkers.clear();
    myMarkers.add(Marker(
      onTap: () =>
          showCustomSnackBar(context, "Long press to move", lavendarBlush),
      markerId: const MarkerId('userLocationMarker'),
      position: LatLng(currentLatLong!.latitude, currentLatLong!.longitude),
      draggable: true,
      onDragEnd: (LatLng t) {},
      icon: await BitmapDescriptor.fromAssetImage(
        ImageConfiguration.empty,
        "assets/images/branch_location.png",
      ),
    ));
    emit(SetMarkerSuccessState());
  }

  Position? branchPosition;

  void setBranchLocation(double latitude, double longitude) {
    branchPosition = Position(
        latitude: latitude,
        longitude: longitude,
        timestamp: DateTime.now(),
        accuracy: 10.0,
        altitude: 0.0,
        heading: 0.0,
        speed: 0.0,
        speedAccuracy: 0.0);

    emit(SetBranchLoactionState());
  }

  void addBranch({
    required String name,
    required String adress,
    required double lat,
    required double long,
    required BuildContext context,
  }) {
    emit(AddBranchLoadingState());
    DioHelper.postData(url: EndPoints.registerBranch, jwt: jwt, data: {
      "name": name,
      "lat_lng": {
        "lat": lat,
        "lng": long,
      },
      "address": adress,
    }).then((value) {
      AppCubit.get(context).fetchBranches();
      showCustomSnackBar(
          context,
          value.data["message"],
          value.data["message"] == "Branch Registered"
              ? Colors.green
              : Colors.red);
      emit(AddBranchSuccessState());
    
    }).catchError((error) {
      print(error.toString());
    });
  }
}
