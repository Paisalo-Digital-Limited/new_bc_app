import 'package:new_bc_app/const/AppColors.dart';
import 'package:new_bc_app/model/loginresponse.dart';
import 'package:new_bc_app/model/withdrawalanddepsitmodel.dart';
import 'package:new_bc_app/views/homepage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../network/api_service.dart';
import '../utils/SaveGeoTags.dart';


class WithdrawalAndDepositHistory extends StatefulWidget {
  final LoginResponse loginResponse;
  final String username;
  const WithdrawalAndDepositHistory({super.key, required this.loginResponse, required this.username});

  @override
  State<WithdrawalAndDepositHistory> createState() => _WithdrawalAndDepositHistoryState();
}

class _WithdrawalAndDepositHistoryState extends State<WithdrawalAndDepositHistory> {
  @override
  void initState() {
    _getWithdrswalDepositHistory();
    SaveGeoTags apIs=SaveGeoTags();
    apIs.getTansactionDetailsByCode(context,"WithdrawalAndDepositHistory",widget.username);
  }
  int apiResponse=1;

  WithdrawalAndDepsitModel transHisList =
  WithdrawalAndDepsitModel(statusCode: 100, message: "", data: []);
  AppColors appColors=new AppColors();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appColors.mainAppColor,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: appColors.mainAppColor,
        leading: IconButton(
          icon: Icon(
            Icons.close,color: Colors.white, // Change the back icon here
          ),
          onPressed: () {
            Navigator.pop(
              context );
          },
        ),
        title: Text(
          'Withdrawal and Deposite History',
          style: TextStyle(color: Colors.white,fontSize: 16),
        ),
      ),
      body: !transHisList.data.isEmpty
          ? Column(
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
                    width: 20,
                  ),
                  Text(
                    "SEE ALL",
                    style: TextStyle(color: Colors.white, fontSize: 10),
                  ),
                  Icon(
                    Icons.arrow_forward_ios_outlined,
                    color: Colors.white,
                    size: 15,
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
          Expanded(
            child: ListView.builder(
              itemCount: transHisList.data.length,
              itemBuilder: (context, index) {
                return CustomListItemWithDrawalHistory(transHisList.data[index]);
              },
            ),
          ),
        ],
      )
          : (apiResponse==1? Center(
        child: Center(
          child: CircularProgressIndicator(
            color: Colors.white,
          ),
        ),
      ): Center(

      ))
      ,

    );
  }

  Future<void> _getWithdrswalDepositHistory() async {
  // try{

    final api=Provider.of<ApiService>(context,listen: false);
    return api
        .getWithdrawalAndDepositHistory(
        "Bearer ${widget.loginResponse.data.token}",widget.username).then((value) {
        if (value.data.isNotEmpty) {
          setState(() {
            transHisList = value;
          });
        }
        else{
          setState(() {
            apiResponse=0;
          });
          QuickAlert.show(
            context: context,
            type: QuickAlertType.error,
            title: 'Oops...',
            text: 'Sorry, no record found',
            backgroundColor: Colors.black,
            titleColor: Colors.white,
            textColor: Colors.white,
          );

        }
      });
    // }catch(_){
    //   apiResponse=0;
    //   QuickAlert.show(
    //     context: context,
    //     type: QuickAlertType.error,
    //     title: 'Oops...',
    //     text: 'Sorry, no record found',
    //     backgroundColor: Colors.black,
    //     titleColor: Colors.white,
    //     textColor: Colors.white,
    //   );
    // }

  }
}

class CustomListItemWithDrawalHistory extends StatefulWidget {
  final WithdrawalDePositData data;
  AppColors appColors = new AppColors();
  CustomListItemWithDrawalHistory(this.data, {super.key});
  @override
  State<CustomListItemWithDrawalHistory> createState() => _CustomListItemState();
}

class _CustomListItemState extends State<CustomListItemWithDrawalHistory> {
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
                  SizedBox(
                    width: 8,
                  ),
                  Container(
                      height: 60,
                      width: 60,
                      child: Image.asset(
                        widget.data.isApproved=="1"?"assets/images/tranc_green_ic.png":"assets/images/trans_ic.png",
                      )),
                  SizedBox(
                    width: 8,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.data.reqType=="W"?"withdrawal":"Deposit",
                        style: TextStyle(fontSize: 14, color: Colors.white),
                      ),
                    ],
                  ),
                ],
              ),
              Column(
                children: [
                  Text(
                    "₹ ${widget.data.amount}",
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "",
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


}
