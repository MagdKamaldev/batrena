part of 'add_branch_cubit.dart';

abstract class AddBranchState {}

class AddBranchInitial extends AddBranchState {}

class ResquestPermissionLoadingState extends AddBranchState {}

class ResquestPermissionSuccessState extends AddBranchState {}

class ResquestPermissionErrorState extends AddBranchState {}

class ResquestPermissionWarningState  extends AddBranchState{}

class GetLatLongLoadingState extends AddBranchState{}

class GetLatLongSuccessState extends AddBranchState{}

class GetLatLongErrorState extends AddBranchState{}

class SetBranchLoactionState extends AddBranchState{}

class SetMarkerLoadingState extends AddBranchState{}

class SetMarkerSuccessState extends AddBranchState{}

class CheckMarkersState extends AddBranchState{}

class AddBranchLoadingState extends AddBranchState{}

class AddBranchSuccessState extends AddBranchState{}

class AddBranchErrorState extends AddBranchState{}


