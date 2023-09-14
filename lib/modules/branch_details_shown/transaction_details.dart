import 'package:batrena/cubit/branch_details_cubit/branch_details_cubit.dart';
import 'package:batrena/models/branch_model.dart';
import 'package:batrena/shared/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TransactionDetails extends StatelessWidget {
  final Transaction transaction;
  const TransactionDetails({super.key, required this.transaction});

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
              "Transactions Details",
              style: textTheme.bodyLarge!.copyWith(fontSize: 20),
            ),
          ),
          body: ListView.builder(
            itemBuilder: (context, index) => parentItem(
                item: transaction.itemsStruct![index],
                theme: textTheme,
                context: context,
                cubit: cubit),
            itemCount: transaction.items!.length,
          ),
        );
      },
    );
  }

  Widget parentItem({
    required Item item,
    required TextTheme theme,
    required BuildContext context,
    required BranchDetailsCubit cubit,
  }) {
    var size = MediaQuery.of(context).size;
    bool isMobile = size.width <= 600;
    return SizedBox(
      width: double.infinity,
      height: size.height * 0.13,
      child: Card(
        elevation: 2,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: isMobile ? 2 : 15),
                child: Text(
                  item.name!,
                  style: theme.bodyLarge!.copyWith(
                      fontSize:
                          isMobile ? size.width * 0.063 : size.width * 0.025,
                      color: raisinBlack.shade900),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "${item.price} LE",
                    style: theme.bodyLarge!.copyWith(
                        fontSize:
                            isMobile ? size.width * 0.05 : size.width * 0.02,
                        color: Colors.grey[700]),
                  ),
                  // Text(
                  //   "    (${item.})",
                  //   style: theme.bodyLarge!.copyWith(
                  //       fontSize:
                  //           isMobile ? size.width * 0.05 : size.width * 0.02,
                  //       color: raisinBlack),
                  // ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
