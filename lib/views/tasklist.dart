import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:intl/intl.dart';
import 'package:new_bc_app/model/monthlyTaskStatus.dart';
import 'package:provider/provider.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

import '../const/AppColors.dart';
import '../network/api_service.dart';

class TaskList extends StatefulWidget {
  final String username;
   TaskList( this.username);

  @override
  State<TaskList> createState() => _TaskListState();
}

Color getRandomLightColor() {
  final Random random = Random();
  return Color.fromARGB(
    255,
    150 + random.nextInt(100), // Red component
    150 + random.nextInt(100), // Green component
    150 + random.nextInt(100), // Blue component
  );
}

class _TaskListState extends State<TaskList> {
  AppColors appColors=new AppColors();
late MonthlyTaskStatus monthlyTaskStatus;
  var headerList={"Target","Achived","Pending"};
int isLoading=0;
  @override
  void initState() {
    _fetchTask();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFB42C3B),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color(0xFFB42C3B),
        leading: IconButton(
          icon: Icon(
            Icons.close, color: Colors.white, // Change the back icon here
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text(
          'TASK LIST',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Center(
          child: isLoading==1?Padding(
            padding:
            const EdgeInsets.only(left: 8.0, right: 8, top: 40, bottom:40),
            child: Container(
              width: double.maxFinite,
              // Adjust the width as needed

              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                      'assets/images/tasklist_bg.png'), // Replace with your SVG file path
                  fit: BoxFit.fill,
                ),
              ),
              child: Column(
                children: [
                  SizedBox(
                    height: 25,
                  ),
                  Text(
                    "YOUR TASK LIST",
                    style: TextStyle(color: Color(0xFFB42C3B), fontSize: 18),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0, right: 23),
                    child: Card(
                      elevation: 6,
                      clipBehavior: Clip.antiAlias,
                      child:    Container(
                        height: 500,
                        child: SingleChildScrollView(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [

                                Row(
                                  children: _buildCellsParticularHeader(1),
                                ),
                                Column(
                                  children: _buildCells(monthlyTaskStatus.data.length,monthlyTaskStatus.data),
                                )
                              ]),
                              Flexible(
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children:
                                          _buildCellsHeader(headerList.length),
                                        ),

                                        Column(
                                            children:_buildRows(monthlyTaskStatus.data.length),
                                        )
                                      ]),
                                ),
                              )
                            ],
                          ),
                        ),),

                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                  ),
                  // Optional space between image and other content
                ],
              ),
            ),
          ):CircularProgressIndicator(color: Colors.white,)),
      // bottomNavigationBar: CurvedNavigationBar(
      //     height: 60,
      //   items: const <Widget>[
      //     Icon(CupertinoIcons.home, size: 25, color: Color(0xFFC2C2C2)),
      //     Icon(CupertinoIcons.add, size: 25, color: Color(0xFFC2C2C2)),
      //     Icon(CupertinoIcons.location_solid,
      //         size: 25, color: Color(0xFFC2C2C2)),
      //     Icon(CupertinoIcons.money_dollar_circle,
      //         size: 25, color: Color(0xFFC2C2C2)),
      //     Icon(CupertinoIcons.profile_circled,
      //         size: 25, color: Color(0xFFC2C2C2)),
      //   ],
      //   color: Colors.white,
      //   buttonBackgroundColor: Colors.white,
      //   backgroundColor: Color(0xFFB42C3B),
      //   animationCurve: Curves.easeInOut,
      //   animationDuration: const Duration(milliseconds: 400),
      //   onTap: (index) {
      //     setState(() {});
      //   },
      //   letIndexChange: (index) => true,
      // ),
    );
  }
  List<Widget> _buildCellsParticularHeader(int count) {
    return List.generate(
        count,
            (index) => GestureDetector(
          onTap: () {},
          child: Container(
            alignment: Alignment.center,
            width: 90.0,
            height: 60.0,
            color: appColors.mainAppColor,
            margin: EdgeInsets.only(left: 1.0, bottom: 1, right: 1),
            child: Text(
              "Timing",
              style: TextStyle(color: Colors.white,fontSize: 15),
            ),
          ),
        ));
  }

  List<Widget> _buildCells(int count, List<Datum> data) {
    return List.generate(
        data.length,
            (index) => GestureDetector(
          onTap: () {},
          child: Container(
            alignment: Alignment.center,
            width: 90.0,
            height: 60.0,
            color: appColors.white,
            margin: EdgeInsets.all(1.0),
            child: Text(
              textAlign: TextAlign.center,
              "${data.elementAt(index).aliasName}",
              style: TextStyle(color: Colors.black,fontSize: 15),
            ),
          ),
        ));
  }





  List<Widget> _buildRows(int count) {
    return List.generate(
      count,
          (index) => Row(

        children: [
          Container(
            alignment: Alignment.center,
            width: 100.0,
            height: 60.0,
            color: appColors.white,
            margin: EdgeInsets.all(1.0),
            child: Center(
              child: Text(
                textAlign: TextAlign.center,
                "${monthlyTaskStatus.data.elementAt(index).targetCount}",
                style: TextStyle(color:appColors.mainAppColor,fontSize: 15),
              ),
            ),
          ),

          Container(
            alignment: Alignment.center,
            width: 100.0,
            height: 60.0,
            color: appColors.white,
            margin: EdgeInsets.all(1.0),
            child: Center(
              child: Text(
                textAlign: TextAlign.center,
                "${monthlyTaskStatus.data.elementAt(index).achieveCount}",
                style: TextStyle(color: appColors.mainAppColor,fontSize: 15),
              ),
            ),
          ),
          Container(
            alignment: Alignment.center,
            width: 100.0,
            height: 60.0,
            color:   monthlyTaskStatus.data.elementAt(index).targetCount-monthlyTaskStatus.data.elementAt(index).achieveCount!=0?Color(
                0xffc70011):Color(0xff38c700),
            margin: EdgeInsets.all(1.0),
            child: Center(
              child: Text(
                textAlign: TextAlign.center,
                "${monthlyTaskStatus.data.elementAt(index).targetCount-monthlyTaskStatus.data.elementAt(index).achieveCount}",
                style: TextStyle(color: appColors.white,fontSize: 15),
              ),
            ),
          )
        ],
      ),
    );
  }

  List<Widget> _buildCellsHeader(int count) {

    // int i = 0;
    // Set setOfDates = {};
    // while (i < count) {
    //   //print("day name==${i}");
    //   //print("day name==${getCurrentDate(setOfDays.elementAt(i), 0)}");
    //   if (setOfDays.elementAt(i) > 10) {
    //     setOfDates.add(getCurrentDate((setOfDays.elementAt(i) - 10), 7));
    //   } else {
    //     setOfDates.add(getCurrentDate(setOfDays.elementAt(i), 0));
    //   }
    //
    //   i++;
    // }
    return List.generate(
        count,
            (index) => GestureDetector(
          onTap: () {},
          child: Container(
            alignment: Alignment.center,
            width: 100.0,
            height: 60.0,
            color: appColors.mainAppColor,
            margin: EdgeInsets.only(left: 1.0, bottom: 1, right: 1),
            child: Center(
                child: Text(
                  "${headerList.elementAt(index)}",
                  style: TextStyle(color: Colors.white,fontSize: 15),
                )),
          ),
        ));
  }

  Future<Null> _fetchTask() {
    var now = DateTime.now();
    var monthFormat = DateFormat.MMMM(); // Month name format
    var yearFormat = DateFormat.y(); // Year format

    String monthName = monthFormat.format(now); // Getting current month name
    String year = yearFormat.format(now);
    final api = Provider.of<ApiService>(context, listen: false);
    return api
        .getTargetStatus(widget.username,monthName,year)
        .then((value) {
      if (value.statusCode == 200) {
        if(value.data.length>0){
          setState(() {
            monthlyTaskStatus = value;
            isLoading=1;

          });
        }else{
          isLoading=1;
          QuickAlert.show(
              context: context,
              type: QuickAlertType.error,
              title: 'Oops...',
              text: 'Sorry, no record found',
              backgroundColor: Colors.white,
              titleColor: appColors.mainAppColor,
              textColor: appColors.mainAppColor,
              onConfirmBtnTap: (){
                Navigator.pop(context);
                Navigator.pop(context);
              },
              confirmBtnColor: appColors.mainAppColor);
        }

      } else {
        setState(() {});
        QuickAlert.show(
          context: context,
          type: QuickAlertType.error,
          title: 'Oops...',
          text: 'Sorry, no record found',
          backgroundColor: Colors.white,
          titleColor: appColors.mainAppColor,
          textColor: appColors.mainAppColor,
          confirmBtnColor: appColors.mainAppColor,
        );
      }
    });
  }
}

class Task {
  final String taskName;
  final bool statusInProgress;
  final bool statusCompleted;
  final bool statusPending;

  Task({
    required this.taskName,
    this.statusInProgress = false,
    this.statusCompleted = false,
    this.statusPending = false,
  });
}
