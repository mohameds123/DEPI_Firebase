import 'package:depi/core/utils/colors_manager.dart';
import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  Function function;
  String txt;
  double? buttonWidth;

   AppButton({super.key, required this.function,required this.txt, this.buttonWidth});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap:()=> function(),
      child: Container(

        alignment: Alignment.center,
        width:buttonWidth ?? double.infinity,
        height: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          color: ColorsManager.primary,
        ),
        child: Text(
          txt,
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
