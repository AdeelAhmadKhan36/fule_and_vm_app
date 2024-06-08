import 'package:flutter/material.dart';
import 'package:fule_and_vm_app/widgets/app.dart';

class JoinScreen extends StatefulWidget {
  const JoinScreen({super.key});

  @override
  State<JoinScreen> createState() => _JoinScreenState();
}

class _JoinScreenState extends State<JoinScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: RoundedAppBar(
        title: Text("Join Screen"),


      ),
      body: Column(children: [

        ElevatedButton(onPressed: (){


    },
            child: Text("Join App")),
      ],),
    );
  }
}
