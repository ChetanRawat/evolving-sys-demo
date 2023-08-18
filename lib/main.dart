import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
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
  int _noOfElements = 5;

  void _incrementPosition() {
    setState(() {
      if(_selectedPosition < _noOfElements-1)
      _selectedPosition++;
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: buildCenterList(),
                  ),
                  InkWell(
                    onTap: (){
                      _incrementPosition();
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: _selectedPosition == _noOfElements-1?Colors.grey:Colors.black,
                          border: Border.all(
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
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  List<Widget> buildCenterList() {
    List<Widget> list = List.empty(growable: true);
    for(int i = 0;i<_noOfElements;i++){
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
        child: Center(child: Text("${i+1}")),
      ));
    }
    return list;
  }
}
