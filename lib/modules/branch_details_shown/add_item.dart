// ignore_for_file: must_be_immutable
import 'package:batrena/models/branch_model.dart';
import 'package:batrena/shared/colors.dart';
import 'package:batrena/shared/components/components.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../cubit/add_item/add_item_cubit.dart';

class AddItem extends StatelessWidget {
  final Branch branch;
  AddItem({super.key, required this.branch});

  var nameController = TextEditingController();
  var priceController = TextEditingController();
  var quantityController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var cubit = AddItemCubit.get(context);
    var size = MediaQuery.of(context).size;
    var textTheme = Theme.of(context).textTheme;
    return BlocConsumer<AddItemCubit, AddItemStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            iconTheme: IconThemeData(color: lavendarBlush),
            title: Text(
              "Add Item ",
              style: textTheme.bodyLarge,
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Text(
                  "Please enter Item details",
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
                                onPressed: cubit.incrementQuantity,
                                icon: Icon(
                                  Icons.add,
                                  color: celeste,
                                ),
                              ),
                              const Spacer(),
                              Text(
                                cubit.quantity.toString(),
                                style: textTheme.bodyLarge,
                              ),
                              const Spacer(),
                              IconButton(
                                onPressed: cubit.decrementQuantity,
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
                ConditionalBuilder(
                  condition: state is! AddToInventoryLoadingState,
                  fallback: (context) => const Center(
                    child: CircularProgressIndicator(),
                  ),
                  builder: (context) => ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: SizedBox(
                      width: size.width * 0.8,
                      height: size.height * 0.08,
                      child: MaterialButton(
                        color: carrebianCurrent,
                        onPressed: () {
                          if (nameController.text.isNotEmpty ||
                              priceController.text.isNotEmpty) {
                            AddItemCubit.get(context).addParentItemToInventory(
                                name: nameController.text,
                                price: double.parse(priceController.text),
                                quantity: quantityController.text.isEmpty
                                    ? AddItemCubit.get(context).quantity
                                    : int.parse(quantityController.text),
                                context: context,
                                branch: branch);
                          } else {
                            showCustomSnackBar(context,
                                "Required fields are empty !", Colors.red);
                          }
                        },
                        child: Text(
                          "Add to inventory",
                          style: textTheme.bodyLarge,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
