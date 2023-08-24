import 'package:batrena/cubit/add_branch/add_branch_cubit.dart';
import 'package:batrena/modules/add_branch/map_screen.dart';
import 'package:batrena/shared/components/components.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../shared/colors.dart';

class AddBranch extends StatelessWidget {
  const AddBranch({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = AddBranchCubit.get(context);
    var size = MediaQuery.of(context).size;
    var textTheme = Theme.of(context).textTheme;
    var nameController = TextEditingController();
    var adressController = TextEditingController();
    return BlocConsumer<AddBranchCubit, AddBranchState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            iconTheme: IconThemeData(color: lavendarBlush),
            title: Text(
              "Add Branch",
              style: textTheme.bodyLarge,
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(
                "Name",
                style: textTheme.bodyLarge!.copyWith(color: raisinBlack),
              ),
              defaultFormField(
                  controller: nameController,
                  type: TextInputType.name,
                  onSubmit: () {},
                  validate: (String text) {
                    if (text.isEmpty) {
                      return "name must not be empty";
                    }
                  },
                  label: "Branch Name",
                  prefix: Icons.coffee,
                  context: context),
              SizedBox(
                height: size.height * 0.02,
              ),
              Text(
                "Adress",
                style: textTheme.bodyLarge!.copyWith(color: raisinBlack),
              ),
              defaultFormField(
                  controller: adressController,
                  type: TextInputType.name,
                  onSubmit: () {},
                  validate: (String text) {
                    if (text.isEmpty) {
                      return "Adress must not be empty";
                    }
                  },
                  label: "Branch Adress",
                  prefix: Icons.map_outlined,
                  context: context),
              SizedBox(
                height: size.height * 0.05,
              ),
              Text(
                "Location",
                style: textTheme.bodyLarge!.copyWith(color: raisinBlack),
              ),
              GestureDetector(
                onTap: () {
                  navigateTo(context, MapScreen());
                },
                child: Container(
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(15)),
                  width: size.width * 0.9,
                  height: size.height * 0.25,
                  child: Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: ConditionalBuilder(
                          condition: state is SetMarkerSuccessState ||
                              state is GetLatLongSuccessState ||
                              state is ResquestPermissionSuccessState,
                          builder: (context) => GoogleMap(
                            mapType: MapType.normal,
                            zoomControlsEnabled: false,
                            zoomGesturesEnabled: false,
                            tiltGesturesEnabled: false,
                            scrollGesturesEnabled: false,
                            rotateGesturesEnabled: false,
                            initialCameraPosition: CameraPosition(
                                zoom: 15.5,
                                target: LatLng(cubit.currentLatLong!.latitude,
                                    cubit.currentLatLong!.longitude)),
                            onMapCreated: (GoogleMapController controller) {
                              cubit.setUserMarkerCustomImage(context);
                            },
                            markers: cubit.myMarkers,
                          ),
                          fallback: (context) => const Center(
                            child: CircularProgressIndicator(),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              color: palePurple.withOpacity(0.8)),
                          width: double.infinity,
                          padding: const EdgeInsets.all(16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('Choose Another Location',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleSmall!
                                      .copyWith(fontSize: 15)),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ]),
          ),
        );
      },
    );
  }
}
