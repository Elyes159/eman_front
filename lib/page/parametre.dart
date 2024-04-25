import 'package:flutter/material.dart';
import 'package:untitled2/page/confidentalite.dart';
import 'package:untitled2/page/page/aide.dart';
import 'package:untitled2/page/page/langage.dart';
import 'package:untitled2/page/profile.dart';
import 'package:untitled2/page/propos.dart';
import 'sidebar.dart'; 
import 'package:untitled2/page/notification.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF006583),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(100),
        child: ClipRRect(
          child: AppBar(
            backgroundColor: Color(0xFF006583),
            title: Container(
              child: Transform.translate(
                offset: Offset(-60.0, 0.0),
                child: Transform.scale(
                  scale: 0.7,
                  child: Image.asset('assets/images/logo.jpg'),
                ),
              ),
            ),
             iconTheme: IconThemeData(
              size: 52, // Adjust the size of the drawer icon here
              color: Colors.white, // Adjust the color of the drawer icon here
            ),

           
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 255, 255, 255),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(50),
            topRight: Radius.circular(50),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: Icon(Icons.arrow_back),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  Expanded(
                    child: Center(
                      child: Transform.translate(
                        offset: Offset(-23, 0.0), // Translation horizontale
                        child: Text(
                          'Paramètre',
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Expanded(
                child: SettingsPage(), // Intégration de la page de paramètres ici
              ),
            ],
          ),
        ),
      ),
      endDrawer: NavBar(), // Utiliser endDrawer pour afficher le drawer à droite
    );
  }
}

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool isDarkThemeEnabled = false; // État initial du thème

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(16.0),
      children: [
        // Catégorie "Compte"
        Container(
          child: ListTile(
            title: Text(
              'Compte',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 29, 29, 29),
              ),
            ),
          ),
        ),

        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
          ),
          child: ListTile(
            leading: Icon(Icons.account_circle, color: Colors.black),
            title: Text('Information personnelle'),
            subtitle: Text('Modifier votre compte'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Profile()),
              );
            },
          ),
        ),

        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
          ),
          child: ListTile(
            leading: Icon(Icons.notifications, color: Colors.black),
            title: Text('Notifications'),
            subtitle: Text(''),
            onTap: () {
            Navigator.push(
  context,
  MaterialPageRoute(builder: (context) => Notificationpage()),
);

             
            },
          ),
        ),

        // Catégorie "Interface"
        Container(
          child: ListTile(
            title: Text(
              'Interface',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: const Color.fromARGB(255, 0, 0, 0),
              ),
            ),
          ),
        ),

        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
          ),
          child: ListTile(
            leading: Switch(
              value: isDarkThemeEnabled,
              onChanged: (value) {
                setState(() {
                  isDarkThemeEnabled = value;
                });
                // Appliquer le thème sombre ou clair ici en fonction de la valeur de l'interrupteur
                if (isDarkThemeEnabled) {
                  // Thème sombre
                  // Vous pouvez utiliser MaterialApp.dark pour appliquer un thème sombre à toute l'application
                  // MaterialApp.darkTheme pourrait être une meilleure option si vous avez défini un thème sombre personnalisé.
                  // MaterialApp.darkTheme,
                } else {
                  // Thème clair
                  // MaterialApp.lightTheme peut être utilisé pour réinitialiser le thème à celui par défaut de Flutter.
                  // MaterialApp.lightTheme,
                }
              },
            ),
            title: Text('Thème'),
            subtitle: Text(isDarkThemeEnabled ? 'Dark' : 'Light'), // Utilisation de l'état du thème ici
            onTap: () {
              // Action à effectuer lors du clic sur "Thème"
            },
          ),
        ),

        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
          ),
          child: ListTile(
            leading: Icon(Icons.language, color: Colors.black),
            title: Text('Langage'),
            subtitle: Text("Changer la langue de l'application"),
            onTap: () {
               Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LangagePage()),
              );
              
            },
          ),
        ),

        
        Container(
          child: ListTile(
            title: Text(
              'Service',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: const Color.fromARGB(255, 0, 0, 0),
              ),
            ),
          ),
        ),

        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
          ),
          child: ListTile(
            leading: Icon(Icons.help, color: Colors.black),
            title: Text('Aide'),
            onTap: () {
                Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AidePage()),
              );
            },
          ),
        ),

        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
          ),
          child: ListTile(
            leading: Icon(Icons.verified_user_rounded, color: Colors.black),
            title: Text('Sécurité et confidentialité'),
            onTap: () {
               Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ConfidentialitePage()),
              );
            },
          ),
        ),

        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
          ),
          child: ListTile(
            leading: Icon(Icons.info, color: Colors.black),
            title: Text('À propos'),
            subtitle: Text("À propos de l'application"),
            onTap: () {
             
               Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProposPage()),
              );
            },
          ),
        ),

        // Option de déconnexion
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
          ),
          child: ListTile(
            leading: Icon(Icons.exit_to_app, color: Colors.black),
            title: Text('Déconnexion'),
            onTap: () {
              // Action à effectuer lors du clic sur "Déconnexion"
            },
          ),
        ),
      ],
    );
  }
}


