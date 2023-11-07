import 'package:flutter/material.dart';

import 'mail_chimp_helper.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: Center(
          child: Text('Hello World!'),
        ),
      ),
    );
  }

  Future<void> mainChimpIt(param) async {
    MailChimpHelper mailChim = MailChimpHelper();
    await mailChim.addSubscriber(param);
  }
}
