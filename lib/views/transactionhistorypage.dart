import 'dart:ffi';

import 'package:new_bc_app/model/loginresponse.dart';
import 'package:new_bc_app/model/transhistoryresponse.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../network/api_service.dart';
import '../const/AppColors.dart';
import 'homepage.dart';

class TransactionHistoryPage extends StatefulWidget {
  final LoginResponse loginResponse;
  final String username;
  const TransactionHistoryPage(
      {super.key, required this.loginResponse, required this.username});

  @override
  State<TransactionHistoryPage> createState() => _TransactionHistoryPageState();
}

class _TransactionHistoryPageState extends State<TransactionHistoryPage> {
  String selectedValue = 'Today';
  final List<String> items = List.generate(50, (index) => 'Item $index');
  AppColors appColors = new AppColors();
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
  TransHistoryResponse transHisList =
      TransHistoryResponse(statusCode: 100, message: "", data: []);

  @override
  void initState() {
    _getTransactionHistory();
  }

  int apiResponse = 1;

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      backgroundColor: Color(0xFFD42D3F),
      appBar: AppBar(
        elevation: 6,
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
          'TRANSACTION HISTORY',
          style: TextStyle(color: Colors.white, fontSize: 15),
        ),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  SizedBox(
                    width: 8,
                  ),
                  Card(
                    elevation: 0,
                    clipBehavior: Clip.antiAlias,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4)),
                    child: Container(
                      alignment: Alignment.center,
                      height: 30,
                      width: 100,
                      color: Colors.white,
                      child: DropdownButton<String>(
                        elevation: 0,
                        style: TextStyle(color: Colors.black),
                        underline: Container(),
                        icon: Icon(Icons.arrow_drop_down,
                            color: appColors.mainAppColor),
                        value: selectedValue,
                        onChanged: (String? newValue) {
                          setState(() {
                            transHisList = TransHistoryResponse(
                                statusCode: 100, message: "", data: []);
                            selectedValue = newValue!;
                            _getTransactionHistory();
                            apiResponse = 1;
                          });
                        },
                        items: <String>['Today', 'Weekly', 'Monthly', 'All']
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(
                              value,
                              style: TextStyle(
                                color: value == selectedValue
                                    ? appColors.mainAppColor
                                    : Colors
                                        .black, // Set text color to red for dropdown items
                                fontSize: 12, // Change font size
                                // Change font weight
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    "DOWNLOAD",
                    style: TextStyle(color: Colors.white, fontSize: 10),
                  ),
                  Icon(
                    Icons.arrow_downward,
                    color: Colors.white,
                    size: 15,
                  ),
                  SizedBox(
                    width: 20,
                  ),
                ],
              )
            ],
          ),
          SizedBox(
            height: 10,
          ),
          !transHisList.data.isEmpty
              ? Expanded(
                  child: ListView.builder(
                    itemCount: transHisList.data.length,
                    itemBuilder: (context, index) {
                      return CustomListItem(transHisList.data[index]);
                    },
                  ),
                )
              : (apiResponse == 1
                  ? Center(
                      child: Center(
                        child: CircularProgressIndicator(
                          color: Colors.white,
                        ),
                      ),
                    )
                  : Center()),
        ],
      ),
    );
  }

  Future<void> _getTransactionHistory() async {
    int days = 0;

    if (selectedValue == 'Today') {
      days = 0;
    } else if (selectedValue == 'Weekly') {
      days = 7;
    } else if (selectedValue == 'Monthly') {
      days = 30;
    } else {
      days = 100;
    }
    DateTime now = DateTime.now();
    String fromDate =
        DateFormat('yyyy-MM-dd').format(now.subtract(Duration(days: days)));
    String toDate = DateFormat('yyyy-MM-dd').format(now);
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      // Perform shared preferences operations after obtaining the instance.

      final api = Provider.of<ApiService>(context, listen: false);
      return api
          .getTransHistory(prefs.get('username').toString(),
              fromDate.toString(), toDate.toString())
          .then((value) {
        if (value.data.isNotEmpty) {
          setState(() {
            transHisList = value;
          });
          apiResponse = 1;
        } else {
          setState(() {
            apiResponse = 0;
          });
          QuickAlert.show(
              context: context,
              type: QuickAlertType.error,
              title: 'Oops...',
              text: 'Sorry, no record found',
              backgroundColor: Colors.white,
              titleColor: appColors.mainAppColor,
              textColor: appColors.mainAppColor,
              confirmBtnColor: appColors.mainAppColor);
        }
      });
    } catch (_) {
      apiResponse = 0;
      QuickAlert.show(
          context: context,
          type: QuickAlertType.error,
          title: 'Oops...',
          text: 'Sorry, no record found',
          backgroundColor: Colors.white,
          titleColor: appColors.mainAppColor,
          textColor: appColors.mainAppColor,
          confirmBtnColor: appColors.mainAppColor);
    }
  }
}

class CustomListItem extends StatefulWidget {
  final TranDataList data;
  AppColors appColors = new AppColors();
  CustomListItem(this.data, {super.key});
  @override
  State<CustomListItem> createState() => _CustomListItemState();
}

class _CustomListItemState extends State<CustomListItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity, // Adjust width as needed
      child: Card(
        elevation: 5,
        color: widget.appColors.mainAppColor,
        margin: EdgeInsets.all(8.0),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text(
                    removeSecondsAndMilliseconds(
                        widget.data.transactionDateTime.split("T")[1])
                    ,
                    style: TextStyle(color: Colors.white),
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Container(
                      height: 60,
                      width: 60,
                      child: Image.asset(
                        "assets/images/trans_ic.png",
                      )),
                  SizedBox(
                    width: 8,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.data.typeOfTransaction,
                        style: TextStyle(fontSize: 12, color: Colors.white),
                      ),
                      Text(
                        "${widget.data.fromAccount} - ${widget.data.toAccount}",
                        style: TextStyle(fontSize: 8, color: Colors.white),
                      ),
                    ],
                  ),
                ],
              ),
              Column(
                children: [
                  Text(
                    "₹${widget.data.amount}",
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    DateFormat('dd-MM-yyyy').format(DateTime.parse(
                        widget.data.transactionDateTime.split("T")[0])),
                    style: TextStyle(fontSize: 10, color: Colors.white),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  String removeSecondsAndMilliseconds(String timeString) {
    // Split the time string by ":" to get individual components
    List<String> components = timeString.split(":");

    // Check if there are enough components to represent hours, minutes, and seconds
    if (components.length >= 2) {
      // Take only the hours and minutes components
      return "${components[0]}:${components[1]}";
    } else {
      // If there are not enough components, return the original string
      return timeString;
    }
  }
}
