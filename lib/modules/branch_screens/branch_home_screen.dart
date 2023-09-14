import 'package:batrena/cubit/branch_view/branch_view_cubit.dart';
import 'package:batrena/models/branch_model.dart';
import 'package:batrena/modules/branch_screens/cart_screen.dart';
import 'package:batrena/modules/change_shift/change_shift_screen.dart';
import 'package:batrena/shared/colors.dart';
import 'package:batrena/shared/components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BranchHomeScreen extends StatelessWidget {
  const BranchHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    var cubit = BranchViewCubit.get(context);
    var size = MediaQuery.of(context).size;
    bool isMobile = size.width <= 600;
    double heightRatio = isMobile ? 1.2 : 1.05;
    bool isPc = size.width > 600;

    return FutureBuilder(
        future: cubit.loadData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return BlocConsumer<BranchViewCubit, BranchViewStates>(
                listener: (context, state) {},
                builder: (context, state) {
                  return Scaffold(
                    drawer: isMobile
                        ? Drawer(
                            child: Column(
                              children: [
                                const SizedBox(
                                  height: 50,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    navigateTo(context, const CartScreen());
                                  },
                                  child: Container(
                                    height: 50,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      color: const Color.fromRGBO(238, 245, 245, 1),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Center(
                                      child: Text(
                                        "Cart",
                                        style:
                                        textTheme.bodyLarge!.copyWith(
                                          color: carrebianCurrent,
                                          fontSize: 20,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: size.height * 0.03,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    navigateTo(
                                        context,
                                        ChangeShiftScreen(
                                          branch: cubit.branch,
                                        ));
                                  },
                                  child: Container(
                                    height: 50,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      color: const Color.fromRGBO(238, 245, 245, 1),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Center(
                                      child: Text(
                                        "Change Shift",
                                        overflow: TextOverflow.ellipsis,
                                        style:
                                        textTheme.bodyLarge!.copyWith(
                                          color: carrebianCurrent,
                                          fontSize: 20,
                                        ),
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
                                    height: 50,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      color: const Color.fromRGBO(238, 245, 245, 1),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Center(
                                      child: Text(
                                        "Logout",
                                        style:
                                        textTheme.bodyLarge!.copyWith(
                                          color: carrebianCurrent,
                                          fontSize: 20,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        : null,
                    appBar: AppBar(
                      iconTheme: IconThemeData(color: lavendarBlush),
                      title: Text(
                        "${cubit.branch.name} (${cubit.branch.currentShift.employee.name})",
                        style: textTheme.bodyLarge!.copyWith(
                            fontSize:
                                isPc ? size.width * 0.02 : size.width * 0.05),
                      ),
                    ),
                    floatingActionButton: FloatingActionButton(
                      onPressed: () {
                        navigateTo(context, const CartScreen());
                      },
                      backgroundColor: carrebianCurrent,
                      child: Icon(
                        Icons.shopping_cart,
                        color: lavendarBlush,
                      ),
                    ),
                    body: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (!isMobile)
                              SizedBox(
                                height: size.height,
                                width: size.width * 0.2,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        navigateTo(context, const CartScreen());
                                      },
                                      child: Container(
                                        height: 50,
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                          color: const Color.fromRGBO(238, 245, 245, 1),
                                          borderRadius: BorderRadius.circular(12),
                                        ),
                                        child: Center(
                                          child: Text(
                                            "Cart",
                                            style:
                                                textTheme.bodyLarge!.copyWith(
                                              color: carrebianCurrent,
                                              fontSize: 20,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: size.height * 0.03,
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        navigateTo(
                                            context,
                                            ChangeShiftScreen(
                                              branch: cubit.branch,
                                            ));
                                      },
                                      child: Container(
                                        height: 50,
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                          color: const Color.fromRGBO(238, 245, 245, 1),
                                          borderRadius: BorderRadius.circular(12),
                                        ),
                                        child: Center(
                                          child: Text(
                                            "Change Shift",
                                            overflow: TextOverflow.ellipsis,
                                            style:
                                                textTheme.bodyLarge!.copyWith(
                                              color: carrebianCurrent,
                                              fontSize: 20,
                                            ),
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
                                        height: 50,
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                          color: const Color.fromRGBO(238, 245, 245, 1),
                                          borderRadius: BorderRadius.circular(12),
                                        ),
                                        child: Center(
                                          child: Text(
                                            "Logout",
                                            style:
                                                textTheme.bodyLarge!.copyWith(
                                              color: carrebianCurrent,
                                              fontSize: 20,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            if (!isMobile)
                              SizedBox(
                                width: size.width * 0.03,
                              ),
                            if (!isMobile)
                              Container(
                                height: size.height * 0.9,
                                width: 1,
                                color: carrebianCurrent,
                              ),
                            if (!isMobile)
                              SizedBox(
                                width: size.width * 0.03,
                              ),
                            Expanded(
                              child: GridView.count(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                crossAxisCount: isMobile ? 2 : 6,
                                mainAxisSpacing: isMobile ? 16 : 20,
                                crossAxisSpacing: isMobile ? 16 : 20,
                                childAspectRatio: 1.2 / (heightRatio+0.14),
                                children: List.generate(
                                  cubit.branch.parentItems.length,
                                  (index) => Padding(
                                    padding: isMobile
                                        ? const EdgeInsets.only(
                                            top: 12,
                                          )
                                        : EdgeInsets.zero,
                                    child: buildBranchItem(
                                        context: context,
                                        item: cubit.branch.parentItems[index]),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                });
          } else {
            return const Scaffold(
                body: Center(child: CircularProgressIndicator()));
          }
        });
  }

  Widget buildBranchItem({
    required BuildContext context,
    required ParentItem item,
  }) {
    var textTheme = Theme.of(context).textTheme;
    var cubit = BranchViewCubit.get(context);
    var size = MediaQuery.of(context).size;
    bool isMobile = size.width <= 500;

    return Container(
      decoration: BoxDecoration(
        color: carrebianCurrent,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (!isMobile)
                SizedBox(
                  height: size.height * 0.002,
                ),
              Column(
                children: [
                  SizedBox(
                    height: size.height * 0.006,
                  ),
                  Text(
                    item.name,
                    style: textTheme.bodyLarge!.copyWith(
                      fontSize:
                          isMobile ? size.width * 0.07 : size.width * 0.018,
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.005,
                  ),
                  Container(
                    width: double.infinity,
                    height: 1,
                    color: lavendarBlush,
                  ),
                  SizedBox(
                    height: size.height * 0.01,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        "${item.price} EGP",
                        style: textTheme.titleMedium!.copyWith(
                            color: lavendarBlush,
                            fontSize: isMobile
                                ? size.width * 0.05
                                : size.width * 0.013),
                      ),

                      Text(
                        "(${item.items.length.toString()})",
                        style: textTheme.titleMedium!.copyWith(
                            fontSize: isMobile
                                ? size.width * 0.05
                                : size.width * 0.013,
                            color: lavendarBlush),
                      ),

                    ],
                  ),
                ],
              ),
              SizedBox(
                height: isMobile ? size.height * 0.04 : size.height * 0.02,
              ),
              SizedBox(
                child: TextButton(
                    onPressed: () {
                      cubit.addTocart(
                          item: item.items.first,
                          parent: item,
                          context: context);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Add Item",
                          style: textTheme.titleMedium!.copyWith(
                            fontSize: isMobile
                                ? size.width * 0.06
                                : size.width * 0.013,
                            color: lavendarBlush,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 5.0),
                          child: Icon(
                            Icons.add_circle_rounded,
                            color: lavendarBlush,
                            size: isMobile
                                ? size.width * 0.06
                                : size.width * 0.023,
                          ),
                        ),
                      ],
                    )),
              )
            ],
          ),
        ],
      ),
    );
  }
}
