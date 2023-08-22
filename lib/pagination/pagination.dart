import 'package:evolving_sys_demo/pagination/src/model/config.dart';
import 'package:evolving_sys_demo/pagination/src/ui/number_paginator.dart';
import 'package:flutter/material.dart';

class NumbersPage extends StatefulWidget {
  const NumbersPage({Key? key}) : super(key: key);

  @override
  _NumbersPageState createState() => _NumbersPageState();
}

class _NumbersPageState extends State<NumbersPage> {
  final int _numPages = 10;
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Center(
        child: NumberPaginator(
          // by default, the paginator shows numbers as center content
          numberPages: _numPages,
          onPageChange: (int index) {
            setState(() {
              _currentPage = index;
            });
          },
          config: NumberPaginatorUIConfig(
            // default height is 48
            // height: 64,
            // buttonSelectedForegroundColor: Colors.white,
            // buttonUnselectedForegroundColor: Colors.white,
            // buttonUnselectedBackgroundColor: Colors.white,
            buttonSelectedBackgroundColor: Colors.pink,
          ),
        ),
      )/*pages[_currentPage]*/,
      // card for elevation
      // bottomNavigationBar: Card(
      //   margin: EdgeInsets.zero,
      //   elevation: 4,
      //   child: NumberPaginator(
      //     // by default, the paginator shows numbers as center content
      //     numberPages: _numPages,
      //     onPageChange: (int index) {
      //       setState(() {
      //         _currentPage = index;
      //       });
      //     },
      //   ),
      // ),
    );
  }
}
