import 'package:flutter_bloc/flutter_bloc.dart';
part 'add_branch_state.dart';

class AddBranchCubit extends Cubit<AddBranchState> {
  AddBranchCubit() : super(AddBranchInitial());
  static AddBranchCubit get(context) => BlocProvider.of(context);
}
