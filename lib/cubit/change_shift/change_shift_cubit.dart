import 'package:flutter_bloc/flutter_bloc.dart';
part 'change_shift_state.dart';


class ChangeShiftCubit extends Cubit<ChangeShiftStates> {
  ChangeShiftCubit() : super(ChangeShiftInitial());
  static ChangeShiftCubit get(context) => BlocProvider.of(context);
}
