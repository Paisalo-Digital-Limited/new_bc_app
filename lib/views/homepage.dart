import 'dart:async';
import 'dart:ui';
import 'dart:io';
import 'package:new_bc_app/model/loginresponse.dart';
import 'package:new_bc_app/views/achiverpage.dart';
import 'package:new_bc_app/views/csp_annual_report.dart';
import 'package:new_bc_app/views/requestforfundtransfer.dart';
import 'package:new_bc_app/views/tasklist.dart';
import 'package:new_bc_app/views/login.dart';
import 'package:new_bc_app/views/withdrawalanddeposithistory.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:table_calendar/table_calendar.dart';
import '../network/api_service.dart';
import '../const/AppColors.dart';
import 'package:gif/gif.dart';

import 'earningpage.dart';
import 'homevisitmappage.dart';
import 'serviceandschemelist.dart';
import 'targetsetpage.dart';
import 'transactionhistorypage.dart';

class HomePage extends StatefulWidget {
  final LoginResponse loginResponse;
  final String username;
  const HomePage({super.key, required this.loginResponse, required this.username});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  AppColors appColors = new AppColors();

  int _currentIndex = 0;
  int _page = 0;
  bool isDialogOpen = false;
  int _current = 0;
  final List<String> imgList = [
    "assets/images/leaderboardbanner.gif",
    "assets/images/leaderboardbanner.gif",
    "assets/images/leaderboardbanner.gif"
  ];


  // CalendarPage(),

  late List<dynamic> _pages ;
  Widget buildDot({required int index}) {
    return Container(
      width: 7,
      height: 7,
      margin: EdgeInsets.symmetric(horizontal: 2),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: _current == index ? Colors.white : Colors.grey,
      ),
    );
  }

  @override
  void initState() {
   _pages = [
    HomePageview(widget.loginResponse,widget.username),
    LeaderBoard(),
    ServiceAndSchemeList(widget.loginResponse,widget.username),
    EarningPage(),
    ProfilePage( loginResponse: widget.loginResponse,username:widget.username),
    ];
    super.initState();
    //_showOverlay(context);
  }

  void _showOverlay(BuildContext context) {
    Navigator.of(context).push(TutorialOverlay());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appColors.mainAppColor,
      body: _pages[_page],

      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     Navigator.push(
      //       context,
      //       MaterialPageRoute(builder: (context) =>  ServiceAndSchemeList()),
      //     );
      //   },
      //   backgroundColor: Colors.white70,
      //   shape: CircleBorder(),
      //   child: Icon(
      //     CupertinoIcons.bars,
      //     color: Colors.white,
      //   ),
      // ),
      bottomNavigationBar: CurvedNavigationBar(
        height: 60,
        items: <Widget>[

          Padding(padding: EdgeInsets.all(8),
          child:  ImageIcon(
            AssetImage('assets/images/home_ic.png'), // Replace 'assets/image.png' with your image path
            size: 20, // Adjust the size as needed
            color: _page==0?appColors.mainAppColor: Colors.grey,
            // Adjust the color as needed
          ),)
         ,
          Padding(padding: EdgeInsets.all(8),
            child:  ImageIcon(
              AssetImage('assets/images/leader_ic.png'), // Replace 'assets/image.png' with your image path
              size: 20, // Adjust the size as needed
              color: _page==1?appColors.mainAppColor: Colors.grey,
              // Adjust the color as needed
            ),)
          ,
          Padding(padding: EdgeInsets.all(8),
            child:  ImageIcon(
              AssetImage('assets/images/service_ic.png'), // Replace 'assets/image.png' with your image path
              size: 20, // Adjust the size as needed
              color: _page==2?appColors.mainAppColor: Colors.grey,
              // Adjust the color as needed
            ),)
          ,
          Padding(padding: EdgeInsets.all(8),
            child:  ImageIcon(
              AssetImage('assets/images/earn_ic.png'), // Replace 'assets/image.png' with your image path
              size: 20, // Adjust the size as needed
              color: _page==3?appColors.mainAppColor: Colors.grey,
              // Adjust the color as needed
            ),)
          ,
          Padding(padding: EdgeInsets.all(8),
            child:  ImageIcon(
              AssetImage('assets/images/prof_ic.png'), // Replace 'assets/image.png' with your image path
              size: 20, // Adjust the size as needed
              color: _page==4?appColors.mainAppColor: Colors.grey,
              // Adjust the color as needed
            ),)
          ,

        ],
        color: Colors.white,
        buttonBackgroundColor: Colors.white,
        backgroundColor: Colors.transparent,
        animationCurve: Curves.easeInOut,
        animationDuration: const Duration(milliseconds: 400),
        onTap: (index) {
          setState(() {
            setState(() {
              _page = index;
            });
          });
        },
        letIndexChange: (index) => true,
      ),
    );
  }
}

class MapPage extends StatelessWidget {
  AppColors appColors = new AppColors();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appColors.mainAppColor,
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Container(
          alignment: Alignment.center,
          child: Text(
            "This page needs some disscussion!!",
            style: TextStyle(fontSize: 33, color: Colors.white),
          ),
        ),
      ),
    );
  }
}

class ProfilePage extends StatefulWidget {
  final LoginResponse loginResponse;
  final String username;
  ProfilePage({super.key, required this.loginResponse, required this.username});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _mobileController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  File? _image;
  AppColors appColors = new AppColors();
  /*final picker = ImagePicker();

  Future getImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }*/

  @override
  void dispose() {
    _nameController.dispose();
    _mobileController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appColors.mainAppColor,
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                GestureDetector(
                  //onTap: getImage,
                  child: CircleAvatar(
                    radius: 40,
                    backgroundColor: Colors.grey[300],
                    backgroundImage:
                    _image != null ? FileImage(_image!) : null,
                    child: _image == null
                        ? Icon(
                      Icons.add_a_photo,
                      size: 50,
                      color: Colors.grey[800],
                    )
                        : null,
                  ),
                ),
                SizedBox(
                  height: 12,
                ),
                Text(
                  widget.loginResponse.data.name,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontFamily: 'Visbybold'),
                ),
                SizedBox(height: 12.0),
                Card(
                  shape: Border.all(
                      width: 0,
                      color:
                      Colors.black), // Optional border for visual clarity

                  child: Container(
                    height: 45,
                    color: Colors.white,
                    padding: EdgeInsets.only(left: 10, right: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'MOBILE NUMBER',
                          style: TextStyle(
                              fontSize: 16, fontFamily: 'Visbyfregular'),
                        ),
                        Row(
                          children: [
                            Text(
                              widget.loginResponse.data.mobile,
                              style: TextStyle(
                                  fontSize: 16,fontFamily: 'Visbyfregular'),
                            ),
                            Icon(
                              CupertinoIcons.check_mark_circled_solid,
                              color: Colors.green,
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 12.0),
                Card(
                  shape: Border.all(
                      width: 0,
                      color:
                      Colors.black), // Optional border for visual clarity
                  child: Container(
                    height: 45,
                    color: Colors.white,
                    padding: EdgeInsets.only(left: 10, right: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'KYC Update',
                          style: TextStyle(
                              fontSize: 16, fontFamily: 'Visbyfregular'),
                        ),
                        Row(
                          children: [
                            Icon(
                              CupertinoIcons.arrow_right,
                              color: Colors.green,
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 12.0),
                Card(
                  shape: Border.all(
                      width: 0,
                      color:
                      Colors.black), // Optional border for visual clarity
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Container(
                      height: 45,
                      color: Colors.white,
                      padding: EdgeInsets.only(left: 10, right: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            widget.loginResponse.data.address,
                            style: TextStyle(
                                fontSize: 16, fontFamily: 'Visbyfregular'),
                          ),
                          Row(
                            children: [
                              Icon(
                                CupertinoIcons.location_solid,
                                color: Colors.green,
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 12.0),
                Card(
                  shape: Border.all(
                      width: 0,
                      color:
                      Colors.black), // Optional border for visual clarity
                  child: Container(
                    height: 45,
                    color: Colors.white,
                    padding: EdgeInsets.only(left: 10, right: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'APPLY FOR LOAN',
                          style: TextStyle(
                              fontSize: 16, fontFamily: 'Visbyfregular'),
                        ),
                        Row(
                          children: [
                            Icon(
                              CupertinoIcons.arrow_right,
                              color: Colors.green,
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 12.0),
                GestureDetector(
                  onTap: (){

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => (TransactionHistoryPage(loginResponse: widget.loginResponse,username:widget.username)),
                      ),
                    );
                  },
                  child:   Card(
                    shape: Border.all(
                        width: 0,
                        color:
                        Colors.black), // Optional border for visual clarity
                    child: Container(
                      height: 45,
                      color: Colors.white,
                      padding: EdgeInsets.only(left: 10, right: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'TRANSACTION HISTORY',
                            style: TextStyle(
                                fontSize: 16, fontFamily: 'Visbyfregular'),
                          ),
                          Row(
                            children: [
                              Icon(
                                CupertinoIcons.arrow_right,
                                color: Colors.green,
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),

                ),

                SizedBox(height: 12.0),
                GestureDetector(
                  onTap: (){

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => (WithdrawalAndDepositHistory(loginResponse: widget.loginResponse,username:widget.username)),
                      ),
                    );
                  },
                  child:   Card(
                    shape: Border.all(
                        width: 0,
                        color:
                        Colors.black), // Optional border for visual clarity
                    child: Container(
                      height: 45,
                      color: Colors.white,
                      padding: EdgeInsets.only(left: 10, right: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Withdrwal and Deposit History',
                            style: TextStyle(
                                fontSize: 16, fontFamily: 'Visbyfregular'),
                          ),
                          Row(
                            children: [
                              Icon(
                                CupertinoIcons.arrow_right,
                                color: Colors.green,
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),

                ),
                SizedBox(height: 12.0),
                GestureDetector(
                  onTap: (){

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => (CSPAnnualReportPage()),
                      ),
                    );
                  },
                  child:   Card(
                    shape: Border.all(
                        width: 0,
                        color:
                        Colors.black), // Optional border for visual clarity
                    child: Container(
                      height: 45,
                      color: Colors.white,
                      padding: EdgeInsets.only(left: 10, right: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'CSP Annual Reports',
                            style: TextStyle(
                                fontSize: 16, fontFamily: 'Visbyfregular'),
                          ),
                          Row(
                            children: [
                              Icon(
                                CupertinoIcons.arrow_right,
                                color: Colors.green,
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),

                ),
                SizedBox(
                  height: 20,
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}

class EarningPage extends StatefulWidget {
  const EarningPage({super.key});

  @override
  State<EarningPage> createState() => _EarningPageState();
}

class _EarningPageState extends State<EarningPage> {
  String targettedAmount="";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getTargetAmount();
  }
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  AppColors appColors = new AppColors();
  // Set your progress value here
  List<dynamic> _ViewList = [WeeklyView(), MonthlyView()];
  int _viewType = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appColors.mainAppColor,
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              SizedBox(
                height: 30,
              ),
              Container(
                width: double.maxFinite,
                height: MediaQuery.of(context).size.height / 5,
                margin: EdgeInsets.all(3),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(
                        'assets/images/list_card_bg.png'), // Replace with the actual image path
                    fit: BoxFit.fill,
                  ),
                ),
                padding: EdgeInsets.all(10),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "CURRENT EARNINGS",
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.white,
                          fontFamily: 'Visbyfregular',
                        ),
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            '₹ 0',
                            style: TextStyle(
                                fontSize: 40,
                                fontFamily: 'Visbybold',
                                color: Colors.white),
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Container(
                            width: 60,
                            alignment: Alignment.center,
                            height: 30,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  CupertinoIcons.down_arrow,
                                  size: 15,
                                ),
                                Text(
                                  "0",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontFamily: 'Visbyfregular'),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                      Text(
                        "Best month ₹0",
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontFamily: 'Visbyfregular',
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "INVESTMENT RECOVERED",
                style: TextStyle(
                    fontFamily: 'Visbyfregular',
                    color: Colors.white,
                    fontSize: 12),
              ),
              SizedBox(
                height: 4,
              ),
              Container(
                width: 250,
                height: 10, // Adjust the height of the progress bar
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                      5), // Adjust the border radius for curved edges
                  color:
                      Colors.grey[300], // Background color of the progress bar
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: LinearProgressIndicator(
                    value: 0.1, // Set the progress value (0.0 to 1.0)
                    backgroundColor: Colors
                        .transparent, // Set the background color of the indicator
                    valueColor: AlwaysStoppedAnimation<Color>(
                        Color(0xFFEE5565)), // Color of the progress indicator
                  ),
                ),
              ),
              SizedBox(
                height: 3,
              ),
              Container(
                width: 250,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('₹0',
                        style: TextStyle(
                            fontFamily: 'Visbyfregular',
                            color: Colors.white,
                            fontSize: 11)),
                    Text('₹0',
                        style: TextStyle(
                            fontFamily: 'Visbyfregular',
                            color: Colors.white,
                            fontSize: 11))
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10, top: 8),
                child: Container(
                  alignment: Alignment.center,
                  // Adjust the width as needed
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height / 2.2,
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
                      Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Row(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        // Toggle light when tapped.
                                        _viewType = 0;
                                      });
                                    },
                                    child: Container(
                                      alignment: Alignment.bottomCenter,
                                      width: 90,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'WEEKLY',
                                            style: TextStyle(fontSize: 12),
                                          ),
                                          Divider(
                                            // You can adjust the height of the divider
                                            color: _viewType == 0
                                                ? appColors.mainAppColor
                                                : Colors.grey
                                                    .shade400, // You can set the color of the divider // You can set the color of the divider
                                            thickness:
                                                3, // You can adjust the thickness of the divider
                                            // You can set an end indent for the divider (space from the right)
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        // Toggle light when tapped.
                                        _viewType = 1;
                                      });
                                    },
                                    child: Container(
                                      alignment: Alignment.bottomCenter,
                                      width: 90,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Text('MONTHLY',
                                              style: TextStyle(fontSize: 12)),
                                          Divider(
                                            // You can adjust the height of the divider
                                            color: _viewType == 1
                                                ? appColors.mainAppColor
                                                : Colors.grey
                                                    .shade400, // You can set the color of the divider // You can set the color of the divider
                                            thickness:
                                                3, // You can adjust the thickness of the divider
                                            // You can set an end indent for the divider (space from the right)
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              GestureDetector(
                                onTap: () {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return Dialog(
                                        clipBehavior: Clip.antiAlias,
                                        backgroundColor: Colors
                                            .white, // Red color with transparency
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ),
                                        child: Container(
                                            color: Colors.white,
                                            // height: 400,
                                            child: TableCalendar(
                                              firstDay:
                                                  DateTime.utc(2023, 1, 1),
                                              lastDay:
                                                  DateTime.utc(2023, 12, 31),
                                              focusedDay: _focusedDay,
                                              calendarFormat: _calendarFormat,
                                              selectedDayPredicate: (day) {
                                                // Use `selectedDayPredicate` to mark the selected day.
                                                return isSameDay(
                                                    _selectedDay, day);
                                              },
                                              onDaySelected:
                                                  (selectedDay, focusedDay) {
                                                setState(() {
                                                  _selectedDay = selectedDay;
                                                  _focusedDay = focusedDay;
                                                });
                                              },
                                              onFormatChanged: (format) {
                                                setState(() {
                                                  _calendarFormat = format;
                                                });
                                              },
                                              onPageChanged: (focusedDay) {
                                                _focusedDay = focusedDay;
                                              },
                                            )),
                                      );
                                    },
                                  );
                                },
                                child: Container(
                                    alignment: Alignment.center,
                                    child: Icon(Icons.arrow_drop_down)),
                              )
                            ],
                          ),
                          Divider(
                            height: 0,
                            color: Colors.grey
                                .shade400, // You can set the color of the divider
                            thickness:
                                1, // You can adjust the thickness of the divider
                            indent:
                                6, // You can set an indent for the divider (space from the left)
                            endIndent:
                                6, // You can set an end indent for the divider (space from the right)
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.arrow_back_ios_outlined,
                            color: Colors.grey,
                            size: 15,
                          ),
                          SizedBox(
                            width: 30,
                          ),
                          Text(
                            'CURRENT PERIOD',
                            style: TextStyle(fontSize: 12),
                          ),
                          SizedBox(
                            width: 30,
                          ),
                          Icon(
                            Icons.arrow_forward_ios_outlined,
                            color: Colors.grey,
                            size: 15,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      _ViewList[_viewType],
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10, top: 8,bottom: 20),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                        20.0), // Adjust the value to change the radius
                  ),
                  color: Colors.white,
                  elevation: 3,
                  clipBehavior: Clip.antiAlias,
                  child: Container(
                    color: Colors.white,
                    // height: 130,
                    width: double.maxFinite,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 16.0, right: 16, top: 16, bottom: 8),
                              child: Text(
                                "FUTURE EARNINGS",
                                style: TextStyle(
                                    color: Color(
                                      0xFFB42C3B,
                                    ),
                                    fontSize: 14),
                              ),
                            )),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 16.0),
                                child: Row(
                                  children: [
                                    Text(
                                      "Over the past",
                                      style: TextStyle(
                                          fontSize: 13, color: Colors.grey),
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: Row(
                                  children: [
                                    Card(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                            20.0), // Adjust the value to change the radius
                                      ),
                                      clipBehavior: Clip.antiAlias,
                                      elevation: 0,
                                      child: Container(
                                          padding: EdgeInsets.only(
                                              left: 3, right: 3),
                                          alignment: Alignment.center,
                                          color: Color(0x33C84527),
                                          height: 18,
                                          child: Text(
                                            '1 month',
                                            style: TextStyle(
                                                fontSize: 10,
                                                color: Color(
                                                  0xFFB42C3B,
                                                )),
                                          )),
                                    ),
                                    Card(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                            20.0), // Adjust the value to change the radius
                                      ),
                                      clipBehavior: Clip.antiAlias,
                                      elevation: 0,
                                      child: Container(
                                          padding: EdgeInsets.only(
                                              left: 3, right: 3),
                                          alignment: Alignment.center,
                                          color: Color(0x33C84527),
                                          height: 18,
                                          child: Text(
                                            '3 months',
                                            style: TextStyle(
                                                fontSize: 10,
                                                color: Color(
                                                  0xFFB42C3B,
                                                )),
                                          )),
                                    ),
                                    Card(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                            20.0), // Adjust the value to change the radius
                                      ),
                                      clipBehavior: Clip.antiAlias,
                                      elevation: 0,
                                      child: Container(
                                        alignment: Alignment.center,
                                        padding:
                                            EdgeInsets.only(left: 3, right: 3),
                                        color: Color(0x33DCD6D6),
                                        height: 18,
                                        child: Text(
                                          '6 months',
                                          style: TextStyle(
                                              fontSize: 10, color: Colors.grey),
                                        ),
                                      ),
                                    ),
                                    Card(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                            20.0), // Adjust the value to change the radius
                                      ),
                                      clipBehavior: Clip.antiAlias,
                                      elevation: 0,
                                      child: Container(
                                        padding:
                                            EdgeInsets.only(left: 3, right: 3),
                                        alignment: Alignment.center,
                                        color: Color(0x33DCD6D6),
                                        height: 18,
                                        child: Text(
                                          '1 year',
                                          style: TextStyle(
                                              fontSize: 10, color: Colors.grey),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 16.0, right: 16),
                          child: Divider(
                            height: 1,
                            color: Colors.grey,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 16.0, right: 10, top: 16, bottom: 8),
                          child: Row(
                            children: [
                              Text(
                                "Your earning would have become ₹0",
                                style: TextStyle(
                                    color: Colors.black54, fontSize: 12),
                              ),
                              Text(
                                " (0%)",
                                style: TextStyle(
                                    color: Color(
                                      0xFFB42C3B,
                                    ),
                                    fontSize: 12),
                              )
                            ],
                          ),
                        ),
                        SizedBox(height: 20,)
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> getTargetAmount() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      targettedAmount=prefs.getString('monthlyTarget')!;
    });
  }
}

class CalendarPage extends StatefulWidget {
  @override
  _CalendarPageState createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TableCalendar(
        firstDay: DateTime.utc(2023, 1, 1),
        lastDay: DateTime.utc(2023, 12, 31),
        focusedDay: _focusedDay,
        calendarFormat: _calendarFormat,
        selectedDayPredicate: (day) {
          // Use `selectedDayPredicate` to mark the selected day.
          return isSameDay(_selectedDay, day);
        },
        onDaySelected: (selectedDay, focusedDay) {
          setState(() {
            _selectedDay = selectedDay;
            _focusedDay = focusedDay;
          });
        },
        onFormatChanged: (format) {
          setState(() {
            _calendarFormat = format;
          });
        },
        onPageChanged: (focusedDay) {
          _focusedDay = focusedDay;
        },
      ),
    );
  }
}

class MonthlyView extends StatelessWidget {
  AppColors appColors = new AppColors();

  @override
  Widget build(BuildContext context) {
    double progressValue1 = 0.1; // Set your progress value here
    double progressValue2 = 0.2; // Set your progress value here
    double progressValue3 = 0.0; // Set your progress value here
    double progressValue4 = 0.2;
    return Column(
      children: [
        Container(
          // height: 200,
          width: 300,

          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  Container(
                    width: 70,
                    height: MediaQuery.of(context).size.height / 4,
                    child: Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        FractionallySizedBox(
                          widthFactor: .2,
                          heightFactor: progressValue1,
                          child: Container(
                            color: appColors.mainAppColor,
                          ),
                        ),
                        Positioned(
                          bottom:
                              progressValue1 * 240, // Calculate the position
                          child: Container(
                            color: Color(0xFFF3F3F3),
                            //height: 40,
                            width: 50,
                            alignment: Alignment.center,
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    '0%',
                                    style: TextStyle(fontSize: 15),
                                  ),
                                  Text(
                                    'र0',
                                    style: TextStyle(fontSize: 10),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  Container(
                    width: 70,
                    height: MediaQuery.of(context).size.height / 4,
                    child: Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        FractionallySizedBox(
                          widthFactor: .2,
                          heightFactor: progressValue2,
                          child: Container(
                            color: appColors.mainAppColor,
                          ),
                        ),
                        Positioned(
                          bottom:
                              progressValue2 * 240, // Calculate the position
                          child: Container(
                            color: Color(0xFFF3F3F3),
                            height: 40,
                            width: 50,
                            alignment: Alignment.center,
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    '-0%',
                                    style: TextStyle(fontSize: 15),
                                  ),
                                  Text(
                                    'र0',
                                    style: TextStyle(fontSize: 10),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  Container(
                    width: 70,
                    height: MediaQuery.of(context).size.height / 4,
                    child: Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        FractionallySizedBox(
                          widthFactor: .2,
                          heightFactor: progressValue3,
                          child: Container(
                            color: appColors.mainAppColor,
                          ),
                        ),
                        Positioned(
                          bottom:
                              progressValue3 * 240, // Calculate the position
                          child: Container(
                            color: Color(0xFFF3F3F3),
                            height: 40,
                            width: 50,
                            alignment: Alignment.center,
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    '0%',
                                    style: TextStyle(fontSize: 15),
                                  ),
                                  Text(
                                    'र0',
                                    style: TextStyle(fontSize: 10),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  Container(
                    width: 70,
                    height: MediaQuery.of(context).size.height / 4,
                    child: Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        FractionallySizedBox(
                          widthFactor: .2,
                          heightFactor: progressValue4,
                          child: Container(
                            color: appColors.mainAppColor,
                          ),
                        ),
                        Positioned(
                          bottom:
                              progressValue4 * 240, // Calculate the position
                          child: Container(
                            color: Color(0xFFF3F3F3),
                            height: 40,
                            width: 50,
                            alignment: Alignment.center,
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    '0%',
                                    style: TextStyle(fontSize: 15),
                                  ),
                                  Text(
                                    'र0',
                                    style: TextStyle(fontSize: 10),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Container(
          height: 30,
          width: 300,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                  alignment: Alignment.center,
                  height: 30,
                  width: 70,
                  child: Text('JAN')),
              Container(
                  alignment: Alignment.center, width: 70, child: Text('FEB')),
              Container(
                  alignment: Alignment.center, width: 70, child: Text('MAR')),
              Container(
                  alignment: Alignment.center, width: 70, child: Text('APR')),
            ],
          ),
        ),
      ],
    );
  }
}

class WeeklyView extends StatelessWidget {
  AppColors appColors = new AppColors();

  @override
  Widget build(BuildContext context) {
    List<double> weeklyProgress = [0.2, 0.1, 0.0, 0.1, 0.3, 0.4, 0.23];
    return Column(
      children: [
        Container(
          height: MediaQuery.of(context).size.height / 4,
          width: 300,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  Container(
                    width: 40,
                    height: MediaQuery.of(context).size.height / 4,
                    child: Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        FractionallySizedBox(
                          widthFactor: .8,
                          heightFactor: weeklyProgress[0],
                          child: Container(
                            color: appColors.mainAppColor,
                          ),
                        ),
                        Positioned(
                          bottom:
                              weeklyProgress[0] * 200, // Calculate the position
                          child: Container(
                            height: 20,
                            width: 50,
                            alignment: Alignment.center,
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    'र0',
                                    style: TextStyle(
                                        fontSize: 13, color: Colors.grey),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  Container(
                    width: 40,
                    height: MediaQuery.of(context).size.height / 4,
                    child: Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        FractionallySizedBox(
                          widthFactor: .8,
                          heightFactor: weeklyProgress[1],
                          child: Container(
                            color: appColors.mainAppColor,
                          ),
                        ),
                        Positioned(
                          bottom:
                              weeklyProgress[1] * 200, // Calculate the position
                          child: Container(
                            height: 20,
                            width: 50,
                            alignment: Alignment.center,
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    'र0',
                                    style: TextStyle(
                                        fontSize: 13, color: Colors.grey),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  Container(
                    width: 40,
                    height: MediaQuery.of(context).size.height / 4,
                    child: Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        FractionallySizedBox(
                          widthFactor: .8,
                          heightFactor: weeklyProgress[2],
                          child: Container(
                            color: appColors.mainAppColor,
                          ),
                        ),
                        Positioned(
                          bottom:
                              weeklyProgress[2] * 200, // Calculate the position
                          child: Container(
                            height: 20,
                            width: 50,
                            alignment: Alignment.center,
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    'र0',
                                    style: TextStyle(
                                        fontSize: 13, color: Colors.grey),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  Container(
                    width: 40,
                    height: MediaQuery.of(context).size.height / 4,
                    child: Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        FractionallySizedBox(
                          widthFactor: .8,
                          heightFactor: weeklyProgress[3],
                          child: Container(
                            color: appColors.mainAppColor,
                          ),
                        ),
                        Positioned(
                          bottom:
                              weeklyProgress[3] * 200, // Calculate the position
                          child: Container(
                            height: 20,
                            width: 50,
                            alignment: Alignment.center,
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    'र0',
                                    style: TextStyle(
                                        fontSize: 13, color: Colors.grey),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  Container(
                    width: 40,
                    height: MediaQuery.of(context).size.height / 4,
                    child: Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        FractionallySizedBox(
                          widthFactor: .8,
                          heightFactor: weeklyProgress[4],
                          child: Container(
                            color: appColors.mainAppColor,
                          ),
                        ),
                        Positioned(
                          bottom:
                              weeklyProgress[4] * 200, // Calculate the position
                          child: Container(
                            height: 20,
                            width: 50,
                            alignment: Alignment.center,
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    'र 0',
                                    style: TextStyle(
                                        fontSize: 13, color: Colors.grey),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  Container(
                    width: 40,
                    height: MediaQuery.of(context).size.height / 4,
                    child: Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        FractionallySizedBox(
                          widthFactor: .8,
                          heightFactor: weeklyProgress[5],
                          child: Container(
                            color: appColors.mainAppColor,
                          ),
                        ),
                        Positioned(
                          bottom:
                              weeklyProgress[5] * 200, // Calculate the position
                          child: Container(
                            height: 20,
                            width: 50,
                            alignment: Alignment.center,
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    'र0',
                                    style: TextStyle(
                                        fontSize: 13, color: Colors.grey),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  Container(
                    width: 40,
                    height: MediaQuery.of(context).size.height / 4,
                    child: Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        FractionallySizedBox(
                          widthFactor: .8,
                          heightFactor: weeklyProgress[6],
                          child: Container(
                            color: appColors.mainAppColor,
                          ),
                        ),
                        Positioned(
                          bottom:
                              weeklyProgress[6] * 200, // Calculate the position
                          child: Container(
                            height: 20,
                            width: 50,
                            alignment: Alignment.center,
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    'र0',
                                    style: TextStyle(
                                        fontSize: 13, color: Colors.grey),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Container(
          height: 20,
          width: 300,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  Container(
                    width: 40,
                    height: 20,
                    child: Center(
                        child: Text(
                      "1",
                      style: TextStyle(color: Colors.grey),
                    )),
                  ),
                ],
              ),
              Column(
                children: [
                  Container(
                    width: 40,
                    height: 20,
                    child: Center(
                        child: Text(
                      "2",
                      style: TextStyle(color: Colors.grey),
                    )),
                  ),
                ],
              ),
              Column(
                children: [
                  Container(
                    width: 40,
                    height: 20,
                    child: Center(
                        child: Text(
                      "3",
                      style: TextStyle(color: Colors.grey),
                    )),
                  ),
                ],
              ),
              Column(
                children: [
                  Container(
                    width: 40,
                    height: 20,
                    child: Center(
                        child: Text(
                      "4",
                      style: TextStyle(color: Colors.grey),
                    )),
                  ),
                ],
              ),
              Column(
                children: [
                  Container(
                    width: 40,
                    height: 20,
                    child: Center(
                        child: Text(
                      "5",
                      style: TextStyle(color: Colors.grey),
                    )),
                  ),
                ],
              ),
              Column(
                children: [
                  Container(
                    width: 40,
                    height: 20,
                    child: Center(
                        child: Text(
                      "6",
                      style: TextStyle(color: Colors.grey),
                    )),
                  ),
                ],
              ),
              Column(
                children: [
                  Container(
                    width: 40,
                    height: 20,
                    child: Center(
                        child: Text(
                      "7",
                      style: TextStyle(color: Colors.grey),
                    )),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class LeaderBoard extends StatefulWidget {
  const LeaderBoard({super.key});

  @override
  State<LeaderBoard> createState() => _LeaderBoardState();
}

class _LeaderBoardState extends State<LeaderBoard>
    with TickerProviderStateMixin {
  AppColors appColors = new AppColors();
  int _current = 0;
  late GifController _controllerGif;

  final CarouselController _controller = CarouselController();
  final List<Map<String, dynamic>> earningsData = [
    {'name': 'Aarav Kumar', 'earnings': 80000},
    {'name': 'Aditya Sharma', 'earnings': 75000},
    {'name': 'Arjun Singh', 'earnings': 70000},
    {'name': 'Anirudh Mishra', 'earnings': 65000},
    {'name': 'Aakash Patel', 'earnings': 60000},
    {'name': 'Ayush Gupta', 'earnings': 55000},
    {'name': 'Abhinav Yadav', 'earnings': 50000},
    {'name': 'Amit Verma', 'earnings': 45000},
    {'name': 'Aryan Shah', 'earnings': 40000},
    {'name': 'Adarsh Dubey', 'earnings': 35000},
    {'name': 'Aniket Malhotra', 'earnings': 30000},
    {'name': 'Anshul Chauhan', 'earnings': 25000},
    {'name': 'Aayush Srivastava', 'earnings': 20000},
    {'name': 'Arnav Tiwari', 'earnings': 15000},
    {'name': 'Amitabh Rajput', 'earnings': 10000},
    // Add more data as needed
  ];
  @override
  void initState() {
    super.initState();
    _controllerGif = GifController(vsync: this);
  }

  @override
  void dispose() {
    _controllerGif.dispose();
    super.dispose();
  }

  final List<String> imgList = [
    "assets/images/leaderboardbanner.gif",
    "assets/images/leaderboardbanner.gif",
    "assets/images/leaderboardbanner.gif"
  ];
  Widget buildDot({required int index}) {
    return Container(
      width: 7,
      height: 7,
      margin: EdgeInsets.symmetric(horizontal: 2),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: _current == index ? Colors.white : Colors.grey,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appColors.mainAppColor,
      body: Stack(
        children: [
          Container(
            child: Gif(
              fit: BoxFit.fitWidth,
              image: AssetImage("assets/images/render.gif"),
              controller:
                  _controllerGif, // if duration and fps is null, original gif fps will be used.
              //fps: 30,
              //duration: const Duration(seconds: 3),
              autostart: Autostart.no,
              onFetchCompleted: () {
                _controllerGif.reset();
                _controllerGif.forward();
              },
            ),
          ),
          Column(
            children: [
              Container(
                decoration: BoxDecoration(),
                child: Column(
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 20,
                    ),
                    Text(
                      "ALL INDIA",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontFamily: 'Visbycfbold',
                          fontSize: 16),
                    ),
                    Text(
                      "LEADER BOARD",
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Visbycfbold',
                          fontSize: 14),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height / 50),
                    CarouselSlider.builder(
                      itemCount:
                          3, // Replace '3' with the total number of items
                      itemBuilder:
                          (BuildContext context, int index, int realIndex) {
                        return Card(
                            elevation: 4,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            child: SizedBox(
                              // Adjust the width as needed// Adjust the height as needed
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(15.0),
                                child: Image.asset(
                                  imgList
                                      .elementAt(0)
                                      .toString(), // Replace with your image URL
                                  fit: BoxFit
                                      .cover, // Adjust the fit as needed (contain, cover, fill, etc.)
                                ),
                              ),
                            ));
                      },
                      options: CarouselOptions(
                        height: MediaQuery.of(context).size.height /
                            7, // Adjust the height as needed
                        viewportFraction:
                            1.0, // Set to 1.0 to display only one item at a time
                        enableInfiniteScroll:
                            true, // Enable infinite scroll if needed
                        reverse:
                            false, // Set true/false for reversing the items
                        autoPlay: false, // Set true/false for autoplay
                        autoPlayInterval:
                            Duration(seconds: 3), // Autoplay interval if needed
                        autoPlayAnimationDuration: Duration(
                            milliseconds: 800), // Autoplay animation duration
                        pauseAutoPlayOnTouch: true,
                        // Pause autoplay on touch

                        onPageChanged: (index, reason) {
                          /*  setState(() {
                            print("page index $index");
                            _current = index;
                          });*/
                        },
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height / 48),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        3, // Replace '3' with the total number of items
                        (index) => buildDot(index: index),
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height / 35),
                  ],
                ),
              ),
              Stack(
                alignment: Alignment.topCenter,
                children: [
                  Container(
                      alignment: Alignment.center,
                      height: MediaQuery.of(context).size.height / 1.7,
                      child: null),
                  Positioned(
                    top: 30,
                    child: Container(
                      color: appColors.mainAppColor,
                      alignment: Alignment.bottomCenter,
                      width: MediaQuery.of(context).size.width / 1.1,
                      height: MediaQuery.of(context).size.height / 1.9,
                      child: Container(
                        margin: EdgeInsets.all(3),
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(
                                'assets/images/list_bg.png'), // Replace with the actual image path
                            fit: BoxFit.fill,
                          ),
                        ),
                        padding: EdgeInsets.only(
                            top: 35, left: 10, right: 10, bottom: 10),
                        //  margin: EdgeInsets.only(top: 30,left: 10,right: 10),
                        child: MediaQuery.removePadding(
                          context: context,
                          removeTop: true,
                          child: ListView.builder(
                            itemCount: 10,
                            itemBuilder: (context, index) {
                              final item = earningsData[index];
                              final bool isFirstItem = index == 0;

                              return Container(
                                padding: EdgeInsets.symmetric(
                                    vertical: 5.0, horizontal: 25.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Card(
                                          clipBehavior: Clip.antiAlias,
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: appColors.mainAppColor,
                                              gradient: isFirstItem
                                                  ? LinearGradient(
                                                      colors: [
                                                        Colors.yellow,
                                                        Colors.orangeAccent,
                                                        Colors.yellow,
                                                        Colors.orange,
                                                        Colors.orange
                                                      ], // Define your gradient colors
                                                      begin: Alignment.topLeft,
                                                      end: Alignment
                                                          .bottomCenter,
                                                    )
                                                  : null, // No gradient for other items
                                            ),
                                            height: 20,
                                            width: 20,
                                            child: Center(
                                              child: Text(
                                                '${index + 1}',
                                                style: TextStyle(
                                                  fontSize: 15,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 20,
                                        ),
                                        Text(
                                          '${item['name']}',
                                          style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.white,
                                            fontWeight: isFirstItem
                                                ? FontWeight.bold
                                                : FontWeight.normal,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Text(
                                      '${item['earnings']}',
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.white,
                                        fontWeight: isFirstItem
                                            ? FontWeight.bold
                                            : FontWeight.normal,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white38,
                        borderRadius: BorderRadius.circular(50.0),
                      ),
                      alignment: Alignment.center,
                      width: 80,
                      height: 80,
                      child: Image.asset('assets/images/trophy_ic.png'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}


class HomePageview extends StatefulWidget {
 final LoginResponse loginResponse;
 final String username;

  HomePageview( this.loginResponse, this.username);





  @override
  State<HomePageview> createState() => _HomePageviewState();
}

class _HomePageviewState extends State<HomePageview> {
  late ScrollController _scrollController;
  late double _opacity = 1.0;

  int targettedAmount=0;

  final currencyFormatter = NumberFormat('#,##0', 'en_US');
    String bannerUrl="";
    double expandedHeight=0;
  @override
  void initState() {
    super.initState();
    getTargetAmount();
    getBannerUrl();
    _scrollController = ScrollController()..addListener(_updateOpacity);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  getBannerUrl(){
    final api = Provider.of<ApiService>(context, listen: false);
    return api.getBannerImageUrl("D").then((value) {
      if(value.data.banner.isNotEmpty){
        setState(() {
          bannerUrl=value.data.banner;
          if(bannerUrl.length>2){
            expandedHeight=220;
          }else{
            expandedHeight=0;
          }

        });
      }
    });

  }
  void _updateOpacity() {
    setState(() {
      // You can adjust these values based on your needs
      if (_scrollController.position.userScrollDirection == ScrollDirection.forward) {
        _opacity = 1.0;
      } else {
        _opacity = 0.0;
      }
    });
  }
  AppColors appColors = new AppColors();

  @override
  Widget build(BuildContext context) {

    return  CustomScrollView(
      controller: _scrollController,
      slivers: [
        SliverAppBar(
          backgroundColor: appColors.mainAppColor,
          leading: null,
          automaticallyImplyLeading: false,
          expandedHeight: expandedHeight,
          floating: false,
          flexibleSpace: FlexibleSpaceBar(
            background:
                bannerUrl.length>0?
            Image.network(
              'https://erp.paisalo.in:981/LOSDOC/BannerPost/${bannerUrl}',
              fit: BoxFit.fill,

            ):Container(height: 0,),
            collapseMode: CollapseMode.none,
          ),
        ),
        // Add other slivers or widgets as needed
        SliverList(

          delegate: SliverChildBuilderDelegate(
            addRepaintBoundaries: true,
                addAutomaticKeepAlives: true,
                (BuildContext context, int index) {
              return  Container(
                  padding: EdgeInsets.only(bottom: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [

                      SizedBox(height: MediaQuery.of(context).size.height / 40),
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                        child: Container(
                          // width: 350, // Adjust the width as needed
                          height: MediaQuery.of(context).size.height / 1.95,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(
                                  'assets/images/card_bg.png'), // Replace with your SVG file path
                              fit: BoxFit.fill,
                            ),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(height: MediaQuery.of(context).size.height / 25),
                              // Replace 'assets/your_image.svg' with your SVG file path
                              Image(
                                image: AssetImage('assets/images/paisa_logo.png'),
                                height: MediaQuery.of(context).size.height / 35,
                                width: 140,
                              ),
                              Image(
                                image: AssetImage('assets/images/money_ic.png'),
                                height: 30,
                                width: 50,
                              ),
                              Text(
                                "Monthly\ncommission target",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 22,
                                    color: Colors.black54,
                                    fontFamily: 'Visbyfregular'),
                              ),
                              Container(
                                alignment: Alignment.center,
                                // width: 100,
                                child: Text(
                                    '₹${currencyFormatter.format(targettedAmount)}'
                                 ,
                                  style: TextStyle(
                                      fontSize: 26,
                                      color: Colors.black,
                                      ),
                                ),
                              ),
                              Column(
                                children: [
                                  Container(
                                    width: 240,
                                    child: LinearProgressIndicator(
                                      value: 0.3,
                                      backgroundColor: Colors.grey[300],
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                          appColors.mainAppColor),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                    alignment: Alignment.center,
                                    width: 240,
                                    child: Text(
                                      '30% COMPLETED',
                                      style: TextStyle(fontSize: 12, color: Colors.black),
                                    ),
                                  ),
                                ],
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => TargetSetPage(loginResponse: widget.loginResponse, username:widget.username,)),
                                  );
                                },
                                child: Container(
                                  alignment: Alignment.center,
                                  width: 120,
                                  height: 30,
                                  decoration:
                                  BoxDecoration(color: appColors.mainAppColor),
                                  child: Text(
                                    'RESET TARGET',
                                    style: TextStyle(fontSize: 15, color: Colors.white),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 50,
                              )
                              // Optional space between image and other content
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => TaskList()),
                          );
                        },
                        child: Text(
                          'TAP TO KNOW YOUR PROGRESS ⟫⟫⟫',
                          style: TextStyle(color: Colors.white, fontSize: 17),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                        child: Row(
                          //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Card(
                                  elevation: 6,
                                  clipBehavior: Clip.antiAlias,
                                  child: Container(
                                    height: MediaQuery.of(context).size.height / 4.8,
                                    color: Colors.white,
                                    child: Padding(
                                      padding: const EdgeInsets.all(15.0),
                                      child: Center(
                                          child: Text(
                                            '10 people\nwill earn\nmore\ncommission',
                                            style: TextStyle(
                                              fontSize: 17,
                                            ),
                                          )),
                                    ),
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20.0),
                                  ),
                                ),
                                flex: 1,
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              // SizedBox(width: 10), // Adjust the space between cards
                              Expanded(
                                child: GestureDetector(
                                  onTap: () {
                                    Timer(
                                      Duration(seconds: 5),
                                          () => Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => AchiverPage(),
                                        ),
                                      ),
                                    );
                                    /* setState(() {
                  isDialogOpen = !isDialogOpen;
                });*/
                                    showDialog(
                                      context: context,
                                      barrierDismissible:
                                      false, // Dialog cannot be dismissed by tapping outside
                                      //barrierColor: Colors.white70.withOpacity(0.9),
                                      builder: (BuildContext context) {
                                        return Dialog(
                                          backgroundColor: Colors.white.withOpacity(0.94),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(20.0),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(20.0),
                                            child: Container(
                                              child: Flexible(
                                                child: Column(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                                  mainAxisSize: MainAxisSize.min,
                                                  children: [
                                                    Container(
                                                      width: 60, // Adjust width as needed
                                                      height:
                                                      60, // Adjust height as needed
                                                      child: CircularProgressIndicator(
                                                        strokeWidth: 5,
                                                        valueColor:
                                                        AlwaysStoppedAnimation<Color>(
                                                            appColors.mainAppColor),
                                                      ),
                                                    ), // Circular Progress Indicator
                                                    SizedBox(height: 40),
                                                    Text(
                                                      'More Tasks\nMore Commission',
                                                      style: TextStyle(
                                                        fontSize: 24,
                                                      ),
                                                      textAlign: TextAlign.center,
                                                    ), // Text indicating the process
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    );
                                  },
                                  child: Card(
                                      color: Colors.white,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20.0),
                                      ),
                                      elevation: 10,
                                      shadowColor: Colors.black,
                                      clipBehavior: Clip.antiAlias,
                                      child: Container(
                                        height: MediaQuery.of(context).size.height / 4.8,
                                        color: appColors.mainAppColor,
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              top: 10, bottom: 10, left: 15, right: 15),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                "Earn maximum\ncommission",
                                                style: TextStyle(
                                                    fontSize: 17, color: Colors.white),
                                              ),
                                              SizedBox(
                                                height:
                                                MediaQuery.of(context).size.height /
                                                    120,
                                              ),
                                              Text(
                                                "AB RUKNA NAHI.",
                                                style: TextStyle(
                                                    fontSize: 17,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white),
                                              ),
                                              SizedBox(
                                                height:
                                                MediaQuery.of(context).size.height /
                                                    120,
                                              ),
                                              Icon(
                                                CupertinoIcons.arrow_right,
                                                color: Colors.white,
                                              )
                                            ],
                                          ),
                                        ),
                                      )),
                                ),
                                flex: 1,
                              ),
                            ]),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => (RequestForFundTransfer(loginResponse: widget.loginResponse,userName:widget.username)),
                            ),
                          );
                        },
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "REQUEST FOR FUND TRANSFER ⟫⟫⟫",
                              style: TextStyle(color: appColors.mainAppColor),
                            ),
                          ),
                        ),
                      )
                    ],
                  ));
            },
            childCount: 1,
          ),
        ),
      ],
    );


  }

  Future<void> getTargetAmount() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      targettedAmount=int.parse(prefs.getString('monthlyTarget')!);
    });
  }


}


class TutorialOverlay extends ModalRoute<void> {
  @override
  Duration get transitionDuration => Duration(milliseconds: 500);

  @override
  bool get opaque => false;

  @override
  bool get barrierDismissible => false;

  @override
  Color get barrierColor => Colors.black.withOpacity(0.5);

  @override
  String? get barrierLabel => null;

  @override
  bool get maintainState => true;

  @override
  Widget buildPage(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
  ) {
    // This makes sure that text and other content follows the material style
    return Material(
      type: MaterialType.transparency,
      // make sure that the overlay content is not cut off
      child: SafeArea(
        child: _buildOverlayContent(context),
      ),
    );
  }

  Widget _buildOverlayContent(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            'This is a nice overlay',
            style: TextStyle(color: Colors.white, fontSize: 30.0),
          ),
          MaterialButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Dismiss',
                style: TextStyle(color: Colors.white, fontSize: 30.0)),
          )
        ],
      ),
    );
  }

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    // You can add your own animations for the overlay content
    return FadeTransition(
      opacity: animation,
      child: ScaleTransition(
        scale: animation,
        child: child,
      ),
    );
  }
}
