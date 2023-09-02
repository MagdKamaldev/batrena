import 'package:flutter_bloc/flutter_bloc.dart';
import '../../main.dart';
import '../../models/branch_model.dart';
import '../../shared/networks/remote/dio_helper.dart';
import '../../shared/networks/remote/end_points.dart';
part 'app_state.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitial()) {
    fetchBranches();
  }

  static AppCubit get(context) => BlocProvider.of(context);

  void getUserInfo() {
    emit(GetUserInfoLoadingState());
    DioHelper.getData(url: EndPoints.getUserInfo, jwt: jwt).then((value) {
      emit(GetUserInfoSuccessState());
    });
  }

  List<Branch> branches = [];

  void fetchBranches() {
    emit(FetchBranchesLoadingState());
    DioHelper.getData(url: EndPoints.fetchBranches, jwt: jwt).then((value) {
      branches =
          List<Branch>.from(value.data.map((json) => Branch.fromJson(json)));

      emit(FetchBranchesSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(FetchBranchesErrorState());
    });
  }
}
