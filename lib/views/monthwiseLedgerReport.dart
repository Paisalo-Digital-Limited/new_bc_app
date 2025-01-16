import 'package:flutter/material.dart';
import 'package:new_bc_app/const/AppColors.dart';
import 'package:new_bc_app/views/csp_annual_report.dart';

class monthwiseledgerReport extends StatefulWidget {
  const monthwiseledgerReport({super.key});

  @override
  State<monthwiseledgerReport> createState() => _MonthWiseledgerReportState();
}

class _MonthWiseledgerReportState extends State<monthwiseledgerReport> {
  AppColors appColors = AppColors();
  List<String> dropdownOptions = ['2023', '2024', '2025'];
  String selectedYear = DateTime.now().year.toString();
  String selectedPeriod = '2025';
  bool isDataAvailable = true;
  String errorMessage = '';

  @override
  void initState() {
    super.initState();
    selectedPeriod = dropdownOptions.first;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appColors.white,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: appColors.mainAppColor,
        leading: IconButton(
          icon: Icon(Icons.close, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'CSP Annual Ledger Reports',
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
      ),
      body: Container(
        color: appColors.mainAppColor,
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [

            Row( mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [  Container(
              child: Text(
                'Select a Year',
                style: TextStyle(color: Colors.white, fontSize: 20, fontFamily: 'Visbyfregular'),
              ),
            ),
              Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        icon: Icon(Icons.arrow_left, color: Colors.white),
                        onPressed: () {
                          int currentIndex = dropdownOptions.indexOf(selectedYear);
                          if (currentIndex > 0) {
                            setState(() {
                              selectedYear = dropdownOptions[currentIndex - 1];
                            });
                          }
                        },
                      ),
                      Text(
                        selectedYear,
                        style: TextStyle(
                          color:  Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.arrow_right, color: Colors.white),
                        onPressed: () {
                          int currentIndex = dropdownOptions.indexOf(selectedYear);
                          if (currentIndex < dropdownOptions.length - 1) {
                            setState(() {
                              selectedYear = dropdownOptions[currentIndex + 1];
                            });
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),],),



            Container(
              child: Text(
                'Click on a month',
                style: TextStyle(color: Colors.white, fontSize: 20, fontFamily: 'Visbyfregular'),
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(left: 20, right: 20, top: 10),
                child: MonthList(
                  selectedYear: selectedYear,
                  selectedMonth: selectedPeriod,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MonthList extends StatelessWidget {
  final String selectedYear;
  final String selectedMonth;

  MonthList({required this.selectedYear, required this.selectedMonth});

  @override
  Widget build(BuildContext context) {
    List<String> months = [
      'January', 'February', 'March', 'April', 'May', 'June',
      'July', 'August', 'September', 'October', 'November', 'December'
    ];

    return ListView.separated(
      separatorBuilder: (BuildContext context, int index) => const Divider(),
      itemCount: months.length,
      itemBuilder: (context, index) {
        String month = months[index];
        String monthYear = '$month $selectedYear';
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => csp_annual_report(
                  monthYear: monthYear,
                  selectedYear: selectedYear,
                  selectedMonth: month,
                ),
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
              SizedBox(width: 10),
              Text(
                monthYear,
                style: TextStyle(color: Colors.white, fontSize: 22, fontFamily: 'Visbyfregular'),
              ),
            ],
          ),
        );
      },
    );
  }
}
