import 'package:batrena/cubit/branch_details_cubit/branch_details_cubit.dart';
import 'package:batrena/models/branch_model.dart';
import 'package:batrena/shared/colors.dart';
import 'package:flutter/material.dart';

class BranchInventory extends StatelessWidget {
  final Branch branch;
  const BranchInventory({super.key, required this.branch});

  @override
  Widget build(BuildContext context) {
    var cubit = BranchDetailsCubit.get(context);
    var size = MediaQuery.of(context).size;
    var textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: lavendarBlush),
        title: Text(
          " ${branch.name} inventory",
          style: textTheme.bodyLarge,
        ),
      ),
    );
  }
}
