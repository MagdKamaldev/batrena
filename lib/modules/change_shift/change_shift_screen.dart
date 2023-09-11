import 'package:batrena/cubit/change_shift/change_shift_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChangeShiftScreen extends StatelessWidget {
  const ChangeShiftScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ChangeShiftCubit, ChangeShiftStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          body: Column(),
        );
      },
    );
  }
}
