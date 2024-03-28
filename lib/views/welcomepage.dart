
import 'package:new_bc_app/Model/loginresponse.dart';
import 'package:new_bc_app/views/login.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../const/common.dart';
import 'dashboard.dart';

class WelocomeView extends StatefulWidget {
  const WelocomeView({Key? key}) : super(key: key);

  @override
  State<WelocomeView> createState() => _WelocomeViewState();
}


class _WelocomeViewState extends State<WelocomeView> {

  TextStyle linkStyle = TextStyle(color: Colors.blue, decoration: TextDecoration.underline,fontSize: 12);
  TextStyle linkStyleOtp = TextStyle(color: Colors.redAccent, decoration: TextDecoration.underline,fontSize: 12);
  CommonAction commonAlert=new CommonAction();
  //PageController _pageController = PageController();
  double currentPageValue = 0.0;
  PageController controller= PageController();
  Duration pageTurnDuration = Duration(milliseconds: 500);
  Curve pageTurnCurve = Curves.ease;



  String _gestureStatus = 'Try Gestures!';

  void _handleTap() {
    setState(() {
      _gestureStatus = 'Tap gesture detected';
    });
  }

  void _handleDoubleTap() {
    setState(() {
      _gestureStatus = 'Double tap gesture detected';
    });
  }

  void _handleLongPress() {
    setState(() {
      _gestureStatus = 'Long press gesture detected';
    });
  }

  void _handlePanUpdate(DragUpdateDetails details) {
    setState(() {
      _gestureStatus =
      'Pan gesture update: dx=${details.delta.dx.toStringAsFixed(2)}, dy=${details.delta.dy.toStringAsFixed(2)}';
    });
  }


  @override
  void initState() {
    super.initState();

  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: _handleTap,
              onDoubleTap: _handleDoubleTap,
              onLongPress: _handleLongPress,
              onPanUpdate: _handlePanUpdate,
              child:Container(
                width: 200,
                height: 200,
                color: Colors.blue,
                child: Center(
                  child: Text(
                    _gestureStatus,
                    style: const TextStyle(
                      color: Colors.redAccent,
                      fontSize: 16,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),

    );



  }





}