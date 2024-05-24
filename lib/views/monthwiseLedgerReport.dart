import 'package:flutter/material.dart';
import 'package:new_bc_app/const/AppColors.dart';
import 'package:new_bc_app/views/csp_annual_report.dart';

class MonthWiseledgerReport extends StatefulWidget {
  const MonthWiseledgerReport({super.key});

  @override
  State<MonthWiseledgerReport> createState() => _MonthWiseledgerReportState();
}

class _MonthWiseledgerReportState extends State<MonthWiseledgerReport> {


  AppColors appColors=AppColors();
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
          'CSP Annual Ledger Reports',
          style: TextStyle(color: Colors.white,fontSize: 16),
        ),
      ),
      body: Container(
        color: appColors.mainAppColor,
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            Container(
              child: Text('Select a month',style: TextStyle(color: Colors.white,fontSize: 40,fontFamily: 'Visbyfregular'),),
            ),
            Container(
              height: MediaQuery.of(context).size.height/1.3,
              child:  Padding(
                padding: EdgeInsets.only(left: 20,right: 20,top: 20),
                child:  MonthList(),
              ),
            )

          ],
        ),
      ),
    );
  }
}
class MonthList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Get the current year
    int currentYear = DateTime.now().year;

    // List of month names
    List<String> months = [
      'January', 'February', 'March', 'April', 'May', 'June',
      'July', 'August', 'September', 'October', 'November', 'December'
    ];

    // Generate the list of months with the current year
    List<String> monthList = months.map((month) => '$month $currentYear').toList();

    return ListView.separated(
      separatorBuilder: (BuildContext context, int index) => const Divider(),
      itemCount: monthList.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: (){
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => (CSPAnnualReportPage(monthYear: monthList[index])),
              ),
            );
          },
          child: Row(
            children: [
              ImageIcon(
                AssetImage("assets/images/ic_cal.png"),
                color: Colors.white,
                size: 24,
              ),
              SizedBox(width: 10,),
              Text("${monthList[index]}",style: TextStyle(color: Colors.white,fontSize: 22,fontFamily: 'Visbyfregular'),)
            ],
          ),
        );
      },
    );
  }
}
