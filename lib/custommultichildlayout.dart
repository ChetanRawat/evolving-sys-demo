import 'package:flutter/material.dart';

/// Flutter code sample for [CustomMultiChildLayout].

// void main() => runApp(const CustomMultiChildLayoutApp());

class CustomMultiChildLayoutApp extends StatelessWidget {
  const CustomMultiChildLayoutApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      home: Directionality(
        // TRY THIS: Try changing the direction here and hot-reloading to
        // see the layout change.
        textDirection: TextDirection.ltr,
        child: Scaffold(
          body: CustomMultiChildLayoutExample(),
        ),
      ),
    );
  }
}

/// Lays out the children in a cascade, where the top corner of the next child
/// is a little above (`overlap`) the lower end corner of the previous child.
///
/// Will relayout if the text direction changes.
class _CascadeLayoutDelegate extends MultiChildLayoutDelegate {
  _CascadeLayoutDelegate({
    required this.colors,
    required this.overlap,
    required this.textDirection,
  });

  final Map<String, Color> colors;
  final double overlap;
  final TextDirection textDirection;

  // Perform layout will be called when re-layout is needed.
  @override
  void performLayout(Size size) {
    final double columnWidth = size.width / colors.length;
    Offset childPosition = Offset(0,size.height/2);
    // switch (textDirection) {
    //   case TextDirection.rtl:
    //     childPosition += Offset(size.width, 0);
    //   case TextDirection.ltr:
    //     break;
    // }
    for (final String color in colors.keys) {
      // layoutChild must be called exactly once for each child.
      final Size currentSize = layoutChild(
        color,
        BoxConstraints(minWidth: columnWidth,maxHeight: columnWidth),
      );
      // positionChild must be called to change the position of a child from
      // what it was in the previous layout. Each child starts at (0, 0) for the
      // first layout.
      switch (textDirection) {
        case TextDirection.rtl:
          positionChild(color, childPosition - Offset(currentSize.width, 0));
          childPosition +=
              Offset(-currentSize.width, currentSize.height - overlap);
        case TextDirection.ltr:
          positionChild(color, childPosition);
          childPosition +=
              Offset(currentSize.width, 0);
      }
    }
  }

  // shouldRelayout is called to see if the delegate has changed and requires a
  // layout to occur. Should only return true if the delegate state itself
  // changes: changes in the CustomMultiChildLayout attributes will
  // automatically cause a relayout, like any other widget.
  @override
  bool shouldRelayout(_CascadeLayoutDelegate oldDelegate) {
    return oldDelegate.textDirection != textDirection ||
        oldDelegate.overlap != overlap;
  }
}

class CustomMultiChildLayoutExample extends StatelessWidget {
   CustomMultiChildLayoutExample({super.key});

  static const Map<String, Color> _colors = <String, Color>{
    'Red': Colors.red,
    'Green': Colors.green,
    'Blue': Colors.blue,
    'Cyan': Colors.cyan,
    'black':Colors.black,
    'asd': Colors.red,
    'zxc': Colors.green,
    'klj': Colors.blue,
    'thgdsfskjflskdjfs': Colors.cyan,
    'gfch':Colors.black,
  };

  int _selectedPosition = 0;
  int _noOfElements = 5;

  @override
  Widget build(BuildContext context) {



    return Container(
      color: Colors.red,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          InkWell(
            onTap: (){
              // _decrementPosition();
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
            width: MediaQuery.of(context).size.width - 100,
            child: CustomMultiChildLayout(
              delegate: _CascadeLayoutDelegate(
                colors: _colors,
                overlap: 30.0,
                textDirection: TextDirection.ltr,
              ),
              children: <Widget>[
                // Create all of the colored boxes in the colors map.
                for (final MapEntry<String, Color> entry in _colors.entries)
                // The "id" can be any Object, not just a String.
                  LayoutId(
                    id: entry.key,
                    child: Container(
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: /*_selectedPosition == i?*/Colors.pinkAccent/*:Colors.transparent*/,
                          border: /*_selectedPosition == i?*/Border.all(
                              width: 0.5
                          )/*:null*/
                      ),
                      width: 32,
                      height: 32,
                      alignment: Alignment.center,
                      margin: EdgeInsets.symmetric(horizontal: 4),
                      child: Center(child: Text("${/*i+*/1}")),
                    )),
              ],
            ),
          ),
          InkWell(
            onTap: (){
              // _decrementPosition();
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
              child: Icon(Icons.arrow_forward),
            ),
          )
        ],
      ),
    );
  }
}
