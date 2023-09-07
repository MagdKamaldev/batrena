part of 'add_item_cubit.dart';

abstract class AddItemStates {}

class AddItemInitial extends AddItemStates {}

class IncrementQuantity extends AddItemStates {}

class DecrementQuantity extends AddItemStates{}

class AddToInventoryLoadingState extends AddItemStates{}

class AddToInventorySuccessState extends AddItemStates{}

class AddToInventoryErrorState extends AddItemStates{}
