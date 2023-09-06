import 'package:flutter_bloc/flutter_bloc.dart';
part 'add_item_state.dart';


class AddItemCubit extends Cubit<AddItemStates> {
  AddItemCubit() : super(AddItemInitial());
  
  static AddItemCubit get(context) => BlocProvider.of(context);
  
  
}
