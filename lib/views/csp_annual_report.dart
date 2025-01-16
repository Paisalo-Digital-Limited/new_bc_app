import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:new_bc_app/model/annualcspreport.dart';
import 'package:provider/provider.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../network/api_service.dart';
import '../const/AppColors.dart';

class csp_annual_report extends StatefulWidget {
  final String monthYear;
  final String selectedYear;
  final String selectedMonth;

  csp_annual_report({
    required this.monthYear,
    required this.selectedYear,
    required this.selectedMonth,
  });

  @override
  State<csp_annual_report> createState() => _CSPAnnualReportPageState();
}

class _CSPAnnualReportPageState extends State<csp_annual_report> {
  CspAnnualReport cspAnnualReport =
  CspAnnualReport(statusCode: 100, message: "", data: []);
  int apiResponse = 1;
  AppColors appColors = new AppColors();

  @override
  void initState() {
    super.initState();
    // Fetch the report data based on the selected month and year
    _getCSPAnnualReport(widget.selectedMonth, widget.selectedYear);
  }

  Future<void> _getCSPAnnualReport(String monthName, String yearName) async {
    EasyLoading.show(status: 'Loading...');
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final api = Provider.of<ApiService>(context, listen: false);
    return api
        .getCSPAnnualReport(prefs.get('username').toString(), monthName, yearName)
        .then((value) {
      if (value.data.isNotEmpty) {
        setState(() {
          cspAnnualReport = value;
        });
        EasyLoading.dismiss();
      } else {
        setState(() {
          cspAnnualReport = CspAnnualReport(statusCode: 100, message: "", data: []);
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
          onConfirmBtnTap: () {
            Navigator.of(context).pop();
            Navigator.of(context).pop();
          },
        );
      }
    }).catchError((onError){
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
        onConfirmBtnTap: () {
          Navigator.of(context).pop();
          Navigator.of(context).pop();
        },
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appColors.white,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: appColors.mainAppColor,
        leading: IconButton(
          icon: Icon(
            Icons.close,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'CSP Ledger ${widget.monthYear}',
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
      ),
      body: cspAnnualReport.data.isEmpty
          ? Center(
        child: CircularProgressIndicator(
          color: Colors.white,
        ),
      )
          : SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    width: 150,
                    padding: EdgeInsets.only(right: 10),
                    child: Image.asset("assets/images/logo.png"),
                  ),
                ],
              ),
              SizedBox(height: 8),
              Text(
                "Banking Monthly Ledger",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              SizedBox(height: 8),
              Text("Date: ${DateFormat('yyyy-MM-dd').format(DateTime.now())}"),
              Text("Month: ${widget.selectedMonth}, Year: ${widget.selectedYear}"),
              Text("CSP Code: ${cspAnnualReport.data[0].cspCode}"),
              Text("CSP Name: ${cspAnnualReport.data[0].cspName}"),
              Text("Circle Name: ${cspAnnualReport.data[0].circleName}"),
              SizedBox(height: 16),
              CustomTable(data: cspAnnualReport.data),
              SizedBox(height: 16),
              Text(
                "For and on behalf of Paisalo This is a system-generated report and does not require any signature",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
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
        0: FractionColumnWidth(0.09),
        1: FractionColumnWidth(0.36),
        2: FractionColumnWidth(0.2),
        3: FractionColumnWidth(0.2),
        4: FractionColumnWidth(0.15),
      },
      border: TableBorder.all(width: .3),
      children: [
        TableRow(
          decoration: BoxDecoration(color: Colors.grey[200]),
          children: [
            tableCell('S.No', isHeader: true),
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
        ),
        TableRow(
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
            tableCell("${((data.fold(0.0, (sum, item) => sum + item.payableToCsp.toDouble()) * 0.99) - (data.fold(0.0, (sum, item) => sum + item.gst.toDouble()))).toStringAsFixed(2)}", isHeader: true),
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
