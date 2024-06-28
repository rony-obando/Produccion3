import 'package:flutter/material.dart';
import 'package:frontendapp/config/domain/entities/Componente.dart';
import 'package:frontendapp/config/domain/entities/Producto.dart';
import 'package:frontendapp/config/domain/entities/union.dart';
import 'package:frontendapp/config/themes/app_theme.dart';
import 'package:frontendapp/presentation/children/kanbanes_child.dart';
import 'package:frontendapp/presentation/providers/Eoq_Provider.dart';
import 'package:frontendapp/presentation/providers/Mc_provider.dart';
import 'package:frontendapp/presentation/providers/inventory_rotation.provider.dart';
import 'package:frontendapp/presentation/providers/kanbanes_provider.dart';
import 'package:frontendapp/presentation/providers/local_notification_provider.dart';
import 'package:frontendapp/presentation/providers/login_provider.dart';
import 'package:frontendapp/presentation/providers/ltc_luc_provider.dart';
import 'package:frontendapp/presentation/providers/menus_provider.dart';
import 'package:frontendapp/presentation/providers/numbercontainer_provider.dart';
import 'package:frontendapp/presentation/providers/planeacion_provider.dart';
import 'package:frontendapp/presentation/providers/product_provider.dart';
import 'package:frontendapp/presentation/providers/push_notification_provider.dart';
import 'package:frontendapp/presentation/screens/Menu_others.dart';
import 'package:frontendapp/presentation/screens/login_screen.dart';
import 'package:frontendapp/presentation/screens/menu_mrp.dart';
import 'package:frontendapp/presentation/screens/options_screen.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:permission_handler/permission_handler.dart';


final pushnotification = pushNotificationProvider();
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

Componente findComponentById(int idComponente) {
  return componentes.firstWhere((c) => c.idComponente == idComponente);
}

void addSubcomponentes(Componente componente) {
  // Encuentra todas las uniones donde este componente es el padre
  var relevantUnions = unions
      .where((u) => u.idPadre == componente.idComponente && !u.PadreEsProducto)
      .toList();
  for (var union in relevantUnions) {
    // Encuentra el componente hijo correspondiente
    Componente subcomponente = findComponentById(union.idHijo);
    // Asegúrate de no añadir un subcomponente si ya está añadido
    if (!componente.subcomponentes
        .any((c) => c.idComponente == subcomponente.idComponente)) {
      componente.subcomponentes.add(subcomponente);
      // Recursivamente añade los subcomponentes de este subcomponente
      addSubcomponentes(subcomponente);
    }
  }
}

List<Componente> fetchComponentsOfProduct(int idProducto) {
  List<Componente> components = [];

  // Encontrar todas las uniones donde el producto es el padre
  var productUnions = unions
      .where((u) => u.idPadre == idProducto && u.PadreEsProducto)
      .toList();
  for (var union in productUnions) {
    // Encuentra el componente inicial
    Componente component = findComponentById(union.idHijo);
    components.add(component);
    // Recursivamente añade subcomponentes
    addSubcomponentes(component);
  }

  return components;
}

List<Producto> productos = [];
List<Componente> componentes = [];
List<Union> unions = [];

void main() async {
  
  WidgetsFlutterBinding.ensureInitialized();
  tz.initializeTimeZones();
  await initNotifications();
  
  
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await Supabase.initialize(
    url: 'https://posnkutxiizhumolqrxo.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InBvc25rdXR4aWl6aHVtb2xxcnhvIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MTM5ODk1MTQsImV4cCI6MjAyOTU2NTUxNH0.VY1kdn2ULW84WheJZbS96qWThzzk96a3ef6F8a-e4h0',
  );
//  await pushnotification.initNotifications();

  if (await Permission.notification.request().isGranted) {
    runApp(MyApp());
  } else {
    print('Permisos de notificación denegados');
  }

  
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {



    
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => LoginProvider()),
          ChangeNotifierProvider(create: (_) => Mc_provider()),
          ChangeNotifierProvider(create: (_) => Inventoryprovider()),
          ChangeNotifierProvider(create: (_) => Eoq_Provider()),
          ChangeNotifierProvider(create: (_) => ProductProvider()),
          ChangeNotifierProvider(create: (_) => MenusProvider()),
          ChangeNotifierProvider(create: (_) => LtcLucProvider()),
          ChangeNotifierProvider(create: (_) => NumberContainerProvider()),
          ChangeNotifierProvider(create: (_) => KanbanesProvider()),
          ChangeNotifierProvider(create: (_) => PlaneacioProvider()),
          
        ],
        builder: (context, _) {
          return MaterialApp(
            title: 'Manejo Inventario',
            debugShowCheckedModeBanner: false,
            theme: AppTheme(selectedColor: 1).theme(),
            initialRoute: 'home',
            routes: {
              'home': (_) =>  login_screen(),
              'Menu_Screen': (_) => MenuSc(),
              'MRP_Screen': (_) => MrpScreen(),
              'Optiosn_Screen': (_) => optionsScreen(),
              'Kanbanes': (_) => const KanbanesChild()
            },
          );
        });
  }
}
