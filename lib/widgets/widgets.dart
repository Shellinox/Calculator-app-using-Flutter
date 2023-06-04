import 'package:calculator/models/colors.dart';
import 'package:flutter/material.dart';

class CalculatorButton extends StatefulWidget {
  final String buttonName;
  final void Function()? onTap;
  const CalculatorButton({super.key, required this.buttonName, this.onTap});

  @override
  State<CalculatorButton> createState() => _CalculatorButtonState();
}

class _CalculatorButtonState extends State<CalculatorButton> {
  @override
  Widget build(BuildContext context) {
    List<String> operators = ["+", "-", "/", "*"];
    List<String> charecters = ["C", "D", "%", ".", "Ans"];
    String eq = "=";
    return GestureDetector(
      onTap:widget.onTap,
      child: widget.buttonName == eq
          ? Padding(
              padding: const EdgeInsets.all(15.0),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(60),
                    color: colors().buttonColor),
                child: Center(
                    child: Text(widget.buttonName,
                        style: TextStyle(
                            color: operators.contains(widget.buttonName)
                                ? colors().buttonColor
                                : charecters.contains(widget.buttonName)
                                    ? colors().primaryButtonColor
                                    : colors().secondaryButtonColor,
                            fontFamily: "News ",
                            fontSize: 22,
                            fontWeight: FontWeight.bold))),
              ),
            )
          : Container(
              color: Colors.transparent,
              child: Center(
                  child: Text(widget.buttonName,
                      style: TextStyle(
                          color: operators.contains(widget.buttonName)
                              ? colors().buttonColor
                              : charecters.contains(widget.buttonName)
                                  ? colors().primaryButtonColor
                                  : colors().secondaryButtonColor,
                          fontFamily: "News ",
                          fontSize: 22,
                          fontWeight: FontWeight.bold))),
            ),
    );
  }
}
