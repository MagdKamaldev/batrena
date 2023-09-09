import 'package:batrena/models/branch_model.dart';
import 'package:batrena/modules/branch_details_shown/add_item.dart';
import 'package:batrena/shared/colors.dart';
import 'package:flutter/material.dart';

import '../../shared/components/components.dart';

class BranchInventory extends StatelessWidget {
  final Branch branch;
  const BranchInventory({super.key, required this.branch});

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: lavendarBlush),
        title: Text(
          " ${branch.name} inventory",
          style: textTheme.bodyLarge,
        ),
      ),
      body: ListView.builder(
        itemBuilder: (context, index) => parentItem(
            item: branch.parentItems[index],
            theme: textTheme,
            context: context),
        itemCount: branch.parentItems.length,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: carrebianCurrent,
        onPressed: () {
          navigateTo(
              context,
              AddItem(
                branch: branch,
              ));
        },
        child: Icon(
          Icons.add,
          color: lavendarBlush,
        ),
      ),
    );
  }

  Widget parentItem(
      {required ParentItem item,
      required TextTheme theme,
      required BuildContext context}) {
    var size = MediaQuery.of(context).size;
    bool isMobile = size.width <= 600;
    return SizedBox(
      width: size.width * 0.8,
      height: size.height * 0.13,
      child: Card(
        elevation: 2,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: isMobile ? 2 : 15),
                child: Text(
                  item.name,
                  style: theme.bodyLarge!.copyWith(
                      fontSize:
                          isMobile ? size.width * 0.075 : size.width * 0.025,
                      color: raisinBlack.shade900),
                ),
              ),
              Row(
                children: [
                  Text(
                    "${item.price} LE",
                    style: theme.bodyLarge!.copyWith(
                        fontSize:
                            isMobile ? size.width * 0.068 : size.width * 0.02,
                        color: Colors.grey[700]),
                  ),
                  Text(
                    "    (${item.items.length})",
                    style: theme.bodyLarge!.copyWith(
                        fontSize:
                            isMobile ? size.width * 0.068 : size.width * 0.02,
                        color: raisinBlack),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
