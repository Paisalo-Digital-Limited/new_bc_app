import 'package:new_bc_app/Model/loginresponse.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../const/AppColors.dart';
import '../const/common.dart';
import 'welcomepage.dart';



class Dashboard extends StatefulWidget {
  final LoginResponse loginResponse;
  Dashboard(this.loginResponse);

  //const Dashboard({Key? key}) : super(key: key);
  // final int _Id;
  // final String _loanNo;
  // const Dashboard(this._Id,this._loanNo);

  @override
  State<Dashboard> createState() => _DashboardState();
}
final List<String> imgList = [
  "assets/images/bannerback.png",
  "assets/images/bannerback.png",
  "assets/images/bannerback.png"
];
class _DashboardState extends State<Dashboard> {

  CommonAction commonAlert= CommonAction();
  // Data? data;
  // List<LoanEmi>? loanEmilist;
  bool pendingEmi=false;
  String loanAmount="";
  String loanDueDate="";
  AppColors appColors=new AppColors();


  /////////////////payment///////////////
  String _platformVersion = 'Unknown';
  String responseData = "Nothing";
  // final _isgpayuiPlugin = IsgpayuiPlugin();

  PageController controller = PageController();
  var currentPageValue = 0.0;

  //////////////////  LoanData  //////////////////////
  /*Future<Null> LoanDataDetails() async {
    EasyLoading.show(status: 'Loading');
    final api = Provider.of<ApiService>(context, listen: false);
    return await api
        .loandata(widget._loanNo)
        .then((result) {
      setState(() {
        EasyLoading.dismiss();
        if(result.statusCode==200){
          if(result.data != null){
            data=result.data;
            loanEmilist=result.data?.loanEmi;
            for (int i = 0; i <loanEmilist!.length; i++) {
              if(pendingEmi==false){
                if(loanEmilist![i].paid=="null"){
                  pendingEmi=true;
                  loanAmount=loanEmilist![i].amount;
                  loanDueDate=commonAlert.dateFormateSQLServer(context,loanEmilist![i].emiDueDate);
                }
              }
            }
          }else{
            commonAlert.messageAlertError(context,"Account ${result.message}. Please Login","Error");
          }
        }else{
          commonAlert.messageAlertError(context,"Account details not found","Error");
        }


      });
    }).catchError((error) {

      EasyLoading.dismiss();
      print(error);
    });
  }

*/
  @override
  void initState() {
    // LoanDataDetails();
    Navigator.push(
      context,
      CupertinoPageRoute(
        builder: (context) => WelocomeView(),
      ),
    );
    super.initState();
  }



  


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Paisalo Digital",style: TextStyle(fontFamily: 'Scada'),),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.logout,
              color: Colors.white,
            ),
            onPressed: () {
              // do something
            },
          )
        ],
      ),
      // drawer: Drawer(
      //     //child: // Populate the Drawer in the next step.
      // ),
      body: SingleChildScrollView(
        child: Column(
          children: [




          ],
        ),
      ),
    );
  }

  final List<Widget> imageSliders = imgList
      .map((item) => Container(
      decoration: BoxDecoration(),
      child: Image.asset(item)))
      .toList();
}