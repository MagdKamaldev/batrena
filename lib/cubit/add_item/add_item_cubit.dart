import 'package:batrena/cubit/home_cubit/app_cubit.dart';
import 'package:batrena/main.dart';
import 'package:batrena/models/branch_model.dart';
import 'package:batrena/shared/components/components.dart';
import 'package:batrena/shared/networks/remote/dio_helper.dart';
import 'package:batrena/shared/networks/remote/end_points.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'add_item_state.dart';

class AddItemCubit extends Cubit<AddItemStates> {
  AddItemCubit() : super(AddItemInitial());

  static AddItemCubit get(context) => BlocProvider.of(context);

  int addQuantity = 1;

  void incrementAddQuantity() {
    addQuantity++;
    emit(IncrementQuantity());
  }

  void decrementAddQuantity() {
    if (addQuantity > 1) {
      addQuantity--;
      emit(DecrementQuantity());
    }
  }


   int updateQuantity = 1;

  void incrementupdateQuantity() {
    updateQuantity++;
    emit(IncrementQuantity());
  }

  void decrementUpdateQuantity() {
    if (updateQuantity > 1) {
      updateQuantity--;
      emit(DecrementQuantity());
    }
  }

  

  void addParentItemToInventory({
    required String name,
    required double price,
    required int quantity,
    required BuildContext context,
    required Branch branch,
  }) {
    emit(AddToInventoryLoadingState());

    List<Item> items = [];
    for (int i = 0; i < quantity; i++) {
      items.add(Item(isSold: false, name: name, price: price));
    }

    final newParentItem = ParentItem(
      branchId: branch.id,
      name: name,
      price: price,
      items: items,
    );
    branch.parentItems.add(newParentItem);
    DioHelper.postData(jwt: jwt, url: EndPoints.updateBranch, data: {
      "ID": branch.id,
      "name": branch.name,
      "address": branch.address,
      "lat_lng": {
        "lat": branch.latLng.lat,
        "lng": branch.latLng.lng,
      },
      "parent_items":
          branch.parentItems.map((parentItem) => parentItem.toJson()).toList(),
    }).then((value) {
      showCustomSnackBar(
        context,
        value.data["message"],
        value.data["message"] == "Branch Updated" ? Colors.green : Colors.red,
      );
      AppCubit.get(context).fetchBranches();
      Navigator.pop(context);
      emit(AddToInventorySuccessState());
    });
  }
}
