import 'package:batrena/cubit/add_branch/add_branch_cubit.dart';
import 'package:batrena/cubit/branch_details_cubit/branch_details_cubit.dart';
import 'package:batrena/cubit/branch_view/branch_view_cubit.dart';
import 'package:batrena/cubit/change_shift/change_shift_cubit.dart';
import 'package:batrena/cubit/heat_map/heat_map_cubit.dart';
import 'package:batrena/cubit/item/add_item_cubit.dart';
import 'package:batrena/loadLib.dart';
import 'package:batrena/modules/branch_screens/branch_home_screen.dart';
import 'package:batrena/modules/home/home_layout.dart';
import 'package:batrena/modules/login/login_screen.dart';
import 'package:batrena/shared/networks/local/cache_helper.dart';
import 'package:batrena/shared/networks/remote/dio_helper.dart';
import 'package:batrena/shared/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'cubit/home_cubit/app_cubit.dart';
import 'cubit/login_cubit/login_cubit.dart';
import 'dart:ffi';
import 'bridge_generated.dart';

String? jwt = "";
int? permission = 0;
late DynamicLibrary lib;
late ImagePixelReplacerImpl impl;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  lib = loadLibForFlutter("libImagePixelReplacer.so", "ImagePixelReplacer.dll");
  // lib = DynamicLibrary.process();
  impl = ImagePixelReplacerImpl(lib);
  await CacheHelper.init();
  jwt = await CacheHelper.getData(key: "jwt");
  permission = await CacheHelper.getData(key: "permission");
  DioHelper.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
  });

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
          return AddItemCubit();
        }),
        BlocProvider(create: (context) {
          return HeatMapCubit();
        }),
        BlocProvider(create: (context) {
          return BranchViewCubit();
        }),
        BlocProvider(create: (context) {
          return ChangeShiftCubit();
        }),
        BlocProvider(create: (context) {
          return BranchDetailsCubit();
        }),
      ],
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            title: 'Flutter Demo',
            debugShowCheckedModeBanner: false,
            theme: lightTheme,
            home: jwt == null || permission == 0
                ? LoginScreen()
                : permission == 1
                    ? const BranchHomeScreen()
                    : const HomeLayout(),
          );
        },
      ),
    );
  }
}
