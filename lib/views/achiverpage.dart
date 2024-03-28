import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:gif/gif.dart';
import 'package:new_bc_app/views/tasklist.dart';

import '../const/AppColors.dart';

class AchiverPage extends StatefulWidget {
  const AchiverPage({super.key});

  @override
  State<AchiverPage> createState() => _AchiverPageState();
}

class _AchiverPageState extends State<AchiverPage> with TickerProviderStateMixin {
  late GifController _controller;
  @override
  void initState() {
    super.initState();
    _controller = GifController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  AppColors appColors=new AppColors();
  final List<Task> tasks = [
    Task(taskName: 'Task 1', statusInProgress: true),
    Task(taskName: 'Task 2', statusCompleted: true),
    Task(taskName: 'Task 3', statusPending: true),
    Task(taskName: 'Task 4', statusInProgress: true),
    Task(taskName: 'Task 5', statusCompleted: true),
    Task(taskName: 'Task 7', statusCompleted: true),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appColors.mainAppColor,

      appBar: AppBar(
        elevation: 6,
        backgroundColor: appColors.mainAppColor,
        leading: IconButton(
          icon: Icon(
            Icons.close,color: Colors.white, // Change the back icon here
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text('SUPER ACHIEVER',style: TextStyle(color: Colors.white),),
      ),
      body: SingleChildScrollView(
        child: Center(
            child: Column(
          children: [
            Padding(
              padding:
                  const EdgeInsets.only(left: 8.0, right: 8, top: 20, bottom: 10),
              child: Container(
                width: double.maxFinite,
                height: 350,
                margin: EdgeInsets.only(left: 10,right: 10),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(
                        'assets/images/card_bg.png'), // Replace with your SVG file path
                    fit: BoxFit.fill,
                  ),
                ),
                child: Column(
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                        alignment: Alignment.center,
                        width: 270,
                        child: Text(
                          "EARN MORE WITH HIGH\nCOMMISSION TASK",
                          style: TextStyle(
                            color: appColors.mainAppColor,
                            fontSize: 18,
                          ),
                          textAlign: TextAlign.center,
                        )),
                    SizedBox(
                      height: 5,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0, right: 23),
                      child: Card(
                        elevation: 6,
                        clipBehavior: Clip.antiAlias,
                        child: Container(
                          child: Column(
                            children: [
                              Container(
                                color: appColors.mainAppColor,
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'PARTICULARS',
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 16),
                                      ),
                                      Text(
                                        'TARGETS',
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 16),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                height: 170,
                                color: Colors.white,
                                child: ListView.separated(
                                  shrinkWrap: true,
                                  itemCount: tasks
                                      .length, // Replace with your task list length
                                  separatorBuilder: (context, index) => Divider(),
                                  itemBuilder: (context, index) {
                                    final task = tasks[index];
                                    return Container(
                                      color: Colors.white,
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 8.0, right: 8),
                                        child: Container(
                                          color: Colors.white,
                                          padding: EdgeInsets.all(8),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                task.taskName,
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 18),
                                              ),
                                              Text(
                                                '20',
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 18),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              )
                            ],
                          ),
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
            ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TaskList(),
                  ),
                );
              },
              child: Container(
                width: 150,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Center(
                  child: Text(
                    'ADD TO TASK LIST',
                    style: TextStyle(
                      color: appColors.mainAppColor,
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {

              },
              child: Container(
                width: 150,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Center(
                  child: Text(
                    'REFRESH',
                    style: TextStyle(
                      color: appColors.mainAppColor,
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
            SizedBox(height: 10,),
            SizedBox(
              height: 300,
              // Adjust the width as needed// Adjust the height as needed
              child: Gif(
                fit: BoxFit.cover,
                image: AssetImage("assets/images/caranimation.gif"),
                controller: _controller, // if duration and fps is null, original gif fps will be used.
                //fps: 30,
                //duration: const Duration(seconds: 3),
                autostart: Autostart.no,
                placeholder: (context) => Center(child: const CircularProgressIndicator()),
                onFetchCompleted: () {
                  _controller.reset();
                  _controller.forward();
                },
              ),
            )
          ],
        )),
      ),
      // bottomNavigationBar: CurvedNavigationBar(
      //   height: 60,
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
      //   backgroundColor: appColors.mainAppColor,
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
