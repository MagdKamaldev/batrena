part of 'branch_details_cubit.dart';


abstract class BranchDetailsState {}

final class BranchDetailsInitial extends BranchDetailsState {}

class GetExcellLoadingState extends BranchDetailsState {}

class GetExcellSucceededState extends BranchDetailsState{}

class GetExcellErrorState extends BranchDetailsState{}
