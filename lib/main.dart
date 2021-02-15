import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Calculator(),
  ));
}

class Calculator extends StatefulWidget {
  @override
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  int firstNumber=0;
  int secondNumber=0;
  String operation = "";
  String firstLine = "";

  int perform(String op, int a, int b){
    switch(operation){
      case "+":
        return a+b;
        break;
      case "-":
        return a-b;
        break;
      case "\u00D7":
        return a*b;
        break;
      case "\u00F7":
        return a~/b;
        break;
    }
  }

  void buttonAction({String buttonValue}){
    switch(buttonValue){
      case "C":
        setState(() {
          firstLine = "";
          firstNumber = 0;
        }); break;
      case "0":
        if(firstLine=="0") break;
        else{
          setState(() {
            firstLine += buttonValue;
          });
        }
        break;
      case "=":
        setState(() {
          int temp = perform(operation, firstNumber, int.parse(firstLine));
          firstLine = temp.toString();
          operation = "";
          firstNumber = 0;
        });
        break;
      case "+":
      case "-":
      case "\u00D7":
      case "\u00F7":
        if(firstNumber!=0){
          setState(() {
            firstNumber = perform(operation, firstNumber, int.parse(firstLine));
            operation = buttonValue;
            firstLine = firstNumber.toString();
          });
        }
        else{
          setState(() {
            firstNumber = int.parse(firstLine);
            operation = buttonValue;
            firstLine = "";
          });
        }
        break;
      default:
        if(firstLine == "0") setState(() {
          firstLine = buttonValue;
        });
        else if(firstNumber!=0){
          setState(() {
            firstLine = buttonValue;
          });
        }
        else setState(() {
          firstLine += buttonValue;
        });
    }
  }
  Widget getButton({String text, Color colour = Colors.grey}){
    return Expanded(
      child: RawMaterialButton(
          shape: CircleBorder(),
          padding: EdgeInsets.all(15),
          onPressed: ()=>{buttonAction(buttonValue: text)},
          highlightColor: Colors.white,
          fillColor: colour,
          child:Text(
            '$text',
            style: TextStyle(
              color:Colors.black,
              fontSize: 25,
            ),
          )
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(
          'Calculator',
          style: TextStyle(
            color:Colors.white
          )

        ),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: EdgeInsets.all(25.0),
        child: Column(
          children: [
            Expanded(
              flex: 2,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    '$firstLine',
                    style: TextStyle(
                        color:Colors.grey,
                        fontSize: 35.0,
                        fontWeight: FontWeight.bold
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Row(
                children: [
                  getButton(text:"9"),
                  getButton(text:"8"),
                  getButton(text:"7"),
                  getButton(text:"\u00F7", colour: Colors.orange)
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Row(
                children: [
                  getButton(text:"6"),
                  getButton(text:"5"),
                  getButton(text:"4"),
                  getButton(text:"\u00D7", colour: Colors.orange)
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Row(
                children: [
                  getButton(text:"3"),
                  getButton(text:"2"),
                  getButton(text:"1"),
                  getButton(text:"+", colour: Colors.orange)
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Row(
                children: [
                  getButton(text:"0"),
                  getButton(text:"C", colour: Colors.orange),
                  getButton(text:"=", colour: Colors.orange),
                  getButton(text:"-", colour: Colors.orange)
                ],
              ),
            )
          ],
        )
      ),
    );
  }
}
