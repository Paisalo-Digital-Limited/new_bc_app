import 'package:flutter/material.dart';
import 'package:new_bc_app/model/TransactionDetailsByCodeModel.dart';
import 'package:new_bc_app/model/leaderBoardDataResponse.dart';
import 'package:provider/provider.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

import '../const/AppColors.dart';
import '../network/api_service.dart';
import '../utils/SaveGeoTags.dart';

class TransactionDetailsPageByCode extends StatefulWidget {
 final Datum datum;
   TransactionDetailsPageByCode({super.key, required this.datum });

  @override
  State<TransactionDetailsPageByCode> createState() => _TransactionDetailsPageByCodeState();
}

class _TransactionDetailsPageByCodeState extends State<TransactionDetailsPageByCode> {
  late TransactionDetailsByCodeModel transactionDetailsByCodeModel;
  int isLoading=0;
  @override
  void initState() {
    _getTansactionDetailsByCode(widget.datum);
    SaveGeoTags apIs=SaveGeoTags();
    apIs.getTansactionDetailsByCode(context,"TransactionDetailsPageByCode",widget.datum.cspCode);
    super.initState();
  }
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
          'Transactions Details',
          style: TextStyle(color: Colors.white, fontSize: 15),
        ),
      ),
      body:  Column(
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
                          width: 1,
                        ),
                        Container(
                          height: 40,
                          width: 40,
                        ),
                        SizedBox(
                          width: 1,
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
                itemCount: transactionDetailsByCodeModel.data.length,
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
                                transactionDetailsByCodeModel.data[index].transactionType,
                                style: TextStyle(fontSize: 14, color: Colors.white),
                              ),)

                            ],
                          ),
                          Padding(padding: EdgeInsets.only(right: 15),
                            child: Column(
                              children: [
                                Text(
                                  "₹${transactionDetailsByCodeModel.data[index].numTransactionsOrAvgBal.toString()}",
                                  style: TextStyle(fontSize: 15, color: Colors.white),
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

  Future<void> _getTansactionDetailsByCode(Datum koData) {
    final api = Provider.of<ApiService>(context, listen: false);
    return api.getTransactionDetailsByCodeModel(koData.cspCode,koData.month,koData.year).then((value){

      if (value.statusCode==200) {
        setState(() {

          transactionDetailsByCodeModel=value;
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
