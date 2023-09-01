import 'package:batrena/main.dart';
import 'package:batrena/shared/networks/remote/dio_helper.dart';
import 'package:batrena/shared/networks/remote/end_points.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'login_states.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(LoginInitialState());
  static LoginCubit get(context) => BlocProvider.of(context);

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
      emit(LoginSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(LoginErrorState());
    });
  }
}
