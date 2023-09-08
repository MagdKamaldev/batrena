import 'package:batrena/main.dart';
import 'package:batrena/models/branch_model.dart';
import 'package:batrena/shared/networks/remote/dio_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'branch_view_state.dart';

class BranchViewCubit extends Cubit<BranchViewStates> {
  BranchViewCubit() : super(BranchViewInitial());
   static BranchViewCubit get(context) => BlocProvider.of(context);

    late Branch branch;

  Future<bool> get loadData async {
    await DioHelper.getData(url: "protected/FetchBranchData", jwt: jwt)
        .then((value) {
      branch = Branch.fromJson(value.data);
    });
    return true;
  }
}
