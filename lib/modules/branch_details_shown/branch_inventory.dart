import 'package:batrena/cubit/add_item/add_item_cubit.dart';
import 'package:batrena/models/branch_model.dart';
import 'package:batrena/modules/branch_details_shown/add_item.dart';
import 'package:batrena/modules/branch_details_shown/edit_item.dart';
import 'package:batrena/shared/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import '../../shared/components/components.dart';

class BranchInventory extends StatelessWidget {
  final Branch branch;
  const BranchInventory({super.key, required this.branch});

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    var cubit = AddItemCubit.get(context);
    return BlocConsumer<AddItemCubit, AddItemStates>(
      listener: (context, state) {},
      builder: (context, state) {
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
                context: context,
                cubit: cubit),
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
      },
    );
  }

  Widget parentItem({
    required ParentItem item,
    required TextTheme theme,
    required BuildContext context,
    required AddItemCubit cubit,
  }) {
    var size = MediaQuery.of(context).size;
    bool isMobile = size.width <= 600;
    return Slidable(
      key: ValueKey(item.id),
      endActionPane: ActionPane(
        motion: const ScrollMotion(),
        dismissible: DismissiblePane(onDismissed: () {}),
        children: [
          SlidableAction(
            onPressed: (context) {},
            spacing: 15,
            backgroundColor: lavendarBlush,
            foregroundColor: Colors.red,
            icon: Icons.delete,
            label: 'Delete',
          ),
          SlidableAction(
            spacing: 15,
            onPressed: (context) {
              navigateTo(context, EditItem(item: item,branch: branch,));
            },
            backgroundColor: lavendarBlush,
            foregroundColor: carrebianCurrent,
            icon: Icons.edit,
            label: 'Edit',
          ),
        ],
      ),
      child: SizedBox(
        width: double.infinity,
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
                            isMobile ? size.width * 0.063 : size.width * 0.025,
                        color: raisinBlack.shade900),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "${item.price} LE",
                      style: theme.bodyLarge!.copyWith(
                          fontSize:
                              isMobile ? size.width * 0.05 : size.width * 0.02,
                          color: Colors.grey[700]),
                    ),
                    Text(
                      "    (${item.items.length})",
                      style: theme.bodyLarge!.copyWith(
                          fontSize:
                              isMobile ? size.width * 0.05 : size.width * 0.02,
                          color: raisinBlack),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
