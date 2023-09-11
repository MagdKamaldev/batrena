import 'package:batrena/main.dart';
import 'package:batrena/shared/components/components.dart';
import 'package:batrena/shared/networks/remote/dio_helper.dart';
import 'package:batrena/shared/networks/remote/end_points.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'change_shift_state.dart';

class ChangeShiftCubit extends Cubit<ChangeShiftStates> {
  ChangeShiftCubit() : super(ChangeShiftInitial());
  static ChangeShiftCubit get(context) => BlocProvider.of(context);

  void checkOtp({required String otp, required BuildContext context}) {
    emit(CheckOTPLoadingState());
    DioHelper.postData(url: EndPoints.switchShift, jwt: jwt, data: {
      "token": otp,
    }).then((value) {
      showCustomSnackBar(context, value.data["message"], Colors.green);
    });
  }
}
