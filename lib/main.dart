import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled2/page/connecte.dart';
import 'package:untitled2/page/home.dart';

void main()async {
   WidgetsFlutterBinding.ensureInitialized();
  await SharedPreferences.getInstance();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? token = prefs.getString('token');

 runApp(MyApp(isLoggedIn: token != null));
}

class MyApp extends StatelessWidget {
  final bool isLoggedIn;

  const MyApp({Key? key, required this.isLoggedIn}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AuthProvider(isLoggedIn: isLoggedIn),
      child: MaterialApp(
        home: Consumer<AuthProvider>(
          builder: (context, authProvider, _) {
            // Vous pouvez conditionner l'affichage de différentes pages en fonction de l'état de connexion
            // Par exemple, si l'utilisateur est connecté, affichez la page Home, sinon, affichez la page LoginPage
            return authProvider.isLoggedIn ? Home() : SignForm();
          },
        ),
      ),
    );
  }
}

