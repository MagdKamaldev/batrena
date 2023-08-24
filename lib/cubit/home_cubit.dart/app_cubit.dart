import 'package:flutter_bloc/flutter_bloc.dart';

import '../../main.dart';
import '../../shared/networks/remote/dio_helper.dart';
import '../../shared/networks/remote/end_points.dart';

part 'app_state.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitial());
  static AppCubit get(context) => BlocProvider.of(context);

  void getUserInfo() {
    emit(GetUserInfoLoadingState());
    DioHelper.getData(url: EndPoints.getUserInfo, jwt: jwt).then((value) {
      emit(GetUserInfoSuccessState());
    });
  }
}
