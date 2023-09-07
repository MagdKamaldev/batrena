import 'package:flutter_bloc/flutter_bloc.dart';
part 'add_item_state.dart';

class AddItemCubit extends Cubit<AddItemStates> {
  AddItemCubit() : super(AddItemInitial());

  static AddItemCubit get(context) => BlocProvider.of(context);

  int quantity = 1;

  void incrementQuantity() {
    quantity++;
    emit(IncrementQuantity());
  }

  void decrementQuantity() {
    if (quantity > 1) {
      quantity--;
      emit(DecrementQuantity());
    }
  }
}
