import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fule_and_vm_app/utils/utils.dart';
import 'package:fule_and_vm_app/views/auth/login_screen.dart';
import 'package:fule_and_vm_app/views/on_boarding_screen/onboarding_screen.dart';
import 'package:get/get.dart';

class Sidebar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.indigo,
            ),
            child: Text(
              'Menubar',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.exit_to_app,),
            title: const Text('Logout', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),),
            onTap: () async {
              await FirebaseAuth.instance.signOut();
              Utils().toastMessage("Logout Successful");
              Get.offAll(() => OnBoarding_Screen()); // Navigate to login screen after logout
            },
          ),
        ],
      ),
    );
  }
}
