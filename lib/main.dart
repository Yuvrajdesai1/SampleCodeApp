import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:nftapp/controllers/auth_controller.dart';
import 'package:nftapp/controllers/idea_controller.dart';
import 'package:nftapp/controllers/product_controller.dart';
import 'package:nftapp/screens/splashScreen.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // ----------- providers ------------
    return MultiProvider(
      providers: [
        ListenableProvider<ProductController>(
            create: (_) => ProductController()),
        ListenableProvider<AuthController>(
          create: (_) => AuthController(),
        ),
        ListenableProvider<IdeaController>(
          create: (_) => IdeaController(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        home: SplashScreen(),
      ),
    );
  }
}
