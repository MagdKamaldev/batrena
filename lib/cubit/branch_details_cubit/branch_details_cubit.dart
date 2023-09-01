
import 'package:flutter_bloc/flutter_bloc.dart';


part 'branch_details_state.dart';

class BranchDetailsCubit extends Cubit<BranchDetailsState> {
  BranchDetailsCubit() : super(BranchDetailsInitial());
   static  BranchDetailsCubit get(context) => BlocProvider.of(context);

}
