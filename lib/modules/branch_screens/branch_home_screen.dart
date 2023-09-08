import 'package:batrena/cubit/branch_view/branch_view_cubit.dart';
import 'package:batrena/models/branch_model.dart';
import 'package:batrena/shared/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BranchHomeScreen extends StatelessWidget {
  const BranchHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    var cubit = BranchViewCubit.get(context);
    return BlocConsumer<BranchViewCubit, BranchViewStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return FutureBuilder(
            future: cubit.loadData,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Scaffold(
                  appBar: AppBar(
                    title: Text(
                      "${cubit.branch.name} inventory",
                      style: textTheme.bodyLarge,
                    ),
                  ),
                  body: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: GridView.count(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      crossAxisCount: 2,
                      mainAxisSpacing: 20,
                      crossAxisSpacing: 20,
                      childAspectRatio: 1 / 1.3,
                      children: List.generate(
                        cubit.branch.parentItems.length,
                        (index) => buildBranchItem(
                            context: context, item: cubit.branch.parentItems[index]),
                      ),
                    ),
                  ),
                );
              } else {
                return const Scaffold(
                    body: Center(child: CircularProgressIndicator()));
              }
            });
      },
    );
  }

  Widget buildBranchItem({
    required BuildContext context,
    required ParentItem item,
  }) {
    var size = MediaQuery.of(context).size;
    var textTheme = Theme.of(context).textTheme;
    return Container(
      decoration: BoxDecoration(
        color: carrebianCurrent,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 12, left: 15, right: 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Spacer(),
            Text(
              item.name,
              style: textTheme.bodyLarge,
            ),
            const Spacer(),
            Container(
              width: double.infinity,
              height: 1,
              color: lavendarBlush,
            ),
            const Spacer(),
            Text(
              item.price.toString(),
              style: textTheme.titleMedium!.copyWith(color: lavendarBlush),
            ),
            const Spacer(),
            TextButton(
                onPressed: () {},
                child: Row(
                  children: [
                    Text(
                      "Add To Cart",
                      style: textTheme.bodyLarge!.copyWith(fontSize: 14),
                    ),
                    SizedBox(
                      width: size.width * 0.02,
                    ),
                    Icon(
                      Icons.add_circle_rounded,
                      color: lavendarBlush,
                    )
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
