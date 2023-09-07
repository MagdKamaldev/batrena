import 'package:batrena/cubit/add_branch/add_branch_cubit.dart';
import 'package:batrena/cubit/add_item/add_item_cubit.dart';
import 'package:batrena/cubit/branch_details_cubit/branch_details_cubit.dart';
import 'package:batrena/modules/login/login_screen.dart';
import 'package:batrena/shared/networks/local/cache_helper.dart';
import 'package:batrena/shared/networks/remote/dio_helper.dart';
import 'package:batrena/shared/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'cubit/home_cubit/app_cubit.dart';
import 'cubit/login_cubit/login_cubit.dart';

String? jwt = "";
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();
  await CacheHelper.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) {
          return LoginCubit();
        }),
        BlocProvider(create: (context) {
          return AppCubit();
        }),
        BlocProvider(create: (context) {
          return AddBranchCubit();
        }),
        BlocProvider(create: (context) {
          return BranchDetailsCubit();
        }),
        BlocProvider(create: (context) {
          return AddItemCubit();
        }),
      ],
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            title: 'Flutter Demo',
            debugShowCheckedModeBanner: false,
            theme: lightTheme,
            home: LoginScreen(),
          );
        },
      ),
    );
  }
}
