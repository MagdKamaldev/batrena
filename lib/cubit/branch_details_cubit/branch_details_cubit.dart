import 'package:batrena/main.dart';
import 'package:batrena/models/branch_model.dart';
import 'package:batrena/shared/networks/remote/dio_helper.dart';
import 'package:file_saver/file_saver.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_file/open_file.dart';
part 'branch_details_state.dart';

class BranchDetailsCubit extends Cubit<BranchDetailsState> {
  BranchDetailsCubit() : super(BranchDetailsInitial());
  static BranchDetailsCubit get(context) => BlocProvider.of(context);

  void generateExcellSheet({required int branchId, required Branch branch}) {
    emit(GetExcellLoadingState());
    DioHelper.postDataBytes(
      url: "protected/GetBranchTransactionsExcel",
      jwt: jwt,
      data: {"branch_id": branchId},
    ).then((value) async {
      try {
    
        // Uint8List bytes = Uint8List.fromList(excelData.codeUnits);
        String path = await FileSaver.instance.saveFile(
          name: branch.name == "" ? "File" : "${branch.name}_Transactions",
          bytes: value.data,
          ext: 'xlsx',
          mimeType: MimeType.microsoftExcel,
        );
        openExcelSheet(path);

        emit(GetExcellSucceededState());
      } catch (error) {
        print('Error converting data: $error');
        emit(GetExcellErrorState());
      }
    });
  }

  void openExcelSheet(String path) async {
    try {
      if (path != "") {
        await OpenFile.open(path);
      } else {
        // Handle the case where the path is null
        print('Path to Excel sheet is null.');
      }
    } catch (error) {
      // Handle any potential errors when opening the file
      print('Error opening Excel sheet: $error');
    }
  }
}
