import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:oddo/res/routes/route_names.dart';
import 'package:oddo/res/routes/routes.dart';
import 'package:phone_email_auth/phone_email_auth.dart';

import 'constants.dart';

// @pragma('vm:entry-point')
// Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
//   await Firebase.initializeApp();
// }

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  // FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  PhoneEmail.initializeApp(clientId: phoneEmailClientId);
  // NotificationServices.initAwesomeNotificationsPlugin();
  // // PushNotifications().fireBaseInit();
  // NotificationServices.initIncomingNotifications();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 800),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            fontFamily: "poppins",
          ),
          defaultTransition: Transition.rightToLeft,
          transitionDuration: Duration(milliseconds: 300),
          initialRoute: RoutesName.loginScreen,
          getPages: Routes.appRoutes(),
        );
      },
    );
  }
}