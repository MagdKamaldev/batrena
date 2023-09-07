import 'package:batrena/modules/heat_map/heat_map_screen.dart';
import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          ElevatedButton(onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (_) => HeatMapScreen()));
          }, child: Container(
            height: 40,
            width: double.infinity,
            color: Colors.red,
            child: Text(
              "Heat Map"
            ),
          ),)
        ],
      ),
    );
  }
}
