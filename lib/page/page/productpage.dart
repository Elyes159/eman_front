import 'package:flutter/material.dart';
import 'package:untitled2/page/page/panier.dart';


class ProductPage extends StatefulWidget {
  final String title;

  ProductPage(this.title);

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  String selectedImage = 'assets/images/TV1.jpg';


  int number = 1;
  bool isFavorited = false;
  double prixActuel = 799; // Prix actuel du produit
  double pourcentageRemise = 11; // Pourcentage de remise sur le produit
  double calculerPrixAvantRemise() {
    return prixActuel / (1 - (pourcentageRemise / 100));
  }
  void changeSelectedImage(String newImage) {
    setState(() {
      selectedImage = newImage;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF006E7F),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(130),
        child: ClipRRect(
          child: Container(
            color: Color(0xFF006E7F),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20),
                Row(
                  children: [
                    Transform.translate(
                      offset: Offset(32, 23),
                      child: Image.asset(
                        'assets/images/logo.png',
                        scale: 7,
                      ),
                    ),
                    
                    Spacer(),
                    Transform.translate(
                      offset: Offset(-10, 25),
                      child: IconButton(
                        icon: Image.asset(
                          'assets/images/menu.png',
                          width: 35,
                          height: 35,
                        ),
                        color: Colors.white,
                        onPressed: () {},
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
            color: Color(0xFFEFEFEF),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(55),
              topRight: Radius.circular(55),
            ),
          ),
          child: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Transform.translate(
                          offset: Offset(142, 17),
                          child: Text(
                            'Produit',
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Transform.translate(
                          offset: Offset(-45, 22),
                          child: Image.asset(
                            'assets/images/flech1.png',
                            width: 26,
                            height: 26,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 25),
                  Stack(
                    children: [
                      Container(
                        height: 250,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 2,
                              blurRadius: 5,
                              offset: Offset(2, 3),
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        top: 10,
                        right: 10,
                        child: IconButton(
                          icon: Icon(
                            isFavorited ? Icons.favorite : Icons.favorite_border,
                            color: isFavorited ? Colors.red : Colors.grey,
                          ),
                          onPressed: () {
                            setState(() {
                              // Toggle the isFavorited state
                              isFavorited = !isFavorited;
                            });
                          },
                        ),
                      ),
                      Positioned(
                        top: 0,
                        left: 0,
                        right: 7,
                        bottom: 10,
                        child: Center(
                          child: Image.asset(
                            selectedImage,
                            width: 300,
                            height: 270,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      buildImageSelector('assets/images/TV3.png', changeSelectedImage),
                      buildImageSelector('assets/images/TV3.png', changeSelectedImage),
                      buildImageSelector('assets/images/TV3.png', changeSelectedImage),
                    ],
                  ),
                  SizedBox(height: 15),
                  // Affichage du prix
                  Row(
                    children: [
                      Transform.translate(
                        offset: Offset(33, 18),
                        child: Text(
                          'TND ',
                          style: TextStyle(
                            color: Color(0xFF006583),
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      SizedBox(width: 2),
                      Transform.translate(
                        offset: Offset(28, 14),
                        child: Text(
                          '${prixActuel.toStringAsFixed(0)}',
                          style: TextStyle(
                            color: Color(0xFF006583),
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Transform.translate(
                        offset: Offset(33, 18),
                        child: Text(
                          'TND ${calculerPrixAvantRemise().toStringAsFixed(0)}',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.lineThrough,
                            decorationColor: Colors.red,
                          ),
                        ),
                      ),
                      Transform.translate(
                        offset: Offset(40, 14),
                      child: Positioned(
                        top: 10,
                        left: 12,
                        child: Container(
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Color(0xFFF6D776),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            '-11%', // discount
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 11,
                            ),
                          ),
                        ),
                      ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Row(
                    children: [
                      Transform.translate(
                        offset: Offset(33, 18),
                        child: Text(
                          'TV SAMSUNG 32'' SMART-LED HD-T5300',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 17,
                            fontWeight: FontWeight.bold,

                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 12),
                  Row(
                    children: [
                      Transform.translate(
                        offset: Offset(33, 18),
                        child: Text(
                          'SKU: UA32T5300',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 12),
                  // Affichage du prix
                  Row(
                    children: [
                      Transform.translate(
                        offset: Offset(33, 18),
                        child: Text(
                          'Stock:  ',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 17,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Transform.translate(
                        offset: Offset(33, 18),
                        child: Text(
                          'Disponible',
                          style: TextStyle(
                            color: Colors.green,
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Transform.translate(
                        offset: Offset(43, 18),
                        child: Row(
                          // Pour minimiser l'espace
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton( // Utilisation d'ElevatedButton pour le bouton de soustraction
                              onPressed: () {
                                if (number > 1) {
                                  setState(() {
                                    number--;
                                  });
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Color(0xFFF6D776), // Couleur de fond
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(6), // Bordure arrondie
                                ),
                                padding: EdgeInsets.all(6), // Ajustement de l'espacement interne
                                minimumSize: Size(15, 15), // Taille minimale du bouton
                              ),
                              child: Icon(
                                Icons.remove,
                                size: 20,
                                color: Colors.black,
                              ),
                            ),
                  SizedBox(width: 5),
                  Text(
                    number.toString(),
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                            SizedBox(width: 5),
                            ElevatedButton( // Utilisation d'ElevatedButton pour le bouton d'addition
                              onPressed: () {
                                setState(() {
                                  number++;
                                });
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Color(0xFFF6D776), // Couleur de fond
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(6), // Bordure arrondie
                                ),
                                padding: EdgeInsets.all(5), // Ajustement de l'espacement interne
                                minimumSize: Size(10,10), // Taille minimale du bouton
                              ),
                              child: Icon(
                                Icons.add,
                                size: 20,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 12),
                  Row(
                    children: [
                      Transform.translate(
                        offset: Offset(33, 18),
                        child: Text(
                          'SAMSUNG',
                          style: TextStyle(
                            color: Color(0xFF1560BD),
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(height: 12),
                      Transform.translate(
                        offset: Offset(-45, 80),
                     child: Positioned(
                        bottom: 20,
                        left: 20,
                        child: Container(
                          height: 45,
                          width: 300,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25), // BorderRadius pour le coin arrondi
                            color: Color(0xFF006E7F), // Couleur de fond
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.7), // Couleur de l'ombre
                                spreadRadius: 2, // Rayon de propagation
                                blurRadius: 5, // Rayon de flou
                                offset: Offset(0, 2), // Décalage de l'ombre
                              ),
                            ],
                          ),
                          child: TextButton(
                            onPressed: () {
                              
                            },
                            child: Text(
                              'Ajouter au panier',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      ),
                      ),
                    ],
                  ),
                  SizedBox(height: 110), // Ajouter un espace
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 30),
                    height: 1, // Hauteur de la ligne
                    color: Colors.grey, // Couleur de la ligne
                  ),
                  SizedBox(height: 8), // Ajouter un espace
            Transform.translate(
              offset: Offset(33, 18),
              child: Text(
                    'Caractéristiques', // Texte à afficher
                    style: TextStyle(
                      color: Color(0xFF006E7F), // Couleur du texte
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
            ),
                  SizedBox(height: 15),
                  // Affichage du prix
                  Row(
                    children: [
                      Transform.translate(
                        offset: Offset(33, 18),
                        child: Text(
                          'Taille de l\'écran : ',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      SizedBox(width: 2),
                      Transform.translate(
                        offset: Offset(28, 18),
                        child: Text(
                          ' 32 Pouces 1',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 12),
                  Row(
                    children: [
                      Transform.translate(
                        offset: Offset(33, 18),
                        child: Text(
                          'Type d\'affichage : ',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      SizedBox(width: 2),
                      Transform.translate(
                        offset: Offset(28, 18),
                        child: Text(
                          ' HD',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 12),
                  Row(
                    children: [
                      Transform.translate(
                        offset: Offset(33, 18),
                        child: Text(
                          'Résolution : ',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      SizedBox(width: 2),
                      Transform.translate(
                        offset: Offset(28, 19),
                        child: Text(
                          ' 1366 x 768 Pixels',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 12),
                  Row(
                    children: [
                      Transform.translate(
                        offset: Offset(33, 18),
                        child: Text(
                          'Téchnologie d\'affichage : ',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      SizedBox(width: 2),
                      Transform.translate(
                        offset: Offset(28, 19),
                        child: Text(
                          ' HD',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 12),
                  Row(
                    children: [
                      Transform.translate(
                        offset: Offset(33, 18),
                        child: Text(
                          'Smart : ',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      SizedBox(width: 2),
                      Transform.translate(
                        offset: Offset(28, 19),
                        child: Text(
                          ' Oui',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 12),
                  Row(
                    children: [
                      Transform.translate(
                        offset: Offset(33, 18),
                        child: Text(
                          'Récepteur integré : ',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      SizedBox(width: 2),
                      Transform.translate(
                        offset: Offset(28, 19),
                        child: Text(
                          ' Oui',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 12),
                  Row(
                    children: [
                      Transform.translate(
                        offset: Offset(33, 18),
                        child: Text(
                          'TNT : ',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      SizedBox(width: 2),
                      Transform.translate(
                        offset: Offset(28, 19),
                        child: Text(
                          ' Oui',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 12),
                  Row(
                    children: [
                      Transform.translate(
                        offset: Offset(33, 18),
                        child: Text(
                          'Haut parleur : ',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      SizedBox(width: 2),
                      Transform.translate(
                        offset: Offset(28, 19),
                        child: Text(
                          ' 2 x 10 W',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 12),
                  Row(
                    children: [
                      Transform.translate(
                        offset: Offset(33, 18),
                        child: Text(
                          'Système d\'exploitation : ',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      SizedBox(width: 2),
                      Transform.translate(
                        offset: Offset(28, 19),
                        child: Text(
                          ' TIZEN',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 12),
                  Row(
                    children: [
                      Transform.translate(
                        offset: Offset(33, 18),
                        child: Text(
                          'High Dynamic Range : ',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      SizedBox(width: 2),
                      Transform.translate(
                        offset: Offset(28, 19),
                        child: Text(
                          ' HDR 10',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 12),
                  Row(
                    children: [
                      Transform.translate(
                        offset: Offset(33, 18),
                        child: Text(
                          'Fréquence de rafraîchissement : ',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      SizedBox(width: 2),
                      Transform.translate(
                        offset: Offset(28, 19),
                        child: Text(
                          ' 60 Hz',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 12),
                  Row(
                    children: [
                      Transform.translate(
                        offset: Offset(33, 18),
                        child: Text(
                          'Connectivité :',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      SizedBox(width: 2),
                      Transform.translate(
                        offset: Offset(28, 19),
                        child: Text(
                          ' 1 USB | 2 HDMI',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 12),
                  Row(
                    children: [
                      Transform.translate(
                        offset: Offset(33, 18),
                        child: Text(
                          'Poids : ',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      SizedBox(width: 2),
                      Transform.translate(
                        offset: Offset(28, 19),
                        child: Text(
                          ' <6 Kg',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 12),
                  Row(
                    children: [
                      Transform.translate(
                        offset: Offset(33, 18),
                        child: Text(
                          'Dimensions : ',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      SizedBox(width: 2),
                      Transform.translate(
                        offset: Offset(28, 19),
                        child: Text(
                          ' 737,4 x 438 x 74,1 mm',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 12),
                  Row(
                    children: [
                      Transform.translate(
                        offset: Offset(33, 18),
                        child: Text(
                          'Points fords : ',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      SizedBox(width: 2),
                      Transform.translate(
                        offset: Offset(28, 19),
                        child: Text(
                          ' Méga contraste | Dolby Digital Plus',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 12),
                  Row(
                    children: [
                      Transform.translate(
                        offset: Offset(33, 18),
                        child: Text(
                          'Connectivité sans fil : ',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(width: 2),
                  Transform.translate(
                    offset: Offset(190, -3), // Offset for the second line
                    child: Text(
                      'WIFI | BLUETOOTH',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  SizedBox(width: 2),
                  Transform.translate(
                    offset: Offset(35, 15), // Offset for the second line
                    child: Text(
                      '| 1 Entrée composant ',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  SizedBox(height: 12),
                  Row(
                    children: [
                      Transform.translate(
                        offset: Offset(33, 18),
                        child: Text(
                          'Garantie : ',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      SizedBox(width: 2),
                      Transform.translate(
                        offset: Offset(28, 19),
                        child: Text(
                          ' 2 ans',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 55), // Ajouter un espace
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 30),
                    height: 1, // Hauteur de la ligne
                    color: Colors.grey, // Couleur de la ligne
                  ),
                  SizedBox(height: 8), // Ajouter un espace
                  Transform.translate(
                    offset: Offset(33, 18),
                    child: Text(
                      'Description', // Texte à afficher
                      style: TextStyle(
                        color: Color(0xFF006E7F), // Couleur du texte
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Transform.translate(
                    offset: Offset(33, 23), // Offset pour le grand texte
                    child: Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(height: 10), // Ajouter un espace
                          ReadMoreText(
                            'Visionnez votre feuilleton préféré tout en profitant\nd’une très bonne qualité d’image, grâce à ce télév-\niseur Smart HD de la grande marque coréenne,\nSamsung.\nBénéficier d’une image nette et claire grâce à la\ntechnologie wide color enhancer lumineux et dyn-\namique, afin de plonger dans des images aux\ncouleurs éclatantes, avec ce TV Samsung prix\nTunisie de 32 pouces.',
                            trimLines: 5,
                            textAlign: TextAlign.justify, // Définir le textAlign à TextAlign.justify
                            trimMode: TrimMode.Length, // Utiliser le TrimMode.Line
                            trimCollapsedText: "Voir Plus", // Texte pour "Afficher plus"
                            trimExpandedText: "Voir Moins",
                            // Texte pour "Afficher moins"

                            lessStyle: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF006E7F), // Couleur du texte
                              fontSize: 16,
                              height: 1.5,
                            ),

                            moreStyle: TextStyle(
                              fontWeight: FontWeight.w600,
                              color:Color(0xFF006E7F), // Couleur du texte
                              fontSize: 16,
                              height: 1.5,
                            ),
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                              height: 1.5,
                            ),
                          ),
                          SizedBox(height: 10), // Ajouter un espace
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 25), // Ajouter un espace
                  Transform.translate(
                    offset: Offset(33, 18),
                    child: Text(
                      'Produits associés', // Texte à afficher
                      style: TextStyle(
                        color: Color(0xFF006E7F), // Couleur du texte
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 35),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          Container(
                            margin: EdgeInsets.only(right: 10),
                            width: 110,
                            height: 110,
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: Color(0xFF9F9F9F),
                                width: 1,
                              ),
                            ),
                            child: Image.asset(
                              'assets/images/smartz.png',
                              width: 30,
                              height: 30,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Text(
                            "SBOX SUPPORT",
                            style: TextStyle(fontSize: 11, color: Colors.grey),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Container(
                            margin: EdgeInsets.only(right: 10),
                            width: 110,
                            height: 110,
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: Color(0xFF9F9F9F),
                                width: 1,
                              ),
                            ),
                            child: Image.asset(
                              'assets/images/cable.png',
                              width: 30,
                              height: 30,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Text(
                            "CABLE VGA-VGA",
                            style: TextStyle(fontSize: 11, color: Colors.grey),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Container(
                            width: 110,
                            height: 110,
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: Color(0xFF9F9F9F),
                                width: 1,
                              ),
                            ),
                            child: Image.asset(
                              'assets/images/recep.png',
                              width: 30,
                              height: 30,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Text(
                            "RÉCEPTEUR SAMSAT",
                            style: TextStyle(fontSize: 11, color: Colors.grey),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 36.0),
                  Padding(
                    padding: EdgeInsets.all(1.0),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Color(0xFFEFEFEF),
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(55.0),
          ),
        ),
        child: BottomNavigationBar(
          backgroundColor: Color(0xFFEFEFEF),
          selectedItemColor: Color(0xFF006E7F),
          unselectedItemColor: Color(0xFF006E7F),
          selectedLabelStyle: TextStyle(color: Color(0xFF006E7F)),
          type: BottomNavigationBarType.fixed,
          items: [
            BottomNavigationBarItem(
              icon: Padding(
                padding: EdgeInsets.only(top: 5, right: 2),
                child: Image.asset(
                  'assets/images/pani.png',
                  width: 30,
                  height: 30,
                ),
              ),
              label: 'Panier',
            ),
            BottomNavigationBarItem(
              icon: Padding(
                padding: EdgeInsets.only(top: 2, right: 3),
                child: Image.asset(
                  'assets/images/recherche.png',
                  width: 32,
                  height: 32,
                ),
              ),
              label: 'Recherche',
            ),
            BottomNavigationBarItem(
              icon: Padding(
                padding: EdgeInsets.only(top: 1, right: 3),
                child: Image.asset(
                  'assets/images/maison.png',
                  width: 30,
                  height: 30,
                ),
              ),
              label: 'Accueil',
            ),
            BottomNavigationBarItem(
              icon: Padding(
                padding: EdgeInsets.only(top: 1, right: 2),
                child: Image.asset(
                  'assets/images/heart.png',
                  width: 30,
                  height: 30,
                ),
              ),
              label: 'Favoris',
            ),
            BottomNavigationBarItem(
              icon: Padding(
                padding: EdgeInsets.only(top: 1, right: 2),
                child: Image.asset(
                  'assets/images/utilisateur.png',
                  width: 30,
                  height: 30,
                ),
              ),
              label: 'Profil',
            ),
          ],
        ),
      ),
    );
  }
}
Widget buildImageSelector(String imagePath, Function(String) changeSelectedImage) {
  return GestureDetector(
    onTap: () {
      changeSelectedImage(imagePath);
    },
  child: Positioned(
  top: 0,
  left: 0,
  right: 7,
  bottom: 10,
  child: Container(
      margin: EdgeInsets.only(right: 10),
      width: 70,
      height: 70,
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: Color(0xFF9F9F9F),
          width: 1,
        ),
      ),
      child: Image.asset(
        imagePath,
        width: 20,
        height: 20,
        fit: BoxFit.cover,
      ),
    ),
  ),
  );
}
class ReadMoreText extends StatefulWidget {
  final String text;
  final int trimLines;
  final String trimCollapsedText;
  final String trimExpandedText;
  final TextStyle style;
  final TextStyle lessStyle;
  final TextStyle moreStyle;
  final TextAlign textAlign;
  final TrimMode trimMode;

  ReadMoreText(
      this.text, {
        Key? key,
        required this.trimLines,
        this.trimCollapsedText = 'Show More',
        this.trimExpandedText = 'Show Less',
        required this.style,
        required this.lessStyle,
        required this.moreStyle,
        this.textAlign = TextAlign.left,
        this.trimMode = TrimMode.Line,
      }) : super(key: key);

  @override
  _ReadMoreTextState createState() => _ReadMoreTextState();
}

enum TrimMode { Line, Length }

class _ReadMoreTextState extends State<ReadMoreText> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final defaultTextStyle = DefaultTextStyle.of(context).style;

    Widget textWidget = Text(
      widget.text,
      style: widget.style ?? defaultTextStyle,
      maxLines: (!_isExpanded && widget.trimMode == TrimMode.Length)
          ? widget.trimLines
          : null,
      textAlign: widget.textAlign,
    );

    return LayoutBuilder(
      builder: (context, size) {
        final span = TextSpan(text: widget.text, style: widget.style);
        final tp = TextPainter(
            text: span, maxLines: widget.trimLines, textDirection: TextDirection.ltr);
        tp.layout(maxWidth: size.maxWidth);

        if (!tp.didExceedMaxLines && widget.trimMode == TrimMode.Line) {
          return textWidget;
        }

        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            textWidget,
            InkWell(
              onTap: () {
                setState(() {
                  _isExpanded = !_isExpanded;
                });
              },
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.only(right: 40.0),
                  child: Text(
                    _isExpanded ? widget.trimExpandedText : widget.trimCollapsedText,
                    style: _isExpanded
                        ? widget.lessStyle.copyWith(decoration: TextDecoration.underline)
                        : widget.moreStyle.copyWith(decoration: TextDecoration.underline),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}