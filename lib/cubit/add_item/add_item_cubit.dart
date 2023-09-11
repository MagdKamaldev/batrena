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

  var addQuantityController = TextEditingController();

  void setAddIncDecSameAsController() {
    addQuantity = int.parse(addQuantityController.text);
    emit(SetAddIncDecSameAsController());
  }

  int addQuantity = 1;
  var quantityController = TextEditingController();

  void incrementAddQuantity() {
    addQuantity++;
     addQuantityController.text = addQuantity.toString();
    emit(IncrementQuantity());
  }

  void decrementAddQuantity() {
    if (addQuantity > 1) {
      addQuantity--;
      addQuantityController.text = addQuantity.toString();
      emit(DecrementQuantity());
    }
  }

  int updateQuantity = 1;

  void incrementupdateQuantity() {
    updateQuantity++;
    quantityController.text = updateQuantity.toString();
    emit(IncrementQuantity());
  }

  void decrementUpdateQuantity() {
    if (updateQuantity > 1) {
      updateQuantity--;
      quantityController.text = updateQuantity.toString();
      emit(DecrementQuantity());
    }
  }

  void setIncDecSameAsController() {
    updateQuantity = int.parse(quantityController.text);
    emit(SetIncDecSameAsController());
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

  void editParentItem({
    required String name,
    required double price,
    required int quantity,
    required BuildContext context,
    required ParentItem item,
    required Branch branch,
  }) {
    emit(AddToInventoryLoadingState());

    List<Item> items = [];
    for (int i = 0; i < quantity; i++) {
      items.add(Item(isSold: false, name: name, price: price));
    }

    branch.parentItems.remove(item);

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

  void deleteParentItem({
    required BuildContext context,
    required ParentItem item,
    required Branch branch,
  }) {
    emit(DeleteParentItemLoadingState());
    branch.parentItems.remove(item);
    emit(DeleteParentItemLocalSuccessState());
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
        "Item Deleted",
        value.data["message"] == "Branch Updated" ? Colors.green : Colors.red,
      );
      AppCubit.get(context).fetchBranches();
      Navigator.pop(context);
      emit(DeleteParentItemSuccessState());
    }).catchError((error) {
      emit(DeleteParentItemErrorState());
    });
  }
}
