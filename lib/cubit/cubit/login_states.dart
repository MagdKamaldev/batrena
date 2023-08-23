part of 'login_cubit.dart';


abstract class LoginStates {}

class LoginInitialState extends LoginStates {}

class LoginLoadingState extends LoginStates {}

class LoginSuccessState extends LoginStates{}

class LoginErrorState extends LoginStates{}

class GetUserInfoLoadingState extends LoginStates{} 

class GetUserInfoSuccessState extends LoginStates{}

class GetUserInfoErrorState extends LoginStates{}


