import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled2/page/page/favoris.dart';
import 'package:untitled2/page/page/home.dart';
import 'package:untitled2/page/parametre.dart';
import 'package:untitled2/page/recheche.dart';
import 'package:http/http.dart' as http;

class PanierPage extends StatefulWidget {
  final String id;

  const PanierPage({Key? key, required this.id}) : super(key: key);

  @override
  State<PanierPage> createState() => _PanierPageState();
}

class _PanierPageState extends State<PanierPage> {
  List<dynamic> cartProducts = []; // Liste pour stocker les produits du panier

  @override
  void initState() {
    super.initState();
    fetchCartProducts(); // Appel de la fonction pour récupérer les produits du panier
  }

  Future<void> fetchCartProducts() async {
    // Récupérer le token de l'utilisateur depuis les préférences partagées
    String? token = await getTokenFromSharedPreferences();
    if (token != null) {
      // Récupérer l'ID de l'utilisateur à partir du token
      String? userId = await getUserIdFromToken(token);
      if (userId != null) {
        // Construire l'URL de l'API pour récupérer les produits du panier de l'utilisateur
        String apiUrl = "http://192.168.1.17:3003/user/get-cart/$userId";
        try {
          // Effectuer une requête HTTP GET pour récupérer les produits du panier
          final response = await http.get(Uri.parse(apiUrl));
          if (response.statusCode == 200) {
            // Mettre à jour la liste des produits du panier avec les données récupérées
            setState(() {
              cartProducts = jsonDecode(response.body);
            });
          } else {
            print(
                "Erreur lors de la récupération des produits du panier: ${response.statusCode}");
          }
        } catch (e) {
          print("Erreur lors de la récupération des produits du panier: $e");
        }
      } else {
        print('Impossible de récupérer l\'ID de l\'utilisateur');
      }
    } else {
      print('Token non trouvé localement');
    }
  }

  Future<String?> getTokenFromSharedPreferences() async {
    // Récupérer le token de l'utilisateur depuis les préférences partagées
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  Future<String?> getUserIdFromToken(String token) async {
    // Construire les en-têtes de la requête HTTP
    Map<String, String> headers = {
      'Content-Type': 'application/json',
    };

    try {
      // Effectuer une requête HTTP GET pour récupérer l'ID de l'utilisateur à partir du token
      final resp = await http.get(
        Uri.parse("http://192.168.1.17:3003/user/getByToken/$token"),
        headers: headers,
      );
      if (resp.statusCode == 200) {
        // Analyser la réponse JSON pour extraire l'ID de l'utilisateur
        final userData = jsonDecode(resp.body);
        final userId = userData['_id'] as String;
        return userId;
      } else {
        print(
            'Erreur lors de la récupération de l\'ID de l\'utilisateur: ${resp.statusCode}');
        return null;
      }
    } catch (e) {
      print('Erreur lors de la récupération de l\'ID de l\'utilisateur: $e');
      return null;
    }
  }

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
                          offset: Offset(
                              -140, 53), // Translation verticale du texte
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
                      offset: Offset(
                          -10, 25), // Translation verticale de l'icône du menu
                      child: IconButton(
                        icon: Image.asset(
                          'assets/images/menu.png', // chemin vers votre image locale
                          width:
                              35, // ajustez la largeur de l'image selon vos besoins
                          height:
                              35, // ajustez la hauteur de l'image selon vos besoins
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
            color: Color(0xFFEFEFEF), // Couleur de fond du corps
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
                  offset: Offset(-145,
                      -20), // Ajuster la marge en haut et à gauche de l'icône
                  child: Image.asset(
                    'assets/images/flech1.png', // chemin vers votre image locale
                    width:
                        20, // ajustez la largeur de l'image selon vos besoins
                    height:
                        20, // ajustez la hauteur de l'image selon vos besoins
                    color: Colors.black, // couleur de l'image si nécessaire
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.height *
                      0.6, // Hauteur définie à 60% de la hauteur de l'écran

                  child: ListView.builder(
                    itemCount: cartProducts.length,
                    itemBuilder: (context, index) {
                      return Container(
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
                              offset: Offset(1, -4),
                              child: Image.asset(
                                'assets/images/pc.png',
                                width: 110,
                                height: 110,
                              ),
                            ),
                            SizedBox(width: 2),
                            Expanded(
                              child: Transform.translate(
                                offset: Offset(2, 7),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      cartProducts[index]
                                          ['name'], // Nom du produit
                                      style: TextStyle(
                                        fontSize: 13.0,
                                        fontFamily: 'Roboto',
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    Text(
                                      cartProducts[index][
                                          'description'], // Description du produit
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
                                        'assets/images/corbeille.png',
                                        width: 20,
                                        height: 20,
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
                                                color: Color(0xFF006E7F),
                                                fontFamily: 'Roboto',
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                            TextSpan(
                                              text: cartProducts[index]['price']
                                                  .toString(), // Convertir en chaîne
                                              style: TextStyle(
                                                fontSize: 29.0,
                                                color: Color(0xFF006E7F),
                                                fontFamily: 'Roboto',
                                                fontWeight: FontWeight.w500,
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
                          ],
                        ),
                      );
                    },
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
                                            fontWeight: FontWeight.w600),
                                      ),
                                      TextSpan(
                                        text:
                                            '-2 666', // Prix actuel du produit
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
                            ]),
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
                            ]),
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
                      backgroundColor:
                          Color(0xFF006E7F), // Couleur de fond du bouton
                      padding: EdgeInsets.symmetric(
                          vertical: 20,
                          horizontal:
                              8), // Ajustez le rembourrage selon vos besoins
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            30), // Ajustez le rayon de la bordure selon vos besoins
                      ),
                    ),
                    child: SizedBox(
                      width:
                          120, // Ajustez la largeur du bouton selon vos besoins
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
          // bottomNavigationBarItem(
          //   image: 'assets/images/panier.png',
          //   label: 'Panier',
          //   context: context,
          //   page: PanierPage(),
          // ),
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
