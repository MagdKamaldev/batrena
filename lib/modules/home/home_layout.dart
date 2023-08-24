import 'package:batrena/modules/add_branch/add_branch_screen.dart';
import 'package:batrena/modules/home/drawer.dart';
import 'package:batrena/shared/colors.dart';
import 'package:batrena/shared/components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../cubit/home_cubit/app_cubit.dart';
import '../../models/branch_model.dart';

class HomeLayout extends StatelessWidget {
  const HomeLayout({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = AppCubit.get(context);
    var size = MediaQuery.of(context).size;
    var textTheme = Theme.of(context).textTheme;
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            iconTheme: IconThemeData(color: lavendarBlush),
            title: Text(
              "Batrena Manager",
              style: textTheme.bodyLarge,
            ),
          ),
          drawer: const AppDrawer(),
          body: Padding(
            padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: raisinBlack, width: 1.5),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      children: [
                        Text(
                          "Branches",
                          style:
                              textTheme.bodyLarge!.copyWith(color: raisinBlack),
                        ),
                        const Spacer(),
                        SizedBox(
                            width: size.width * 0.4,
                            height: size.height * 0.08,
                            child: Image.asset("assets/images/branches.png")),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.03,
                  ),
                  GridView.count(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: 2,
                    mainAxisSpacing: 20,
                    crossAxisSpacing: 20,
                    childAspectRatio: 1 / 1.3,
                    children: List.generate(
                      cubit.branches.length,
                      (index) => buildBranchItem(
                          context: context, branch: cubit.branches[index]),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          ),
          floatingActionButton: FloatingActionButton(
            backgroundColor: carrebianCurrent,
            onPressed: () {
              navigateTo(context, AddBranch());
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

  Widget buildBranchItem({
    required BuildContext context,
    required Branch branch,
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  branch.name,
                  style: textTheme.titleMedium!.copyWith(color: lavendarBlush),
                ),
                SizedBox(
                    height: size.height * 0.03,
                    child: Image.asset("assets/images/branch.png")),
              ],
            ),
            SizedBox(
              height: size.height * 0.02,
            ),
            Container(
              width: double.infinity,
              height: 1,
              color: lavendarBlush,
            ),
            SizedBox(
              height: size.height * 0.02,
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: SizedBox(
                height: size.height * 0.1,
                child: Image.asset(
                  "assets/images/batrena.jpg",
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  "Details",
                  style: textTheme.titleMedium!.copyWith(color: lavendarBlush),
                ),
                Icon(
                  Icons.navigate_next,
                  color: lavendarBlush,
                ),
              ],
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
