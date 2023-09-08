// ignore_for_file: use_key_in_widget_constructors
import 'package:batrena/cubit/heat_map/heat_map_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';


class HeatMapScreen extends StatefulWidget {
 
  @override
  State<HeatMapScreen> createState() => _HeatMapScreenState();
}

class _HeatMapScreenState extends State<HeatMapScreen> {
  @override
  void initState() {
    clearData();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    var cubit = HeatMapCubit.get(context);

    return BlocConsumer<HeatMapCubit, HeatMapStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          body: FutureBuilder(
            future: cubit.loadData,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return GoogleMap(
                  circles: circles,
                  markers: markers,
                  initialCameraPosition: cubit.kGooglePlex,
                  onMapCreated: cubit.onMapCreated,
                  onCameraMove: cubit.onCameraMove,
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        );
      },
    );
  }
}
