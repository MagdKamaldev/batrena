import 'package:batrena/shared/colors.dart';
import 'package:flutter/material.dart';

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
        ),
        decoration: InputDecoration(
          labelText: label,
          labelStyle:
              Theme.of(context).textTheme.titleMedium!.copyWith(fontSize: 16),
          prefixIcon: Icon(
            prefix,
            color: carrebianCurrent,
          ),
          suffixIcon: suffix != null
              ? IconButton(
                  icon: Icon(
                    suffix,
                  ),
                  onPressed: () {
                    suffixPressed!();
                  },
                )
              : null,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(
                10.0), // Set the desired border radius value
          ),
        ),
      ),
      const SizedBox(height: 5),
    ],
  );
}
