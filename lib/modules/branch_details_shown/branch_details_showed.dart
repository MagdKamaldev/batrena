import 'package:batrena/cubit/branch_details_cubit/branch_details_cubit.dart';
import 'package:batrena/models/branch_model.dart';
import 'package:batrena/modules/branch_details_shown/branch_inventory.dart';
import 'package:batrena/shared/colors.dart';
import 'package:batrena/shared/components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BranchDetailsShown extends StatelessWidget {
  final Branch branch;
  const BranchDetailsShown({super.key, required this.branch});

  @override
  Widget build(BuildContext context) {
    var cubit = BranchDetailsCubit.get(context);
    var size = MediaQuery.of(context).size;
    var textTheme = Theme.of(context).textTheme;
    return BlocConsumer<BranchDetailsCubit, BranchDetailsState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            iconTheme: IconThemeData(color: lavendarBlush),
            title: Text(
              branch.name,
              style: textTheme.bodyLarge,
            ),
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                  width: size.width,
                  height: size.height * 0.3,
                  child: Hero(
                    tag: "branch ${branch.id}",
                    child: Image.asset(
                      "assets/images/batrena.jpg",
                      fit: BoxFit.cover,
                    ),
                  )),
              SizedBox(
                height: size.height * 0.04,
              ),
              Text(
                "ID : ${branch.id.toString()}",
                style: textTheme.bodyLarge!.copyWith(color: raisinBlack),
              ),
              SizedBox(
                height: size.height * 0.04,
              ),
              Container(
                width: double.infinity,
                height: 1,
                color: carrebianCurrent,
              ),
              SizedBox(
                height: size.height * 0.04,
              ),
              Text(
                "Total Sales : 500 L.E.",
                style: textTheme.bodyLarge!.copyWith(color: raisinBlack),
              ),
              SizedBox(
                height: size.height * 0.04,
              ),
              Container(
                width: double.infinity,
                height: 1,
                color: carrebianCurrent,
              ),
              SizedBox(
                height: size.height * 0.04,
              ),
              Text(
                "Current shift :  shift guy",
                style: textTheme.bodyLarge!.copyWith(color: raisinBlack),
              ),
              SizedBox(
                height: size.height * 0.04,
              ),
              Container(
                width: double.infinity,
                height: 1,
                color: carrebianCurrent,
              ),
              SizedBox(
                height: size.height * 0.04,
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  decoration: BoxDecoration(
                    color: carrebianCurrent,
                  ),
                  width: size.width * 0.48,
                  height: size.height * 0.08,
                  child: MaterialButton(
                    color: carrebianCurrent,
                    onPressed: () {
                      navigateTo(context, BranchInventory(branch: branch,));
                    },
                    child: Row(
                      children: [
                        Text(
                          "Inventory",
                          style: textTheme.bodyLarge!
                              .copyWith(color: lavendarBlush),
                        ),
                        SizedBox(
                          width: size.width * 0.04,
                        ),
                        Icon(
                          Icons.arrow_forward_ios,
                          color: lavendarBlush,
                        )
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: size.height * 0.04,
              ),
            ],
          ),
        );
      },
    );
  }
}
