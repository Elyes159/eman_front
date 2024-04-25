import 'package:flutter/material.dart';
import 'package:untitled2/page/page/favoris.dart';
import 'package:untitled2/page/page/home.dart';
import 'package:untitled2/page/parametre.dart';
import 'package:untitled2/page/recheche.dart';


class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: PanierPage(),
    );
  }
}


class PanierPage extends StatefulWidget {
  const PanierPage({Key? key}) : super(key: key);

  @override
  State<PanierPage> createState() => _PanierPageState();
}
class _PanierPageState extends State<PanierPage>{

  int number = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF006E7F), // Couleur de fond de toute la page
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(130), // Réduit la hauteur de l'app bar
        child: ClipRRect(
          child: Container(
            color: Color(0xFF006E7F), // Couleur de l'app bar
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20),
                Row(
                  children: [
                    Transform.translate(
                      offset: Offset(32, 23), // Translation verticale du logo
                      child: Image.asset(
                        'assets/images/logo.png',
                        scale: 7,
                      ),
                    ),
                    SizedBox(width: 20), // Espacement entre le logo et le texte
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Transform.translate(
                          offset: Offset(-140, 53), // Translation verticale du texte
                          child: Text(
                            'Bonjour Marwa',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Spacer(), // Pour pousser l'icône du menu à droite
                    Transform.translate(
                      offset: Offset(-10, 25), // Translation verticale de l'icône du menu
                      child: IconButton(
                        icon: Image.asset(
                          'assets/images/menu.png', // chemin vers votre image locale
                          width: 35, // ajustez la largeur de l'image selon vos besoins
                          height: 35, // ajustez la hauteur de l'image selon vos besoins
                        ),
                        color: Colors.white,
                        onPressed: () {
                          // Action à effectuer lors du clic sur le bouton de menu
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),

      body: SingleChildScrollView(

      child: Container(
        decoration: BoxDecoration(
          color: Color(0xFFEFEFEF),// Couleur de fond du corps
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(55), // Coin supérieur gauche arrondi
            topRight: Radius.circular(55), // Coin supérieur droit arrondi
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Transform.translate(
                offset: Offset(-8, -2),
                child: Text(
                  'Votre panier',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Transform.translate(
                offset: Offset(-145, -20), // Ajuster la marge en haut et à gauche de l'icône
                child: Image.asset(
                  'assets/images/flech1.png', // chemin vers votre image locale
                  width: 20, // ajustez la largeur de l'image selon vos besoins
                  height: 20, // ajustez la hauteur de l'image selon vos besoins
                  color: Colors.black, // couleur de l'image si nécessaire
                ),
              ),
              Transform.translate(
                offset: Offset(-1, 0),
                child: Container(
                  height: 120,
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(20.0),
                    border: Border.all(color: Color(0xFF9F9F9F)),
                  ),

                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Transform.translate(
                        offset: Offset(6, -5), // Ajuster la marge en haut et à gauche de l'icône
                        child: Image.asset(
                          'assets/images/TV.png',  // Remplacez par le chemin de votre image
                          width: 110,  // Ajustez la largeur de l'image selon vos besoins
                          height: 110,  // Ajustez la hauteur de l'image selon vos besoins
                        ),
                      ),
                SizedBox(width: 2), // Réduire l'espacement entre l'image et le texte
                Expanded(
                  child: Transform.translate(
                    offset: Offset(-3, 7),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'TV SAMSUNG 32" SMART-LED',
                        style: TextStyle(
                          fontSize: 13.0,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        'HD-T5300',
                        style: TextStyle(
                          fontSize: 13.0,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w500,
                        ),
                      ),

                  SizedBox(height: 5),
                  Transform.translate(
                    offset: Offset(200, -28),
                    child: Image.asset(
                        'assets/images/corbeille.png', // Chemin de votre icône
                        width: 20, // Ajustez la largeur de l'icône selon vos besoins
                        height: 20, // Ajustez la hauteur de l'icône selon vos besoins
                      ),
                  ),
                  Transform.translate(
                    offset: Offset(130, 13),
                    child: RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: 'TND ',
                            style: TextStyle(
                              fontSize: 13.0,
                              color: Color(0xFF006E7F), // Couleur #006E7F
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          TextSpan(
                            text: '799', // Prix actuel du produit
                            style: TextStyle(
                              fontSize: 29.0,
                              color: Color(0xFF006E7F), // Couleur #006E7F
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                    Transform.translate(
                      offset: Offset(38, -8),
                          child:Text(
                            'TND 899',  // Prix avant réduction
                            style: TextStyle(
                              fontSize: 13.0,
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.w500,
                              decoration: TextDecoration.lineThrough,
                              decorationColor: Colors.red,
                              color: Colors.grey,
                            ),
                          ),
                    ),
                    ],
                  ),
                  ),
                ),
                    ],
                  ),
                ),
              ),
              Transform.translate(
                offset: Offset(-1, 30),
                child: Container(
                  height: 120,
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(20.0),
                    border: Border.all(color: Color(0xFF9F9F9F)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Transform.translate(
                        offset: Offset(1, -4), // Ajuster la marge en haut et à gauche de l'icône
                        child: Image.asset(
                          'assets/images/pc.png',  // Remplacez par le chemin de votre image
                          width: 110,  // Ajustez la largeur de l'image selon vos besoins
                          height: 110,  // Ajustez la hauteur de l'image selon vos besoins
                        ),
                      ),
                      SizedBox(width: 2), // Réduire l'espacement entre l'image et le texte
                      Expanded(
                        child: Transform.translate(
                          offset: Offset(2, 7),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'PC Portable LENOVO IdeapPad',
                                style: TextStyle(
                                  fontSize: 13.0,
                                  fontFamily: 'Roboto',
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Text(
                                'AMD RYZEN 3 8GO 512GOssd',
                                style: TextStyle(
                                  fontSize: 13.0,
                                  fontFamily: 'Roboto',
                                  fontWeight: FontWeight.w500,
                                ),
                              ),

                              SizedBox(height: 5),
                              Transform.translate(
                                offset: Offset(195, -25),
                                child: Image.asset(
                                  'assets/images/corbeille.png', // Chemin de votre icône
                                  width: 20, // Ajustez la largeur de l'icône selon vos besoins
                                  height: 20, // Ajustez la hauteur de l'icône selon vos besoins
                                ),
                              ),
                              Transform.translate(
                                offset: Offset(130, 13),
                                child: RichText(
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text: 'TND ',
                                        style: TextStyle(
                                          fontSize: 13.0,
                                          color: Color(0xFF006E7F), // Couleur #006E7F
                                          fontFamily: 'Roboto',
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      TextSpan(
                                        text: '659', // Prix actuel du produit
                                        style: TextStyle(
                                          fontSize: 29.0,
                                          color: Color(0xFF006E7F), // Couleur #006E7F
                                          fontFamily: 'Roboto',
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Transform.translate(
                                offset: Offset(38, -8),
                                child:Text(
                                  'TND 1 099',  // Prix avant réduction
                                  style: TextStyle(
                                    fontSize: 13.0,
                                    fontFamily: 'Roboto',
                                    fontWeight: FontWeight.w500,
                                    decoration: TextDecoration.lineThrough,
                                    decorationColor: Colors.red,
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Transform.translate(
                offset: Offset(-1, 60),
                child: Container(
                  height: 120,
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(20.0),
                    border: Border.all(color: Color(0xFF9F9F9F)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Transform.translate(
                        offset: Offset(1, -4), // Ajuster la marge en haut et à gauche de l'icône
                        child: Image.asset(
                          'assets/images/clima.png',  // Remplacez par le chemin de votre image
                          width: 115,  // Ajustez la largeur de l'image selon vos besoins
                          height: 115,  // Ajustez la hauteur de l'image selon vos besoins
                        ),
                      ),
                      SizedBox(width: 2), // Réduire l'espacement entre l'image et le texte
                      Expanded(
                        child: Transform.translate(
                          offset: Offset(-3, 7),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Climatiseur LG Inverter Dual',
                                style: TextStyle(
                                  fontSize: 13.0,
                                  fontFamily: 'Roboto',
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Text(
                                'ArtCool 24000 Btu ch/f',
                                style: TextStyle(
                                  fontSize: 13.0,
                                  fontFamily: 'Roboto',
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              SizedBox(height: 5),
                              Transform.translate(
                                offset: Offset(195, -25),
                                child: Image.asset(
                                  'assets/images/corbeille.png', // Chemin de votre icône
                                  width: 20, // Ajustez la largeur de l'icône selon vos besoins
                                  height: 20, // Ajustez la hauteur de l'icône selon vos besoins
                                ),
                              ),
                              Transform.translate(
                                offset: Offset(103, 13),
                                child: RichText(
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text: 'TND ',
                                        style: TextStyle(
                                          fontSize: 13.0,
                                          color: Color(0xFF006E7F), // Couleur #006E7F
                                          fontFamily: 'Roboto',
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      TextSpan(
                                        text: '3 083', // Prix actuel du produit
                                        style: TextStyle(
                                          fontSize: 29.0,
                                          color: Color(0xFF006E7F), // Couleur #006E7F
                                          fontFamily: 'Roboto',
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Transform.translate(
                                offset: Offset(30, -8),
                                child:Text(
                                  'TND 5 139',  // Prix avant réduction
                                  style: TextStyle(
                                    fontSize: 13.0,
                                    fontFamily: 'Roboto',
                                    fontWeight: FontWeight.w500,
                                    decoration: TextDecoration.lineThrough,
                                    decorationColor: Colors.red,
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
        Transform.translate(
          offset: Offset(-1, 60),
                child:
                  Container(
                    height: 200,
                    decoration: BoxDecoration(
                      color: Color(0xFFEFEFEF),// Couleur de fond du corps
                    ),
                  ),
              ),
        Transform.translate(
          offset: Offset(-1, -110),
          child: Container(
            height: 120,
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(20.0),
              border: Border.all(color: Color(0xFF9F9F9F)),
            ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Transform.translate(
                    offset: Offset(1, -4), // Ajuster la marge en haut et à gauche de l'icône
                    child: Image.asset(
                      'assets/images/hachoir.png',  // Remplacez par le chemin de votre image
                      width: 120,  // Ajustez la largeur de l'image selon vos besoins
                      height: 120,  // Ajustez la hauteur de l'image selon vos besoins
                    ),
                  ),
                  SizedBox(width: 2), // Réduire l'espacement entre l'image et le texte
                  Expanded(
                    child: Transform.translate(
                      offset: Offset(-6, 7),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Hachoir à Viande Touch Avec',
                            style: TextStyle(
                              fontSize: 13.0,
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            'Accessoires 2000W - Noir',
                            style: TextStyle(
                              fontSize: 13.0,
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Transform.translate(
                            offset: Offset(192, -25),
                            child: InkWell(
                              onTap: () {
                                // Code pour supprimer le produit
                              },
                              child: Image.asset(
                                'assets/images/corbeille.png',
                                width: 20,
                                height: 20,
                              ),
                            ),
                          ),
                          Transform.translate(
                            offset: Offset(123, 13),
                            child: RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: 'TND ',
                                    style: TextStyle(
                                      fontSize: 13.0,
                                      color: Color(0xFF006E7F), // Couleur #006E7F
                                      fontFamily: 'Roboto',
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  TextSpan(
                                    text: '219', // Prix actuel du produit
                                    style: TextStyle(
                                      fontSize: 29.0,
                                      color: Color(0xFF006E7F), // Couleur #006E7F
                                      fontFamily: 'Roboto',
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Transform.translate(
                            offset: Offset(26, -8),
                            child:Text(
                              'TND 5 289',  // Prix avant réduction
                              style: TextStyle(
                                fontSize: 13.0,
                                fontFamily: 'Roboto',
                                fontWeight: FontWeight.w500,
                                decoration: TextDecoration.lineThrough,
                                decorationColor: Colors.red,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                        ],

                      ),
                    ),
                  ),
                ],
              ),
          ),
        ),
        Transform.translate(
          offset: Offset(-1, -80),
          child:
              Container(
                height: 10, // Ajustez la hauteur selon vos besoins pour élever la ligne horizontale
                child: Divider(
                  color: Color(0xFF717171),
                  thickness: 1,
                ),
              ),
        ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Transform.translate(
                      offset: Offset(10, -75),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Economisez',
                            style: TextStyle(
                              fontSize: 23,
                              fontWeight: FontWeight.w600, // Semi-bold
                            ),
                          ),
        Transform.translate(
          offset: Offset(245, -30.5),
          child: RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: 'TND ',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 11,
                      fontWeight: FontWeight.w600
                  ),
                ),
                TextSpan(
                  text: '-2 666', // Prix actuel du produit
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 23,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
        ]

                      ),
                    ),
                  ),


                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Transform.translate(
                      offset: Offset(10, -95),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Total',
                              style: TextStyle(
                                fontSize: 23,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF006E7F),
                              ),
                            ),
                            Transform.translate(
                              offset: Offset(242, -35),
                              child: RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: 'TND ',
                                      style: TextStyle(
                                        color: Color(0xFF006E7F),
                                        fontSize: 13,
                                          fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    TextSpan(
                                      text: '4700', // Prix actuel du produit
                                      style: TextStyle(
                                        color: Color(0xFF006E7F),
                                        fontSize: 29,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ]

                      ),
                    ),
                  ),


                ],
              ),
        Transform.translate(
          offset: Offset(1, -72),
          child: ElevatedButton(
                onPressed: () {
                  // Action à effectuer lorsque le bouton est pressé
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF006E7F), // Couleur de fond du bouton
                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 8), // Ajustez le rembourrage selon vos besoins
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30), // Ajustez le rayon de la bordure selon vos besoins
                  ),
                ),
            child: SizedBox(
              width: 120, // Ajustez la largeur du bouton selon vos besoins
              child: Center(
                child: Text(
                  'Valider',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white, // Couleur du texte
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    ),
        ),
      ),
    ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color(0xFFEFEFEF),
        selectedItemColor: Color(0xFF006E7F),
        unselectedItemColor: Color(0xFF006E7F),
        selectedLabelStyle: TextStyle(color: Color(0xFF006E7F)),
        type: BottomNavigationBarType.fixed,
        items: [
          bottomNavigationBarItem(
            image: 'assets/images/panier.png',
            label: 'Panier',
            context: context,
            page: PanierPage(),
          ),
          bottomNavigationBarItem(
            image: 'assets/images/recherche.png',
            label: 'Recherche',
            context: context,
            page: RecherchePage(),
          ),
          bottomNavigationBarItem(
            image: 'assets/images/acceuil.png',
            label: 'Accueil',
            context: context,
            page: Home(),
          ),
          bottomNavigationBarItem(
            image: 'assets/images/heart.png',
            label: 'Favoris',
            context: context,
            page: FavorisPage(),
          ),
          bottomNavigationBarItem(
            image: 'assets/images/utilisateur.png',
            label: 'Profil',
            context: context,
            page: ProfilePage(),
          ),
        ],
      ),
    );
  }

  BottomNavigationBarItem bottomNavigationBarItem({
    required String image,
    required String label,
    required BuildContext context,
    required Widget page,
  }) {
    return BottomNavigationBarItem(
      icon: Padding(
        padding: EdgeInsets.only(top: 5, right: 2),
        child: IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => page),
            );
          },
          icon: Image.asset(
            image,
            width: 30,
            height: 30,
          ),
        ),
      ),
      label: label,
    );
  }
}
