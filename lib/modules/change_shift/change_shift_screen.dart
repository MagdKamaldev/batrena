// ignore_for_file: must_be_immutable
import 'package:batrena/cubit/change_shift/change_shift_cubit.dart';
import 'package:batrena/shared/colors.dart';
import 'package:batrena/shared/components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../models/branch_model.dart';

class ChangeShiftScreen extends StatelessWidget {
  final Branch branch;
  ChangeShiftScreen({super.key, required this.branch});

  var codeController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ChangeShiftCubit, ChangeShiftStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var size = MediaQuery.of(context).size;
        var cubit = ChangeShiftCubit.get(context);
        bool isPc = size.width > 600;

        TextTheme theme = Theme.of(context).textTheme;
        return Scaffold(
          appBar: AppBar(
            iconTheme: IconThemeData(color: lavendarBlush),
            title: Text(
              "Change shift (${branch.name})",
              style: theme.bodyLarge!.copyWith(
                  fontSize: isPc ? size.width * 0.02 : size.width * 0.05),
            ),
          ),
          body: Form(
            key: formKey,
            child: Column(
              children: [
                SizedBox(
                  height: size.height * 0.08,
                ),
                Align(
                  alignment: Alignment.topCenter,
                  child: SizedBox(
                      width: size.width * 0.3,
                      height: size.height * 0.1,
                      child: Image.asset("assets/images/replacement.png")),
                ),
                SizedBox(
                  height: size.height * 0.05,
                ),
                Text(
                  "Enter code to confirm change",
                  style: theme.bodyLarge!.copyWith(
                      color: raisinBlack,
                      fontSize: isPc ? size.width * 0.03 : size.width * 0.05),
                ),
                SizedBox(
                  height: size.height * 0.06,
                ),
                SizedBox(
                  width: isPc ? size.width * 0.5 : size.width * 0.9,
                  child: defaultFormField(
                      controller: codeController,
                      type: TextInputType.name,
                      onSubmit: () {},
                      validate: (String value) {
                        if (value.isEmpty) {
                          return "value must not be empty";
                        } else if (value.length > 12) {
                          return "value must not be greater than 12 characters";
                        } else if (value.length < 12) {
                          return "value must not be less than 12 characters";
                        }
                      },
                      label: "OTP",
                      prefix: Icons.lock,
                      context: context),
                ),
                const Spacer(),
                SizedBox(
                  width: isPc ? size.width * 0.8 : double.infinity,
                  height: size.height * 0.08,
                  child: GestureDetector(
                    onTap: () {
                      if (formKey.currentState!.validate()) {
                        cubit.checkOtp(
                            otp: codeController.text, context: context);
                      }
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: carrebianCurrent,
                        borderRadius: isPc ? BorderRadius.circular(12) : null,
                      ),
                      child: Center(
                        child: Text(
                          "Confirm OTP",
                          style: theme.bodyLarge!.copyWith(
                              fontSize:
                                  isPc ? size.width * 0.03 : size.width * 0.05),
                        ),
                      ),
                    ),
                  ),
                ),
                if (isPc)
                  SizedBox(
                    height: size.height * 0.05,
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}
