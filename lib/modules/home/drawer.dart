import 'package:batrena/modules/heat_map/heat_map_screen.dart';
import 'package:batrena/shared/colors.dart';
import 'package:batrena/shared/components/components.dart';
import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Drawer(
      child: Column(
        children: [
          SizedBox(
            height: size.height * 0.08,
          ),
          GestureDetector(
            onTap: () {
              navigateTo(context, HeatMapScreen());
            },
            child: Container(
                height: 60,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: const Color.fromRGBO(238, 245, 245, 1),
                  borderRadius: BorderRadius.circular(12),
                ),
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
          SizedBox(
            height: size.height * 0.03,
          ),
          GestureDetector(
            onTap: () {
              logout(context: context);
            },
            child: Container(
              height: 60,
              width: double.infinity,
              decoration: BoxDecoration(
                color: const Color.fromRGBO(238, 245, 245, 1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Card(
                elevation: 3,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      "Logout",
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .copyWith(color: raisinBlack),
                    ),
                    const Icon(
                      Icons.logout,
                    )
                  ],
                ),
              ),
            ),
          ),
          // SizedBox(
          //   height: size.height * 0.02,
          // ),
          // GestureDetector(
          //   onTap: () {
          //     navigateTo(context, const ChangeShiftScreen());
          //   },
          //   child: SizedBox(
          //     height: 70,
          //     child: Card(
          //       elevation: 3,
          //       child: Row(
          //         mainAxisAlignment: MainAxisAlignment.spaceAround,
          //         children: [
          //           Text(
          //             "Change Shift",
          //             style: Theme.of(context)
          //                 .textTheme
          //                 .bodyLarge!
          //                 .copyWith(color: raisinBlack),
          //           ),
          //           const Icon(
          //             Icons.change_circle_outlined,
          //           )
          //         ],
          //       ),
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}
