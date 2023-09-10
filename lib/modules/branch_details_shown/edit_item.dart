// ignore_for_file: must_be_immutable
import 'package:batrena/cubit/add_item/add_item_cubit.dart';
import 'package:batrena/shared/colors.dart';
import 'package:batrena/shared/components/components.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../models/branch_model.dart';

class EditItem extends StatelessWidget {
  final ParentItem item;
  final Branch branch;

  EditItem({super.key, required this.item, required this.branch});

  var nameController = TextEditingController();
  var priceController = TextEditingController();
  var quantityController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    var cubit = AddItemCubit.get(context);
    var size = MediaQuery.of(context).size;

    nameController.text = item.name;
    priceController.text = item.price.toString();
    quantityController.text = item.items.length.toString();
    cubit.updateQuantity = item.items.length;
    return BlocConsumer<AddItemCubit, AddItemStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            iconTheme: IconThemeData(color: lavendarBlush),
            title: Text(
              "Edit ${item.name}",
              style: textTheme.bodyLarge,
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Text(
                  "Update Item details",
                  style: textTheme.bodyLarge!.copyWith(color: raisinBlack),
                ),
                SizedBox(
                  height: size.height * 0.08,
                ),
                defaultFormField(
                    controller: nameController,
                    type: TextInputType.name,
                    onSubmit: () {},
                    validate: (String value) {
                      if (value.isEmpty) {
                        return "Field must not be empty !";
                      }
                    },
                    label: "Name",
                    prefix: Icons.add_to_home_screen_sharp,
                    context: context),
                SizedBox(
                  height: size.height * 0.04,
                ),
                defaultFormField(
                    controller: priceController,
                    type: TextInputType.number,
                    onSubmit: () {},
                    validate: (String value) {
                      if (value.isEmpty) {
                        return "Field must not be empty !";
                      }
                    },
                    label: "Price",
                    prefix: Icons.monetization_on_rounded,
                    context: context),
                SizedBox(
                  height: size.height * 0.08,
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Select quantity",
                    style: textTheme.bodyLarge!.copyWith(color: raisinBlack),
                  ),
                ),
                SizedBox(
                  height: size.height * 0.02,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: size.width * 0.4,
                      height: size.height * 0.1,
                      child: Card(
                        elevation: 2.0,
                        color: carrebianCurrent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IconButton(
                                onPressed: cubit.incrementupdateQuantity,
                                icon: Icon(
                                  Icons.add,
                                  color: celeste,
                                ),
                              ),
                              const Spacer(),
                              Text(
                                cubit.updateQuantity.toString(),
                                style: textTheme.bodyLarge,
                              ),
                              const Spacer(),
                              IconButton(
                                onPressed: cubit.decrementUpdateQuantity,
                                icon: Icon(
                                  Icons.remove,
                                  color: celeste,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const Spacer(),
                    Text(
                      "OR",
                      style:
                          textTheme.titleMedium!.copyWith(color: raisinBlack),
                    ),
                    const Spacer(),
                    SizedBox(
                      width: size.width * 0.35,
                      height: size.height * 0.079,
                      child: defaultFormField(
                        controller: quantityController,
                        type: TextInputType.number,
                        onSubmit: () {},
                        validate: () {},
                        label: "Quantity",
                        prefix: Icons.numbers,
                        context: context,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: size.height * 0.1,
                ),
              ],
            ),
          ),
          bottomNavigationBar: ConditionalBuilder(
            condition: state is! AddToInventoryLoadingState,
            fallback: (context) => const Center(
              child: CircularProgressIndicator(),
            ),
            builder: (context) => SizedBox(
              width: size.width * 0.8,
              height: size.height * 0.08,
              child: MaterialButton(
                color: carrebianCurrent,
                onPressed: () {
                  if (nameController.text.isNotEmpty ||
                      priceController.text.isNotEmpty) {
                    // AddItemCubit.get(context).addParentItemToInventory(
                    //     name: nameController.text,
                    //     price: double.parse(priceController.text),
                    //     quantity: quantityController.text.isEmpty
                    //         ? AddItemCubit.get(context).updateQuantity
                    //         : int.parse(quantityController.text),
                    //     context: context,
                    //     branch: branch);
                    cubit.editParentItem(
                      name: nameController.text,
                      price: double.parse(priceController.text),
                      quantity: quantityController.text.isEmpty
                          ? cubit.updateQuantity
                          : int.parse(quantityController.text),
                      context: context,
                      branch: branch,
                      item: item,
                    );
                  } else {
                    showCustomSnackBar(
                        context, "Required fields are empty !", Colors.red);
                  }
                },
                child: Text(
                  "Update",
                  style: textTheme.bodyLarge,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
