import 'package:calculator/res/theme.dart';
import 'package:flutter/material.dart';
import 'res/colors.dart';
import 'res/signs.dart';
import 'res/operations.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: MyTheme.mainTheme,
      home: Scaffold(
        appBar: AppBar(title: const Text('Калькулятор'), backgroundColor: MyColors.mainColor),
        body: MyBody(),
      )
    )
  );
}

String history = "";
String number = "";
String tempNumber = "";
String operation = "";
String tempOperation = "";
bool flag = false;
bool stop = false;

class MyWidget extends StatefulWidget {
  @override
  createState() => MyWidgetState();
}

class MyWidgetState extends State<MyWidget> {

  updateState(){
    setState(() {
    });
  }

  //Ввод числа
  printNumber(String digit){
    if (stop) return;

    if (number == tempNumber) number = digit;
    else number += digit;
  }

  //Производим операцию или можем поменять
  selectOperation(String sign) {
    if (stop) return;

    tempOperation = sign;

    //позволяет поменять операцию
    if (operation.isNotEmpty && history.isNotEmpty && number == tempNumber && tempOperation != operation) {
      history = history.substring(0, history.length - 1) + sign;
    }

    //иначе выполняем
    else if (number.isNotEmpty){

      //Если точка является последним знаком в числе, то добавляем 0
      if (number.endsWith(".")) {
        number += "0";
      }

      history += number + sign; //верхняя строка

      if (flag) {
        number = completeOperation();
        if (number == "Infinity") stop = true;
      }

      tempNumber = number;
      flag = true;
    }

    operation = sign;
  }

  //сброс
  reset(){
    history = "";
    number = "";
    tempNumber = "";
    operation = "";
    tempOperation = "";
    flag = false;
    stop = false;
  }

  //Стирает вводимое число
  delete(){
    if (number.isNotEmpty) number = number.substring(0, number.length - 1);
  }

  //Добавляем минус или убирает
  plusMinus(){
    if (number.isNotEmpty) {
      if (double.parse(number) <= 0) number = number.substring(1, number.length);
      else number = "-" + number;
    }
  }

  printDot(){
    if (number.isNotEmpty && !number.contains(".")){
      number += ".";
    }
  }

  calculate() {
    if (number.isNotEmpty){
      number = completeOperation();

      history = "";
      operation = "";
      flag = false;
    }
  }

  //Производим операцию в зависимости от знака
  completeOperation(){
    flag = false;

    switch (operation){
      case Signs.sum:
        return Operations.Sum(double.parse(tempNumber), double.parse(number));
      case Signs.difference:
        return Operations.Difference(double.parse(tempNumber), double.parse(number));
      case Signs.multiply:
        return Operations.Multiply(double.parse(tempNumber), double.parse(number));
      case Signs.divide:
        return Operations.Divide(double.parse(tempNumber), double.parse(number));
      case Signs.pow:
        return Operations.Pow(double.parse(tempNumber), double.parse(number));
    }
  }

  @override
  Widget build(BuildContext context) {

    return Column(
      children: [
        Flexible(
        flex: 1,
        fit: FlexFit.tight,
        child: Container( color: MyColors.outputColor, child:
        Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(child: Align(alignment: Alignment.bottomRight, child: Text(history, style: Theme.of(context).textTheme.bodySmall))),
              Expanded(child: Align(alignment: Alignment.bottomRight, child: Text(number, style: Theme.of(context).textTheme.bodySmall))),
            ]
        ))),

        Flexible(
            flex: 3,
            fit: FlexFit.loose,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Flexible(flex: 1, child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(child: OutlinedButton(onPressed: () => { reset(), updateState()}, child: Text('C', style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: MyColors.mainColor)))),
                    Expanded(child: OutlinedButton(onPressed: () => {  delete(), updateState() }, child: Text('<', style: Theme.of(context).textTheme.bodyLarge))),
                    Expanded(child: OutlinedButton(onPressed: () => {  plusMinus(), updateState() }, child: Text('±', style: Theme.of(context).textTheme.bodyLarge))),
                    Expanded(child: OutlinedButton(onPressed: () => {  selectOperation(Signs.divide), updateState() }, child: Text('÷', style: Theme.of(context).textTheme.bodyLarge))),
                  ],
                )),

                Flexible(flex: 1, child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(child: OutlinedButton(onPressed: () => { printNumber('1'), updateState() }, child: Text('1', style: Theme.of(context).textTheme.bodyLarge))),
                    Expanded(child: OutlinedButton(onPressed: () => { printNumber('2'), updateState() }, child: Text('2', style: Theme.of(context).textTheme.bodyLarge))),
                    Expanded(child: OutlinedButton(onPressed: () => { printNumber('3'), updateState() }, child: Text('3', style: Theme.of(context).textTheme.bodyLarge))),
                    Expanded(child: OutlinedButton(onPressed: () => { selectOperation(Signs.multiply) ,updateState() }, child: Text('×', style: Theme.of(context).textTheme.bodyLarge))),
                  ],
                )),
                Flexible(flex: 1, child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(child: OutlinedButton(onPressed: () => { printNumber('4'), updateState() }, child: Text('4', style: Theme.of(context).textTheme.bodyLarge))),
                    Expanded(child: OutlinedButton(onPressed: () => { printNumber('5'), updateState() }, child: Text('5', style: Theme.of(context).textTheme.bodyLarge))),
                    Expanded(child: OutlinedButton(onPressed: () => { printNumber('6'), updateState() }, child: Text('6', style: Theme.of(context).textTheme.bodyLarge))),
                    Expanded(child: OutlinedButton(onPressed: () => { selectOperation(Signs.sum) ,updateState()}, child: Text('+', style: Theme.of(context).textTheme.bodyLarge))),
                  ],
                )),
                Flexible(flex: 1, child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(child: OutlinedButton(onPressed: () => { printNumber('7'), updateState() }, child: Text('7', style: Theme.of(context).textTheme.bodyLarge))),
                    Expanded(child: OutlinedButton(onPressed: () => { printNumber('8'), updateState() }, child: Text('8', style: Theme.of(context).textTheme.bodyLarge))),
                    Expanded(child: OutlinedButton(onPressed: () => { printNumber('9'), updateState() }, child: Text('9', style: Theme.of(context).textTheme.bodyLarge))),
                    Expanded(child: OutlinedButton(onPressed: () => { selectOperation(Signs.difference), updateState() }, child: Text('−', style: Theme.of(context).textTheme.bodyLarge))),
                  ],
                )),
                Flexible(flex: 1, child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(flex: 1, child: OutlinedButton(onPressed: () => { calculate(), updateState() }, style: ButtonStyle(backgroundColor: MaterialStateProperty.all(MyColors.mainColor)), child: Text('=', style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Colors.white)))),
                    Expanded(flex: 1, child: OutlinedButton(onPressed: () => { printNumber('0'), updateState() }, child: Text('0', style: Theme.of(context).textTheme.bodyLarge))),
                    Expanded(flex: 1, child: OutlinedButton(onPressed: () => { printDot() ,updateState() }, child: Text('.', style: Theme.of(context).textTheme.bodyLarge))),
                    Expanded(flex: 1, child: OutlinedButton(onPressed: () => { selectOperation(Signs.pow) ,updateState() }, child: Text('^', style: Theme.of(context).textTheme.bodyLarge))),
                  ],
                )),
              ],
            )),
      ]
    );
  }
}

class MyBody extends StatelessWidget{
  Widget build(BuildContext context) {
    return MyWidget();
  }
}