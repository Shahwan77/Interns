import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:int_tst/tst.dart';

import 'cartmethod/bottom_nav.dart';
import 'expense_section/expense_add_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home:
      // ImageListScreen(),
      BottomNav(),
    );
  }
}
