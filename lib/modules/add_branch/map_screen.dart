import 'package:batrena/cubit/add_branch/add_branch_cubit.dart';
import 'package:batrena/shared/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatelessWidget {
  const MapScreen({super.key});

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
            mapType: MapType.normal,
            zoomControlsEnabled: false,
            compassEnabled: false,
            liteModeEnabled: false,
            initialCameraPosition: CameraPosition(
                zoom: 15.5,
                target: LatLng(cubit.currentLatLong!.latitude,
                    cubit.currentLatLong!.longitude)),
            onMapCreated: (GoogleMapController controller) {
              cubit.setBranchMarkerCustomImage(context);
            },
            markers: cubit.myMarkers,
          ),
          floatingActionButton: Padding(
            padding: EdgeInsets.only(
                left: size.width * 0.1, bottom: size.height * 0.01),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: size.width * 0.4,
                height: size.height * 0.05,
                decoration: BoxDecoration(
                    color: carrebianCurrent,
                    borderRadius: BorderRadius.circular(10)),
                child: FloatingActionButton(
                  elevation: 2,
                  onPressed: () {},
                  backgroundColor: carrebianCurrent,
                  child: Text(
                    "My Location",
                    style:
                        textTheme.titleMedium!.copyWith(color: lavendarBlush),
                  ),
                ),
              ),
            ),
          ),
          bottomNavigationBar: Container(
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
        );
      },
    );
  }
}
