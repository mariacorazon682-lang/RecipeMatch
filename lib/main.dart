import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    // Try initializing with native google-services.json configuration first
    await Firebase.initializeApp();
  } catch (e) {
    debugPrint("Firebase default initialization info: $e");
    // Fallback manual options configuration for recipematch-54e75
    try {
      await Firebase.initializeApp(
        options: const FirebaseOptions(
          apiKey: "AIzaSyAsFakeKeyForCompilationEnsureProperSetup",
          appId: "1:1234567890:android:fakeappid123456",
          messagingSenderId: "1234567890",
          projectId: "recipematch-54e75",
            databaseURL: "https://your-new-project-id-default-rtdb.firebaseio.com/",
        ),
      );
    } catch (e2) {
      debugPrint("Firebase manual options initialization info: $e2");
    }
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'RecipeMatch',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF0D3E26)),
        useMaterial3: true,
      ),
      home: const LoginScreen(),
    );
  }

}
