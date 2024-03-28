import 'package:new_bc_app/model/annualcspreport.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';
import '../network/api_service.dart';
import '../const/AppColors.dart';
import 'homepage.dart';

class CSPAnnualReportPage extends StatefulWidget {
  const CSPAnnualReportPage({super.key});

  @override
  State<CSPAnnualReportPage> createState() => _CSPAnnualReportPageState();
}

class _CSPAnnualReportPageState extends State<CSPAnnualReportPage> {
  CspAnnualReport cspAnnualReport =
      CspAnnualReport(statusCode: 100, message: "", data: []);
  @override
  void initState() {
    _getCSPAnnualReport();
  }
  int apiResponse = 1;
  AppColors appColors = new AppColors();
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
              Navigator.pop(context);
            },
          ),
          title: Text(
            'CSP Annual Reports',
            style: TextStyle(color: Colors.white,fontSize: 16),
          ),
        ),
        body:cspAnnualReport.data.length<1?(apiResponse == 1
            ? Center(
          child: Center(
            child: CircularProgressIndicator(
              color: Colors.white,
            ),
          ),
        )
            : Center()): ListView.builder(
          itemCount: cspAnnualReport.data.length, // Change this to the number of cards you want
          itemBuilder: (context, index) {
            return GestureDetector(child: Container(

              child: Card(
                elevation: 6,
                clipBehavior: Clip.antiAlias,
                color: Colors.white,

                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5)
                ),
                child: Container(
                  color: Colors.white,
                  padding: EdgeInsets.only(left: 10,right: 20,top: 8,bottom: 8),
                  alignment: Alignment.centerLeft,
                  child:Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(children: [
                        Container(height: 50,width: 50,child: Image(image: AssetImage("assets/images/pdf_ic.png")),)
                        ,
                        SizedBox(width: 10,),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                          Text(cspAnnualReport.data[index].year,style: TextStyle(fontSize: 16,color: Colors.grey.shade500),),
                          Text(cspAnnualReport.data[index].fileName,style: TextStyle(fontSize: 11,color: appColors.mainAppColor),),
                        ],)                     ],)
                      ,
                      Row(children: [
                        Icon(Icons.arrow_forward_ios_outlined,size: 15,color: Colors.grey.shade500,)
                      ],)

                    ],
                  ),),


                  // Add other widgets as needed

              ),
            ),
            onTap: (){
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => (AnnualReportPdfPage(pdfUrl:'https://erp.paisalo.in:981/losdoc/CSPApprovalDocs/${cspAnnualReport.data[index].fileName.toString().trim()}',year:cspAnnualReport.data[index].year)),
                ),
              );
            },);
          },
        ),

    );
  }

  Future<void> _getCSPAnnualReport() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    final api = Provider.of<ApiService>(context, listen: false);
    return api
        .getCSPAnnualReport(prefs.get('username').toString())
        .then((value) {
      if (value.data.length > 0) {
        setState(() {
          cspAnnualReport = value;
          print(
              "");
        });
      }else{
        setState(() {
          apiResponse=0;
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

class AnnualReportPdfPage extends StatefulWidget {
  final String pdfUrl;
  final String year;
  const AnnualReportPdfPage({super.key, required this.pdfUrl, required this.year});

  @override
  State<AnnualReportPdfPage> createState() => _AnnualReportPdfPageState();
}

class _AnnualReportPdfPageState extends State<AnnualReportPdfPage> {
  AppColors appColors=AppColors();
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
            Navigator.pop(context);
          },
        ),
        title: Text(
          'CSP Annual Report ${widget.year}',
          style: TextStyle(color: Colors.white,fontSize: 16),
        ),

      ),
      body:
      Container(
      child: PDF().cachedFromUrl(
      widget.pdfUrl,
      placeholder: (progress) => Center(child: Text('$progress %')),
      errorWidget: (error) => Center(child: Text(error.toString())),
      )
      )
    );
  }
}

