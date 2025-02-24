import 'package:flutter/material.dart';
import 'package:new_bc_app/const/AppColors.dart';
import 'package:new_bc_app/model/commissionDetailsResponse.dart';
import 'package:new_bc_app/model/leaderBoardDataResponse.dart';
import 'package:new_bc_app/model/loginresponse.dart';
import 'package:provider/provider.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

import '../network/api_service.dart';



class LeaderBoardItemDetails extends StatefulWidget {
  final String koid;
  const LeaderBoardItemDetails(this.koid);

  @override
  State<LeaderBoardItemDetails> createState() => _LeaderBoardItemDetailsState();
}

class _LeaderBoardItemDetailsState extends State<LeaderBoardItemDetails> {
  @override
  void initState() {
    _getCommisionDetails();
    super.initState();
  }
  int isLoading=0;
  late CommisionDetailsResponse commisionDetailsResponse;

  //CommisionDetailsResponse commisionDetailsResponse=CommisionDetailsResponse(statusCode: 0, message: "",data:);
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
                        width: 40,
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Text(
                        "Type Of Transactions",
                        style: TextStyle(fontSize: 14, color: appColors.mainAppColor),
                      ),

                    ],
                  ),
                  Padding(padding: EdgeInsets.only(right: 15),
                    child: Column(
                      children: [
                        Text(
                          "Count ot Trancations",
                          style: TextStyle(fontSize: 13, color: appColors.mainAppColor),
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
            child: isLoading==0
                ? CircularProgressIndicator(color: Colors.white,) // Show loading indicator if data is being fetched
                :ListView.builder(
              itemCount: commisionDetailsResponse.data.transactionDetails.length,
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
                              width: 8,
                            ),
                            Container(
                                height: 40,
                                width: 40,
                                child: Image.asset(
                                  "assets/images/trans_ic.png",
                                )),
                            SizedBox(
                              width: 8,
                            ),
                           Container(width: MediaQuery.of(context).size.width/3,child:  Text(
                             commisionDetailsResponse.data.transactionDetails[index].typeOfTransaction.toString(),
                             style: TextStyle(fontSize: 14, color: Colors.white),
                           ),)

                          ],
                        ),
                        Padding(padding: EdgeInsets.only(right: 15),
                          child: Column(
                            children: [
                              Text(
                                commisionDetailsResponse.data.transactionDetails[index].transactionCount.toString(),
                                style: TextStyle(fontSize: 13, color: Colors.white),
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
  String getFirstDateOfMonth() {
    final now = DateTime.now();
    final firstDayOfMonth = DateTime(now.year, now.month, 1);
    return '${firstDayOfMonth.year}-${firstDayOfMonth.month.toString().padLeft(2, '0')}-${firstDayOfMonth.day.toString().padLeft(2, '0')}';
  }

  String getCurrentDate() {
    final now = DateTime.now();
    return '${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}';
  }

  Future<Null> _getCommisionDetails() {
    String  fromDate = getFirstDateOfMonth();
    String  toDate = getCurrentDate();

     final api = Provider.of<ApiService>(context, listen: false);
    return api
        .getCommsionDetails(fromDate,toDate,widget.koid,"1","true")
        .then((value) {

      if (value.statusCode==200) {
        setState(() {

          commisionDetailsResponse=value;
          isLoading=1;

        });

      }else{
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
