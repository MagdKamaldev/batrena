// ignore_for_file: must_be_immutable
import 'package:batrena/shared/colors.dart';
import 'package:batrena/shared/components/components.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: celeste,
      appBar: AppBar(
          backgroundColor: carrebianCurrent,
          centerTitle: true,
          title: Text(
            "Batrena",
            style: Theme.of(context)
                .textTheme
                .bodyLarge!
                .copyWith(color: lavendarBlush),
          )),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.6,
            height: MediaQuery.of(context).size.height * 0.15,
            child: Image.asset("assets/images/login_icon.png"),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.04,
          ),
          Text(
            "A smart way for inventory management",
            style: Theme.of(context)
                .textTheme
                .bodyLarge!
                .copyWith(color: raisinBlack, fontSize: 16),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.07,
          ),
          defaultFormField(
              controller: emailController,
              type: TextInputType.emailAddress,
              onSubmit: () {},
              validate: (String value) {
                if (value.isEmpty) {
                  return "Email adress must not be empty";
                }
              },
              label: "Email",
              prefix: Icons.email,
              context: context),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.04,
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
            height: MediaQuery.of(context).size.height * 0.06,
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.07,
              decoration: BoxDecoration(
                color: carrebianCurrent,
              ),
              child: MaterialButton(
                onPressed: () {},
                color: carrebianCurrent,
                child: Text(
                  "Login",
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.04,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "New User ?",
                style: Theme.of(context)
                    .textTheme
                    .titleMedium!
                    .copyWith(color: carrebianCurrent, fontSize: 20),
              ),
              TextButton(
                  onPressed: () {},
                  child: Text(
                    "SignUp",
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium!
                        .copyWith(color: raisinBlack, fontSize: 20),
                  )),
            ],
          )
        ]),
      ),
    );
  }
}
