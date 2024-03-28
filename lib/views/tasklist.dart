import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

import '../const/AppColors.dart';

class TaskList extends StatefulWidget {
  const TaskList({super.key});

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

  final List<Task> tasks = [
    Task(taskName: 'Task 1', statusInProgress: true),
    Task(taskName: 'Task 2', statusCompleted: true),
    Task(taskName: 'Task 3', statusPending: true),
    Task(taskName: 'Task 4', statusInProgress: true),
    Task(taskName: 'Task 5', statusCompleted: true),
    Task(taskName: 'Task 7', statusCompleted: true),
    Task(taskName: 'Task 5', statusCompleted: true),
    Task(taskName: 'Task 5', statusCompleted: true),
    Task(taskName: 'Task 5', statusCompleted: true),
    Task(taskName: 'Task 5', statusCompleted: true),
    Task(taskName: 'Task 5', statusCompleted: true),
    Task(taskName: 'Task 5', statusCompleted: true),
    Task(taskName: 'Task 6', statusCompleted: true),
    Task(taskName: 'Task 5', statusCompleted: true),
    Task(taskName: 'Task 5', statusCompleted: true),
    Task(taskName: 'Task 5', statusCompleted: true),
    Task(taskName: 'Task 5', statusCompleted: true),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFB42C3B),
      appBar: AppBar(
        elevation: 6,
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
          child: Padding(
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
                child: Row(

                  children: [
                    Column(
                      children: [
                        Row(children: [
                          Container(
                            alignment: Alignment.center,
                                height: 60,
                              width: 140,
                              color: appColors.mainAppColor,
                              child: Text('PARTICULARS',style: TextStyle(
                                  color: Colors.white
                              ),))
                        ],),
                        Column(
                          children: [
                            Container(
                                color: Colors.white,
                                width: 140,
                                alignment: Alignment.center,
                                  height: 60,
                                child: Text('COMPLETED')),
                            Divider(
                              color: Colors.grey,
                              height: 1,
                            ),
                            Container(
                                color: Colors.white,

                                width: 140,
                                alignment: Alignment.center,
                                  height: 60,
                                child: Text('TARGETS')),
                            Divider(
                              color: Colors.grey,
                              height: 1,
                            ),
                            Container(
                                color: Colors.white,

                                width: 140,
                                alignment: Alignment.center,
                                  height: 60,
                                child: Text('ACHIEVED')),
                            Divider(
                              color: Colors.grey,
                              height: 1,
                            ),
                            Container(
                                color: Colors.white,

                                width: 140,
                                alignment: Alignment.center,
                                height: 60,
                                child: Text('ACHIEVED')),
                            Divider(
                              color: Colors.grey,
                              height: 1,
                            ),
                            Container(
                                color: Colors.white,

                                width: 140,
                                alignment: Alignment.center,
                                height: 60,
                                child: Text('ACHIEVED')),
                            Divider(
                              color: Colors.grey,
                              height: 1,
                            ),
                            Container(
                                color: Colors.white,

                                width: 140,
                                alignment: Alignment.center,
                                height: 60,
                                child: Text('ACHIEVED')),
                            Divider(
                              color: Colors.grey,
                              height: 1,
                            ),
                            Container(
                                color: Colors.white,

                                width: 140,
                                alignment: Alignment.center,
                                height: 60,
                                child: Text('ACHIEVED')),
                            Divider(
                              color: Colors.grey,
                              height: 1,
                            ),


                          ],
                        )

                      ],
                    ),

                    Flexible(
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Column(children: [
                          Row(children: [
                            Container(
                                color: appColors.mainAppColor,
                                width:90,
                                alignment: Alignment.center,
                                  height: 60,
                                child: Text('COMPLETED',style: TextStyle(
                                  color: Colors.white
                                ),)),
                            Container(
                                color: appColors.mainAppColor,
                                width: 90,
                                alignment: Alignment.center,
                                  height: 60,
                                child: Text('TARGETS',style: TextStyle(
                                    color: Colors.white
                                ),)),
                            Container(
                                color: appColors.mainAppColor,
                                width: 90,
                                alignment: Alignment.center,
                                  height: 60,
                                child: Text('ACHIEVED',style: TextStyle(
                                    color: Colors.white
                                ),))
                          ],),
                          Column(
                            children: [
                              Row(
                                children: [
                                  Container(
                                    color: Colors.white,
                                      width:90,
                                      alignment: Alignment.center,
                                        height: 60,
                                      child: Text('COMPLETED')),
                                  Container(
                                      color: Colors.white,

                                      width: 90,
                                      alignment: Alignment.center,
                                        height: 60,
                                      child: Text('TARGETS')),
                                  Container(
                                      color: Colors.white,

                                      width: 90,
                                      alignment: Alignment.center,
                                        height: 60,
                                      child: Text('ACHIEVED'))
                                ],
                              ),
                              Divider(
                                color: Colors.grey,
                                height: 1,
                              ),
                              Row(
                                children: [
                                  Container(
                                      color: Colors.white,

                                      width:90,
                                      alignment: Alignment.center,
                                        height: 60,
                                      child: Text('COMPLETED')),
                                  Container(
                                      color: Colors.white,

                                      width: 90,
                                      alignment: Alignment.center,
                                        height: 60,
                                      child: Text('TARGETS')),
                                  Container(
                                      color: Colors.white,

                                      width: 90,
                                      alignment: Alignment.center,
                                        height: 60,
                                      child: Text('ACHIEVED'))
                                ],
                              ),
                              Divider(
                                color: Colors.grey,
                                height: 1,
                              ),
                              Row(
                                children: [
                                  Container(
                                      color: Colors.white,

                                      width:90,
                                      alignment: Alignment.center,
                                        height: 60,
                                      child: Text('COMPLETED')),
                                  Container(
                                      color: Colors.white,

                                      width: 90,
                                      alignment: Alignment.center,
                                        height: 60,
                                      child: Text('TARGETS')),
                                  Container(
                                      color: Colors.white,

                                      width: 90,
                                      alignment: Alignment.center,
                                        height: 60,
                                      child: Text('ACHIEVED'))
                                ],
                              ),
                              Divider(
                                color: Colors.grey,
                                height: 1,
                              ),
                              Row(
                                children: [
                                  Container(
                                      color: Colors.white,

                                      width:90,
                                      alignment: Alignment.center,
                                      height: 60,
                                      child: Text('COMPLETED')),
                                  Container(
                                      color: Colors.white,

                                      width: 90,
                                      alignment: Alignment.center,
                                      height: 60,
                                      child: Text('TARGETS')),
                                  Container(
                                      color: Colors.white,

                                      width: 90,
                                      alignment: Alignment.center,
                                      height: 60,
                                      child: Text('ACHIEVED'))
                                ],
                              ),
                              Divider(
                                color: Colors.grey,
                                height: 1,
                              ),
                              Row(
                                children: [
                                  Container(
                                      color: Colors.white,

                                      width:90,
                                      alignment: Alignment.center,
                                      height: 60,
                                      child: Text('COMPLETED')),
                                  Container(
                                      color: Colors.white,

                                      width: 90,
                                      alignment: Alignment.center,
                                      height: 60,
                                      child: Text('TARGETS')),
                                  Container(
                                      color: Colors.white,

                                      width: 90,
                                      alignment: Alignment.center,
                                      height: 60,
                                      child: Text('ACHIEVED'))
                                ],
                              ),
                              Divider(
                                color: Colors.grey,
                                height: 1,
                              ),
                              Row(
                                children: [
                                  Container(
                                      color: Colors.white,

                                      width:90,
                                      alignment: Alignment.center,
                                      height: 60,
                                      child: Text('COMPLETED')),
                                  Container(
                                      color: Colors.white,

                                      width: 90,
                                      alignment: Alignment.center,
                                      height: 60,
                                      child: Text('TARGETS')),
                                  Container(
                                      color: Colors.white,

                                      width: 90,
                                      alignment: Alignment.center,
                                      height: 60,
                                      child: Text('ACHIEVED'))
                                ],
                              ),
                              Divider(
                                color: Colors.grey,
                                height: 1,
                              ),
                              Row(
                                children: [
                                  Container(
                                      color: Colors.white,

                                      width:90,
                                      alignment: Alignment.center,
                                      height: 60,
                                      child: Text('COMPLETED')),
                                  Container(
                                      color: Colors.white,

                                      width: 90,
                                      alignment: Alignment.center,
                                      height: 60,
                                      child: Text('TARGETS')),
                                  Container(
                                      color: Colors.white,

                                      width: 90,
                                      alignment: Alignment.center,
                                      height: 60,
                                      child: Text('ACHIEVED'))
                                ],
                              ),
                              Divider(
                                color: Colors.grey,
                                height: 1,
                              ),


                            ],
                          )

                        ],),
                      ),
                    )
                  ],
                ),

                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
              ),
              // Optional space between image and other content
            ],
          ),
        ),
      )),
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
