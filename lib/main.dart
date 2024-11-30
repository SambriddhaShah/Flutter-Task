import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lipstick/Routes/routes.dart';
import 'package:lipstick/Routes/routesGenerator.dart';
import 'package:lipstick/Service/firebase_service.dart';
import 'package:lipstick/firebase_options.dart';
import 'package:lipstick/utils/hexColor.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await FirebaseService().initNotifications();
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'LipStick',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: HexColor('#f4dace')),
        iconTheme: const IconThemeData(color: Colors.white),
        useMaterial3: true,
      ),
      initialRoute: Routes.SplashScreen,
      onGenerateRoute: RouteGenerator().generateRoute,
      // home: const ManageWifiPage(),
    );
  }
}
