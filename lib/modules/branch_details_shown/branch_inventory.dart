import 'package:batrena/models/branch_model.dart';
import 'package:batrena/shared/colors.dart';
import 'package:flutter/material.dart';

class BranchInventory extends StatelessWidget {
  final Branch branch;
  const BranchInventory({super.key, required this.branch});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
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
            item: branch.parentItems[index], size: size, theme: textTheme),
        itemCount: branch.parentItems.length,
      ),
    );
  }

  Widget parentItem({
    required ParentItem item,
    required size,
    required TextTheme theme,
  }) {
    return SizedBox(
      width: size.width * 0.8,
      height: size.height * 0.115,
      child: Card(
        elevation: 2,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              item.name,
              style: theme.bodyLarge!
                  .copyWith(fontSize: 20, color: raisinBlack.shade300),
            ),
            Row(
              children: [
                Text(
                  item.price.toString(),
                  style: theme.bodyLarge!
                      .copyWith(fontSize: 20, color: raisinBlack),
                ),
                Text(
                  "    (${item.items.length})",
                  style: theme.bodyLarge!
                      .copyWith(fontSize: 20, color: Colors.black),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
