part of 'app_cubit.dart';

abstract class AppStates {}

final class AppInitial extends AppStates {}

class GetUserInfoLoadingState extends AppStates {}

class GetUserInfoSuccessState extends AppStates {}

class GetUserInfoErrorState extends AppStates {}

class FetchBranchesLoadingState extends AppStates {}

class FetchBranchesSuccessState extends AppStates {
 
}

class FetchBranchesErrorState extends AppStates {}
