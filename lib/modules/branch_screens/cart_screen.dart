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
        var size = MediaQuery.of(context).size;
        bool isPc = size.width > 600;
        return Scaffold(
          appBar: AppBar(
            iconTheme: IconThemeData(color: lavendarBlush),
            title: Text(
              "${cubit.branch.name} Cart",
              style: textTheme.bodyLarge!.copyWith(
                  fontSize: isPc ? size.width * 0.02 : size.width * 0.05),
            ),
          ),
          body: ListView(
            children: [
              ...List.generate(
                cubit.parentItems.length,
                (index) => parentItem(
                    item: cubit.parentItems[index],
                    theme: textTheme,
                    context: context),
              ),
            ],
          ),
          bottomNavigationBar: ConditionalBuilder(
            condition: state is! CheckOutLoadingState,
            builder: (context) => Container(
                color: carrebianCurrent,
                width: 20,
                height: MediaQuery.of(context).size.height * 0.08,
                child: TextButton(
                    onPressed: () {
                      cubit.checkout(context);
                    },
                    child: Text(
                      "Checkout (${cubit.totalPrice} EGP)",
                      style: textTheme.bodyLarge!
                          .copyWith(fontSize: size.height * 0.037),
                    ))),
            fallback: (context) => const Center(
              child: CircularProgressIndicator(),
            ),
          ),
        );
      },
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
          padding: EdgeInsets.symmetric(horizontal: isMobile ? 3 : 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: isMobile ? 2 : 15),
                child: Text(
                  item.name,
                  style: theme.bodyLarge!.copyWith(
                      fontSize:
                          isMobile ? size.width * 0.05 : size.width * 0.025,
                      color: raisinBlack.shade900),
                ),
              ),
              Row(
                children: [
                  Text(
                    "${item.price} LE",
                    style: theme.bodyLarge!.copyWith(
                        fontSize: isMobile ? 14 : size.width * 0.02,
                        color: Colors.grey[700]),
                  ),
                  SizedBox(
                    width: size.width * 0.05,
                  ),
                  ClipOval(
                    child: Material(
                      color: carrebianCurrent,
                      child: InkWell(
                        onTap: () {},
                        child: SizedBox(
                          width: isMobile ? size.width * 0.09 : 40,
                          height: isMobile ? size.width * 0.09 : 40,
                          child: Icon(
                            Icons.add,
                            color: lavendarBlush,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: isMobile ? 10 : size.width * 0.02,
                  ),
                  Text(
                    "${item.items.length}",
                    style: theme.bodyLarge!.copyWith(
                        fontSize:
                            isMobile ? size.width * 0.05 : size.width * 0.02,
                        color: raisinBlack),
                  ),
                  SizedBox(
                    width: isMobile ? 10 : size.width * 0.02,
                  ),
                  ClipOval(
                    child: Material(
                      color: carrebianCurrent,
                      child: InkWell(
                        onTap: () {},
                        child: SizedBox(
                          width: isMobile ? size.width * 0.09 : 40,
                          height: isMobile ? size.width * 0.09 : 40,
                          child: Icon(
                            Icons.remove,
                            color: lavendarBlush,
                          ),
                        ),
                      ),
                    ),
                  ),
                  if (!isMobile)
                    SizedBox(
                      width: size.width * 0.03,
                    ),
                  if (!isMobile)
                    Container(
                      width: 4,
                      height: double.infinity,
                      color: lavendarBlush,
                    ),
                  if (!isMobile)
                    SizedBox(
                      width: size.width * 0.02,
                    ),
                  IconButton(
                      onPressed: () {
                        BranchViewCubit.get(context).deleteParentItemFromCart(
                          item: item.items[0],
                          parent: item,
                          context: context,
                        );
                      },
                      icon: Icon(
                        Icons.delete,
                        color: Colors.red,
                        size: isMobile ? 25 : size.width * 0.04,
                      ))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
