import 'package:calculator/models/colors.dart';
import 'package:calculator/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

// ignore: must_be_immutable
class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String userinput = "";
  String answer = "0";
  List<String> numbers = [
    "C",
    "%",
    "D",
    "/",
    "7",
    "8",
    "9",
    "*",
    "4",
    "5",
    "6",
    "+",
    "1",
    "2",
    "3",
    "-",
    "Ans",
    "0",
    ".",
    "="
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colors().primaryColorDark,
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Calc.",
          style: TextStyle(fontFamily: "Panoptica", fontSize: 25),
        ),
        backgroundColor: Colors.black,
        elevation: 0,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            height: 270,
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(color: Colors.black),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40.0),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      userinput.toString(),
                      style: const TextStyle(
                          fontFamily: "News",
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 25),
                    ),
                    const SizedBox(height: 15),
                    Text(
                      answer.toString(),
                      style: TextStyle(
                          fontFamily: "News",
                          fontWeight: FontWeight.bold,
                          color: colors().buttonColor,
                          fontSize: 40),
                    ),
                  ]),
            ),
          ),
          Expanded(
              child: Padding(
            padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
            child: SizedBox(
              height: double.infinity,
              width: double.infinity,
              child: GridView.builder(
                itemCount: numbers.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                ),
                itemBuilder: (context, index) {
                  return CalculatorButton(
                    buttonName: numbers[index],
                    onTap: () {
                      if (index == 0) {
                        setState(() {
                          userinput = "";
                          answer = "0";
                        });
                      } else if (index == 1) {
                        setState(() {
                          userinput += numbers[index];
                        });
                      } else if (index == 2) {
                        setState(() {
                          userinput =
                              userinput.substring(0, userinput.length - 1);
                        });
                      } else if (index == 19) {
                        setState(() {
                          if (userinput.contains("%")) {
                            double res = (int.parse(userinput.substring(
                                    0, userinput.indexOf("%"))) /
                                100);
                            answer = res.toString();
                          } else {
                            equalPressed();
                          }
                        });
                      } else if (index == 16) {
                        if (answer != "0") {
                          setState(() {
                          userinput = answer;
                          answer = "0";
                        });
                        }
                      } else {
                        setState(() {
                          userinput += numbers[index];
                        });
                      }
                    },
                  );
                },
              ),
            ),
          )),
        ],
      ),
    );
  }

  void equalPressed() {
    String finaluserinput = userinput;
    finaluserinput = userinput.replaceAll('x', '*');

    Parser p = Parser();
    Expression exp = p.parse(finaluserinput);
    ContextModel cm = ContextModel();
    double eval = exp.evaluate(EvaluationType.REAL, cm);
    answer = eval.toString();
  }
}
