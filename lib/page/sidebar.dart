import 'package:flutter/material.dart';

import 'package:untitled2/page/parametre.dart';



class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mon application',
      home: Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(size: 52)
           // Changer la taille de l'icône de menu
        ),
        endDrawer: NavBar(), // Utilisez endDrawer au lieu de drawer
      ),
    );
  }
}

class NavBar extends StatefulWidget {
  @override
  _NavBarState createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  bool isCategoryExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        decoration: BoxDecoration(
          color: Color(0xFF006583),
        ),
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Color(0xFF006583),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 3),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset(
                      'assets/images/logo.jpg',
                      height: 30,
                    ),
                    SizedBox(height: 20),
                    Row(
                      children: [
                        CircleAvatar(
                          backgroundImage: AssetImage(
                            'assets/images/emna.png',
                          ),
                          radius: 30,
                        ),
                        SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'bouachiri emna',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 5),
                            Text(
                              'bouachiriemna6@gmail.com',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            buildListTile(
              icon: Icons.favorite,
              title: 'Favoris',
              onTap: () => null, // Ajouter la fonctionnalité pour les Favoris
            ),
            buildListTile(
              icon: Icons.shopping_cart,
              title: 'Suivre votre commande',
              onTap: () => null, // Ajouter la fonctionnalité pour Suivre votre commande
            ),
            buildListTile(
              icon: Icons.local_offer,
              title: 'Coupons',
              onTap: () => null, // Ajouter la fonctionnalité pour les Coupons
            ),
      buildListTile(
  icon: Icons.settings,
  title: 'Paramètres',
  onTap: () {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ProfilePage()),
    );
  }, // Ajouter la fonctionnalité pour les Paramètres
),

            buildListTile(
              icon: Icons.category,
              title: 'Catégorie',
              onTap: () {
                setState(() {
                  isCategoryExpanded = !isCategoryExpanded; // Basculer l'état d'expansion
                });
              },
            ),
            // Widget de sous-catégorie
            if (isCategoryExpanded)
              Column(
                children: [
                  buildListTile(
                    icon: Icons.subdirectory_arrow_right,
                    title: 'Électroménager',
                    onTap: () => null, // Définir l'action onTap
                  ),
                  buildListTile(
                    icon: Icons.subdirectory_arrow_right,
                    title: 'Informatique',
                    onTap: () => null, // Définir l'action onTap
                  ),
                  buildListTile(
                    icon: Icons.subdirectory_arrow_right,
                    title: 'Sport & Loisirs',
                    onTap: () => null, // Définir l'action onTap
                  ),
                  buildListTile(
                    icon: Icons.subdirectory_arrow_right,
                    title: 'Bureautique',
                    onTap: () => null, // Définir l'action onTap
                  ),
                  buildListTile(
                    icon: Icons.subdirectory_arrow_right,
                    title: 'Animalerie',
                    onTap: () => null, // Définir l'action onTap
                  ),
                  buildListTile(
                    icon: Icons.subdirectory_arrow_right,
                    title: 'Gaming',
                    onTap: () => null, // Définir l'action onTap
                  ),
                  buildListTile(
                    icon: Icons.subdirectory_arrow_right,
                    title: 'TV & Son',
                    onTap: () => null, // Définir l'action onTap
                  ),
                  buildListTile(
                    icon: Icons.subdirectory_arrow_right,
                    title: 'Santé & Beauté',
                    onTap: () => null, // Définir l'action onTap
                  ),
                  // Ajouter plus de tuiles de sous-catégorie si nécessaire
                ],
              ),
            buildListTile(
              icon: Icons.notifications,
              title: 'Notification',
              onTap: () => null, // Ajouter la fonctionnalité pour les Notifications
              trailing: ClipOval(
                child: Container(
                  color: Colors.red,
                  width: 20,
                  height: 20,
                  child: Center(
                    child: Text(
                      '8',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            buildListTile(
              icon: Icons.exit_to_app,
              title: 'Déconnexion',
              onTap: () => null,
            ),
          ],
        ),
      ),
    );
  }

  ListTile buildListTile({
    required IconData icon,
    required String title,
    required Function()? onTap,
    Widget? trailing,
  }) {
    return ListTile(
      leading: Icon(icon, color: Colors.white),
      title: Text(
        title,
        style: TextStyle(color: Colors.white),
      ),
      onTap: onTap,
      trailing: trailing,
    );
  }
}
