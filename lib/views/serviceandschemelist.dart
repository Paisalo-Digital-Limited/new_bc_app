import 'dart:convert';

import 'package:new_bc_app/model/loginresponse.dart';
import 'package:new_bc_app/const/AppColors.dart';
import 'package:new_bc_app/model/servicelistmodel.dart';
import 'package:new_bc_app/model/slablistmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toggle_list/toggle_list.dart';

import '../network/api_service.dart';
import 'homepage.dart';

class ServiceAndSchemeList extends StatefulWidget {
  final LoginResponse loginResponse;
  final String username;

  ServiceAndSchemeList( this.loginResponse, this.username);

  @override
  _ServiceAndSchemeListState createState() => _ServiceAndSchemeListState();
}

class _ServiceAndSchemeListState extends State<ServiceAndSchemeList> {
  AppColors appColors = new AppColors();
  final List<String> serviceList = [
    'Service 1',
    'Service 2',
    'Service 3',
    // Add more services
  ];

  final List<String> schemeList = [
    'Scheme 1',
    'Scheme 2',
    'Scheme 3',
    // Add more schemes
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3, // Number of tabs
      child: Scaffold(
        backgroundColor: appColors.mainAppColor,
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(
              Icons.close,color: Colors.white, // Change the back icon here
            ),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => HomePage(loginResponse: widget.loginResponse, username: widget.username)),
              );
            },
          ),
          iconTheme: IconThemeData(color: Colors.white),
          backgroundColor: appColors.mainAppColor,
          title: Text(
            'Services and Schemes',
            style: TextStyle(color: Colors.white),
          ),
          bottom: TabBar(
            labelStyle: TextStyle(fontSize: 10,fontWeight: FontWeight.bold),
            unselectedLabelColor: Colors.grey, // Color for unselected tab text
            labelColor: Colors.white,
            indicatorColor: Colors.white,
            tabs: [
              Tab(text: 'SERVICES',),
              Tab(text: 'SCHEMES'),
              Tab(text: 'SPECIAL SERVICES')
            ],
          ),
        ),
        body: TabBarView(
          children: [
            ServicePage(),
            SchemesPage(),
            SpecialServicesPage()
          ],
        ),
      ),
    );
  }
}

class ServicePage extends StatefulWidget {
  const ServicePage({super.key});

  @override
  State<ServicePage> createState() => _ServicePageState();
}

class _ServicePageState extends State<ServicePage> {

ServiceListModel serviceListModel=new ServiceListModel(statusCode: 100 , message: "", data: []);
int apiResponse=1;
AppColors appColors=new AppColors();
  @override
  void initState() {
    _getServicePage();
  }
  @override
  Widget build(BuildContext context) {

    AppColors appColors=new AppColors();


    return Scaffold(
      backgroundColor: appColors.mainAppColor,
      body: !serviceListModel.data.isEmpty
          ?Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: ToggleList(
          divider: const SizedBox(height: 10),
          toggleAnimationDuration: const Duration(milliseconds: 400),
          scrollPosition: AutoScrollPosition.begin,
          trailing: const Padding(
            padding: EdgeInsets.all(10),
            child: Icon(Icons.expand_more),
          ),
          children: List.generate(
            serviceListModel.data.length,
                (index) => ToggleListItem(
              title: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      serviceListModel.data[index].name,
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge!
                          .copyWith(fontSize: 15, fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
              divider: const Divider(
                color: Color(0xFFEFEFEF),
                height: 1,
                thickness: 1,
              ),
              content: Container(
                margin: const EdgeInsets.only(bottom: 10),
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.vertical(
                    bottom: Radius.circular(10),
                  ),
                  color: Colors.white,
                ),
                child:
                Container(
                  constraints: BoxConstraints(
                    maxHeight: 80, // Example
                  ),
                  child: ListView.builder(
                    itemCount: serviceListModel.data[index].data.length, // Example number of rows
                    itemBuilder: (BuildContext context, int indexs) {
                      return   Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'upto ₹${serviceListModel.data[index].data[indexs].rangeA} - ₹${serviceListModel.data[index].data[indexs].rangeB}',
                            style: TextStyle(color: Colors.grey.shade500),
                          ),
                          Text('₹${serviceListModel.data[index].data[indexs].maxAmt}',
                              style: TextStyle(color: Colors.grey.shade500))
                        ],
                      );
                    },
                  ),
                ),
              ),
              onExpansionChanged: _expansionChangedCallback,
              headerDecoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(1)),
              ),
              expandedHeaderDecoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(10),
                ),
              ),
            ),
          ),
        ),
      ) :(apiResponse==1? Center(
        child: Center(
          child: CircularProgressIndicator(
            color: Colors.white,
          ),
        ),
      ): Center(

      ))
    );
  }

 Future<void> _getServicePage() async {
    try{
      SharedPreferences prefs = await SharedPreferences.getInstance();
      // Perform shared preferences operations after obtaining the instance.

      final api = Provider.of<ApiService>(context, listen: false);
      return api
          .getServiceList()
          .then((value) {
        if (value.data.isNotEmpty) {
          setState(() {
            serviceListModel = value;
          });
          apiResponse=1;
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
              confirmBtnColor: appColors.mainAppColor
          );

        }
      });
    }catch(_){
      apiResponse=0;
      QuickAlert.show(
          context: context,
          type: QuickAlertType.error,
          title: 'Oops...',
          text: 'Sorry, no record found',
          backgroundColor: Colors.white,
          titleColor: appColors.mainAppColor,
          textColor: appColors.mainAppColor,
          confirmBtnColor: appColors.mainAppColor

      );
    }
  }
}


class SpecialServicesPage extends StatelessWidget {
  AppColors appColors = new AppColors();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appColors.mainAppColor,
      body: Center(
        child: Card(

          clipBehavior: Clip.antiAlias,
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white
            ),
            height: 340,
            width: 300,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 160,
                  width: 160,
                  child: Image.asset("assets/images/qr_ic.png"),
                ),

                Text("Open your\nDemat Account",textAlign: TextAlign.center, style: TextStyle(
                    fontSize: 22, fontFamily: 'Visbyfregular',),)
              

              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Item {
  final String id;
  bool isExpanded;

  Item({required this.id, this.isExpanded = false});
}

List<Item> generateItems(int numberOfItems) {
  return List.generate(numberOfItems, (int index) {
    return Item(id: '$index');
  });
}

class SchemesPage extends StatefulWidget {
  const SchemesPage({super.key});

  @override
  State<SchemesPage> createState() => _SchemesPageState();
}

class _SchemesPageState extends State<SchemesPage> {


  AppColors appColors = new AppColors();

  Color appColor = Color.fromRGBO(225, 195, 64, 1);

  SlabListModel slabList=new SlabListModel(statusCode: 100, message: "", data: []);

  @override
  void initState() {
        super.initState();
       _getSlabList();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appColors.mainAppColor,
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Text(
              'EARN EXTRA COMMISSION',
              style: TextStyle(fontSize: 20, color: Colors.white),
            ),
            Container(
                alignment: Alignment.center,
                padding: EdgeInsets.only(left: 30, right: 30),
                child: Text(
                  'Earn more on top of individual product commissions\nas you complete each level',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16, color: Colors.white),
                )),
            Expanded(
              child:slabList.data.length>1? ListView.builder(
                itemCount: slabList.data.length,
                itemBuilder: (context, index) {
                  return SlabCustomList( slabListData: slabList.data[index],index:index);
                },
              ):Center(child: CircularProgressIndicator(color: Colors.white,),),
            ),
          ],
        ),
      ),
    );
  }

  Future<Null> _getSlabList() {
    final api = Provider.of<ApiService>(context, listen: false);
    return api.getAllSlabList()
        .then((value) {
      if (value.data.isNotEmpty) {
        setState(() {
          slabList = value;
        });
      }
    });
  }




}
class SlabCustomList extends StatefulWidget {
  final SlabListData slabListData;
  final int index;
  const SlabCustomList({super.key, required this.slabListData, required this.index});

  @override
  State<SlabCustomList> createState() => _SlabCustomListState();
}

class _SlabCustomListState extends State<SlabCustomList> {
  AppColors appColors=new AppColors();
  @override
  Widget build(BuildContext context) {
    return  Container(
      height: 155,
      margin: EdgeInsets.all(3),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: widget.index==0?AssetImage('assets/images/list_card_bg.png'):AssetImage('assets/images/list_card_grey_bg.png'), // Replace with the actual image path
          fit: BoxFit.fitWidth,
        ),
      ),
      padding: EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Flex(
            direction: Axis.horizontal,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Text(
                    '${widget.slabListData.slab}',
                    style: TextStyle(
                        fontSize: 20, color: Colors.white,fontWeight: FontWeight.bold),
                    textAlign: TextAlign.start,
                  ),
                ),
                flex: 1,
              ),
              Expanded(
                child: Text(
                  'Earn Extra ₹${widget.slabListData.incentive}',
                  style: TextStyle(
                      color: Colors.white, fontSize: 16),
                  textAlign: TextAlign.start,
                ),

                flex: 3,
              )
            ],
          ),
          Flex(
            direction: Axis.horizontal,
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'SCHEMES',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'TARGETS',
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    )
                  ],
                ),
                flex: 1,
              ),
              Expanded(
                  child: Column(
                    children: [
                      Text(
                        'PMJDY',
                        style: TextStyle(
                            color: Colors.white, fontSize: 12),
                        textAlign: TextAlign.center,
                      ),
                      Card(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius:
                          BorderRadius.circular(15.0),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(
                            left: 10,
                            right: 10,
                          ),
                          child: Container(
                            width: 30,
                            child: Center(
                              child: Text(
                                "${widget.slabListData.pmjdy}",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 15,
                                    color: widget.index==0?
                                    appColors.mainAppColor:appColors.grey),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  flex: 1),
              Expanded(
                  child: Column(
                    children: [
                      Text(
                        'PMJJBY',
                        style: TextStyle(
                            color: Colors.white, fontSize: 12),
                        textAlign: TextAlign.center,
                      ),
                      Card(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius:
                          BorderRadius.circular(15.0),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(
                            left: 10,
                            right: 10,),
                          child: Container(
                            width: 30,
                            child: Center(
                              child: Text(
                                "${widget.slabListData.pmjjby}",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 15,
                                    color:
                                    widget.index==0?
                                    appColors.mainAppColor:appColors.grey),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  flex: 1),
              Expanded(
                  child: Column(
                    children: [
                      Text(
                        'PMSBY',
                        style: TextStyle(
                            color: Colors.white, fontSize: 12),
                        textAlign: TextAlign.center,
                      ),
                      Card(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius:
                          BorderRadius.circular(15.0),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(
                            left: 10,
                            right: 10,),
                          child: Container(
                            width: 30,
                            child: Center(
                              child: Text(
                                "${widget.slabListData.pmsby}",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 15,
                                    color:
                                    widget.index==0?
                                    appColors.mainAppColor:appColors.grey),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  flex: 1),
              Expanded(
                  child: Column(
                    children: [
                      Text(
                        'APY',
                        style: TextStyle(
                            color: Colors.white, fontSize: 12),
                        textAlign: TextAlign.center,
                      ),
                      Card(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius:
                          BorderRadius.circular(15.0),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(
                            left: 10,
                            right: 10,),
                          child: Container(
                            width: 30,
                            child: Center(
                              child: Text(
                                "${widget.slabListData.apy}",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 15,
                                    color:
                                    widget.index==0?
                                    appColors.mainAppColor:appColors.grey),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  flex: 1)
            ],
          ),
        ],
      ),
    );
  }
}


void _expansionChangedCallback(int index, bool newValue) {
  print(
      'Changed expansion status of item  no.${index + 1} to ${newValue ? "expanded" : "shrunk"}.');
}

