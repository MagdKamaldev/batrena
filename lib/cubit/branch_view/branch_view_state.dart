part of 'branch_view_cubit.dart';

abstract class BranchViewStates {}

class BranchViewInitial extends BranchViewStates {}

class AddToCart extends BranchViewStates {}

class RemoveFromCart extends BranchViewStates {}

class IncrementItems extends BranchViewStates {}

class DecrementItems extends BranchViewStates {}

class CheckOutLoadingState extends BranchViewStates {}

class CheckOutSuccessState extends BranchViewStates {}

class CheckOutErrorState extends BranchViewStates {}
