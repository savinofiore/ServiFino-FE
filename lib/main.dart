import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:servifino/pages/worker/history_worker.dart';
import 'package:servifino/pages/worker/home_worker.dart';
import 'package:servifino/pages/worker/profile_worker.dart';
import 'package:servifino/providers/pagesProviders/edit_profile_owner_provider.dart';
import 'package:servifino/providers/pagesProviders/edit_profile_worker_provider.dart';
import 'package:servifino/providers/modelsProviders/owner_provider.dart';
import 'package:servifino/providers/pagesProviders/register_provider.dart';
import 'package:servifino/providers/modelsProviders/user_provider.dart';
import 'package:servifino/providers/modelsProviders/works_provider.dart';
import 'package:servifino/screens/authentication/login.dart';
import 'package:servifino/screens/authentication/register.dart';
import 'package:servifino/screens/landing/landing.dart';
import 'package:servifino/utils/app_routes.dart';
import 'package:servifino/utils/app_texts.dart';
import 'package:servifino/utils/app_themeData.dart';
import 'auth_router_wrapper.dart';
import 'firebase_options.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  // Inizializzazione binding Flutter
  WidgetsFlutterBinding.ensureInitialized();
  // Inizializzazione Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    MyApp(),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      // Inizializzazione providers
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => RegisterProvider()),
        ChangeNotifierProvider(create: (_) => ProfileEditProvider(user: null, works: null)),
        ChangeNotifierProvider(create: (_) => WorksProvider()),
        ChangeNotifierProvider(create: (_) => OwnerProvider()),
        ChangeNotifierProvider(create: (_) => EditOwnerProfileProvider(owner: null)),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: AppTexts.title,
        theme: ThemeData(
          primaryColor: MyTheme.primaryColor,
          scaffoldBackgroundColor: MyTheme.scaffoldBackgroundColor,
          appBarTheme: const AppBarTheme(
            backgroundColor: MyTheme.appBarBackgroundColor,
            titleTextStyle: TextStyle(
              color: MyTheme.appBarTitleColor,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          colorScheme: const ColorScheme.light(
            primary: MyTheme.primaryColor,
            secondary: MyTheme.textColor,
          ),
          bottomNavigationBarTheme: BottomNavigationBarThemeData(
            backgroundColor: MyTheme.bottomNavigationBarTheme.backgroundColor,
            selectedItemColor: MyTheme.bottomNavigationBarTheme.selectedItemColor,
            //unselectedItemColor: MyTheme.textColor,
          ),
        ),

        // Rotta iniziale
        initialRoute: AppRoutes.authWrapper,
        // Dichiarazione rotte
        routes: {
          AppRoutes.authWrapper: (context) => AuthWrapper(),
          AppRoutes.landing: (context) => LandingScreen(),
          AppRoutes.auth.login: (context) => LoginScreen(),
          AppRoutes.auth.register: (context) => RegisterScreen(),
          AppRoutes.worker.home: (context) => HomeWorker(
                user: null,
                works: null,
                reservations: [],
              ),
          AppRoutes.worker.profile: (context) =>
              ProfileWorker(user: null, works: null),
          AppRoutes.worker.history: (context) => HistoryWorker(
                user: null,
                works: null,
                reservations: [],
              ),
        },
      ),
    );
  }
}
