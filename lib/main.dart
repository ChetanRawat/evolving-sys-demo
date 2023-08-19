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
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
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
  int currentNo = 1;
  late int maxElements;

  List<int> _numbers = [1, 2,3,4,5,6,7,8,9,10,11,12,13,14,15,16];
  // List<String> displayString =

  void _incrementPosition() {
    setState(() {
      if(_selectedPosition < maxElements-1){
        _selectedPosition++;
      }

      if(currentNo < _numbers.length){
          currentNo++;
      }

    });
  }

  void _decrementPosition() {
    setState(() {
      if(_selectedPosition > 0)
      _selectedPosition--;
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
                    ),
                  ),
                  InkWell(
                    onTap: (){
                      _incrementPosition();
                    },
                    child: Container(
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
    maxElements = maxwidth~/elementWidth;

    if(_numbers.length <= maxElements){
      maxElements = _numbers.length;
    }

    List<Widget> list = List.empty(growable: true);
    for(int i = 0;i<maxElements;i++){
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
        child: Center(child: Text(determineDisplaytext(maxElements,_selectedPosition,i))),
      ));
    }
    return list;
  }

  String determineDisplaytext(int maxElements, int selectedPos,int position) {
    String value = "";

    if(_numbers.length <= maxElements || position == 0 ){
      value = "${_numbers.elementAt(position)}";
    }else if(position == maxElements - 1){
      value = "${_numbers.length}";
    }else{
      // value = "na";

      if(!canFitRight(maxElements, selectedPos) && position == maxElements - 2){
          value = "...";
      }else if(selectedPos == maxElements-3 && canFitRight(maxElements, selectedPos)){
          value = "${_numbers.elementAt(position)}";
      }else{
        value = "${_numbers.elementAt(position)}";
      }

    }


    return value;
  }

  bool canFitRight(int maxElements , int selectedPos){
    int rightAvailableSpaces =  maxElements - selectedPos + 1;
    int remainingElements = _numbers.length - (selectedPos+1);
    return rightAvailableSpaces == remainingElements;
  }
}
