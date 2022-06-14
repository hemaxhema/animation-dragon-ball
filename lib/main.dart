import 'dart:math';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:animation_dragon_ball/detailPage.dart';

import 'ListofChar.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      initialRoute: MyApp.id,
      routes: {
        MyApp.id: (context) => MyApp(),
        DetailPage.id: (context) => DetailPage(),
      },
    ),
  );
}

class MyApp extends StatefulWidget {
  static const id = "MyApp";

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late PageController ControllerofPageView;
  double currentPage = 0;

  _pageListener() {
    currentPage = ControllerofPageView.page!;
    setState(() {});
  }

  @override
  void initState() {
    ControllerofPageView = PageController(viewportFraction: 0.6);
    ControllerofPageView.addListener(_pageListener);
    super.initState();
  }

  @override
  void dispose() {
    ControllerofPageView.removeListener(_pageListener);
    ControllerofPageView.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Dragon Ball"),
        centerTitle: true,
      ),
      body: PageView.builder(
        scrollDirection: Axis.vertical,
        controller: ControllerofPageView,
        itemBuilder: (context, i) {
          // print("index = $i  , currentPage = ${ControllerofPageView.page}");
          final double ResizeFactor =
              (1 - (((currentPage - i).abs() * 0.4).clamp(0, 1)));
          final CurrentChar = ListofChar[i];

          return GestureDetector(
            onTap: () {
              // print(ResizeFactor);
              Navigator.pushNamed(context, DetailPage.id,
                  arguments: CurrentChar);
            },
            child: ItemList(
              thisColor: CurrentChar.thisColor,
              thisName: CurrentChar.thisName,
              thisUrl: CurrentChar.thisUrl,
              ResizeFactor: ResizeFactor as double,
            ),
          );
        },
        itemCount: ListofChar.length,
      ),
    );
  }
}

class ItemList extends StatelessWidget {
  String thisName;
  String thisUrl;
  int thisColor;
  double ResizeFactor;

  ItemList(
      {required this.thisName,
      required this.thisUrl,
      required this.thisColor,
      required this.ResizeFactor});

  @override
  Widget build(BuildContext context) {
    return Padding(
      // padding: EdgeInsets.all(ResizeFactor * -1 * 100 + 115),
      padding: EdgeInsets.all(pow(ResizeFactor, -5.0799).toDouble() * 15),

      child: Stack(children: [
        Container(
          child: Container(
            width: double.infinity,
            alignment: Alignment.bottomLeft,
            margin: EdgeInsets.all(15),
            child: Text(
              thisName,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 25 * ResizeFactor),
            ),
          ),
          height:
              (MediaQuery.of(context).size.height - kToolbarHeight) / 3 - 10,
          margin: EdgeInsets.all(30),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(15),
            ),
            gradient: LinearGradient(
              colors: [Color(thisColor), Colors.white],
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              stops: [0.2, 1],
            ),
            boxShadow: [
              BoxShadow(
                  color: Colors.black, offset: Offset(-5, 5), blurRadius: 10)
            ],
          ),
        ),
        Container(
          alignment: Alignment.topRight,
          margin: EdgeInsets.only(right: 40),
          child: Hero(
            tag: thisUrl,
            child: Image.asset(thisUrl,
                height: (MediaQuery.of(context).size.height - kToolbarHeight) /
                    2.8 *
                    (ResizeFactor)),
          ),
        ),
      ]),
    );
  }
}
