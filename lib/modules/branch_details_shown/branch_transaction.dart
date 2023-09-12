import 'package:batrena/cubit/branch_details_cubit/branch_details_cubit.dart';
import 'package:batrena/shared/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../models/branch_model.dart';

class BranchTransactions extends StatelessWidget {
  final Branch branch;
  const BranchTransactions({super.key, required this.branch});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var textTheme = Theme.of(context).textTheme;
    var cubit = BranchDetailsCubit.get(context);
    return BlocConsumer<BranchDetailsCubit, BranchDetailsState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            iconTheme: IconThemeData(color: lavendarBlush),
            title: Text(
              "${branch.name} Transactions",
              style: textTheme.bodyLarge,
            ),
          ),
          body: ListView.builder(
            itemBuilder: (context, index) => parentItem(
                item: branch.transactions![index],
                theme: textTheme,
                context: context,
                cubit: cubit),
            itemCount: branch.transactions!.length,
          ),
          bottomNavigationBar: Container(
              color: carrebianCurrent,
              width: 20,
              height: size.height * 0.08,
              child: TextButton(
                  onPressed: () {
                    cubit.generateExcellSheet(
                        branchId: branch.id, branch: branch);
                  },
                  child: Text(
                    "Generate Excel Sheet",
                    style: textTheme.bodyLarge,
                  ))),
        );
      },
    );
  }

  Widget parentItem({
    required item,
    required TextTheme theme,
    required BuildContext context,
    required BranchDetailsCubit cubit,
  }) {
    var size = MediaQuery.of(context).size;
    bool isMobile = size.width <= 600;
    String dateString = item["CreatedAt"];
    String formattedDate =
        DateFormat('dd-MM-yyyy / HH:mm').format(DateTime.parse(dateString));
    return SizedBox(
      width: double.infinity,
      height: size.height * 0.13,
      child: Card(
        elevation: 2,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 7),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Total Cost :   ",
                    style: theme.bodyLarge!.copyWith(
                        fontSize:
                            isMobile ? size.width * 0.05 : size.width * 0.02,
                        color: Colors.grey[700]),
                  ),
                  Text(
                    "${item["total_cost"].toString()} EGP",
                    style: theme.bodyLarge!.copyWith(
                        fontSize:
                            isMobile ? size.width * 0.05 : size.width * 0.02,
                        color: raisinBlack),
                  ),
                ],
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: Text(
                  formattedDate,
                  style: theme.titleSmall!.copyWith(color: Colors.grey),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
