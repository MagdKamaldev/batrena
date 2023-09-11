part of 'change_shift_cubit.dart';


abstract class ChangeShiftStates {}

class ChangeShiftInitial extends ChangeShiftStates {}

class CheckOTPLoadingState extends ChangeShiftStates {}

class CheckOTPSuccessState extends ChangeShiftStates {}

class CheckOTPErrorState extends ChangeShiftStates {}
