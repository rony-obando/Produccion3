import 'package:flutter/material.dart';
import 'package:frontendapp/config/themes/app_theme.dart';
import 'package:frontendapp/presentation/providers/MethodsProviders.dart';
import 'package:frontendapp/presentation/providers/push_notification_provider.dart';

import 'package:frontendapp/presentation/screens/Menu_Screen.dart';
import 'package:frontendapp/presentation/screens/login_screen.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

final pushnotification = pushNotificationProvider();
final navigatorKey = GlobalKey<NavigatorState>();


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
  options: DefaultFirebaseOptions.currentPlatform,
  
);
  await pushnotification.initNotifications();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
     // theme: AppTheme(selectedColor: 1).theme(),
      home: MyHomePage(),
    );
  }
}
class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MyHomePageState createState() => _MyHomePageState();
}


class _MyHomePageState extends State<MyHomePage>  {


@override
  Widget build(BuildContext context) {
    return MultiProvider
    (providers: [
      ChangeNotifierProvider(create: (_) => MethodsProvider())
    ],
    child: MaterialApp(
      title: 'Manejo Inventario',
      debugShowCheckedModeBanner: false,
      theme: AppTheme(selectedColor: 1).theme(),
      initialRoute: 'home',
      routes: {
        'home': (_) => const login_screen(),
        'Menu_Screen': (_) => const MenuSc()
      },
      
    )
    );
  }
}



