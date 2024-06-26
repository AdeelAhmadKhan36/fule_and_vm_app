import 'package:flutter/material.dart';
import 'package:fule_and_vm_app/controllers/SignUp_Provider.dart';
import 'package:fule_and_vm_app/controllers/login_provider.dart';
import 'package:fule_and_vm_app/controllers/profile_updateProvider.dart';
import 'package:fule_and_vm_app/home_screen.dart';
import 'package:fule_and_vm_app/views/Admin/admin_dashboard.dart';
import 'package:fule_and_vm_app/views/Admin/admin_profile.dart';
import 'package:fule_and_vm_app/views/Location_Screen.dart';
import 'package:fule_and_vm_app/views/auth/login_screen.dart';
import 'package:fule_and_vm_app/views/on_boarding_screen/onboarding_screen.dart';
import 'package:fule_and_vm_app/views/splash_Screen.dart';
import 'package:fule_and_vm_app/views/vehicle_maintenance/maintenance_homepage.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'controllers/on_boarding_providers.dart';
import 'firebase_options.dart';



void main() async{

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());

}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => loginNotifier()),
        ChangeNotifierProvider(create: (_) => SignUpNotifier()),
        ChangeNotifierProvider(create: (_) => changeprofileNotifier()),
        ChangeNotifierProvider(create: (_) => onBoard_Notifier()),

      ],
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints){
          return GetMaterialApp(


            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
              useMaterial3: true,

            ),
            home:OnBoarding_Screen(),
          );
        } ,

      ),
    );
  }
}