import 'dart:async';
import 'dart:ui';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:new_bc_app/model/CspMonthlyLazerResponse.dart';
import 'package:new_bc_app/model/CspWeeklyLazerResponse.dart';
import 'package:new_bc_app/model/leaderBoardDataResponse.dart';
import 'package:new_bc_app/model/loginresponse.dart';
import 'package:new_bc_app/utils/currentLocation.dart';
import 'package:new_bc_app/views/KYCUpdatePage.dart';
import 'package:new_bc_app/views/LeaderBoardItemDetails.dart';
import 'package:new_bc_app/views/achiverpage.dart';
import 'package:new_bc_app/views/csp_annual_report.dart';
import 'package:new_bc_app/views/requestforfundtransfer.dart';
import 'package:new_bc_app/views/tasklist.dart';
import 'package:new_bc_app/views/login.dart';
import 'package:new_bc_app/views/transactionDetailsPageByCode.dart';
import 'package:new_bc_app/views/withdrawalanddeposithistory.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:video_player/video_player.dart';
import '../model/commissionDetailsResponse.dart';
import '../model/getTaskSlabDetailsResponse.dart';
import '../network/api_service.dart';
import '../const/AppColors.dart';
import 'package:gif/gif.dart';

import 'earningpage.dart';
import 'homevisitmappage.dart';
import 'monthwiseLedgerReport.dart';
import 'serviceandschemelist.dart';
import 'targetsetpage.dart';
import 'transactionhistorypage.dart';

class HomePage extends StatefulWidget {
  final LoginResponse loginResponse;
  final String username;
  const HomePage(
      {super.key, required this.loginResponse, required this.username});

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

  late List<dynamic> _pages;
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
      HomePageview(widget.loginResponse, widget.username),
      LeaderBoard(widget.loginResponse, widget.username),
      ServiceAndSchemeList(widget.loginResponse, widget.username),
      EarningPage(widget.username),
      ProfilePage(
          loginResponse: widget.loginResponse, username: widget.username),
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
          Padding(
            padding: EdgeInsets.all(8),
            child: ImageIcon(
              AssetImage(
                  'assets/images/home_ic.png'), // Replace 'assets/image.png' with your image path
              size: 20, // Adjust the size as needed
              color: _page == 0 ? appColors.mainAppColor : Colors.grey,
              // Adjust the color as needed
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8),
            child: ImageIcon(
              AssetImage(
                  'assets/images/leader_ic.png'), // Replace 'assets/image.png' with your image path
              size: 20, // Adjust the size as needed
              color: _page == 1 ? appColors.mainAppColor : Colors.grey,
              // Adjust the color as needed
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8),
            child: ImageIcon(
              AssetImage(
                  'assets/images/service_ic.png'), // Replace 'assets/image.png' with your image path
              size: 20, // Adjust the size as needed
              color: _page == 2 ? appColors.mainAppColor : Colors.grey,
              // Adjust the color as needed
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8),
            child: ImageIcon(
              AssetImage(
                  'assets/images/earn_ic.png'), // Replace 'assets/image.png' with your image path
              size: 20, // Adjust the size as needed
              color: _page == 3 ? appColors.mainAppColor : Colors.grey,
              // Adjust the color as needed
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8),
            child: ImageIcon(
              AssetImage(
                  'assets/images/prof_ic.png'), // Replace 'assets/image.png' with your image path
              size: 20, // Adjust the size as needed
              color: _page == 4 ? appColors.mainAppColor : Colors.grey,
              // Adjust the color as needed
            ),
          ),
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
  currentLocation _locationService = currentLocation();
  String _currentAddress = '';
  double _latitude = 0.0;
  double _longitude = 0.0;
  int isLoading = 0;
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
  Future<void> _getCurrentLocation() async {
    try {
      Map<String, dynamic> locationData =
          await _locationService.getCurrentLocation();
      setState(() {
        _latitude = locationData['latitude'];
        _longitude = locationData['longitude'];
        _currentAddress = locationData['address'];
      });
    } catch (e) {
      print("Error getting current location: $e");
    }
  }

  @override
  void initState() {
    _getCurrentLocation();
    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _mobileController.dispose();
    _addressController.dispose();
    super.dispose();
  }
  void _showLogoutAlert(BuildContext context) {
    QuickAlert.show(
      context: context,
      type: QuickAlertType.confirm,
      title: 'Logout',
      text: 'Are you sure you want to logout?',
        backgroundColor: Colors.white,
        headerBackgroundColor: appColors.mainAppColor,
        titleColor: Colors.red,
        textColor: Colors.red,
      confirmBtnColor: appColors.mainAppColor,

      confirmBtnText: 'Yes',
      cancelBtnText: 'No',
      onConfirmBtnTap: () async {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('username',"");
        prefs.setString('password', "");
        Navigator.of(context).pop(); // Close the dialog
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) =>
              Login()),
        );
      },
      onCancelBtnTap: () {
        Navigator.of(context).pop(); // Close the dialog
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appColors.mainAppColor,
      appBar: AppBar(

        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.logout,color: Colors.white,),
            onPressed: () {
              _showLogoutAlert(context);

            },
          ),
        ],

        backgroundColor: appColors.mainAppColor,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.only(left:16.0,right: 16.0,top: 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              GestureDetector(
                //onTap: getImage,
                child: CircleAvatar(
                  radius: 40,
                  backgroundColor: Colors.grey[300],
                  backgroundImage: _image != null ? FileImage(_image!) : null,
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
              Row(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width / 1.5,
                    child: Card(
                      shape: Border.all(
                          width: 0,
                          color: Colors
                              .black), // Optional border for visual clarity
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
                                    fontSize: 16,
                                    fontFamily: 'Visbyfregular'),
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
                  ),
                  isLoading == 1
                      ? Center(
                    child: CircularProgressIndicator(
                      color: Colors.white,
                    ),
                  )
                      : GestureDetector(
                    child: Card(
                      shape: Border.all(width: 0, color: Colors.black),
                      child: Container(
                        alignment: Alignment.center,
                        height: 45,
                        width: MediaQuery.of(context).size.width -
                            (MediaQuery.of(context).size.width / 1.5 +
                                40),
                        color: Colors.white,
                        child: Text("GEO TAG",
                            style: TextStyle(
                                fontSize: 16,
                                fontFamily: 'Visbyfregular')),
                      ),
                    ),
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return CustomInputDialog(
                            onSubmit: (String pin) {
                              String pinCode = pin;
                              double latitude =
                                  _latitude; // Set latitude
                              double longitude =
                                  _longitude; // Set longitude
                              String address =
                                  _currentAddress; // Set address
                              _saveDataToApi(pinCode, latitude,
                                  longitude, address);
                            },
                          );
                        },
                      );
                    },
                  )
                ],
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
                                fontSize: 16, fontFamily: 'Visbyfregular'),
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
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => (KYCUpdatePage(widget.loginResponse,widget.username,))));
                },
                child: Card(
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
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => (TransactionHistoryPage(
                          loginResponse: widget.loginResponse,
                          username: widget.username)),
                    ),
                  );
                },
                child: Card(
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
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => (WithdrawalAndDepositHistory(
                          loginResponse: widget.loginResponse,
                          username: widget.username)),
                    ),
                  );
                },
                child: Card(
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
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => (MonthWiseledgerReport()),
                    ),
                  );
                },
                child: Card(
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
    );
  }

  Future<void> _saveDataToApi(
      String pinCode, double latitude, double longitude, String address) async {
    setState(() {
      isLoading = 1;
    });

    try {
      String apiUrl =
          'https://erpservice.paisalo.in:980/PDL.Mobile.Api/api/LiveTrack/SaveCSPCenters';
      final response = await http.post(
        Uri.parse(
            '$apiUrl?Pincode=$pinCode&Latitude=$latitude&Longitude=$longitude&Address=$address&IsActive=true'),
      );
      if (response.statusCode == 200) {
        QuickAlert.show(
            context: context,
            type: QuickAlertType.success,
            title: 'Geo Tagging Response',
            text: 'Data saved successfully',
            backgroundColor: Colors.white,
            titleColor: appColors.green,
            textColor: appColors.lightgreen,
            confirmBtnColor: appColors.green);
        print('Data saved successfully');
      } else {
        // Failure
        QuickAlert.show(
            context: context,
            type: QuickAlertType.error,
            title: 'Oops...',
            text: 'Failed to save data: ${response.body}',
            backgroundColor: Colors.white,
            titleColor: appColors.mainAppColor,
            textColor: appColors.mainAppColor,
            confirmBtnColor: appColors.mainAppColor);
        print('Failed to save data: ${response.body}');
        // Show error message
      }
    } catch (e) {
      QuickAlert.show(
          context: context,
          type: QuickAlertType.error,
          title: 'Oops...',
          text: 'Something went wrong: Exception: $e',
          backgroundColor: Colors.white,
          titleColor: appColors.mainAppColor,
          textColor: appColors.mainAppColor,
          confirmBtnColor: appColors.mainAppColor);
      print('Exception: $e');
      // Show error message
    } finally {
      setState(() {
        isLoading = 0;
      });
    }
  }
}

class CustomInputDialog extends StatefulWidget {
  final Function(String) onSubmit;

  const CustomInputDialog({Key? key, required this.onSubmit}) : super(key: key);

  @override
  _CustomInputDialogState createState() => _CustomInputDialogState();
}

class _CustomInputDialogState extends State<CustomInputDialog> {
  late TextEditingController _textController;

  @override
  void initState() {
    super.initState();
    _textController = TextEditingController();
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  String _pinCodeError = "";

  @override
  Widget build(BuildContext context) {
    return Dialog(
      key: _scaffoldKey,
      backgroundColor:
          Colors.transparent, // Set dialog background color to transparent
      child: Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width / 1.3,
            height: 300,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                    'assets/images/card_bg.png'), // Set your image path here
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            height: 280,
            width: MediaQuery.of(context).size.width / 1.3,
            padding: EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Enter Pin Code',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 50,
                ),
                TextField(
                  maxLength: 6,
                  controller: _textController,
                  style: TextStyle(
                      fontSize: 17,
                      letterSpacing: 28,
                      fontWeight: FontWeight.bold),
                  cursorColor: Colors.white,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    errorText: _pinCodeError,
                    filled: true,
                    fillColor:
                        Colors.white, // Set text field background color to red
                    hintText: 'Enter Pin Code here',
                    hintStyle: TextStyle(letterSpacing: 1),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors.grey), // Set border color to grey
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors
                              .grey), // Set border color to grey when focused
                    ),
                  ),
                ),
                SizedBox(height: 16),
                Container(
                  width: MediaQuery.of(context).size.width,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_textController.text.length != 6) {
                        setState(() {
                          _pinCodeError = "Please enter correct pincode";
                        });
                      } else {
                        String pinCode = _textController.text;
                        widget.onSubmit(pinCode);
                        Navigator.of(context).pop();
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red, // Set background color of button to red
                    ),
                    child: Text(
                      'Submit',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class EarningPage extends StatefulWidget {
  final String userName;
  const EarningPage(this.userName);

  @override
  State<EarningPage> createState() => _EarningPageState();
}

class _EarningPageState extends State<EarningPage> {
  String targettedAmount = "";
  int isLoading = 0;
  late CommisionDetailsResponse commisionDetailsResponse;
  late CspWeeklyLazerResponse cspWeeklyLazerResponse;
  late CspMonthlyLazerResponse cspMonthlyLazerResponse;
  late String bestMonth;
  late int bestMonthEarning;
  late List<dynamic> _ViewList ;
  bool month1=true;
  bool month3=false;
  bool month6=false;
  bool month12=false;



  Color enabledFutureColor= Color(0x33C84527);
  Color enabledFutureTextColor= Color(0xFFB42C3B);
  Color disabledFutureColor= Color(0x33DCD6D6);
  Color disabledFutureTextColor= Color(0xFF727272);

  var futurEarnings=0;

  int currentDate=DateTime.now().day;

  @override
  void initState() {
    getCommisionDetail();
    getCSPWeeklyLedger();
    getCSPMonthlyLedger();

    super.initState();
    getTargetAmount();
  }

  int totalEarning=0;
  String getFirstDateOfMonth() {
    final now = DateTime.now();
    final firstDayOfMonth = DateTime(now.year, now.month, 1);
    return '${firstDayOfMonth.year}-${firstDayOfMonth.month.toString().padLeft(2, '0')}-${firstDayOfMonth.day.toString().padLeft(2, '0')}';
  }

  String getCurrentDate() {
    final now = DateTime.now();
    return '${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}';
  }

  Future<Null> getCommisionDetail() {
    String fromDate = getFirstDateOfMonth();
    String toDate = getCurrentDate();

    final api = Provider.of<ApiService>(context, listen: false);
    return api
        .getCommsionDetails(fromDate, toDate, widget.userName, "1", "true")
        .then((value) {
      if (value.statusCode == 200) {
        setState(() {
          commisionDetailsResponse = value;
          isLoading = 1;
        });
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

  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  AppColors appColors = new AppColors();
  // Set your progress value here
  int profitIncrease=1;
  final currencyFormatter = NumberFormat('#,##0', 'en_US');
  int _viewType = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appColors.mainAppColor,
      body: isLoading == 0
          ? Center(
              child: CircularProgressIndicator(
                color: Colors.white,
              ),
            )
          : SingleChildScrollView(
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
                        padding: const EdgeInsets.only(left: 10,right: 10,top: 10),
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
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              LeaderBoardItemDetails(
                                                  widget.userName),
                                        ));
                                  },
                                  child: Text(

                                    '₹ ${currencyFormatter.format(commisionDetailsResponse.data.myIncomeResult)}',
                                    style: TextStyle(
                                        fontSize: 40,
                                        fontFamily: 'Visbybold',
                                        color: Colors.white),
                                  ),
                                ),
                                SizedBox(
                                  width: 8,
                                ),
                                Container(
                                  padding: EdgeInsets.only(left: 4,right: 4),
                                  alignment: Alignment.center,
                                  height: 30,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  child:  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                  profitIncrease==1?Icon(
                                    CupertinoIcons.up_arrow,
                                    size: 15,
                                  ):Icon(
                                        CupertinoIcons.down_arrow,
                                        size: 15,
                                      ),
                                      Text(
                                        "${getProfitPercantage()}%",
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
                              "Best month Earnings ₹${bestMonthEarning} (${bestMonth})",
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.white,
                                fontFamily: 'Visbyfregular',
                              ),
                            ),
                            Text("Note:- This is tentative data.",style: TextStyle(color: appColors.white,fontSize: 12,),textAlign: TextAlign.left,),


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
                        color: Colors
                            .grey[300], // Background color of the progress bar
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(5),
                        child: LinearProgressIndicator(
                          value: (((commisionDetailsResponse.data.myIncomeResult.toInt()*100)/(int.parse(targettedAmount)))/100), // Set the progress value (0.0 to 1.0)
                          backgroundColor: Colors
                              .transparent, // Set the background color of the indicator
                          valueColor: AlwaysStoppedAnimation<Color>(Color(
                              0xFFEE5565)), // Color of the progress indicator
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
                          Text('₹${commisionDetailsResponse.data.myIncomeResult.toInt()}',
                              style: TextStyle(
                                  fontFamily: 'Visbyfregular',
                                  color: Colors.white,
                                  fontSize: 11)),
                          Text('₹${targettedAmount}',
                              style: TextStyle(
                                  fontFamily: 'Visbyfregular',
                                  color: Colors.white,
                                  fontSize: 11))
                        ],
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 10, right: 10, top: 8),
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
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
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  'WEEKLY',
                                                  style:
                                                      TextStyle(fontSize: 12),
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
                                                    style: TextStyle(
                                                        fontSize: 12)),
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
                                    // GestureDetector(
                                    //   onTap: () {
                                    //     showDialog(
                                    //       context: context,
                                    //       builder: (BuildContext context) {
                                    //         return Dialog(
                                    //           clipBehavior: Clip.antiAlias,
                                    //           backgroundColor: Colors
                                    //               .white, // Red color with transparency
                                    //           shape: RoundedRectangleBorder(
                                    //             borderRadius:
                                    //                 BorderRadius.circular(10.0),
                                    //           ),
                                    //           child: Container(
                                    //               height: 400,
                                    //               color: Colors.white,
                                    //               // height: 400,
                                    //               child: TableCalendar(
                                    //                 firstDay: DateTime.utc(
                                    //                     2023, 1, 1),
                                    //                 lastDay: DateTime.utc(
                                    //                     2030, 12, 31),
                                    //                 focusedDay: _focusedDay,
                                    //                 calendarFormat:
                                    //                     _calendarFormat,
                                    //                 selectedDayPredicate:
                                    //                     (day) {
                                    //                   // Use `selectedDayPredicate` to mark the selected day.
                                    //                   return isSameDay(
                                    //                       _selectedDay, day);
                                    //                 },
                                    //                 onDaySelected: (selectedDay,
                                    //                     focusedDay) {
                                    //                   setState(() {
                                    //                     _selectedDay =
                                    //                         selectedDay;
                                    //                     _focusedDay =
                                    //                         focusedDay;
                                    //                   });
                                    //                 },
                                    //                 onFormatChanged: (format) {
                                    //                   setState(() {
                                    //                     _calendarFormat =
                                    //                         format;
                                    //                   });
                                    //                 },
                                    //                 onPageChanged:
                                    //                     (focusedDay) {
                                    //                   _focusedDay = focusedDay;
                                    //                 },
                                    //               )),
                                    //         );
                                    //       },
                                    //     );
                                    //   },
                                    //   child: Container(
                                    //       alignment: Alignment.center,
                                    //       child: Icon(Icons.arrow_drop_down)),
                                    // )
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
                      padding: const EdgeInsets.only(
                          left: 10, right: 10, top: 8, bottom: 20),
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
                                        left: 16.0,
                                        right: 16,
                                        top: 16,
                                        bottom: 8),
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
                                      padding:
                                          const EdgeInsets.only(left: 16.0),
                                      child: Row(
                                        children: [
                                          Text(
                                            "Over the past",
                                            style: TextStyle(
                                                fontSize: 13,
                                                color: Colors.grey),
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
                                          GestureDetector(child:  Card(
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
                                                color: month1? enabledFutureColor:disabledFutureColor,
                                                height: 18,
                                                child: Text(
                                                  '1 month',
                                                  style: TextStyle(
                                                    fontSize: 10,
                                                    color: month1? enabledFutureTextColor:disabledFutureTextColor,),
                                                )),
                                          ),
                                          onTap: (){
                                            setState(() {
                                              futurEarnings=((commisionDetailsResponse.data.myIncomeResult/currentDate)*30).toInt();
                                              month1=true;
                                              month3=false;
                                              month6=false;
                                              month12=false;
                                            });
                                          },
                                          )
                                         ,
                                          GestureDetector(
                                            child: Card(
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
                                                  color: month3? enabledFutureColor:disabledFutureColor,
                                                  height: 18,
                                                  child: Text(
                                                    '3 months',
                                                    style: TextStyle(
                                                      fontSize: 10,
                                                      color: month3? enabledFutureTextColor:disabledFutureTextColor,),
                                                  )),
                                            ),
                                            onTap: (){
                                              setState(() {
                                                futurEarnings=((commisionDetailsResponse.data.myIncomeResult/currentDate)*90).toInt();
                                                month1=false;
                                                month3=true;
                                                month6=false;
                                                month12=false;
                                              });
                                            },
                                          )
                                          ,
                                          GestureDetector(child: Card(
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(
                                                  20.0), // Adjust the value to change the radius
                                            ),
                                            clipBehavior: Clip.antiAlias,
                                            elevation: 0,
                                            child: Container(
                                              alignment: Alignment.center,
                                              padding: EdgeInsets.only(
                                                  left: 3, right: 3),
                                              color: month6? enabledFutureColor:disabledFutureColor,
                                              height: 18,
                                              child: Text(
                                                '6 months',
                                                style: TextStyle(
                                                  fontSize: 10,
                                                  color: month6? enabledFutureTextColor:disabledFutureTextColor,),
                                              ),
                                            ),
                                          ),
                                          onTap: (){
                                            setState(() {
                                              futurEarnings=((commisionDetailsResponse.data.myIncomeResult/currentDate)*180).toInt();
                                              month1=false;
                                              month3=false;
                                              month6=true;
                                              month12=false;
                                            });
                                          },
                                          )
                                          ,
                                          GestureDetector(
                                            onTap: (){
                                              setState(() {
                                                futurEarnings=((commisionDetailsResponse.data.myIncomeResult/currentDate)*365).toInt();
                                                month1=false;
                                                month3=false;
                                                month6=false;
                                                month12=true;
                                              });
                                            },
                                            child:  Card(
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
                                                color: month12? enabledFutureColor:disabledFutureColor,
                                                height: 18,
                                                child: Text(
                                                  '1 year',
                                                  style: TextStyle(
                                                    fontSize: 10,
                                                    color: month12? enabledFutureTextColor:disabledFutureTextColor,),
                                                ),
                                              ),
                                            ),
                                          )
                                         ,
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 16.0, right: 16),
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
                                      "Your earning would have become ",
                                      style: TextStyle(
                                          color: Colors.black54, fontSize: 12),
                                    ),
                                   futurEarnings==0?Text(
                                     "(₹${((commisionDetailsResponse.data.myIncomeResult/currentDate)*30).toInt()})",
                                     style: TextStyle(
                                         color: Color(
                                           0xFFB42C3B,
                                         ),
                                         fontSize: 12),
                                   ): Text(
                                      "(₹${futurEarnings})",
                                      style: TextStyle(
                                          color: Color(
                                            0xFFB42C3B,
                                          ),
                                          fontSize: 12),
                                    ),
                                    Text(
                                      "(Approx)",
                                      style: TextStyle(
                                          color: Colors.black54, fontSize: 10),
                                    ),
                                  ],
                                ),
                              ),
                          SizedBox(
                            height: 2,

                          ),
                             Text("**This is tentative data.",style: TextStyle(color: appColors.mainAppColor,fontSize: 12,),textAlign: TextAlign.left,),

                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }

  Future<void> getTargetAmount() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      targettedAmount = prefs.getString('monthlyTarget')!;
    });
  }

  Future<Null> getCSPWeeklyLedger() {

    final api = Provider.of<ApiService>(context, listen: false);
    return api
        .getCSPWeeklyCommision(widget.userName)
        .then((value) {
      if (value.statusCode == 200) {
        setState(() {
          cspWeeklyLazerResponse = value;
          _ViewList= [WeeklyView( cspWeeklyLazer: cspWeeklyLazerResponse), MonthlyView(cspMonthlyLazerResponse: cspMonthlyLazerResponse)];
          //isLoading = 1;
        });
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


  Future<Null> getCSPMonthlyLedger() {

    final api = Provider.of<ApiService>(context, listen: false);
    return api
        .getCSPMonthlyCommision(widget.userName)
        .then((value) {
      if (value.statusCode == 200) {
        setState(() {
          cspMonthlyLazerResponse = value;
          bestMonth=cspMonthlyLazerResponse.data.length>1?cspMonthlyLazerResponse.data.reduce((prev, current) =>
          prev.payableToCsp > current.payableToCsp ? prev : current).month:"Data Not Found";
          bestMonthEarning=  cspMonthlyLazerResponse.data.length>1?  cspMonthlyLazerResponse.data.reduce((prev, current) =>
          prev.payableToCsp > current.payableToCsp ? prev : current).payableToCsp.toInt():0;
          _ViewList= [WeeklyView( cspWeeklyLazer: cspWeeklyLazerResponse), MonthlyView(cspMonthlyLazerResponse:cspMonthlyLazerResponse)];
          //isLoading = 1;



        });
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

  getProfitPercantage() {
    if(commisionDetailsResponse.data.transactionDetails.isNotEmpty){
      int percentage= commisionDetailsResponse.data.myIncomeResult==0?0: ((((bestMonthEarning/30)-(commisionDetailsResponse.data.myIncomeResult.toInt()/currentDate))/((commisionDetailsResponse.data.myIncomeResult.toInt()/currentDate)))*100).toInt();
      //13236
      if(percentage<0){
        setState(() {
          profitIncrease=1;
        });
        return percentage-(2*percentage);

      }else{
        setState(() {
          profitIncrease=0;

        });
        return percentage;
      }
    }else{
      return 0;
    }

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
class MonthlyView extends StatefulWidget {
  final CspMonthlyLazerResponse cspMonthlyLazerResponse;
  MonthlyView({super.key, required this.cspMonthlyLazerResponse});

  @override
  State<MonthlyView> createState() => _MonthlyViewState();
}

class _MonthlyViewState extends State<MonthlyView> {


  AppColors appColors = new AppColors();
  List<Map<String, dynamic>> organizedData = List.generate(
    4,
        (index) => {"monthOfYear": "", "numTransactionsOrAvgBal": 0.0},
  );
int divis=1000;
  @override
  void initState() {
    getLastFourMonths(widget.cspMonthlyLazerResponse);
    getDivisionValue();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
                          heightFactor: organizedData[0]["numTransactionsOrAvgBal"]/divis,
                          child: Container(
                            color: appColors.mainAppColor,
                          ),
                        ),
                        Positioned(
                          bottom:
                          (organizedData[0]["numTransactionsOrAvgBal"]/divis) * 240, // Calculate the position
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
                                    'र${organizedData[0]["numTransactionsOrAvgBal"]}',
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
                          heightFactor: organizedData[1]["numTransactionsOrAvgBal"]/divis,
                          child: Container(
                            color: appColors.mainAppColor,
                          ),
                        ),
                        Positioned(
                          bottom:
                          (organizedData[1]["numTransactionsOrAvgBal"]/divis) * 240, // Calculate the position
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
                                    'र${organizedData[1]["numTransactionsOrAvgBal"]}',
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
                          heightFactor: organizedData[2]["numTransactionsOrAvgBal"]/divis,
                          child: Container(
                            color: appColors.mainAppColor,
                          ),
                        ),
                        Positioned(
                          bottom:
                          (organizedData[2]["numTransactionsOrAvgBal"]/divis) * 240, // Calculate the position
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
                                    'र${organizedData[2]["numTransactionsOrAvgBal"]}',
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
                          heightFactor: organizedData[3]["numTransactionsOrAvgBal"]/divis,
                          child: Container(
                            color: appColors.mainAppColor,
                          ),
                        ),
                        Positioned(
                          bottom:
                          (organizedData[3]["numTransactionsOrAvgBal"]/divis) * 240, // Calculate the position
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
                                    'र${organizedData[3]["numTransactionsOrAvgBal"]}',
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
                  child: Text(organizedData[0]["monthOfYear"])),
              Container(
                  alignment: Alignment.center, width: 70, child: Text(organizedData[1]["monthOfYear"])),
              Container(
                  alignment: Alignment.center, width: 70, child: Text(organizedData[2]["monthOfYear"])),
              Container(
                  alignment: Alignment.center, width: 70, child: Text(organizedData[3]["monthOfYear"])),
            ],
          ),
        ),
      ],
    );
  }

  void getLastFourMonths(CspMonthlyLazerResponse cspMonthlyLazerResponse) {

    String currentMonth = DateFormat('MMMM').format(DateTime.now()); // Get the current month name

    // Get the last three months
    List<String> lastThreeMonths = [];

    lastThreeMonths.add(currentMonth);
    for (var i = 1; i <= 3; i++) {
      var previousMonth = DateTime.now().subtract(Duration(days: 30 * i));
      lastThreeMonths.add(DateFormat('MMMM').format(previousMonth)); // Get the month name using DateFormat
    }
print(lastThreeMonths);

    for(var z=0;z<lastThreeMonths.length;z++){

      for (var data in cspMonthlyLazerResponse.data) {
        String month = data.month;
        double payableToCSP = data.payableToCsp;
        print("monthNAME ${lastThreeMonths[z]}    month${data.month}");
        if(lastThreeMonths[z]==month){


          // Update payableToCSP for the corresponding month in organizedData
          organizedData[3-z]["monthOfYear"] = month;
          organizedData[3-z]["numTransactionsOrAvgBal"] = payableToCSP;
        }
        // Find the index for the month in organizedData


      }
    }




    print(organizedData);
  }

  void getDivisionValue() {
    for (var data in organizedData) {
      double payableToCSP = data["numTransactionsOrAvgBal"];
      if (payableToCSP > 9999) {
        divis = 100000;
        break;
      } else if (payableToCSP > 1000) {
        divis = 10000;
      } else if (payableToCSP > 100) {
        divis = 1000;
      }
    }
  }

}





class WeeklyView extends StatefulWidget {
  final CspWeeklyLazerResponse cspWeeklyLazer;

  const WeeklyView({super.key, required this.cspWeeklyLazer});

  @override
  State<WeeklyView> createState() => _WeeklyViewState();
}

class _WeeklyViewState extends State<WeeklyView> {
  AppColors appColors=AppColors();
  List<Map<String, dynamic>> organizedData = List.generate(
    7,
        (index) => {"dayOfWeek": _getDayName(index), "payableToCSP": 0.0},
  );
  int divis=1000;


@override
  void initState() {
  getOrganizeData();
    super.initState();
  }




static String _getDayName(int index) {
  int currentDayIndex = DateTime.now().weekday;
  List<String> days = List.generate(7, (index) {
    int dayIndex = (currentDayIndex + index) % 7;
    return _getDayNameList(dayIndex);
  });
  return days[index].substring(0,3).toUpperCase();
}

static String _getDayNameList(int index) {
  List<String> days = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"];
  return days[index];
}

int _getDayIndex(String day) {
  int currentDayIndex = DateTime.now().weekday;
  List<String> days = List.generate(7, (index) {
    int dayIndex = (currentDayIndex + index) % 7;
   // print("dayName= ${day} index =${dayIndex}");
    return _getDayNameList(dayIndex);
  });
  return days.indexOf(day);
}

void getOrganizeData(){
  for(int i=0;i<organizedData.length;i++){
    for (var data in widget.cspWeeklyLazer.data) {
      print("${organizedData[i]["dayOfWeek"]}== ${data.dayOfWeek}  == ${data.payableToCsp}");

      if(data.dayOfWeek.toLowerCase().contains(organizedData[i]["dayOfWeek"].toString().toLowerCase())){
        print("${organizedData[i]["dayOfWeek"]}== ${data.dayOfWeek}  == ${data.payableToCsp}");
        organizedData[i]["payableToCSP"]=data.payableToCsp;
      }



      // var dayIndex = _getDayIndex(data.dayOfWeek);
      // if(data.dayOfWeek.toLowerCase().contains(organizedData[dayIndex]["dayOfWeek"].toString().toLowerCase())){
      //   organizedData[dayIndex]["payableToCSP"] = data.payableToCsp;
      // }

    }

  }

  organizedData.map((task) => task["payableToCSP"]).reduce((a, b) => a > b ? a : b);
//print("maxCommission $maxCommission");
  for (var data in organizedData) {
    double payableToCSP = data["payableToCSP"];
    if (payableToCSP > 9999) {
      divis = 100000;
      break;
    } else if (payableToCSP > 1000) {
      divis = 10000;
      break;
    } else if (payableToCSP > 100) {
      divis = 1000;
      break;
    }
  }
  }
  @override
  Widget build(BuildContext context) {

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
                          heightFactor: organizedData[0]["payableToCSP"]/divis,
                          child: Container(
                            color: appColors.mainAppColor,
                          ),
                        ),
                        Positioned(
                          bottom:
                          (organizedData[0]["payableToCSP"]/divis) * 200, // Calculate the position
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
                                    'र${organizedData[0]["payableToCSP"]}',
                                    style: TextStyle(
                                        fontSize: 10, color: Colors.grey),
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
                          heightFactor: organizedData[1]["payableToCSP"]/divis,
                          child: Container(
                            color: appColors.mainAppColor,
                          ),
                        ),
                        Positioned(
                          bottom:
                          (organizedData[1]["payableToCSP"]/divis) * 200, // Calculate the position
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
                                    'र${organizedData[1]["payableToCSP"]}',
                                    style: TextStyle(
                                        fontSize: 10, color: Colors.grey),
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
                          heightFactor: organizedData[2]["payableToCSP"]/divis,
                          child: Container(
                            color: appColors.mainAppColor,
                          ),
                        ),
                        Positioned(
                          bottom:
                          (organizedData[2]["payableToCSP"]/divis) * 200, // Calculate the position
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
                                    'र${organizedData[2]["payableToCSP"]}',
                                    style: TextStyle(
                                        fontSize: 10, color: Colors.grey),
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
                          heightFactor: organizedData[3]["payableToCSP"]/divis,
                          child: Container(
                            color: appColors.mainAppColor,
                          ),
                        ),
                        Positioned(
                          bottom:
                          (organizedData[3]["payableToCSP"]/divis) * 200, // Calculate the position
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
                                    'र${organizedData[3]["payableToCSP"]}',
                                    style: TextStyle(
                                        fontSize: 10, color: Colors.grey),
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
                          heightFactor: organizedData[4]["payableToCSP"]/divis,
                          child: Container(
                            color: appColors.mainAppColor,
                          ),
                        ),
                        Positioned(
                          bottom:
                          (organizedData[4]["payableToCSP"]/divis) * 200, // Calculate the position
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
                                    'र${organizedData[4]["payableToCSP"]}',
                                    style: TextStyle(
                                        fontSize: 10, color: Colors.grey),
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
                          heightFactor: organizedData[5]["payableToCSP"]/divis,
                          child: Container(
                            color: appColors.mainAppColor,
                          ),
                        ),
                        Positioned(
                          bottom:
                          (organizedData[5]["payableToCSP"]/divis) * 200, // Calculate the position
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
                                    'र${organizedData[5]["payableToCSP"]}',
                                    style: TextStyle(
                                        fontSize: 10, color: Colors.grey),
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
                          heightFactor:organizedData[6]["payableToCSP"]/divis,
                          child: Container(
                            color: appColors.mainAppColor,
                          ),
                        ),
                        Positioned(
                          bottom:
                          (organizedData[6]["payableToCSP"]/divis) * 200, // Calculate the position
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
                                    'र${organizedData[6]["payableToCSP"]}',
                                    style: TextStyle(
                                        fontSize: 10, color: Colors.grey),
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
                          organizedData[0]["dayOfWeek"],
                          style: TextStyle(color: Colors.grey,fontSize: 12),
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
                          organizedData[1]["dayOfWeek"],
                          style: TextStyle(color: Colors.grey,fontSize: 12),
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
                          organizedData[2]["dayOfWeek"],
                          style: TextStyle(color: Colors.grey,fontSize: 12),
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
                          organizedData[3]["dayOfWeek"],
                          style: TextStyle(color: Colors.grey,fontSize: 12),
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
                          organizedData[4]["dayOfWeek"],
                          style: TextStyle(color: Colors.grey,fontSize: 12),
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
                          organizedData[5]["dayOfWeek"],
                          style: TextStyle(color: Colors.grey,fontSize: 12),
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
                          organizedData[6]["dayOfWeek"],
                          style: TextStyle(color: Colors.grey,fontSize: 12),
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
  final LoginResponse loginResponse;
  final String username;
  LeaderBoard(this.loginResponse, this.username);

  @override
  State<LeaderBoard> createState() => _LeaderBoardState();
}

class _LeaderBoardState extends State<LeaderBoard>
    with TickerProviderStateMixin {
  AppColors appColors = new AppColors();
  int _current = 0;
  late GifController _controllerGif;
  int isLoading=0;
  final CarouselController _controller = CarouselController();
  LeaderBoardDataResponse earningsData =
      LeaderBoardDataResponse(statusCode: 0, message: "", data: []);
  @override
  void initState() {
    super.initState();
    _controllerGif = GifController(vsync: this);
    _getLeaderBoardData();
  }

  @override
  void dispose() {
    _controllerGif.dispose();
    super.dispose();
  }

  final List<String> imgList = [
    "assets/images/banner3.gif",
    "assets/images/banner2.gif",

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

  Future<void> _getLeaderBoardData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    final api = Provider.of<ApiService>(context, listen: false);
    return api.getLeaderBoardData().then((value) {
      if (value.data.isNotEmpty) {
        setState(() {
          earningsData = value;
          isLoading=1;
        });
      } else {
        setState(() {
          isLoading=2;

        });

        QuickAlert.show(
          context: context,
          type: QuickAlertType.error,
          title: 'Oops...',
          text: 'Sorry, no record',
          backgroundColor: Colors.white,
          titleColor: appColors.mainAppColor,
          textColor: appColors.mainAppColor,
          confirmBtnColor: appColors.mainAppColor,
        );
      }
    });
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
                          2, // Replace '3' with the total number of items
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
                                      .elementAt(index)
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
                        autoPlay: true, // Set true/false for autoplay
                        autoPlayInterval:
                            Duration(seconds: 10), // Autoplay interval if needed
                        autoPlayAnimationDuration: Duration(
                            milliseconds: 3000), // Autoplay animation duration
                        pauseAutoPlayOnTouch: false,
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
                       2, // Replace '3' with the total number of items
                        (index) => buildDot(index: index),
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height / 35),
                  ],
                ),
              ),
              isLoading != 0
                  ?  isLoading ==1?Stack(
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
                                  top: 65, left: 10, right: 10, bottom: 10),
                              //  margin: EdgeInsets.only(top: 30,left: 10,right: 10),
                              child: MediaQuery.removePadding(
                                context: context,
                                removeTop: true,
                                child: ListView.builder(
                                  itemCount: 10,
                                  itemBuilder: (context, index) {
                                    final item = earningsData.data[index];
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
                                                    color:
                                                        appColors.mainAppColor,
                                                    gradient: isFirstItem
                                                        ? LinearGradient(
                                                            colors: [
                                                              Colors.yellow,
                                                              Colors
                                                                  .orangeAccent,
                                                              Colors.yellow,
                                                              Colors.orange,
                                                              Colors.orange
                                                            ], // Define your gradient colors
                                                            begin: Alignment
                                                                .topLeft,
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
                                                        fontSize: 14,
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              Container(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    3,
                                                child: Text(
                                                  item.cspName,
                                                  style: TextStyle(
                                                    fontSize: 15,
                                                    color: Colors.white,
                                                    fontWeight: isFirstItem
                                                        ? FontWeight.bold
                                                        : FontWeight.normal,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          GestureDetector(
                                            child: Text(
                                              item.payableToCsp.toString(),
                                              style: TextStyle(
                                                fontSize: 15,
                                                color: Colors.white,
                                                decorationThickness: 1,
                                                decoration: TextDecoration.underline,

                                                decorationColor: Colors.white,
                                                fontWeight: isFirstItem
                                                    ? FontWeight.bold
                                                    : FontWeight.normal,
                                              ),
                                            ),
                                            onTap: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        TransactionDetailsPageByCode(
                                                             datum: item,),
                                                  ));
                                            },
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
                          top:78,
                          child:  Text('Last Month Achievers',style: TextStyle(color: Colors.white,fontSize: 16,fontFamily: 'Visbyfregular'),),),
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
                    ):Container()
                  : CircularProgressIndicator(
                      color: appColors.white,
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

  HomePageview(this.loginResponse, this.username);

  @override
  State<HomePageview> createState() => _HomePageviewState();
}

class _HomePageviewState extends State<HomePageview> {
  late ScrollController _scrollController;
  late double _opacity = 1.0;
  int isLoading = 0;
  late CommisionDetailsResponse commisionDetailsResponse;
  late GetTaskSlabDetailsResponse getTaskSlabDetailsResponse=GetTaskSlabDetailsResponse(statusCode: 0, message: "", data: []);


  AppColors appColors = AppColors();
  int targettedAmount = 0;
  int completedAmountPer=-1;
  final currencyFormatter = NumberFormat('#,##0', 'en_US');
  String bannerUrl = "";
  double expandedHeight = 0;
  late VideoPlayerController _controller;
  @override
  void initState() {
    getTargetAmount();
    _getTaskSlabDetails();
    getCommisionDetail();
    super.initState();



    getBannerUrl();
    _scrollController = ScrollController()..addListener(_updateOpacity);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  getBannerUrl() {
    final api = Provider.of<ApiService>(context, listen: false);
    return api.getBannerImageUrl("B").then((value) {
      if (value.data.banner.isNotEmpty) {

          setState(() {

            bannerUrl = value.data.banner;
            if(value.data.banner.endsWith(".mp4")){
              _controller = VideoPlayerController.network(

                'https://erp.paisalo.in:981/LOSDOC/BannerPost/${bannerUrl}', // Replace with your video URL or asset path

              )..initialize().then((_) {

                setState(() {
                  _controller.play();
                  _controller.setLooping(true);

                  Timer.periodic(Duration(seconds: 7), (Timer t) {
                    setState(() {
                      _controller.pause();
                      _controller.setLooping(false);
                      expandedHeight = 0;
                    });
                  });
                }); // Ensure the first frame is shown after the video is initialized

              });
            }
            if (bannerUrl.length > 2) {
              expandedHeight = 220;
            } else {
              expandedHeight = 0;
            }
          });


      }
    });
  }








  void _updateOpacity() {
    setState(() {
      // You can adjust these values based on your needs
      if (_scrollController.position.userScrollDirection ==
          ScrollDirection.forward) {
        _opacity = 1.0;
      } else {
        _opacity = 0.0;
      }
    });
  }
  Future<Null> _getTaskSlabDetails() {

    final api = Provider.of<ApiService>(context, listen: false);
    return api
        .getTaskSlabDetails()
        .then((value) {
      if (value.statusCode == 200) {
        setState(() {
          getTaskSlabDetailsResponse = value;
          //isLoading = 1;
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
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      controller: _scrollController,
      slivers: [
        SliverAppBar(
          backgroundColor: appColors.mainAppColor,
          leading: null,
          automaticallyImplyLeading: false,
          expandedHeight: expandedHeight,
          floating: false,
          flexibleSpace: FlexibleSpaceBar(
            background: bannerUrl.length > 0 && expandedHeight>0
                ? bannerUrl.endsWith(".mp4")? VideoPlayer(_controller): Image.network(
                    'https://erp.paisalo.in:981/LOSDOC/BannerPost/${bannerUrl}',
                    fit: BoxFit.fill,
                  )
                : Container(
                    height: 0,
                  ),
            collapseMode: CollapseMode.none,
          ),
        ),
        // Add other slivers or widgets as needed
        SliverList(
          delegate: SliverChildBuilderDelegate(
            addRepaintBoundaries: true,
            addAutomaticKeepAlives: true,
            (BuildContext context, int index) {
              return Container(
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
                              SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height / 25),
                              // Replace 'assets/your_image.svg' with your SVG file path
                              Image(
                                image:
                                    AssetImage('assets/images/paisa_logo.png'),
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
                              Padding(padding: EdgeInsets.only(left: 25),child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    '₹${currencyFormatter.format(targettedAmount)}',
                                    style: TextStyle(
                                      fontSize: 26,
                                      color: Colors.black,
                                    ),
                                  ),
                                  SizedBox(width: 10,),
                                  completedAmountPer==-1?Container(
                                      height: 14,width: 14,
                                      child: CircularProgressIndicator(color: appColors.mainAppColor,strokeWidth: 2,)):
                                  GestureDetector(child: Icon(Icons.info_outlined,color: appColors.mainAppColor,size: 15,),
                                  onTap: (){

                                    for(int i=0;i<getTaskSlabDetailsResponse.data.length;i++){
                                      var arr=getTaskSlabDetailsResponse.data[i].slabs.split("-");
                                      print("check it ${arr[0]}, ${arr[1]}, ${targettedAmount}");
                                      if( int.parse(arr[0]) <=targettedAmount && int.parse(arr[1])>=targettedAmount ){
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => SlabDetailsPage(getTaskSlabDetailsResponse.data[i]),
                                            )
                                        );
                                      }
                                    }
                                  },
                                  )

                                ],
                              ),),

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
                                      '${completedAmountPer==-1?0:completedAmountPer}% COMPLETED',
                                      style: TextStyle(
                                          fontSize: 12, color: Colors.black),
                                    ),
                                  ),
                                ],
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => TargetSetPage(
                                              loginResponse:
                                                  widget.loginResponse,
                                              username: widget.username,
                                            )),
                                  );
                                },
                                child: Container(
                                  alignment: Alignment.center,
                                  width: 120,
                                  height: 30,
                                  decoration: BoxDecoration(
                                      color: appColors.mainAppColor),
                                  child: Text(
                                    'RESET TARGET',
                                    style: TextStyle(
                                        fontSize: 15, color: Colors.white),
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
                            MaterialPageRoute(builder: (context) => TaskList(widget.username)),
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
                                    height: MediaQuery.of(context).size.height /
                                        4.8,
                                    color: Colors.white,
                                    child: Padding(
                                      padding: const EdgeInsets.all(15.0),
                                      child: Center(
                                          child: Text(
                                        isLoading == 1
                                            ? 'Current Earning\n₹${commisionDetailsResponse.data.myIncomeResult.toInt()}\n${commisionDetailsResponse.data.comparisonResult} people are earning\nmore commission'
                                            : "Please wait..\nyour data\nis fetching",
                                        style: TextStyle(
                                          fontSize: 17,
                                          fontFamily: 'Visbyfregular'
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
                                    print('commsion ${commisionDetailsResponse.data.myIncomeResult}');
                                    Timer(
                                      Duration(seconds: 2),
                                      () => Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => AchiverPage(widget.username,commisionDetailsResponse.data.myIncomeResult),
                                        ),
                                      ),
                                    );
                                    /* setState(() {
                  isDialogOpen = !isDialogOpen;
                });*/
                                    showDialog(
                                      context: context,
                                      barrierDismissible: false, // Dialog cannot be dismissed by tapping outside
                                      builder: (BuildContext context) {
                                        return Dialog(
                                          backgroundColor: Colors.white.withOpacity(0.92),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(20.0),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(20.0),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min, // Adjust size to fit content
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: [
                                                Container(
                                                  width: 60, // Adjust width as needed
                                                  height: 60, // Adjust height as needed
                                                  child: CircularProgressIndicator(
                                                    strokeWidth: 5,
                                                    valueColor: AlwaysStoppedAnimation<Color>(
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
                                        );
                                      },
                                    );

                                  },
                                  child: Card(
                                      color: Colors.white,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20.0),
                                      ),
                                      elevation: 10,
                                      shadowColor: Colors.black,
                                      clipBehavior: Clip.antiAlias,
                                      child: Container(
                                        height:
                                            MediaQuery.of(context).size.height /
                                                4.8,
                                        color: appColors.mainAppColor,
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              top: 10,
                                              bottom: 10,
                                              left: 15,
                                              right: 15),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                "Earn maximum\ncommission",
                                                style: TextStyle(
                                                    fontSize: 17,
                                                    color: Colors.white),
                                              ),
                                              SizedBox(
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height /
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
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height /
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
                              builder: (context) => (RequestForFundTransfer(
                                  loginResponse: widget.loginResponse,
                                  userName: widget.username)),
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
      targettedAmount = int.parse(prefs.getString('monthlyTarget')!);
      print("target $targettedAmount");
      print(commisionDetailsResponse.data.myIncomeResult);


    });
  }

  String getFirstDateOfMonth() {
    final now = DateTime.now();
    final firstDayOfMonth = DateTime(now.year, now.month, 1);
    return '${firstDayOfMonth.year}-${firstDayOfMonth.month.toString().padLeft(2, '0')}-${firstDayOfMonth.day.toString().padLeft(2, '0')}';
  }

  String getCurrentDate() {
    final now = DateTime.now();
    return '${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}';
  }

  Future<Null> getCommisionDetail() {
    String fromDate = getFirstDateOfMonth();
    String toDate = getCurrentDate();

    final api = Provider.of<ApiService>(context, listen: false);
    return api
        .getCommsionDetails(fromDate, toDate, widget.username, "1", "true")
        .then((value) {
      if (value.statusCode == 200) {
        setState(() {
          commisionDetailsResponse = value;
          completedAmountPer=((commisionDetailsResponse.data.myIncomeResult.toInt()/targettedAmount)*100).toInt();
          isLoading = 1;
        });
      } else {
        setState(() {
          isLoading = 1;
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
    }).catchError((_){
      setState(() {
        isLoading = 1;
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
