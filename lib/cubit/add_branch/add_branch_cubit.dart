import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'add_branch_state.dart';

class AddBranchCubit extends Cubit<AddBranchState> {
  AddBranchCubit() : super(AddBranchInitial());
}
