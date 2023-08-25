import 'package:batrena/cubit/add_branch/add_branch_cubit.dart';
import 'package:batrena/shared/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../shared/components/components.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    var cubit = AddBranchCubit.get(context);
    var size = MediaQuery.of(context).size;
    return BlocConsumer<AddBranchCubit, AddBranchState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            iconTheme: IconThemeData(color: lavendarBlush),
            title: Text(
              "Set Branch Location",
              style: textTheme.bodyLarge,
            ),
          ),
          body: GoogleMap(
            myLocationButtonEnabled: true,
            myLocationEnabled: true,
            mapType: MapType.normal,
            zoomControlsEnabled: false,
            compassEnabled: false,
            liteModeEnabled: false,
            onTap: (LatLng latLng) async {
              AddBranchCubit.get(context).myMarkers.clear();
              AddBranchCubit.get(context).myMarkers.add(Marker(
                    onTap: () => showCustomSnackBar(
                        context, "Long press to move", lavendarBlush),
                    markerId: const MarkerId('userLocationMarker'),
                    position: latLng,
                    draggable: true,
                    onDragEnd: (LatLng t) {},
                    icon: await BitmapDescriptor.fromAssetImage(
                      ImageConfiguration.empty,
                      "assets/images/branch_location.png",
                    ),
                  ));
              setState(() {});
            },
            initialCameraPosition: CameraPosition(
                zoom: 15.5,
                target: LatLng(cubit.myMarkers.first.position.latitude,
                    cubit.myMarkers.first.position.longitude)),
            onMapCreated: (GoogleMapController controller) {},
            markers: cubit.myMarkers,
          ),
          bottomNavigationBar: GestureDetector(
            onTap: () {
              cubit.setBranchLocation(cubit.myMarkers.first.position.latitude,
                  cubit.myMarkers.first.position.longitude);

              showSetLoactionSuccess(context, size.height, size.width,textTheme);
            },
            child: Container(
              color: carrebianCurrent,
              width: size.width,
              height: size.height * 0.08,
              child: Center(
                child: Text(
                  "Confirm Location",
                  style: textTheme.bodyLarge,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
