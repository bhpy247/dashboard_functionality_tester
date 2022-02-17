import 'package:dashboard_functionality_tester/screens/homeScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firedart/firestore/firestore.dart';
import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart';
/// Initialize with a secondary app until dart-only initialization is merged.
FirebaseOptions get firebaseOptions => const FirebaseOptions(
  appId: '1:448618578101:ios:0b650370bb29e29cac3efc',
  apiKey: 'AIzaSyAgUhHU8wSJgO5MVNy95tMT07NEjzMOfz0',
  projectId: 'testing-project-2200b',
  messagingSenderId: '436026096379',
  authDomain: 'https://react-native-firebase-testing.firebaseapp.com',
);
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await windowManager.ensureInitialized();

  await Firebase.initializeApp(options: firebaseOptions);
  Firestore.initialize("testing-project-2200b");
  // await FirebaseAuth.instance.useAuthEmulator('localhost', 9099);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme:ThemeData.dark(),
      home: const HomeScreen(),
    );
  }
}
