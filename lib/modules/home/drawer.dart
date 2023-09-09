import 'package:batrena/modules/heat_map/heat_map_screen.dart';
import 'package:batrena/shared/colors.dart';
import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
   

    return Drawer(
      child: Column(
        children: [
          const SizedBox(
            height: 70,
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (_) => HeatMapScreen()));
            },
            child: Container(
              height: 70,
              child: Card(
                elevation: 3,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      "Heat Map",
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .copyWith(color: raisinBlack),
                    ),
                    const Icon(
                      Icons.map,
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
