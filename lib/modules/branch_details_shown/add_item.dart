// ignore_for_file: must_be_immutable
import 'package:batrena/shared/colors.dart';
import 'package:batrena/shared/components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubit/add_item/add_item_cubit.dart';

class AddItem extends StatelessWidget {
  AddItem({super.key});

  var nameController = TextEditingController();
  var priceController = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
                  "Please Enter Item details",
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
              ],
            ),
          ),
        );
      },
    );
  }
}
