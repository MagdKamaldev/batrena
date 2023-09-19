// ignore_for_file: use_build_context_synchronously
import 'package:batrena/main.dart';
import 'package:batrena/models/branch_model.dart';
import 'package:batrena/shared/components/components.dart';
import 'package:batrena/shared/networks/remote/dio_helper.dart';
import 'package:batrena/shared/networks/remote/end_points.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'branch_view_state.dart';

class BranchViewCubit extends Cubit<BranchViewStates> {
  BranchViewCubit() : super(BranchViewInitial());
  static BranchViewCubit get(context) => BlocProvider.of(context);

  late Branch branch;

  Future<bool> get loadData async {
    await DioHelper.getData(url: EndPoints.fetchBranchData, jwt: jwt)
        .then((value) {
      branch = Branch.fromJson(value.data);
    });
    return true;
  }

  double totalPrice = 0.0;
  List<Item> cartItems = [];
  List<ParentItem> parentItems = [];

  void addTocart({
    required Item item,
    required ParentItem parent,
    required BuildContext context,
  }) {
    bool isAdded = false;
    for (ParentItem parentItem in parentItems) {
      if (parentItem.id == item.parentItemId) {
        parentItem.items.add(item);
        isAdded = true;
      }
    }
    if (!isAdded) {
      parentItems.add(ParentItem(
          id: item.parentItemId,
          price: item.price!,
          name: parent.name,
          items: [item]));
    }

    totalPrice = totalPrice + item.price!;
    cartItems.add(item);
    parent.items.remove(item);
    showCustomSnackBar(context, "Added Successfully", Colors.green);
    emit(AddToCart());
  }

 

  void deleteParentItemFromCart({
    required Item item,
    required ParentItem parent,
    required BuildContext context,
  }) async {
    parentItems.remove(parent);
    branch.parentItems.add(parent);
    await loadData;
    num itemsPrices = 0.0;
    for (item in parent.items) {
      itemsPrices = itemsPrices + item.price!;
    }
    totalPrice = totalPrice - itemsPrices;
    showCustomSnackBar(context, "Deleted Successfully", Colors.red);
    emit(RemoveFromCart());
  }

  // void decrementItem({
  //   required Item item,
  //   required ParentItem parent,
  // })  {
  //   cartItems.remove(item);
  //   parent.items.remove(item);
  //   totalPrice = totalPrice + item.price!;
  //   emit(DecrementItems());
  // }

  List<Map<String, int>> itemIds = [];
  void checkout(context) {
    emit(CheckOutLoadingState());

    for (Item item in cartItems) {
      itemIds.add({"ID": item.id!});
    }

    DioHelper.postData(url: EndPoints.registerTransaction, jwt: jwt, data: {
      "items": itemIds,
    }).then((value) {
      cartItems.clear();
      parentItems.clear();
      totalPrice = 0.0;
      showCustomSnackBar(context, value.data["message"], Colors.green);
      Navigator.pop(context);
      emit(CheckOutSuccessState());
    }).catchError((error) {
      emit(CheckOutErrorState());
    });
  }
}
