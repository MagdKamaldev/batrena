import 'package:batrena/cubit/branch_view/branch_view_cubit.dart';
import 'package:batrena/models/branch_model.dart';
import 'package:batrena/modules/branch_screens/cart_screen.dart';
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
                                ElevatedButton(
                                  onPressed: () {
                                    navigateTo(context, const CartScreen());
                                  },
                                  child: SizedBox(
                                    height: 40,
                                    width: double.infinity,
                                    child: Center(
                                      child: Text(
                                        "Cart",
                                        style: textTheme.bodyLarge!
                                            .copyWith(color: carrebianCurrent),
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
                        "${cubit.branch.name} inventory",
                        style: textTheme.bodyLarge,
                      ),
                    ),
                    floatingActionButton: FloatingActionButton(
                      onPressed: () {
                        navigateTo(context, CartScreen());
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
                        child: GridView.count(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          crossAxisCount: isMobile ? 2 : 6,
                          mainAxisSpacing: isMobile ? 16 : 20,
                          crossAxisSpacing: isMobile ? 16 : 20,
                          childAspectRatio: 1 / heightRatio,
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
    print(size.width);

    return Container(
      decoration: BoxDecoration(
        color: carrebianCurrent,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Stack(
        children: [
          // ClipRRect(
          //   borderRadius: BorderRadius.circular(10),
          //   child: Image.asset(
          //     "assets/images/pepsi.jpg",
          //     fit: BoxFit.cover,
          //   ),
          // ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (!isMobile)
                SizedBox(
                  height: size.height * 0.01,
                ),
              Column(
                children: [
                  SizedBox(
                    height: size.height * 0.02,
                  ),
                  Text(
                    item.name,
                    style: textTheme.bodyLarge!.copyWith(
                      fontSize:
                          isMobile ? size.width * 0.08 : size.width * 0.023,
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
              const Spacer(),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: SizedBox(
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
                                  : size.width * 0.015,
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
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
