import 'package:batrena/modules/heat_map/heat_map_screen.dart';
import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          const SizedBox(
            height: 30,
          ),
          ElevatedButton(onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (_) => HeatMapScreen()));
          }, child: const SizedBox(
            height: 40,
            width: double.infinity,
            child: Center(
              child: Text(
                "Heat Map"
              ),
            ),
          ),),
        ],
      ),
    );
  }
}
