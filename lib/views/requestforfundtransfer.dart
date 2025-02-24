import 'dart:typed_data';

import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_picker/image_picker.dart';
import 'package:new_bc_app/model/loginresponse.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_container.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'dart:io';
import 'package:path/path.dart' as path;

import '../network/api_service.dart';
import '../const/AppColors.dart';
import '../utils/SaveGeoTags.dart';

class RequestForFundTransfer extends StatefulWidget {
  final LoginResponse loginResponse;
  final String userName;
  const RequestForFundTransfer({super.key, required this.loginResponse, required this.userName});

  @override
  State<RequestForFundTransfer> createState() => _RequestForFundTransferState();
}

class _RequestForFundTransferState extends State<RequestForFundTransfer> {
  AppColors appColors = new AppColors();
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: appColors.mainAppColor,
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.white),
          backgroundColor: appColors.mainAppColor,
          leading: IconButton(
            icon: Icon(
              Icons.close,color: Colors.white, // Change the back icon here
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          title: Text(
            'Withdrawal and Deposite',
            style: TextStyle(color: Colors.white,fontSize: 16),
          ),
          bottom: TabBar(
            unselectedLabelColor: Colors.grey, // Color for unselected tab text
            labelColor: Colors.white,
            indicatorColor: Colors.white,
            tabs: [
              Tab(text: 'FUND WITHDRAWAL'),
              Tab(text: 'FUND DEPOSIT')
            ],
          ),
        ),
        body: TabBarView(
          children: [
            FundWithdrawalPage(loginResponse: widget.loginResponse,userName:widget.userName),
            FundDipositePage(loginResponse: widget.loginResponse,userName:widget.userName)
      
          ],
        ),
      ),
    );
  }
}


class FundDipositePage extends StatefulWidget {
  final LoginResponse loginResponse;
  final String userName;
  const FundDipositePage({super.key, required this.loginResponse, required this.userName});

  @override
  State<FundDipositePage> createState() => _FundDipositePageState();
}

class _FundDipositePageState extends State<FundDipositePage> {
  XFile? _image;

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      _image = pickedImage;
    });
  }
  AppColors appColors = new AppColors();
  TextEditingController depositeAmountController = new TextEditingController();
  TextEditingController cspCodeController = new TextEditingController();

    @override
  void initState() {
      SaveGeoTags apIs=SaveGeoTags();
      apIs.getTansactionDetailsByCode(context,"FundDepositPage",widget.userName);
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      cspCodeController.text=widget.userName;
    });
    return  SingleChildScrollView(
      child:    Center(
        child: Padding(
          padding: const EdgeInsets.only(left: 20,right: 20,top: 40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("CSP CODE",style: TextStyle(color: Colors.white,fontSize: 17),),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 5),
                height: 50,
                child:CupertinoTextField(
                  enabled: false,
                  controller: cspCodeController,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(2))
                  ),
                  clearButtonMode: OverlayVisibilityMode.editing,
                  keyboardType: TextInputType.text,
                  maxLines: 1,
                  style: TextStyle(fontSize: 17),
                  //placeholder: 'ENTER YOUR CODE',
                ),
              ),
              SizedBox(height: 30,),

              Text("AMOUNT",style: TextStyle(color: Colors.white,fontSize: 17),),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 5),
                height: 50,
                child:CupertinoTextField(
                  controller: depositeAmountController,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(2))
                  ),
                  clearButtonMode: OverlayVisibilityMode.editing,
                  keyboardType: TextInputType.number,

                  maxLines: 1,
                  style: TextStyle(fontSize: 17),
                  placeholder: 'ENTER YOUR AMOUNT',
                ),
              ),

              SizedBox(height: 30,),
              Text("DEPOSIT SLIP",style: TextStyle(color: Colors.white,fontSize: 17),),
            GestureDetector(child:        Container(
              color: Colors.white,
              margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 5),
              padding: EdgeInsets.only(left: 16),
              height: 50,
              child:_image==null?Row(
                children: [
                  Text("UPLOAD IMAGE LESS THAN 1 MB",style: TextStyle(color: Colors.grey.shade400,fontSize: 17),),
                  SizedBox(width: 8,),
                  Icon(Icons.cloud_upload_outlined,color: Colors.grey.shade400,)

                ],
              ):Row(
                children: [
                  Text("${_image!.name}",style: TextStyle(color: Colors.grey.shade400,fontSize: 17),),
                  SizedBox(width: 8,),
                  Icon(Icons.file_copy,color: appColors.mainAppColor,)

                ],
              ),
            ),onTap: (){
              _pickImage();


            },),
              SizedBox(height: 40,),

          GestureDetector(
            child: Container(
                color: Colors.white,
                margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 5),
                height: 50,
                child:Center(child: Text("SEND REQUEST",style: TextStyle(color:  appColors.mainAppColor,),))
            ),
            onTap: (){
              if(_image==null){
                final snackBar = SnackBar(
                  content: Text('Please upload slip'),
                  duration: Duration(seconds: 3),
                  action: SnackBarAction(
                    label: 'Close',
                    onPressed: () {
                      // Perform some action when 'Close' is pressed
                    },
                  ),
                );
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              }else if(depositeAmountController.text.isEmpty || int.parse(depositeAmountController.text)==0){
                QuickAlert.show(
                  context: context,
                  type: QuickAlertType.warning,
                  confirmBtnColor: appColors.mainAppColor,
                  title: "Amount not found",
                  text: 'Deposit amount not be blank or zero',
                  showConfirmBtn: true,
                  onConfirmBtnTap: (){
                    Navigator.of(context).pop();

                  }
              );}else{
                insertDepositRecord(widget.loginResponse.data.token,widget.loginResponse.data.name,cspCodeController.text,depositeAmountController.text,_image);
              }

            },
          )
              ,
            ],
          ),
        ),

      ),
    )

   ;
  }
  showAlertDialog(BuildContext context,String msg) {

    QuickAlert.show(
      context: context,
      type: QuickAlertType.success,
      confirmBtnColor: appColors.mainAppColor,
      title: "Fund Deposit!!",
      text: msg,
      showConfirmBtn: true,
      onConfirmBtnTap: (){
        Navigator.of(context).pop();
        Navigator.of(context).pop();
      }
    );
  }
  Future<int> getFileSize(File file) async {
    return await file.length();
  }
  Future<File> compressFile(File file) async {
    final filePath = file.absolute.path;
    final fileBytes = await file.readAsBytes();

    // Compress the file
    final compressedBytes = await FlutterImageCompress.compressWithList(
      fileBytes,
      minWidth: 800,  // Adjust based on your needs
      minHeight: 800, // Adjust based on your needs
      quality: 60,    // Adjust based on your needs
    );

    // Get the directory to save the compressed file
    final tempDir = await getTemporaryDirectory();
    final compressedFilePath = path.join(tempDir.path, 'compressed_${path.basename(filePath)}');
    final compressedFile = File(compressedFilePath);

    // Write the compressed bytes to the file
    await compressedFile.writeAsBytes(compressedBytes);

    return compressedFile;
  }
  Future<void> insertDepositRecord(String token, String name,String cspCode, String amount,XFile? image) async {
    EasyLoading.show(status: 'Data Sending...',maskType: EasyLoadingMaskType.black);
    final fileBytes = await image!.readAsBytes();
    final multipartFile = MultipartFile.fromBytes(
      fileBytes,
      filename: "Receipt"
    );
    final api = Provider.of<ApiService>(context, listen: false);

    File file = File(image!.path);
     final compressedBytes = await compressFile(file);

    return await api.uploadDepositeData( name, cspCode.trim(),amount.trim(),"D", "0" ,"1",compressedBytes).then((value) async {
      if(value.statusCode==200){
        showAlertDialog( context,value.message);
      }
    EasyLoading.dismiss();
    }).catchError((error){
      EasyLoading.dismiss();

      if(error is DioError){

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
              title: "Fund Deposit!!",
              text: "Unauthorized Asses",
              showConfirmBtn: true,
            );
          } else if (statusCode == 404) {
            QuickAlert.show(
              context: context,
              type: QuickAlertType.error,
              confirmBtnColor: appColors.mainAppColor,
              title: "Fund Deposit!!",
              text: "Bad Request",
              showConfirmBtn: true,
            );
          } if (statusCode == 400) {
            QuickAlert.show(
              context: context,
              type: QuickAlertType.error,
              confirmBtnColor: appColors.mainAppColor,
              title: "Fund Deposit!!",
              text: "Please check ASP code",
              showConfirmBtn: true,
            );
          }
        } else {
          QuickAlert.show(
            context: context,
            type: QuickAlertType.error,
            confirmBtnColor: appColors.mainAppColor,
            title: "Fund Deposit!!",
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
          title: "Fund Deposit!!",
          text: "An error occurred: $error",
          showConfirmBtn: true,
        );
      }


    });
  }
}


class FundWithdrawalPage extends StatefulWidget {
  final LoginResponse loginResponse;
  final String userName;

  const FundWithdrawalPage({super.key, required this.loginResponse, required this.userName});

  @override
  State<FundWithdrawalPage> createState() => _FundWithdrawalPageState();
}

class _FundWithdrawalPageState extends State<FundWithdrawalPage> {
  TextEditingController withDrawalAmountController = new TextEditingController();
  TextEditingController cspCodeController = new TextEditingController();

  AppColors appColors = new AppColors();

  @override
  void initState() {
    SaveGeoTags apIs=SaveGeoTags();
    apIs.getTansactionDetailsByCode(context,"FundWithdrawalPage",widget.userName);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    setState(() {
      cspCodeController.text=widget.userName;
    });
    return SingleChildScrollView(
      child:  Center(
        child: Padding(
          padding: const EdgeInsets.only(left: 20,right: 20,top: 40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("CSP CODE",style: TextStyle(color: Colors.white,fontSize: 17),),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 5),
                height: 50,
                child:CupertinoTextField(
                  enabled: false,
                  controller: cspCodeController,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(2))
                  ),
                  clearButtonMode: OverlayVisibilityMode.editing,
                  keyboardType: TextInputType.text,

                  maxLines: 1,
                  style: TextStyle(fontSize: 17),
                 // placeholder: 'ENTER YOUR CODE',
                ),
              ),
              SizedBox(height: 30,),

              Text("AMOUNT",style: TextStyle(color: Colors.white,fontSize: 17),),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 5),
                height: 50,
                child:CupertinoTextField(
                  controller: withDrawalAmountController,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(2))
                  ),
                  clearButtonMode: OverlayVisibilityMode.editing,
                  keyboardType: TextInputType.number,

                  maxLines: 1,
                  style: TextStyle(fontSize: 17),
                  placeholder: 'ENTER YOUR AMOUNT',
                ),
              ),
              SizedBox(height: 35,),


              GestureDetector(
                child: Container(
                    color: Colors.white,
                    margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 5),
                    height: 50,
                    child:Center(child: Text("SEND REQUEST",style: TextStyle(color:  appColors.mainAppColor,),))
                ),
                onTap: (){

                  if(withDrawalAmountController.text.isEmpty || int.parse(withDrawalAmountController.text)==0){
                    QuickAlert.show(
                        context: context,
                        type: QuickAlertType.warning,
                        confirmBtnColor: appColors.mainAppColor,
                        title: "Amount not found",
                        text: 'withdrawal amount not be blank or zero',
                        showConfirmBtn: true,
                        onConfirmBtnTap: (){
                          Navigator.of(context).pop();

                        }
                    );
                  }else{
                    insertWithDrawalRecord(widget.loginResponse.data.token,cspCodeController.text,withDrawalAmountController.text);

                  }




                }
                ,
              )
              ,
            ],
          ),
        ),

      ),
    )

     ;
  }
  showAlertDialog(BuildContext context) {
    QuickAlert.show(
      context: context,
      type: QuickAlertType.success,
      confirmBtnColor: appColors.mainAppColor,
      title: "Fund Withdrawal",
      text: 'Request sent successfully!!',
      showConfirmBtn: true,
      onConfirmBtnTap: (){
        Navigator.of(context).pop();
        Navigator.of(context).pop();
      }
    );

    // set up the button
    // Widget okButton = TextButton(
    //   child: Text("OK"),
    //   onPressed: () { },
    // );
    //
    // // set up the AlertDialog
    // AlertDialog alert = AlertDialog(
    //   title: Text("Fund Deposit"),
    //   content: Text("Your request has been submitted!!"),
    //   actions: [
    //     okButton,
    //   ],
    // );
    //
    // // show the dialog
    // showDialog(
    //   context: context,
    //   builder: (BuildContext context) {
    //     return alert;
    //   },
    // );
  }

  Future<void> insertWithDrawalRecord(String token,String cspCode, String amount) async {
    EasyLoading.show(status: 'Data Sending...',maskType: EasyLoadingMaskType.black);
    final api = Provider.of<ApiService>(context, listen: false);

    return await api.uploadWithDrawalData( "Bearer $token", cspCode.trim(),amount.trim(),"W", "0" ,"1").then((value) async {
      if(value.data==1){
        showAlertDialog( context);
      }
      EasyLoading.dismiss();

    }).catchError((error){
      EasyLoading.dismiss();

      if(error is DioError){

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
              title: "Fund Withdrawal",
              text: "Unauthorized Asses",
              showConfirmBtn: true,
            );
          } else if (statusCode == 404) {
            QuickAlert.show(
              context: context,
              type: QuickAlertType.error,
              confirmBtnColor: appColors.mainAppColor,
              title: "Fund Withdrawal",
              text: "Bad Request",
              showConfirmBtn: true,
            );
          } if (statusCode == 400) {
            QuickAlert.show(
              context: context,
              type: QuickAlertType.error,
              confirmBtnColor: appColors.mainAppColor,
              title: "Fund Withdrawal",
              text: "Please check ASP code",
              showConfirmBtn: true,
            );
          }
        } else {
          QuickAlert.show(
            context: context,
            type: QuickAlertType.error,
            confirmBtnColor: appColors.mainAppColor,
            title: "Fund Withdrawal",
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
          title: "Fund Withdrawal",
          text: "An error occurred: $error",
          showConfirmBtn: true,
        );
      }


    });
  }
}





