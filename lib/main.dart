import 'package:cianfafire/firestore/presentation/home_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cianfafire/_core/my_colors.dart';
import 'authentication/screens/auth_screen.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());

  FirebaseFirestore firestore = FirebaseFirestore.instance;
  firestore.collection("Só para testar").doc("Estou testando").set({
    "funcionou?": true,
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Listin - Lista Colaborativa",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // primarySwatch: MyColors.brown,
        scaffoldBackgroundColor: Colors.white,
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: MyColors.red,
        ),
        listTileTheme: const ListTileThemeData(
          iconColor: MyColors.blue,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.deepPurple,
          toolbarHeight: 72,
          centerTitle: true,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(32),
            ),
          ),
          titleTextStyle: TextStyle(
            color: Colors.white, // Define a cor do texto como branco
            fontSize: 22, // Tamanho da fonte
            fontWeight: FontWeight.bold, // Peso da fonte
          ),
        ),
      ),
      home: const RoteadorTelas(),
    );
  }
}

class RoteadorTelas extends StatelessWidget {
  const RoteadorTelas({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.userChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else {
          if (snapshot.hasData) {
            return HomeScreen(
              user: snapshot.data!,
            );
          } else {
            return const AuthScreen();
          }
        }
      },
    );
  }
}
