import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:new_bc_app/const/AppColors.dart';
import 'package:new_bc_app/model/cSPKYCDocumentModel.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

import '../model/loginresponse.dart';
import '../network/api_service.dart';



class KYCUpdatePage extends StatefulWidget {
  final LoginResponse loginResponse;
  final String username;

  const KYCUpdatePage( this.loginResponse,  this.username);



  @override
  State<KYCUpdatePage> createState() => _KYCUpdatePageState();
}

class _KYCUpdatePageState extends State<KYCUpdatePage> {
  int isLoading=0;
  @override
  void initState() {
    getCSPKYCdocument();
    super.initState();
  }
  final ImagePicker _picker = ImagePicker();
  XFile? _panImage,
      _aadhaarImage,
      _iifbCertImage,
      _centerPicImage,
      _policeVerifiImage;

  Future<void> _getImage(int index) async {
    final pickedFile = await _picker.pickImage(
      source: ImageSource.camera, // Default to camera
    );

    if (pickedFile == null) return;

    setState(() {
      switch (index) {
        case 0:
          _panImage = pickedFile;
          break;

        case 1:
          _aadhaarImage = pickedFile;

          break;

        case 2:
          _iifbCertImage = pickedFile;

          break;

        case 3:
          _centerPicImage = pickedFile;

          break;

        case 4:
          _policeVerifiImage = pickedFile;

          break;
      }
    });
  }
  late CspkycDocumentModel cspkycDocumentModel;
  AppColors appColors = AppColors();
  List<String> docList = [
    "PAN",
    "AADHAAR",
    "IIBF Certificate",
    "Center Picture",
    "Police Verification"
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appColors.mainAppColor,
      appBar: AppBar(
        title: Text(
          "KYC Update",
          style: TextStyle(color: Colors.white),
        ),
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
              Icons.close,color: Colors.white
          ),
        ),
        backgroundColor: appColors.mainAppColor,
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child:Column(
          children: [
            Text("Upload your KYC Document",style: TextStyle(color: Colors.white,fontSize: 35,fontFamily: 'Visbybold'),),
           isLoading==1? Container(
              height: MediaQuery.of(context).size.height/2,
              child:
            ListView.builder(
                          itemCount: docList.length,
                          itemBuilder: (BuildContext context, int index) {
                            int recordFound=0;
                            int i=0;
                            for(i=0;i<cspkycDocumentModel.data.length;i++){
                              if(cspkycDocumentModel.data.elementAt(i).docType.toLowerCase().trim()==docList[index].replaceAll(" ", "").toLowerCase()){
                                recordFound=1;
                                break;
                              }

                            }

                            return recordFound==0?
                            Padding(
                              padding: EdgeInsets.all(6),
                              child:
                              GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => (UploadImagePage( docName: docList[index],loginResponse: widget.loginResponse,username: widget.username,)),
                                      ),
                                    );
                                    //await _showImageSourceBottomSheet(context, index);
                                  },
                                  child: Card(
                                    elevation: 6,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(6)),
                                    color: Colors.white,
                                    clipBehavior: Clip.antiAlias,
                                    child: Container(
                                      alignment: Alignment.center,

                                      height: 55,
                                      padding: EdgeInsets.all(15),
                                      color: Colors.white,
                                      width: MediaQuery.of(context).size.width,
                                      child:
                                      Text("${docList[index]}",style: TextStyle(color: appColors.mainAppColor,fontFamily: 'Visbyfregular',fontSize: 15),),
                                    ),
                                  ))
                            ): Padding(
                                padding: EdgeInsets.all(6),
                                child:Card(
                                  elevation: 6,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(6)),
                                  color: Colors.green,
                                  clipBehavior: Clip.antiAlias,
                                  child: Container(
                                    alignment: Alignment.center,

                                    height: 55,
                                    padding: EdgeInsets.all(15),
                                    color: Colors.green,
                                    width: MediaQuery.of(context).size.width,
                                    child:
                                    Text("${docList[index]} Uploaded",style: TextStyle(color: appColors.white,fontFamily: 'Visbyfregular',fontSize: 15),),
                                  ),
                                )
                            );
                          })
                          ,):CircularProgressIndicator(color: Colors.white,)
          ],
        ),
      ),
    );
  }

  
  
  _showImageSourceBottomSheet(BuildContext context,int index) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          color: Colors.white,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                title: Text('Camera'),
                onTap: () {
                  Navigator.pop(context);
                  _getImage(index);
                },
              ),
              Divider(),
              ListTile(
                title: Text('Gallery'),
                onTap: () async {
                  Navigator.pop(context);
                  final pickedFile = await _picker.pickImage(
                    source: ImageSource.gallery,
                  );
                  setState(() {
                    switch (index) {
                      case 0:
                        _panImage = pickedFile;
                        break;
                      case 1:
                        _aadhaarImage = pickedFile;
                        break;
                      case 2:
                        _iifbCertImage = pickedFile;
                        break;
                      case 3:
                        _centerPicImage = pickedFile;
                        break;
                      case 4:
                        _policeVerifiImage = pickedFile;
                        break;
                    }
                  });
                },
              ),
            ],
          ),
        );
      },
    );
  }
  getCorrectRow(int index) {
    switch (index) {
      case 0:
        return _panImage == null
            ? Row(
                children: [
                  Text(
                    "Choose file",
                    style: TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                  Icon(
                    Icons.upload_file_outlined,
                    size: 15,
                    color: Colors.grey,
                  )
                ],
              )
            :  Row(
          children: [
            Text(
              "File Picked",
              style: TextStyle(color: Colors.green, fontSize: 14),
            ),
            Icon(
              Icons.file_present_sharp,
              size: 15,
              color: appColors.green,
            )
          ],
        );

        break;

      case 1:
        return _aadhaarImage == null
            ? Row(
                children: [
                  Text(
                    "Choose file",
                    style: TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                  Icon(
                    Icons.upload_file_outlined,
                    size: 15,
                    color: Colors.grey,
                  )
                ],
              )
            :  Row(
          children: [
            Text(
              "File Picked",
              style: TextStyle(color: Colors.green, fontSize: 14),
            ),
            Icon(
              Icons.file_present_sharp,
              size: 15,
              color: appColors.green,
            )
          ],
        );

        break;

      case 2:
        return _iifbCertImage == null
            ? Row(
                children: [
                  Text(
                    "Choose file",
                    style: TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                  Icon(
                    Icons.upload_file_outlined,
                    size: 15,
                    color: Colors.grey,
                  )
                ],
              )
            :  Row(
          children: [
            Text(
              "File Picked",
              style: TextStyle(color: Colors.green, fontSize: 14),
            ),
            Icon(
              Icons.file_present_sharp,
              size: 15,
              color: appColors.green,
            )
          ],
        );

        break;

      case 3:
        return _centerPicImage == null
            ? Row(
                children: [
                  Text(
                    "Choose file",
                    style: TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                  Icon(
                    Icons.upload_file_outlined,
                    size: 15,
                    color: Colors.grey,
                  )
                ],
              )
            : Row(
          children: [
            Text(
              "File Picked",
              style: TextStyle(color: Colors.green, fontSize: 14),
            ),
            Icon(
              Icons.file_present_sharp,
              size: 15,
              color: appColors.green,
            )
          ],
        );

        break;

      case 4:
        return _policeVerifiImage == null
            ? Row(
                children: [
                  Text(
                    "Choose file",
                    style: TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                  Icon(
                    Icons.upload_file_outlined,
                    size: 15,
                    color: Colors.grey,
                  )
                ],
              )
            : Row(
                children: [
                  Text(
                    "File Picked",
                    style: TextStyle(color: Colors.green, fontSize: 14),
                  ),
                  Icon(
                    Icons.file_present_sharp,
                    size: 15,
                    color: appColors.green,
                  )
                ],
              );

        break;
    }
  }

  showImageWithImage(int index) {
    switch (index) {
      case 0:
        return (_panImage == null
            ? SizedBox(height: 100,
        child: Icon(Icons.image_not_supported,size: 50,color: appColors.mainAppColor,),)
            : Image.file(
                File(_panImage!.path),
                height: 100,
                fit: BoxFit.fitWidth,
              ));

        break;

      case 1:
        return (_aadhaarImage == null
            ? SizedBox(height: 100,
          child: Icon(Icons.image_not_supported,size: 50,color: appColors.mainAppColor,),)
            : Image.file(
                File(_aadhaarImage!.path),
                height: 100,
                fit: BoxFit.fitWidth,
              ));

        break;

      case 2:
        return (_iifbCertImage == null
            ? SizedBox(height: 100,
          child: Icon(Icons.image_not_supported,size: 50,color: appColors.mainAppColor,),)
            : Image.file(
                File(_iifbCertImage!.path),
                height: 100,
                fit: BoxFit.fitWidth,
              ));

        break;

      case 3:
        return (_centerPicImage == null
            ? SizedBox(height: 100,
          child: Icon(Icons.image_not_supported,size: 50,color: appColors.mainAppColor,),)
            : Image.file(
                File(_centerPicImage!.path),
                height: 100,
                fit: BoxFit.fitWidth,
              ));

        break;

      case 4:
        return (_policeVerifiImage == null
            ? SizedBox(height: 100,
          child: Icon(Icons.image_not_supported,size: 50,color: appColors.mainAppColor,),)
            : Image.file(
                File(_policeVerifiImage!.path),
                height: 100,
                fit: BoxFit.fitWidth,
              ));

        break;
    }
  }

  Future<void> getCSPKYCdocument() async {

    EasyLoading.show(status: 'Loading...',maskType: EasyLoadingMaskType.black);


    final api = Provider.of<ApiService>(context, listen: false);
    return await api.getCSPKYCdocument(widget.username).then((value) async {
      if(value.statusCode==200){
        setState(() {
          cspkycDocumentModel=value;
          isLoading=1;
        });

      }else{
        setState(() {
          cspkycDocumentModel=value;
          isLoading=1;
        });
      }
      EasyLoading.dismiss();

    }).catchError((_){ setState(() {
      cspkycDocumentModel=CspkycDocumentModel(statusCode: 200, message: "", data: []);
      isLoading=1;
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
      
    });
  }






}
class UploadImagePage extends StatefulWidget {
  final LoginResponse loginResponse;
  final String username;
  final String docName;
   UploadImagePage({super.key, required this.docName, required this.loginResponse, required this.username});

  @override
  State<UploadImagePage> createState() => _UploadImagePageState();
}

class _UploadImagePageState extends State<UploadImagePage> {
  final ImagePicker _picker = ImagePicker();
  AppColors appColors = AppColors();
  late File _pickedFile;
  int filePicked=0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appColors.mainAppColor,
      appBar: AppBar(
        title: Text(
          "Upload ${widget.docName}",
          style: TextStyle(color: Colors.white),
        ),
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
              Icons.close,color: Colors.white
          ),
        ),
        backgroundColor: appColors.mainAppColor,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              Text("Upload a photo of your ${widget.docName}", style: TextStyle(
                  color: Colors.white, fontSize: 35, fontFamily: 'Visbybold'),),
              SizedBox(height: 20,),
             filePicked==0? Card(
                elevation: 0,
                color: appColors.mainAppColor,
                clipBehavior: Clip.antiAlias,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: Container(
                  height: 200,
                  width: MediaQuery
                      .of(context)
                      .size
                      .width,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.white, width: 1)
                  ),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.image, color: Colors.white,),
                        Text("Selected file", style: TextStyle(color: Colors
                            .white, fontFamily: 'Visbyfregular', fontSize: 16),)
                      ],
                    ),
                  ),
                ),

              ):Card(
               elevation: 0,
               color: appColors.mainAppColor,
               clipBehavior: Clip.antiAlias,
               shape: RoundedRectangleBorder(
                 borderRadius: BorderRadius.circular(20.0),
               ),
               child: Container(
                 height: 200,
                 width: MediaQuery
                     .of(context)
                     .size
                     .width,
                 decoration: BoxDecoration(
                     borderRadius: BorderRadius.circular(20),
                     border: Border.all(color: Colors.white, width: 1)
                 ),
                 child: Image.file(_pickedFile,fit: BoxFit.fill,),
               ),

             ),

              SizedBox(height: 20,),
              Divider(height: 1, color: Colors.white,),
              SizedBox(height: 20,),
              GestureDetector(onTap: () async {
                final pickedFile = await _picker.pickImage(
                  source: ImageSource.camera, // Default to camera
                );
                File _imageFile=File(pickedFile!.path);
                double height=12;
                double width=8;
                if(widget.docName=="PAN")
                  {
                    height=3;
                    width=4.5;
                  }else if(widget.docName=="AADHAAR"){
                  height=3;
                  width=4.5;
                }

                _cropImage(_imageFile);
               

              }, child: Card(

                color: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5)

                ),
                child: Container(
                  height: 55,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.image, color: appColors.mainAppColor,),
                      SizedBox(width: 4,),
                      Text("Open Camera & Take Photo", style: TextStyle(
                          color: appColors.mainAppColor,
                          fontSize: 16,
                          fontFamily: 'Visbyfregular'),)
                    ],
                  ),
                ),),),

              SizedBox(height: 80,),
              GestureDetector(child:Card(

                color: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5)

                ),
                child: Container(
                  height: 55,
                  width: MediaQuery
                      .of(context)
                      .size
                      .width / 2,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("SUBMIT", style: TextStyle(
                          color: appColors.mainAppColor,
                          fontSize: 18,
                          fontFamily: 'Visbyfregular'),)
                    ],
                  ),
                ),) ,onTap: (){
                _sendImageToServer();
              },)
              ,


            ],
          ),
        ),
      ),
    );
  }

  showAlertDialog(BuildContext context,String msg,String docType) {

    QuickAlert.show(
        context: context,
        type: QuickAlertType.success,
        confirmBtnColor: appColors.mainAppColor,
        title: "${docType} Uploading Response",
        text: msg,
        showConfirmBtn: true,
        onConfirmBtnTap: (){
          Navigator.of(context).pop();
          Navigator.of(context).pop();
        }
    );
  }
  Future<void> _sendImageToServer() async {
    EasyLoading.show(status: 'Loading...',maskType: EasyLoadingMaskType.black);


    final api = Provider.of<ApiService>(context, listen: false);
    return await api.insertCspKycDocument(widget.username,widget.docName.replaceAll(" ", ""),true, _pickedFile).then((value) async {
      if(value.statusCode==200){
        showAlertDialog( context,value.message,widget.docName);
      }
      EasyLoading.dismiss();

    }).catchError((error){
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
              title: "${widget.docName} Uploading Response",
              text: "Unauthorized Asses",
              showConfirmBtn: true,
            );
          } else if (statusCode == 404) {
            QuickAlert.show(
              context: context,
              type: QuickAlertType.error,
              confirmBtnColor: appColors.mainAppColor,
              title: "${widget.docName} Uploading Response",
              text: "Bad Request",
              showConfirmBtn: true,
            );
          } if (statusCode == 400) {
            QuickAlert.show(
              context: context,
              type: QuickAlertType.error,
              confirmBtnColor: appColors.mainAppColor,
              title: "${widget.docName} Uploading Response",
              text: "Please check ASP code",
              showConfirmBtn: true,
            );
          }
        } else {
          QuickAlert.show(
            context: context,
            type: QuickAlertType.error,
            confirmBtnColor: appColors.mainAppColor,
            title: "${widget.docName} Uploading Response",
            text: "Please check internet connection!!",
            showConfirmBtn: true,
          );
        }
        EasyLoading.dismiss();

      } else {
        // Handle other types of errors (not DioError)
        QuickAlert.show(
          context: context,
          type: QuickAlertType.error,
          confirmBtnColor: appColors.mainAppColor,
          title: "${widget.docName} Uploading Response",
          text: "An error occurred: $error",
          showConfirmBtn: true,
        );
        EasyLoading.dismiss();

      }


    });

  }


  MemoryImage dynamicResponseToMemoryImage(dynamic response) {
    // Check if the response is of Uint8List type
    if (response is Uint8List) {
      // Create a MemoryImage from the binary data
      return MemoryImage(response);
    } else {
      throw ArgumentError('Response does not contain binary data');
    }
  }
  Future<FileImage> convertToFileImage(MemoryImage memoryImage) async {
    // Get bytes from MemoryImage
    Uint8List bytes = await memoryImage.bytes;

    // Create a temporary file
    Directory tempDir = await getTemporaryDirectory();
    File tempFile = File('${tempDir.path}/temp_image.png');

    // Write bytes to the file
    await tempFile.writeAsBytes(bytes);

    // Return a FileImage using the temporary file
    return FileImage(tempFile);
  }
  Future _cropImage(File imageFile) async {
    if (imageFile != null) {
      CroppedFile? cropped = await ImageCropper().cropImage(
          sourcePath: imageFile!.path,
          compressQuality: 100,
          maxHeight: 700,
          maxWidth: 700,
          compressFormat: ImageCompressFormat.jpg,

          uiSettings: [
          AndroidUiSettings(
          toolbarTitle: 'Crop',
          cropGridColor: Colors.black,
          initAspectRatio: CropAspectRatioPreset.original,
          lockAspectRatio: false),
          IOSUiSettings(title: 'Crop')
    ]);

    if (cropped != null) {
    setState(() {
      _pickedFile = File(cropped.path);
      filePicked=1;
    });
    }
  }
  }
}





