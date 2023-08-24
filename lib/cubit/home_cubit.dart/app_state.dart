part of 'app_cubit.dart';


abstract class AppStates {}

final class AppInitial extends AppStates {}

class GetUserInfoLoadingState extends AppStates{} 

class GetUserInfoSuccessState extends AppStates{}

class GetUserInfoErrorState extends AppStates{}
