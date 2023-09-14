import 'package:batrena/main.dart';
import 'package:batrena/modules/login/login_screen.dart';
import 'package:batrena/shared/colors.dart';
import 'package:batrena/shared/networks/local/cache_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

Widget defaultFormField({
  required TextEditingController controller,
  required TextInputType type,
  required Function onSubmit,
  required Function validate,
  bool isPassword = false,
  required String label,
  required IconData prefix,
  IconData? suffix,
  Function? suffixPressed,
  bool isClickable = true,
  required BuildContext context,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      TextFormField(
        validator: (value) {
          return validate(value);
        },
        controller: controller,
        keyboardType: type,
        enabled: isClickable,
        obscureText: isPassword,
        onFieldSubmitted: (s) {
          onSubmit();
        },
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.normal,
          color: Colors.black, // Set the text color here
        ),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: Theme.of(context)
              .textTheme
              .titleMedium!
              .copyWith(fontSize: 16, color: raisinBlack),
          prefixIcon: Icon(
            prefix,
            color: carrebianCurrent,
          ),
          suffixIcon: suffix != null
              ? IconButton(
                  icon: Icon(
                    suffix,
                    color: carrebianCurrent,
                  ),
                  onPressed: () {
                    suffixPressed!();
                  },
                )
              : null,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
      ),
      const SizedBox(height: 5),
    ],
  );
}

void logout({
  required BuildContext context,
}) {
  navigateAndFinish(context, LoginScreen());
  jwt = "";
  permission = 0;
  CacheHelper.saveData(key: "jwt", value: "");
  CacheHelper.saveData(key: "permission", value: 0);
}

void showCustomSnackBar(
    BuildContext context, String message, Color backgroundColor) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Center(
        child: Text(
          message,
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ),
      backgroundColor: backgroundColor,
      duration: const Duration(seconds: 2),
    ),
  );
}

void showSetLoactionSuccess(context, height, width, TextTheme textTheme) {
  showDialog(
    context: context,
    builder: (context) => Align(
      alignment: Alignment.center,
      child: Container(
        width: width * 0.75,
        height: height * 0.6,
        decoration: BoxDecoration(
            color: lavendarBlush, borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Lottie.asset("assets/animations/location_set.json"),
              Text(
                "Location Set Successfully !",
                style: textTheme.titleMedium!.copyWith(color: carrebianCurrent),
              ),
              SizedBox(
                height: height * 0.03,
              ),
              Container(
                width: width * 0.3,
                decoration: BoxDecoration(
                    color: carrebianCurrent,
                    borderRadius: BorderRadius.circular(10)),
                child: TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.pop(context);
                  },
                  child: Center(
                    child: Text(
                      "Back ",
                      style: textTheme.bodyLarge!,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    ),
  );
}

void navigateTo(context, widget) => Navigator.push(
    context,
    CupertinoPageRoute(
      builder: (context) => widget,
    ));

void navigateAndFinish(context, widget) => Navigator.pushAndRemoveUntil(
        context, CupertinoPageRoute(builder: (context) => widget), (route) {
      return false;
    });
