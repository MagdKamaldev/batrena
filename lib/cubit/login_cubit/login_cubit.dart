import 'package:batrena/main.dart';
import 'package:batrena/shared/networks/remote/dio_helper.dart';
import 'package:batrena/shared/networks/remote/end_points.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'login_states.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(LoginInitialState());
  static LoginCubit get(context) => BlocProvider.of(context);

  bool isPassword = true;
  changePassword() {
    isPassword = !isPassword;
    emit(ChangePasswordVisibilityState());
  }

  void login({
    required String username,
    required String password,
  }) {
    emit(LoginLoadingState());
    DioHelper.postData(url: EndPoints.login, data: {
      "username": username,
      "password": password,
    }).then((value) {
      jwt = value.data["jwt"];
      permission = value.data["permission"];
      print(jwt);
      emit(LoginSuccessState());
    }).catchError((error) {
      emit(LoginErrorState());
    });
  }
}
