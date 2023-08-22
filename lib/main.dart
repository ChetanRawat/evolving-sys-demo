import 'package:evolving_sys_demo/pagination/pagination.dart';
import 'package:flutter/material.dart';

import 'custommultichildlayout.dart';

void main() {
  runApp(const MyApp()/*CustomMultiChildLayoutApp()*/);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Scaffold(body: NumbersPage())/*const MyHomePage(title: 'Flutter Demo Home Page')*/,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedPosition = 0;
  late int noOfSpots;

  List<int> _numbers = [1, 2,3,4,5,6,7,8,9,10,11,12,13,14,15,16];
  // List<String> displayString =

  int currentPage = 1;

  void _incrementPosition() {
    setState(() {

      if(_selectedPosition < _numbers.length){
        // currentPage++;
        _selectedPosition++;
      }

      // if(_selectedPosition < maxElements-1 && (canFitRight(maxElements, _selectedPosition) || _selectedPosition== maxElements -3)){
      //   _selectedPosition++;
      // }

    });
  }

  void _decrementPosition() {
    setState(() {
      if(_selectedPosition > 0)
      _selectedPosition--;

      if(currentPage > 0)
        currentPage--;
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(

        backgroundColor: Theme.of(context).colorScheme.inversePrimary,

        title: Text(widget.title),
      ),
      body: Center(

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              height: 48,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  InkWell(
                    onTap: (){
                      _decrementPosition();
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                          border: Border.all(
                            color: _selectedPosition == 0?Colors.grey:Colors.black,
                              width: 1
                          )
                      ),
                      width: 32,
                      height: 32,
                      margin: EdgeInsets.symmetric(horizontal: 4),
                      child: Icon(Icons.arrow_back),
                    ),
                  ),
                  Container(
                    child: Wrap(
                      children: buildCenterList(MediaQuery.of(context).size.width - 80),
                    ),),
                  InkWell(
                    onTap: (){
                      _incrementPosition();
                    },
                    child:Container(
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                              color: _selectedPosition == _numbers.length -1?Colors.grey:Colors.black,
                              width: 1
                          )
                      ),
                      width: 32,
                      height: 32,
                      margin: EdgeInsets.symmetric(horizontal: 4),
                      child: Icon(Icons.arrow_forward),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),// This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  List<Widget> buildCenterList(double maxwidth) {
    double elementWidth  = 40;
    noOfSpots = maxwidth~/elementWidth;

    if(_numbers.length <= noOfSpots){
      noOfSpots = _numbers.length;
    }

    List<Widget> list = List.empty(growable: true);
    for(int i = 0;i<noOfSpots;i++){
      list.add(Container(
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: _selectedPosition == i?Colors.pinkAccent:Colors.transparent,
            border: _selectedPosition == i?Border.all(
                width: 0.5
            ):null
        ),
        width: 32,
        height: 32,
        margin: EdgeInsets.symmetric(horizontal: 4),
        child: Center(child: Text(determineDisplaytext(noOfSpots,_selectedPosition,i))),
      ));
    }
    return list;
  }

  String determineDisplaytext(int noOfSpots, int selectedPos,int position) {
    String value = "";

    if(_numbers.length <= noOfSpots || position == 0 ){ //always display first element
      value = "${_numbers.elementAt(position)}";
    }else if(position == noOfSpots - 1){
      value = "${_numbers.length}";
    }else{
      // value = "na";

      if(!canFitRight(noOfSpots, selectedPos) && position == noOfSpots - 2){
          value = "...";
      }else if(selectedPos == noOfSpots-3 && canFitRight(noOfSpots, selectedPos)){
          value = "${_numbers.elementAt(position)}";
      }else{
        value = "${_numbers.elementAt(position)}";
      }

    }


    return value;
  }

  bool canFitRight(int noOfSpots , int selectedPos){
    int remainingSpotsToRight =  noOfSpots - selectedPos + 1;
    int remainingElementsRight = _numbers.length - currentPage;
    return remainingSpotsToRight == remainingElementsRight;
  }

  bool canFitLeft(int noOfSpots , int selectedPos){
    int remainingSpotsToLeft =  selectedPos;
    int remainingElementsLeft = currentPage -1;
    return remainingSpotsToLeft == remainingElementsLeft;
  }
}
