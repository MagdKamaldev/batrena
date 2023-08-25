import 'package:batrena/cubit/add_branch/add_branch_cubit.dart';
import 'package:batrena/modules/add_branch/map_screen.dart';
import 'package:batrena/shared/components/components.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:lottie/lottie.dart';
import '../../shared/colors.dart';

class BranchDetails extends StatelessWidget {
  const BranchDetails({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = AddBranchCubit.get(context);
    var size = MediaQuery.of(context).size;
    var textTheme = Theme.of(context).textTheme;
    var nameController = TextEditingController();
    var adressController = TextEditingController();
    var formKey = GlobalKey<FormState>();
    return BlocConsumer<AddBranchCubit, AddBranchState>(
      listener: (context, state) {
        if (state is AddBranchSuccessState) {
          Navigator.pop(context);
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            iconTheme: IconThemeData(color: lavendarBlush),
            title: Text(
              "Add Branch",
              style: textTheme.bodyLarge,
            ),
          ),
          body: Form(
            key: formKey,
            child: Padding(
              padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
              child: SingleChildScrollView(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Location",
                        style:
                            textTheme.bodyLarge!.copyWith(color: raisinBlack),
                      ),
                      GestureDetector(
                        onTap: () {
                          navigateTo(context, const MapScreen());
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(color: raisinBlack, width: 1),
                          ),
                          width: size.width * 0.9,
                          height: size.height * 0.25,
                          child: Stack(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(16),
                                child: ConditionalBuilder(
                                  condition: cubit.currentLatLong != null ||
                                      cubit.branchPosition != null ||
                                      cubit.myMarkers.isNotEmpty,
                                  builder: (context) => ConditionalBuilder(
                                    condition: cubit.branchPosition == null,
                                    fallback: (context) => Container(
                                      color: lavendarBlush,
                                      child: Center(
                                          child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          SizedBox(
                                            width: size.width * 0.2,
                                            height: size.height * 0.07,
                                            child: Lottie.asset(
                                                "assets/animations/done.json"),
                                          ),
                                          Text(
                                            "Location Set",
                                            style: textTheme.titleMedium!
                                                .copyWith(
                                                    color: carrebianCurrent),
                                          ),
                                          SizedBox(
                                            height: size.height * 0.06,
                                          ),
                                        ],
                                      )),
                                    ),
                                    builder: (context) => GoogleMap(
                                      mapType: MapType.normal,
                                      zoomControlsEnabled: false,
                                      zoomGesturesEnabled: false,
                                      tiltGesturesEnabled: false,
                                      scrollGesturesEnabled: false,
                                      rotateGesturesEnabled: false,
                                      initialCameraPosition: CameraPosition(
                                          zoom: 15.5,
                                          target: LatLng(
                                            cubit.myMarkers.isNotEmpty
                                                ? cubit.myMarkers.first.position
                                                    .latitude
                                                : cubit.currentLatLong!
                                                    .latitude, // Handle empty markers case
                                            cubit.myMarkers.isNotEmpty
                                                ? cubit.myMarkers.first.position
                                                    .longitude
                                                : cubit
                                                    .currentLatLong!.longitude,
                                          )),
                                      onMapCreated:
                                          (GoogleMapController controller) {
                                        if (cubit.myMarkers.isEmpty) {
                                          cubit.setBranchMarkerCustomImage(
                                              context);
                                        }
                                      },
                                      markers: cubit.myMarkers,
                                    ),
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
                                      borderRadius: BorderRadius.circular(14),
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
                      SizedBox(
                        height: size.height * 0.05,
                      ),
                      Text(
                        "Name",
                        style:
                            textTheme.bodyLarge!.copyWith(color: raisinBlack),
                      ),
                      SizedBox(
                        height: size.height * 0.01,
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
                        height: size.height * 0.04,
                      ),
                      Text(
                        "Adress",
                        style:
                            textTheme.bodyLarge!.copyWith(color: raisinBlack),
                      ),
                      SizedBox(
                        height: size.height * 0.01,
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
                      ConditionalBuilder(
                        condition: state is! AddBranchLoadingState,
                        builder: (context) => ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Container(
                            width: double.infinity,
                            height: size.height * 0.07,
                            decoration: BoxDecoration(
                              color: carrebianCurrent,
                            ),
                            child: MaterialButton(
                              onPressed: () {
                                if (formKey.currentState!.validate() &&
                                    cubit.branchPosition != null) {
                                  cubit.addBranch(
                                      name: nameController.text,
                                      adress: adressController.text,
                                      lat: cubit.branchPosition!.latitude,
                                      long: cubit.branchPosition!.longitude,
                                      context: context);
                                }
                              },
                              color: carrebianCurrent,
                              child: Text(
                                "Confirm branch",
                                style: textTheme.bodyLarge,
                              ),
                            ),
                          ),
                        ),
                        fallback: (context) => const Center(
                          child: CircularProgressIndicator(),
                        ),
                      ),
                    ]),
              ),
            ),
          ),
        );
      },
    );
  }
}
