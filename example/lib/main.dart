import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:ola_maps_autofill/ola_maps_autofill.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        body: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Autofill",
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
                const Gap(5),
                SearchField(
                  apiKey: 'YourApiKey',
                  onChanged: (value) {
                    log((value?.toJson()).toString());
                  },
                ),
                const Gap(15),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
