import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:http/http.dart'as http;
import 'package:new_bc_app/model/commonresponsemodelInt.dart';
import 'package:new_bc_app/network/api_service.dart';
import 'package:new_bc_app/views/transactionhistorypage.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:package_info/package_info.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:in_app_update/in_app_update.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'Utils/localnotificationservice.dart';
import 'model/appVersionModel.dart';
import 'views/login.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print("Handling a background message: ${message.messageId}");
}
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await Permission.notification.isDenied.then((value) {
    if (value) {
      Permission.notification.request();
    }else{
      print("Notification permission allowed");

    }
  });
  await Permission.location.isDenied.then((value) {
    if(value){
      Permission.location.request();
    }else{


    }
  });
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);


  await FirebaseAppCheck.instance.activate(
    // You can also use a `ReCaptchaEnterpriseProvider` provider instance as an
    // argument for `webProvider`
    webProvider: ReCaptchaV3Provider('recaptcha-v3-site-key'),
    // Default provider for Android is the Play Integrity provider. You can use the "AndroidProvider" enum to choose
    // your preferred provider. Choose from:
    // 1. Debug provider
    // 2. Safety Net provider
    // 3. Play Integrity provider
    androidProvider: AndroidProvider.debug,
    // Default provider for iOS/macOS is the Device Check provider. You can use the "AppleProvider" enum to choose
    // your preferred provider. Choose from:
    // 1. Debug provider
    // 2. Device Check provider
    // 3. App Attest provider
    // 4. App Attest provider with fallback to Device Check provider (App Attest provider is only available on iOS 14.0+, macOS 14.0+)
    appleProvider: AppleProvider.appAttest,
  );

  FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance; // Change here
  _firebaseMessaging.setAutoInitEnabled(true);
  SharedPreferences prefs = await SharedPreferences.getInstance();
  _firebaseMessaging.getToken().then((token){
    prefs.setString("GSMID", token!);
    print("token is $token");
  });
  LocalNotificationService.initialize();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  FirebaseMessaging.instance.getInitialMessage().then((message) {
    if(message != null){
      LocalNotificationService.display(message);
      print("getInitialMessage-     ${message}");

    }
  });

  ///forground work
  FirebaseMessaging.onMessage.listen((message) {
    if(message.notification != null){
      print(message.notification?.body);
      print(message.notification?.title);
      print("forground-     ${message.notification?.title}");


    }
    LocalNotificationService.display(message);

  });

  ///When the app is in background but opened and user taps
  ///on the notification
  FirebaseMessaging.onMessageOpenedApp.listen((message) {
    final routeFromMessage = message.data["data"];
    // Navigator.of(context).pushNamed(routeFromMessage);
    LocalNotificationService.display(message);
    print("background_OpenedApp-     ${message.notification?.title}");


  });
  runApp( MyApp());

}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Provider<ApiService>(
      create: (context)=>ApiService.create(),

      child: MaterialApp(
          title: '',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            // This is the theme of your application.
            //
            // TRY THIS: Try running your application with "flutter run". You'll see
            // the application has a blue toolbar. Then, without quitting the app,
            // try changing the seedColor in the colorScheme below to Colors.green
            // and then invoke "hot reload" (save your changes or press the "hot
            // reload" button in a Flutter-supported IDE, or press "r" if you used
            // the command line to start the app).
            //
            // Notice that the counter didn't reset back to zero; the application
            // state is not lost during the reload. To reset the state, use hot
            // restart instead.
            //
            // This works for code too, not just values: Most code changes can be
            // tested with just a hot reload.
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          builder: EasyLoading.init(),
          home:  MyHomePage(title: 'Home Page',)
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});



  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  @override
  void initState() {
    super.initState();
   // checkForUpdate();
    checkForLocalServerUpdate();
    // Timer(
    //   Duration(seconds: 5),
    //       () => Navigator.pushReplacement(
    //     context as BuildContext,
    //     MaterialPageRoute(
    //       builder: (context) => (Login()),
    //     ),
    //   ),
    // );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child:Image.asset('assets/images/logo.gif'),

          ),


        ],
      ),
    );
  }

  Future<void> checkForUpdate() async {
    try {
      await InAppUpdate.checkForUpdate().then((updateInfo) {
        if (updateInfo.updateAvailability == UpdateAvailability.updateAvailable) {
          if (updateInfo.immediateUpdateAllowed) {
            // Perform immediate update
            InAppUpdate.performImmediateUpdate().then((appUpdateResult) {
              if (appUpdateResult == AppUpdateResult.success) {
                // App Update successful
                print('Immediate update successful');
              }
            });
          } else if (updateInfo.flexibleUpdateAllowed) {
            // Perform flexible update
            InAppUpdate.startFlexibleUpdate().then((appUpdateResult) {
              if (appUpdateResult == AppUpdateResult.success) {
                // App Update successful
                InAppUpdate.completeFlexibleUpdate();
                print('Flexible update successful');
              }
            });
          }
        }
      });
    } catch (e) {
      print('Error checking for update: $e');
    }
  }

  Future<void> checkForLocalServerUpdate() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
  String appVersion = packageInfo.version;
  String buildNumber = packageInfo.buildNumber;
  print("App version ${appVersion}, Build Number ${buildNumber}");

    String baseUrl = 'https://erpservice.paisalo.in:980/PDL.Mobile.API/api';
    String endpoint = '/LiveTrack/GetAppLink';
    String queryParams = '?version=${appVersion}&AppName=B&action=1';
    String fullUrl = baseUrl + endpoint + queryParams;
    try {
      http.Response response = await http.get(Uri.parse(fullUrl));

      if (response.statusCode == 200) {
        Map<String, dynamic> responseData = json.decode(response.body);
        AppVersionModel appVersionModel = AppVersionModel.fromJson(responseData);
        if (appVersionModel.data is int) {
          int intValue = appVersionModel.data;
          print("Response for App Version ${intValue}");
          Timer(
            Duration(seconds: 5),
                () => Navigator.pushReplacement(
              context as BuildContext,
              MaterialPageRoute(
                builder: (context) => (Login()),
              ),
            ),
          );

        } else if (appVersionModel.data is String) {

          String stringValue = appVersionModel.data;
          print("Response for App Version ${stringValue}");

          _showUpdateDialog(context,stringValue.trim());
        } else {
          // Handle other types if necessary
        }
      } else {
        // Handle error
        print('Request failed with status: ${response.statusCode}');
      }
    } catch (e) {
      // Handle exception
      print('Exception occurred: $e');
    }
  }
  void _showUpdateDialog(BuildContext context,String url) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          elevation: 0,
          backgroundColor: Colors.white,
          title: Text('Update Available'),
          content: Text('A new version of the app is available. Please update to the latest version.\n\n**Copy link via copy button and paste it on your browser.'),
          actions: <Widget>[
            TextButton(
              child: Text('Copy Link'),
              onPressed: () async {

                  await Clipboard.setData(ClipboardData(text: "https://erpservice.paisalo.in:980/PDL.Mobile.Api/api/ApkApp/Csp"));
                  // copied successfully

                // Navigator.pushReplacement(
                //   context as BuildContext,
                //   MaterialPageRoute(
                //     builder: (context) => (MyWebView(url: url,)),
                //   ),
                // );
                //_launchURLBrowser('https://erpservice.paisalo.in:980/PDL.Mobile.Api/api/ApkApp/Csp');
              },
            ),
            TextButton(
              child: Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  _launchURLBrowser(String urls) async {
    var url = Uri.parse(urls);
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Could not launch $url';
    }
  }


  void _downloadFile(String url) async {
    try {
      // Send a GET request to the URL
      http.Response response = await http.get(Uri.parse(url));

      // Get the app's documents directory
      Directory appDocDir = await getApplicationDocumentsDirectory();

      // Create a new file in the documents directory with the same name as the downloaded file
      File file = File('${appDocDir.path}/downloaded_file.apk');

      // Write the downloaded bytes to the file
      await file.writeAsBytes(response.bodyBytes);

      // Show a message indicating that the file has been downloaded
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('File Downloaded'),
            content: Text('The file has been downloaded successfully.'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    } catch (e) {
      // Handle any errors that occur during the file download process
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('An error occurred while downloading the file: $e'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }
}







