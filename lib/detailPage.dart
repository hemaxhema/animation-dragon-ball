import 'package:flutter/material.dart';
import 'ListofChar.dart';

class DetailPage extends StatelessWidget {
  static const String id = "DetailPage";

  @override
  Widget build(BuildContext context) {
    final thisChar = ModalRoute.of(context)!.settings.arguments as Char;
    return Scaffold(
        backgroundColor: Color(thisChar.thisColor),
        body: SafeArea(
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: IconButton(
                      alignment: Alignment.centerLeft,
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                        size: 25,
                      ),
                      padding: EdgeInsets.all(15),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      alignment: Alignment.topCenter,
                      padding: const EdgeInsets.all(15.0),
                      child: Text(
                        thisChar.thisName,
                        style: TextStyle(fontSize: 22, color: Colors.white),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(),
                  ),
                ],
              ),
              Hero(
                tag: thisChar.thisUrl,
                child: Image.asset(thisChar.thisUrl,
                    height:
                        (MediaQuery.of(context).size.height - kToolbarHeight) /
                            2),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Text(
                  thisChar.description,
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              )
            ],
          ),
        ));
  }
}
