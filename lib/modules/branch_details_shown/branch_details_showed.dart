// ignore_for_file: must_be_immutable
import 'package:batrena/models/branch_model.dart' as branch_model;
import 'package:batrena/modules/branch_details_shown/branch_inventory.dart';
import 'package:batrena/modules/branch_details_shown/branch_transaction.dart';
import 'package:batrena/shared/colors.dart';
import 'package:batrena/shared/components/components.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class BranchDetailsShown extends StatelessWidget {
  final branch_model.Branch branch;
  BranchDetailsShown({super.key, required this.branch});
  Set<Marker> markers = {};
  Future<bool> get loadMarkers async {
    markers.add(Marker(
      markerId: const MarkerId("branchMarker"),
      position: LatLng(branch.latLng.lat, branch.latLng.lng),
      icon: await BitmapDescriptor.fromAssetImage(
        ImageConfiguration.empty,
        "assets/images/branch_location.png",
      ),
    ));
    return true;
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: lavendarBlush),
        title: Text(
          branch.name,
          style: textTheme.bodyLarge,
        ),
      ),
      body: FutureBuilder(
          future: loadMarkers,
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const CircularProgressIndicator();
            } else {
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                        width: size.width,
                        height: size.height * 0.3,
                        child: Hero(
                          tag: "branch ${branch.id}",
                          child: Image.asset(
                            "assets/images/batrena.jpg",
                            fit: BoxFit.cover,
                          ),
                        )),
                    SizedBox(
                      height: size.height * 0.04,
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: size.width * 0.04),
                      child: Text(
                        "Address: ${branch.address}",
                        style:
                            textTheme.bodyLarge!.copyWith(color: raisinBlack),
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.04,
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: size.width * 0.04),
                      child: Text(
                        "Current Shift: ${branch.currentShift.employee.name}",
                        style:
                            textTheme.bodyLarge!.copyWith(color: raisinBlack),
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.04,
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: size.width * 0.04),
                      child: Text(
                        "Today's Sales: ${branch.soldToday}",
                        style:
                            textTheme.bodyLarge!.copyWith(color: raisinBlack),
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.05,
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: SizedBox(
                          width: size.width * 0.9,
                          height: size.height * 0.25,
                          child: Stack(children: [
                            GoogleMap(
                                zoomGesturesEnabled: false,
                                zoomControlsEnabled: false,
                                markers: markers,
                                initialCameraPosition: CameraPosition(
                                    zoom: 15,
                                    target: LatLng(
                                        branch.latLng.lat, branch.latLng.lng))),
                            Align(
                              alignment: Alignment.bottomCenter,
                              child: GestureDetector(
                                onTap: () async {
                                  String url =
                                      "https://www.google.com/maps/search/?api=1&query=${branch.latLng.lat},${branch.latLng.lng}";

                                  await launchUrl(Uri.parse(url));
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: palePurple.withOpacity(0.8)),
                                  width: double.infinity,
                                  height: size.height * 0.075,
                                  padding: const EdgeInsets.all(16),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text('Show On Maps',
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleSmall!
                                              .copyWith(fontSize: 15)),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ]),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.05,
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: size.width * 0.04),
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Container(
                              decoration: BoxDecoration(
                                color: carrebianCurrent,
                              ),
                              width: size.width * 0.43,
                              height: size.height * 0.08,
                              child: MaterialButton(
                                color: carrebianCurrent,
                                onPressed: () {
                                  navigateTo(
                                      context,
                                      BranchInventory(
                                        branch: branch,
                                      ));
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Inventory",
                                      style: textTheme.bodyLarge!.copyWith(
                                          color: lavendarBlush, fontSize: 22),
                                    ),
                                    SizedBox(
                                      width: size.width * 0.02,
                                    ),
                                    Icon(
                                      Icons.arrow_forward_ios,
                                      color: lavendarBlush,
                                      size: 16,
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: size.width * 0.05,
                          ),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Container(
                              decoration: BoxDecoration(
                                color: carrebianCurrent,
                              ),
                              width: size.width * 0.43,
                              height: size.height * 0.08,
                              child: MaterialButton(
                                color: carrebianCurrent,
                                onPressed: () {
                                  navigateTo(
                                      context,
                                      BranchTransactions(
                                        branch: branch,
                                      ));
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Transactions",
                                      style: textTheme.bodyLarge!.copyWith(
                                          color: lavendarBlush, fontSize: 22),
                                    ),
                                    SizedBox(
                                      width: size.width * 0.02,
                                    ),
                                    Icon(
                                      Icons.arrow_forward_ios,
                                      color: lavendarBlush,
                                      size: 16,
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.05,
                    ),
                  ],
                ),
              );
            }
          }),
    );
  }
}
