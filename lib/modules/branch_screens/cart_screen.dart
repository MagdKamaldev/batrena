import 'package:batrena/cubit/branch_view/branch_view_cubit.dart';
import 'package:batrena/models/branch_model.dart';
import 'package:batrena/shared/colors.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BranchViewCubit, BranchViewStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = BranchViewCubit.get(context);
        TextTheme textTheme = Theme.of(context).textTheme;
        return Scaffold(
          appBar: AppBar(
            iconTheme: IconThemeData(color: lavendarBlush),
            title: Text(
              "${cubit.branch.name} Cart",
              style: textTheme.bodyLarge,
            ),
          ),
          body: ListView(
            children: [
              ...List.generate(
                cubit.parentItems.length,
                (index) => parentItem(
                    item: cubit.parentItems[index],
                    size: MediaQuery.of(context).size,
                    theme: textTheme),
              ),
            ],
          ),
          bottomNavigationBar: ConditionalBuilder(
            condition: state is ! CheckOutLoadingState,
            builder: (context) =>  Container(
                color: carrebianCurrent,
                width: 20,
                height: MediaQuery.of(context).size.height * 0.08,
                child: TextButton(
                    onPressed: () {
                      cubit.checkout(context);
                    },
                    child: Text(
                      "Chekout",
                      style: textTheme.bodyLarge,
                    ))),
            fallback: (context) => const Center(child: CircularProgressIndicator(),),
          ),
        );
      },
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
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                item.name,
                style: theme.bodyLarge!
                    .copyWith(fontSize: 20, color: raisinBlack.shade900),
              ),
              Row(
                children: [
                  Text(
                    "${item.price} LE",
                    style: theme.bodyLarge!
                        .copyWith(fontSize: 20, color: Colors.grey[700]),
                  ),
                  Text(
                    "    (${item.items.length})",
                    style: theme.bodyLarge!
                        .copyWith(fontSize: 20, color: raisinBlack),
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
