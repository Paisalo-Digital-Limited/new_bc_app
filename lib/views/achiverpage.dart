import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/widgets.dart';
import 'package:gif/gif.dart';
import 'package:new_bc_app/model/commissionDetailsResponse.dart';
import 'package:new_bc_app/model/getTaskSlabDetailsResponse.dart';
import 'package:new_bc_app/views/tasklist.dart';
import 'package:provider/provider.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

import '../const/AppColors.dart';
import '../network/api_service.dart';

class AchiverPage extends StatefulWidget {
  final String username;
  final double commisionDetailsResponse;
   AchiverPage( this.username, this.commisionDetailsResponse, {super.key});

  @override
  State<AchiverPage> createState() => _AchiverPageState();
}

class _AchiverPageState extends State<AchiverPage> with TickerProviderStateMixin {
  late GifController _controller;
  @override
  void initState() {
    _getTaskSlabDetails();
    super.initState();
    _controller = GifController(vsync: this);
    showDelayedMessage();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  String message = '';
  double marginTop = 80.0;
  double fontSize = 20;
  int isLoading=0;
late GetTaskSlabDetailsResponse getTaskSlabDetailsResponse=GetTaskSlabDetailsResponse(statusCode: 0, message: "", data: []);
  AppColors appColors=new AppColors();
  // final List<Task> tasks = [
  //   Task(taskName: 'Task 1', statusInProgress: true),
  //   Task(taskName: 'Task 2', statusCompleted: true),
  //   Task(taskName: 'Task 3', statusPending: true),
  //   Task(taskName: 'Task 4', statusInProgress: true),
  //   Task(taskName: 'Task 5', statusCompleted: true),
  //   Task(taskName: 'Task 7', statusCompleted: true),
  // ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appColors.mainAppColor,

      appBar: AppBar(
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
                                        'COMMISSION',
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 16),
                                      ),
                                      Text(
                                        'TASKS',
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 16),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            isLoading==0?CircularProgressIndicator(color: Colors.white,):  Container(
                              height: 170,
                              color: Colors.white,
                              child: ListView.separated(
                                shrinkWrap: true,
                                itemCount: getTaskSlabDetailsResponse.data.length, // Replace with your task list length
                                separatorBuilder: (context, index) => Divider(),
                                itemBuilder: (context, index) {
                                  final task = getTaskSlabDetailsResponse.data[index];
                                  return Container(
                                    color: Colors.white,
                                    child: GestureDetector(
                                      onTap: (){
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => SlabDetailsPage(getTaskSlabDetailsResponse.data[index]),
                                            )
                                        );
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 8.0, right: 0),
                                        child: Container(
                                          color: Colors.white,
                                          padding: EdgeInsets.all(8),
                                          child: Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                '₹${task.slabs}',
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 18),
                                              ),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                children: [
                                                Text(
                                                  task.transactions.length.toString(),
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 18),
                                                ),
                                                  SizedBox(width: 10,),
                                                  Icon(Icons.arrow_forward_ios_sharp,size: 11,color: Colors.grey,)
                                              ],)
                                              ,
                                            ],
                                          ),
                                        ),
                                      ),
                                    )
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
                    builder: (context) => TaskList(widget.username),
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
            SizedBox(height: 20,),
            SizedBox(
              height: 350,
              width:  MediaQuery.of(context).size.width,

              // Adjust the width as needed// Adjust the height as needed
              child: Stack(
                children: [
                  AnimatedContainer(
                    width: MediaQuery.of(context).size.width,
                    duration: Duration(seconds: 1), // Animation duration
                    margin: EdgeInsets.only(top: marginTop), // Use marginTop here
                    child: Text(
                      textAlign: TextAlign.center,
                      message,
                      style: TextStyle(fontFamily: 'Visbybold',fontSize: fontSize,color: Colors.white,shadows: [
                        Shadow(
                          color: Colors.black.withOpacity(0.5),
                          blurRadius: 10,
                          offset: Offset(2,5),
                        ),
                      ],),
                    ),
                  ),
                  Container(
             width:MediaQuery.of(context).size.width,height:300,
                    child: Gif(

                    fit: BoxFit.contain,
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
                  ),)
                  ,


                ],
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
  void showDelayedMessage() {
    Future.delayed(Duration(seconds: 2), () {
      setState(() {
        message = '₹${widget.commisionDetailsResponse.toInt()}';
        marginTop = 20.0; // Update marginTop to 20
        fontSize = 60;
        // Update marginTop to 20
      });
    });
  }  Future<Null> _getTaskSlabDetails() {

    final api = Provider.of<ApiService>(context, listen: false);
    return api
           .getTaskSlabDetails()
        .then((value) {
      if (value.statusCode == 200) {
        setState(() {
          getTaskSlabDetailsResponse = value;
          isLoading = 1;
        });
      } else {
        setState(() {

        });
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


class SlabDetailsPage extends StatefulWidget {
  final SlabData slabData;
  SlabDetailsPage( this.slabData);

  @override
  State<SlabDetailsPage> createState() => _SlabDetailsPageState();
}

class _SlabDetailsPageState extends State<SlabDetailsPage> {
  AppColors appColors=AppColors();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appColors.mainAppColor,
      appBar: AppBar(

        backgroundColor: Color(0xFFD42D3F).withOpacity(0.7),
        leading: IconButton(
          icon: Icon(
            Icons.close, color: Colors.white, // Change the back icon here
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Commission Details',
          style: TextStyle(color: Colors.white, fontSize: 15),
        ),
      ),

        body:
        Column(
          children: [
            Container(

              child:
              Card(
                color: Colors.white,
                elevation: 2,
                margin: EdgeInsets.all(8.0),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          SizedBox(
                            width: 8,
                          ),
                          Container(
                            height: 40,

                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Text(
                            "Task Name",
                            style: TextStyle(fontSize: 15, color: appColors.mainAppColor),
                          ),

                        ],
                      ),
                      Padding(padding: EdgeInsets.only(right: 15),
                        child: Column(
                          children: [
                            Text(
                              "Count of Task",
                              style: TextStyle(fontSize: 15, color:appColors.mainAppColor),
                            ),
                          ],
                        ),),

                    ],
                  ),
                ),
              ) ,)
            ,
            Container(height: MediaQuery.of(context).size.height-170,width: MediaQuery.of(context).size.width,
              child: Center(
                child:ListView.builder(
                  itemCount: widget.slabData.transactions.length,
                  itemBuilder: (BuildContext context, int index) {
                    // Display the fetched data in a list view
                    return Card(
                      elevation: 5,
                      color: appColors.mainAppColor,
                      margin: EdgeInsets.all(8.0),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                SizedBox(
                                  width: 4,
                                ),
                                Container(
                                    height: 40,
                                    width: 40,
                                    child: Padding(padding: EdgeInsets.all(8),child: Image.asset(
                                      "assets/images/earn_ic.png",
                                      color: Colors.white,
                                    ),)),
                                SizedBox(
                                  width: 8,
                                ),
                                Container(width: MediaQuery.of(context).size.width/1.8,child:  Text(
                                  widget.slabData.transactions[index].transactionType.toString(),
                                  style: TextStyle(fontSize: 14, color: Colors.white),
                                ),)


                              ],
                            ),
                            Padding(padding: EdgeInsets.only(right: 15),
                              child: Column(
                                children: [
                                  Text(
                              widget.slabData.transactions[index].count.toString(),
                                    style: TextStyle(fontSize: 16, color: Colors.white),
                                  ),
                                ],
                              ),),

                          ],
                        ),
                      ),
                    );
                  },
                ), // Show error message if data is not available
              ),)
            ,
          ],
        )
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
