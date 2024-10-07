import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:intl/intl.dart';
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
 final String monthYear;
   CSPAnnualReportPage({required this.monthYear});

  @override
  State<CSPAnnualReportPage> createState() => _CSPAnnualReportPageState();
}

class _CSPAnnualReportPageState extends State<CSPAnnualReportPage> {
  CspAnnualReport cspAnnualReport =
      CspAnnualReport(statusCode: 100, message: "", data: []);
  int selectedYear = DateTime.now().year;
  String selectedMonth = '';
  final List<String> months = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December'
  ];
  void _showMonthDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Theme(
            data: ThemeData.dark().copyWith(
          dialogBackgroundColor: Colors.white, // Ensure bright white background
        ), child: AlertDialog(
          backgroundColor: Colors.white,
          title: Text('Select a Month',style: TextStyle(color: appColors.mainAppColor)),
          content: Container(
            // Adjust the height as needed
            height: 300.0,
            width: double.maxFinite,
            child: ListView.separated(
              separatorBuilder: (BuildContext context, int index) => Divider(
                color: Colors.grey, // Separator color
              ),
              itemCount: months.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  height: 40,
                  child: ListTile(
                    leading: Icon(Icons.date_range_sharp,size: 20,color: appColors.mainAppColor,),
                    title: Text(months[index],style: TextStyle(color: appColors.mainAppColor),),
                    onTap: () {
                      Navigator.pop(context);
                      _getCSPAnnualReport(months[index]);
                    },
                  ),
                );
              },
            ),
          ),
        ),);
      },
    );
  }


  @override
  void initState() {
    var now = DateTime.now();
    var monthFormat = DateFormat.MMMM();
    String monthName = monthFormat.format(now);

    _getCSPAnnualReport(widget.monthYear.split(" ")[0]);
  }
  int apiResponse = 1;
  AppColors appColors = new AppColors();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: appColors.white,
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
            'CSP Ledger ${widget.monthYear}',
            style: TextStyle(color: Colors.white,fontSize: 16),
          ),
        ),
        body:cspAnnualReport.data.length<1? Center(
          child: Center(
            child: CircularProgressIndicator(
              color: Colors.white,
            ),
          ),
        ):SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(width: 150,
                        padding: EdgeInsets.only(right:10),
                        child:   Image.asset("assets/images/logo.png"),)


                    ],),
                  Padding(padding: EdgeInsets.only(left: 20)),
                  Text("Banking Monthly Ledger",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),)
                  , SizedBox(height: 8),
                  Text("Date: ${DateFormat('yyyy-MM-dd').format(DateTime.now())}"),
                  Text("Month: ${widget.monthYear.split(" ")[0]}, Year: ${widget.monthYear.split(" ")[1]}"),
                  Text("CSP Code: ${cspAnnualReport.data[0].cspCode}"),
                  Text("CSP Name: ${cspAnnualReport.data[0].cspName}"),
                  Text("Circle Name: ${cspAnnualReport.data[0].circleName}"),
                  SizedBox(height: 16),
                  CustomTable(data: cspAnnualReport.data),
                  SizedBox(height: 16),
                  Text("For and on behalf of Paisalo This is a system-generated report and does not require any signature",style: TextStyle(fontWeight: FontWeight.bold),),

                ],
              ),

            ),
          ),
        )


    );
  }

  Future<void> _getCSPAnnualReport(String monthName) async {
    EasyLoading.show(status: 'Loading...',);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var now = DateTime.now();
    var monthFormat = DateFormat.MMMM(); // Month name format
    var yearFormat = DateFormat.y(); // Year format

 // Getting current month name
    String year = yearFormat.format(now);
    final api = Provider.of<ApiService>(context, listen: false);
    return api
        .getCSPAnnualReport(prefs.get('username').toString(),monthName,year)
        .then((value) {
      if (value.data.length > 0) {
        setState(() {
          cspAnnualReport = value;
          print(
              "");
        });
        EasyLoading.dismiss();
      }else{
        setState(() {
         cspAnnualReport= CspAnnualReport(statusCode: 100, message: "", data: []);
          apiResponse=0;
        });
        EasyLoading.dismiss();

        QuickAlert.show(
            context: context,
            type: QuickAlertType.error,
            title: 'Oops...',
            text: 'Sorry, no record found',
            backgroundColor: Colors.white,
            titleColor: appColors.mainAppColor,
            textColor: appColors.mainAppColor,
            confirmBtnColor: appColors.mainAppColor,
          onConfirmBtnTap: (){
              Navigator.of(context).pop();
              Navigator.of(context).pop();
          }
        );
      }
    });
  }




}
class _MonthPickerDialog extends StatefulWidget {
  final String selectedMonth;

  _MonthPickerDialog({
    required this.selectedMonth,
  });

  @override
  __MonthPickerDialogState createState() => __MonthPickerDialogState();
}

class __MonthPickerDialogState extends State<_MonthPickerDialog> {
  late String selectedMonth;

  @override
  void initState() {
    super.initState();
    selectedMonth = widget.selectedMonth;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Select Month'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          DropdownButton<String>(
            value: selectedMonth,
            items: <String>[
              'January', 'February', 'March', 'April',
              'May', 'June', 'July', 'August',
              'September', 'October', 'November', 'December'
            ].map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            onChanged: (String? value) {
              setState(() {
                selectedMonth = value!;
              });
            },
          ),
        ],
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(selectedMonth);
          },
          child: Text('OK'),
        ),
      ],
    );
  }
}
class CustomTable extends StatelessWidget {
  final List<Datum> data;

  CustomTable({required this.data});

  @override
  Widget build(BuildContext context) {
    return Table(
      columnWidths: {
        0: FractionColumnWidth(0.09),  // 10% of the table width
        1: FractionColumnWidth(0.36),  // 50% of the table width
        2: FractionColumnWidth(0.2),  // 20% of the table width
        3: FractionColumnWidth(0.2),  // 20% of the table width
        4: FractionColumnWidth(0.15),  // 20% of the table width
      },
      border: TableBorder.all(width: .3),
      children: [
        TableRow(
          decoration: BoxDecoration(color: Colors.grey[200]),
          children: [
            tableCell('S.No', isHeader: true,),
            tableCell('Description with Code', isHeader: true),
            tableCell('TXN Count', isHeader: true),
            tableCell('Commission Amount', isHeader: true),
            tableCell('GST @18%', isHeader: true),
          ],
        ),
        ...data.asMap().entries.map((entry) {
          int index = entry.key;
          Datum record = entry.value;
          return TableRow(
            children: [
              tableCell((index + 1).toString()),
              tableCell(record.transactionType),
              tableCell(record.numTransactionsOrAvgBal.toString()),
              tableCell(record.payableToCsp.toString()),
              tableCell(record.gst.toString()),
            ],
          );
        }).toList(),
        TableRow(
          decoration: BoxDecoration(color: Colors.white),
          children: [
            tableCell('', isHeader: false),
            tableCell('', isHeader: false),
            tableCell('Total Commission', isHeader: true),
            tableCell("${data.fold(0.00, (sum, item) => sum + item.payableToCsp.toDouble()).toStringAsFixed(2)}", isHeader: true),
            tableCell('', isHeader: false),

          ],
        ),      TableRow(
          decoration: BoxDecoration(color: Colors.white),
          children: [
            tableCell('', isHeader: false),
            tableCell('', isHeader: false),
            tableCell('Applicable TDS (1%)', isHeader: true),
            tableCell("${(data.fold(0.0, (sum, item) => sum + item.payableToCsp.toDouble()) * 0.01).toStringAsFixed(2)}", isHeader: true),
            tableCell('', isHeader: false),

          ],
        ),
        TableRow(
          decoration: BoxDecoration(color: Colors.white),
          children: [
            tableCell('', isHeader: false),
            tableCell('', isHeader: false),
            tableCell('GST @18%', isHeader: true),
            tableCell("${(data.fold(0.0, (sum, item) => sum + item.gst.toDouble())).toStringAsFixed(2)}", isHeader: true),
            tableCell('', isHeader: false),

          ],
        ),

        TableRow(
          decoration: BoxDecoration(color: Colors.white),
          children: [
            tableCell('', isHeader: false),
            tableCell('', isHeader: false),
            tableCell('Payable Commission', isHeader: true),
            tableCell("${((data.fold(0.0, (sum, item) => sum + item.payableToCsp.toDouble()) * 0.99)-(data.fold(0.0, (sum, item) => sum + item.gst.toDouble()))).toStringAsFixed(2)}", isHeader: true),
            tableCell('', isHeader: false),

          ],
        ),
      ],
    );
  }

  Widget tableCell(String text, {bool isHeader = false}) {
    return Container(
      padding: EdgeInsets.all(4),
      child: Text(
        text,
        style: TextStyle(
          fontWeight: isHeader ? FontWeight.bold : FontWeight.normal,
          fontSize: isHeader ? 10 : 10,
        ),
        textAlign: TextAlign.left,
      ),
    );
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

