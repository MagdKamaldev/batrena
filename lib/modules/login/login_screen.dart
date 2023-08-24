// ignore_for_file: must_be_immutable
import 'package:batrena/modules/home/home_layout.dart';
import 'package:batrena/shared/colors.dart';
import 'package:batrena/shared/components/components.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import '../../cubit/login_cubit/login_cubit.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  var nameController = TextEditingController();
  var passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var cubit = LoginCubit.get(context);
    var size = MediaQuery.of(context).size;
    var textTheme = Theme.of(context).textTheme;
    return BlocConsumer<LoginCubit, LoginStates>(
      listener: (context, state) {
        if (state is LoginSuccessState) {
          navigateAndFinish(context, HomeLayout());
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
              backgroundColor: carrebianCurrent,
              centerTitle: true,
              title: Text(
                "Batrena",
                style: textTheme.bodyLarge!.copyWith(color: lavendarBlush),
              )),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: formKey,
              child: SingleChildScrollView(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: size.width * 0.6,
                        height: size.height * 0.15,
                        child: Lottie.asset(
                            "assets/animations/animation_llo54g9c.json"),
                      ),
                      SizedBox(
                        height: size.height * 0.04,
                      ),
                      Text(
                        "Welcome Back !",
                        style: textTheme.bodyLarge!
                            .copyWith(color: raisinBlack, fontSize: 20),
                      ),
                      SizedBox(
                        height: size.height * 0.07,
                      ),
                      defaultFormField(
                          controller: nameController,
                          type: TextInputType.emailAddress,
                          onSubmit: () {},
                          validate: (String value) {
                            if (value.isEmpty) {
                              return "Name must not be empty";
                            }
                          },
                          label: "Name",
                          prefix: Icons.person,
                          context: context),
                      SizedBox(
                        height: size.height * 0.04,
                      ),
                      defaultFormField(
                          controller: passwordController,
                          type: TextInputType.visiblePassword,
                          onSubmit: () {},
                          validate: (String value) {
                            if (value.isEmpty) {
                              return "Password must not be empty";
                            }
                          },
                          label: "Password",
                          prefix: Icons.lock,
                          suffix: Icons.remove_red_eye,
                          context: context),
                      SizedBox(
                        height: size.height * 0.06,
                      ),
                      ConditionalBuilder(
                        condition: state is! LoginLoadingState,
                        fallback: (context) => const Center(
                          child: CircularProgressIndicator(),
                        ),
                        builder: (context) => ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Container(
                            width: double.infinity,
                            height: size.height * 0.07,
                            decoration: BoxDecoration(
                              color: carrebianCurrent,
                            ),
                            child: MaterialButton(
                              onPressed: () {
                                if (formKey.currentState!.validate()) {
                                  cubit.login(
                                      username: nameController.text,
                                      password: passwordController.text);
                                }
                              },
                              color: carrebianCurrent,
                              child: Text(
                                "Login",
                                style: textTheme.bodyLarge,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.04,
                      ),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.center,
                      //   children: [
                      //     Text(
                      //       "New User ?",
                      //       style: Theme.of(context)
                      //           .textTheme
                      //           .titleMedium!
                      //           .copyWith(color: carrebianCurrent, fontSize: 20),
                      //     ),
                      //     TextButton(
                      //         onPressed: () {},
                      //         child: Text(
                      //           "SignUp",
                      //           style: Theme.of(context)
                      //               .textTheme
                      //               .titleMedium!
                      //               .copyWith(color: raisinBlack, fontSize: 20),
                      //         )),
                      //   ],
                      // )
                    ]),
              ),
            ),
          ),
        );
      },
    );
  }
}
