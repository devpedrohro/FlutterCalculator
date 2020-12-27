import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class CalculatorScreen extends StatefulWidget {
  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String equation = "0";
  String result = "0";
  String expression = "";
  double equationFontSize = 38.0;
  double resultFontSize = 48.0;

  Color backColor = Color.fromARGB(255, 38, 38, 38);
  Color buttonColor = Color.fromARGB(255, 50, 50, 50);

  buttonPressed(String buttonText) {
    setState(() {
      if (buttonText == "C") {
        equation = "0";
        result = "0";
        equationFontSize = 38.0;
        resultFontSize = 48.0;
      } else if (buttonText == "⌫") {
        equationFontSize = 48.0;
        resultFontSize = 38.0;
        equation = equation.substring(0, equation.length - 1);
        if (equation == "") {
          equation = "0";
        }
      } else if (buttonText == "=") {
        equationFontSize = 38.0;
        resultFontSize = 60.0;

        expression = equation;
        expression = expression.replaceAll('×', '*');
        expression = expression.replaceAll('÷', '/');

        try {
          Parser p = Parser();
          Expression exp = p.parse(expression);

          ContextModel cm = ContextModel();
          result = '${exp.evaluate(EvaluationType.REAL, cm)}';
        } catch (e) {
          result = "Error";
        }
      } else {
        equationFontSize = 48.0;
        resultFontSize = 38.0;
        if (equation == "0") {
          equation = buttonText;
        } else {
          equation = equation + buttonText;
        }
      }
    });
  }

  Widget buildButton(
      String buttonText, double buttonHeight, Color textButtonColor) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.1 * buttonHeight,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(50)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(3),
        child: FlatButton(
            color: buttonColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            onPressed: () => buttonPressed(buttonText),
            child: Text(
              buttonText,
              style: TextStyle(
                  fontSize: 30.0,
                  fontWeight: FontWeight.normal,
                  color: textButtonColor),
            )),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: backColor,
      child: SafeArea(
        child: Column(
          children: [
            Container(
              alignment: Alignment.centerRight,
              padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
              child: Text(
                equation,
                style:
                    TextStyle(fontSize: equationFontSize, color: Colors.white),
              ),
            ),
            Container(
              alignment: Alignment.centerRight,
              padding: EdgeInsets.fromLTRB(10, 30, 10, 0),
              child: Text(
                result,
                style: TextStyle(fontSize: resultFontSize, color: Colors.white),
              ),
            ),
            Expanded(
              child: Divider(),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * .75,
                  child: Table(
                    children: [
                      TableRow(children: [
                        buildButton("C", 1, Colors.purpleAccent),
                        buildButton("⌫", 1, Colors.purpleAccent),
                        buildButton("÷", 1, Colors.purpleAccent),
                      ]),
                      TableRow(children: [
                        buildButton("7", 1, Colors.white),
                        buildButton("8", 1, Colors.white),
                        buildButton("9", 1, Colors.white),
                      ]),
                      TableRow(children: [
                        buildButton("4", 1, Colors.white),
                        buildButton("5", 1, Colors.white),
                        buildButton("6", 1, Colors.white),
                      ]),
                      TableRow(children: [
                        buildButton("1", 1, Colors.white),
                        buildButton("2", 1, Colors.white),
                        buildButton("3", 1, Colors.white),
                      ]),
                      TableRow(children: [
                        buildButton(".", 1, Colors.white),
                        buildButton("0", 1, Colors.white),
                        buildButton("00", 1, Colors.white),
                      ]),
                    ],
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.25,
                  child: Table(
                    children: [
                      TableRow(children: [
                        buildButton("×", 1, Colors.purpleAccent),
                      ]),
                      TableRow(children: [
                        buildButton("-", 1, Colors.purpleAccent),
                      ]),
                      TableRow(children: [
                        buildButton("+", 1, Colors.purpleAccent),
                      ]),
                      TableRow(children: [
                        buildButton("=", 2, Colors.purpleAccent),
                      ]),
                    ],
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
