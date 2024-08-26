
import 'dart:convert';
import 'dart:ui';

import 'package:new_bc_app/const/AppColors.dart';
import 'package:new_bc_app/model/commonresponsemodel.dart';
import 'package:new_bc_app/model/commonresponsemodelInt.dart';
import 'package:new_bc_app/model/loginresponse.dart';
import 'package:new_bc_app/views/homepage.dart';
import 'package:new_bc_app/views/operationselect.dart';
import 'package:new_bc_app/views/targetsetpage.dart';
import 'package:new_bc_app/views/dashboard.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../network/api_service.dart';
import '../const/common.dart';
import '../utils/SaveGeoTags.dart';
import 'dashboard.dart';
import 'welcomepage.dart';

class Login extends StatefulWidget {
  //const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}


class _LoginState extends State<Login> {

  TextEditingController nameController = new TextEditingController();
  TextEditingController mobileController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  TextEditingController mobileControllerlogin = new TextEditingController();
  TextEditingController passwordControllerlogin = new TextEditingController();
  TextStyle linkStyle = TextStyle(color: Colors.blue, decoration: TextDecoration.underline,fontSize: 12);
  TextStyle linkStyleOtp = TextStyle(color: Colors.redAccent, decoration: TextDecoration.underline,fontSize: 12);
  CommonAction commonAlert=new CommonAction();
  AppColors appColors=new AppColors();


  @override
  void initState() {
   _getAutoLogin();

    super.initState();

  }


  bool _isObscure = true;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
      FocusScopeNode currentFocus = FocusScope.of(context);
      if (!currentFocus.hasPrimaryFocus) {
        currentFocus.unfocus();
      }
    },child:Scaffold(
        backgroundColor: Colors.white,
        body:

        SingleChildScrollView(
          child:Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(height: MediaQuery.of(context).size.height / 5),
                Container(
                    height: 80.0,
                    margin: const EdgeInsets.symmetric(horizontal: 8),
                    child: Image.asset('assets/images/paisa_logo.png')),

                Padding(
                  padding: EdgeInsets.all(MediaQuery.of(context).size.height * 0.03),
                  child:Column(
                    children: [
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text('LOGIN',
                            style:TextStyle(color: Colors.redAccent,fontSize: 18,fontWeight: FontWeight.bold, fontFamily: 'Visbyfregular',),

                            // TextStyle(color: Colors.black,fontSize: 18.sp,fontFamily:'Abel'),
                            textAlign: TextAlign.start,
                          ),
                        ],
                      ),

                      const SizedBox(height: 10,),
                      const Row(
                        children: [

                          Text('Enter User Id',
                            style:TextStyle(color: Colors.redAccent,fontSize: 16, fontFamily: 'Visbyfregular',),
                            // TextStyle(color: Colors.black,fontSize: 18.sp,fontFamily:'Abel'),
                            textAlign: TextAlign.start,
                          ),
                        ],
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 5),
                        height: 50,
                        child:CupertinoTextField(
                          controller: mobileControllerlogin,
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          decoration: BoxDecoration(
                             // color: Colors.black12,
                              border: Border.all(
                                  color: Colors.redAccent,
                                  width: 1,
                              ),
                              borderRadius: BorderRadius.all(Radius.circular(2))
                          ),

                          clearButtonMode: OverlayVisibilityMode.editing,
                          maxLines: 1,
                          style: TextStyle(fontSize: 17),
                          placeholder: '',
                        ),
                      ),

                      SizedBox(height: 15,),
                      Row(
                        children: [
                          Text('Password',
                            style:TextStyle(color: Colors.redAccent,fontSize: 16, fontFamily: 'Visbyfregular',),
                            // TextStyle(color: Colors.black,fontSize: 18.sp,fontFamily:'Abel'),
                            textAlign: TextAlign.start,
                          ),
                        ],
                      ),

                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 5),
                        height: 50,
                        child:CupertinoTextField(
                          controller: passwordControllerlogin,
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.redAccent,
                                width: 1,
                              ),
                              borderRadius: BorderRadius.all(Radius.circular(5))
                          ),
                          clearButtonMode: OverlayVisibilityMode.editing,
                          obscureText: _isObscure,
                            suffix: IconButton(
                        icon: Icon(
                        _isObscure ? Icons.visibility : Icons.visibility_off),
                          onPressed: () {
                            setState(() {
                              _isObscure = !_isObscure;
                            });
                          }),
                          maxLines: 1,
                          style: TextStyle(fontSize: 17),
                          placeholder: '',
                        ),
                      ),

                      Container(
                          margin: const EdgeInsets.symmetric(horizontal: 0,vertical: 10),
                          child: Material(
                            elevation: 5.0,
                            borderRadius: BorderRadius.circular(5.0),
                            color: const Color(0xFFFF0741),
                            child: MaterialButton(
                              minWidth: MediaQuery.of(context).size.width,
                              height: 1,
                              padding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                              onPressed: () async {
                                // if(mobileControllerlogin.text.length<10){
                                //   commonAlert.showToast(context,"Enter Mobile");
                                // }else if(passwordControllerlogin.text.length<3){
                                //   commonAlert.showToast(context,"Enter Password");
                                // }else{

                                  _getLogin(mobileControllerlogin.text,passwordControllerlogin.text);

                                  // Navigator.push(context,
                                  //   MaterialPageRoute(builder: (context) =>  TargetSetPage()),
                                  // );
                              //  }
                              },
                              child: Text("SUBMIT",
                                textAlign: TextAlign.center,
                                style: TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.bold),
                              ),
                            ),
                          )
                      ),
                      // SizedBox(height: 5,),




                      Padding(
                        padding: EdgeInsets.all(MediaQuery.of(context).size.height * 0.01),
                        child:RichText(
                          textAlign: TextAlign.justify,
                          text: TextSpan(
                            style: TextStyle(color: Colors.black38,fontSize: 12,fontWeight: FontWeight.bold,fontFamily: 'Visby'
                                'fregular'),
                            children: <TextSpan>[
                              TextSpan(text: 'By Signing in, you indicate that you agreed to our '),
                              TextSpan(
                                  text: 'Terms of Service',
                                  style: linkStyle,
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      print('Terms of Service"');
                                    }),
                              TextSpan(text: ' and that you have read our '),
                              TextSpan(
                                  text: 'Privacy Policy',
                                  style: linkStyle,
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      print('Privacy Policy"');
                                    }),
                            ],
                          ),
                        ),
                      ),

                      /*Padding(
                        padding: EdgeInsets.all(MediaQuery.of(context).size.height * 0.01),
                        child:RichText(
                          textAlign: TextAlign.justify,
                          text: TextSpan(
                            style: TextStyle(color: Colors.black38,fontSize: 12,fontWeight: FontWeight.bold),
                            children: <TextSpan>[
                              TextSpan(text: 'New User? '),
                              TextSpan(
                                  text: 'Register here',
                                  style: linkStyleOtp,
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      setState(() {
                                       // _mobilelayout=true;
                                        //_loanlayout=false;
                                      });
                                      print('Terms of Service"');
                                    }),
                            ],
                          ),
                        ),
                      ),*/


                      // SizedBox(height: 30,),
                    ],
                  ),
                ),
              ],
            ),
          ),

        )


    ),
    );



    }

  Future<Null> _getLogin(String userName, String userPassword) async {
    EasyLoading.show(status: 'Loading...',);
    final api = Provider.of<ApiService>(context, listen: false);

    // try{

      return await api.getLogins(userName.trim(),userPassword.trim()).then((value) async {
        if(value.statusCode==200 && value.data!=null){

          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setString('username', userName.trim());
          prefs.setString('password', userPassword.trim());
          LoginResponse loginResponse=value;
          _saveGsmId(loginResponse,userName);
          SaveGeoTags apIs=SaveGeoTags();
          apIs.getTansactionDetailsByCode(context,"Login",userName);
          saveLoginDate(loginResponse);
          EasyLoading.dismiss();

        }else{
          EasyLoading.dismiss();

          QuickAlert.show(
            context: context,
            type: QuickAlertType.error,
            confirmBtnColor: appColors.mainAppColor,
            title: "Login Response",
            text: value.message,
            showConfirmBtn: true,
          );
        }


      }).catchError((error){
       if(error is DioError){
         EasyLoading.dismiss();
         // DioError is specific to Dio library for handling HTTP errors
         if (error.response != null) {
           // The request was made and the server responded with a status code
           // Extract the status code from the response
           int statusCode = error.response!.statusCode!;
           print('HTTP error status code: $statusCode');
           // Handle the error based on the status code
           if (statusCode == 401) {
             QuickAlert.show(
               context: context,
               type: QuickAlertType.error,
               confirmBtnColor: appColors.mainAppColor,
               title: "Login Response",
               text: "Unauthorized Asses",
               showConfirmBtn: true,
             );
           } else if (statusCode == 404) {
             QuickAlert.show(
               context: context,
               type: QuickAlertType.error,
               confirmBtnColor: appColors.mainAppColor,
               title: "Login Response",
               text: "Bad Request",
               showConfirmBtn: true,
             );
           } if (statusCode == 400) {
             QuickAlert.show(
               context: context,
               type: QuickAlertType.error,
               confirmBtnColor: appColors.mainAppColor,
               title: "Login Response",
               text: "Please check username or password",
               showConfirmBtn: true,
             );
           }
         } else {
           QuickAlert.show(
             context: context,
             type: QuickAlertType.error,
             confirmBtnColor: appColors.mainAppColor,
             title: "Login Response",
             text: "Please check internet connection!!",
             showConfirmBtn: true,
           );
         }
       } else {
         // Handle other types of errors (not DioError)
         QuickAlert.show(
           context: context,
           type: QuickAlertType.error,
           confirmBtnColor: appColors.mainAppColor,
           title: "Login Response",
           text: "An error occurred: $error",
           showConfirmBtn: true,
         );
       }


      });
    // }catch(_){
    //
    //   QuickAlert.show(
    //     context: context,
    //     type: QuickAlertType.error,
    //     confirmBtnColor: appColors.mainAppColor,
    //     title: "Login Response",
    //     text: 'Please check username password or Internet connection!!',
    //     showConfirmBtn: true,
    //   );
    // }


  }



    void saveLoginDate(LoginResponse loginResponse) async {
      // Use 'await' to wait for SharedPreferences.getInstance() to complete.
      SharedPreferences prefs = await SharedPreferences.getInstance();
      // Perform shared preferences operations after obtaining the instance.
      String loginObject = jsonEncode(loginResponse.toJson());
      prefs.setString('LoginResponse', loginObject);

      String? storedJsonString = prefs.getString('LoginResponse');
      if (storedJsonString != null) {

        Map<String, dynamic> storedJson = jsonDecode(storedJsonString);
        LoginResponse loginResponse = LoginResponse.fromJson(storedJson);
        getTarget(loginResponse);



      }
      EasyLoading.dismiss();
  }


  Future<Null> _saveGsmId(LoginResponse loginResponse,String userName) async {
      final api = Provider.of<ApiService>(context, listen: false);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      return await api.updateGsmid(
          "Bearer ${loginResponse.data.token}", userName,
          prefs.getString("GSMID")!).then((value) async {
        if (value != null) {

          CommonResponseModelInt loginResponse=value;
          //saveLoginDate(loginResponse);


        }
        EasyLoading.dismiss();
      });
    }

  Future<void> getTarget(LoginResponse loginResponse) async {
    final api = Provider.of<ApiService>(context, listen: false);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userName=prefs.getString('username');

    var now = DateTime.now();
    var monthFormat = DateFormat.MMMM(); // Month name format
    var yearFormat = DateFormat.y(); // Year format

    String monthName = monthFormat.format(now); // Getting current month name
    String year = yearFormat.format(now);
    
    return await api.getTarget(userName!, monthName,year).then((value){
      if(value.data.isNotEmpty){
        prefs.setString('monthlyTarget', value.data[0].targetCommAmt.toString());
        Navigator.pushReplacement(
          context,
          CupertinoPageRoute(
            builder: (context) => HomePage(loginResponse: loginResponse,username:userName),
          ),
        );
      }else{
        Navigator.pushReplacement(
          context,
          CupertinoPageRoute(
            builder: (context) => TargetSetPage(loginResponse: loginResponse,username:userName),
          ),
        );
      }
    });

  }

  Future<void> _getAutoLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userName=prefs.getString('username');
    String? password=prefs.getString('password');
    if(userName!.isNotEmpty && password!.isNotEmpty){
      _getLogin(userName!, password!);
    }
  }




}