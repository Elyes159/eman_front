import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';




class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: RecherchePage(),
    );
  }
}

class RecherchePage extends StatefulWidget {

  @override
  State<RecherchePage> createState() => _RecherchePageState();
}

class _RecherchePageState extends State<RecherchePage> {
  int number = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF026376), // Couleur de fond de toute la page
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(130), // Réduit la hauteur de l'app bar
        child: ClipRRect(
          child: Container(
            color: Color(0xFF026376), // Couleur de l'app bar
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
          height: 780,
          decoration: BoxDecoration(
            color: Color(0xFFEFEFEF),
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(60.0),
              // Radius pour les coins supérieurs

              // Radius pour les coins inférieurs
            ),
          ),

          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      //use expended if you are using textformfield in row
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                              color: Color(0xFFdcdcdc),
                              borderRadius: BorderRadius.circular(50),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.grey.shade400,
                                    blurRadius: 10,
                                    spreadRadius: 3,
                                    offset: const Offset(5, 5))
                              ]),
                          child: TextFormField(
                            decoration: const InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Chercher un produit',
                                prefixIcon: Icon(Icons.search)),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),

                      Container(
                          decoration: BoxDecoration(
                              color: Color(0xFFdcdcdc),
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.grey.shade400,
                                    blurRadius: 10,
                                    spreadRadius: 3,
                                    offset: const Offset(5, 5))
                              ]),
                          child: const Padding(
                            padding: EdgeInsets.all(10.0),
                            child: Icon(
                              Icons.sort,
                              size: 26,
                            ),
                          ))
                    ],
                  ),
                  SizedBox(height: 5.0),
                  Row(
                    children: [
                      Transform.translate(
                        offset: Offset(18, 10),
                        child:
                      Text(
                        "Marques",
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF548a87),
                        ),
                      ),
                      ),
              Transform.translate(
                offset: Offset(194, 10),
                child: Row(
                    children: [
                Transform.translate(
                offset: Offset(12, -1),
                child:
                      Text(
                        "Voir plus",
                        style: TextStyle(
                          fontSize: 13.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                ),

                      // Espacement entre le texte et l'image
                      IconButton(
                        onPressed: () {
                          // Action à effectuer lorsque le bouton est pressé
                        },
                        icon: Image.asset(
                          'assets/images/blacc.png',
                          width: 20,
                          // Ajustez la largeur selon vos besoins
                          height: 20, // Ajustez la hauteur selon vos besoins
                        ),
                      ),
                    ],
                  ),
              ),
                  ],
              ),
                  SizedBox(height: 10),
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _buildCircularImage('assets/images/recherche11.png', width: 20, height: 3),
                          _buildCircularImage('assets/images/recherche22.png', width: 20, height: 3),
                          _buildCircularImage('assets/images/recherche3.png', width: 30, height: 30),
                          _buildCircularImage('assets/images/recherche4.png', width: 5, height: 3),
                        ],
                      ),
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _buildCircularImage('assets/images/recherche55.png', width: 30, height: 10),
                          _buildCircularImage('assets/images/recherche66.png', width: 30, height: 10),
                          _buildCircularImage('assets/images/recherche7.png', width: 30, height: 30),
                          _buildCircularImage('assets/images/recherche88.png', width: 40, height: 30),
                        ],
                      ),
                    ],
                  ),

                  SizedBox(height: 5.0),
                  Row(
                    children: [
                      Transform.translate(
                        offset: Offset(18, 10),
                        child:
                        Text(
                          "Catégories",
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF548a87),
                          ),
                        ),
                      ),
                      Transform.translate(
                        offset: Offset(174, 10),
                        child: Row(
                          children: [
                            Transform.translate(
                              offset: Offset(12, -1),
                              child:
                              Text(
                                "Voir plus",
                                style: TextStyle(
                                  fontSize: 13.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                            ),

                            // Espacement entre le texte et l'image
                            IconButton(
                              onPressed: () {
                                // Action à effectuer lorsque le bouton est pressé
                              },
                              icon: Image.asset(
                                'assets/images/blacc.png',
                                width: 20,
                                // Ajustez la largeur selon vos besoins
                                height: 20, // Ajustez la hauteur selon vos besoins
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 10),
                  Column(
                    children: [
                      Transform.translate(
                        offset: Offset(-47, 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Image.asset('assets/images/catego11.png', width: 40, height: 40),
                        Transform.translate(
                          offset: Offset(-44, 5),
                          child:
                          Text(
                            'Eléctorménager',
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        ],
                      ),
                      ),
                      SizedBox(height: 10),
                      Transform.translate(
                        offset: Offset(-52.5, 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Image.asset('assets/images/catego2.png', width: 40, height: 40),
                        Transform.translate(
                          offset: Offset(-46, 5),
                          child:
                          Text('Informatiques',
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                        ],
                      ),
                      ),
                      SizedBox(height: 10),
                      Transform.translate(
                        offset: Offset(-50, 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Image.asset('assets/images/catego3.png', width: 40, height: 40),
                        Transform.translate(
                          offset: Offset(-44, 5),
                          child:
                          Text('Sport & Loisirs',
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        ],
                      ),
                      ),
                      SizedBox(height: 10),
                      Transform.translate(
                        offset: Offset(-55, 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Image.asset('assets/images/catego4.png', width: 40, height: 40),
                        Transform.translate(
                          offset: Offset(-46, 5),
                          child:
                          Text('Smartphones',
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        ],
                      ),
                      ),
                      SizedBox(height: 10),
                      Transform.translate(
                        offset: Offset(-58, 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Image.asset('assets/images/catego5.png', width: 40, height: 40),
                        Transform.translate(
                          offset: Offset(-52, 5),
                          child:
                          Text('Impression',
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        ],
                      ),
                      ),
                      SizedBox(height: 10),
                      Transform.translate(
                        offset: Offset(-58, 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Image.asset('assets/images/catego6.png', width: 40, height: 40),
                            Transform.translate(
                              offset: Offset(-56, 5),
                              child:
                              Text('Jeux vidéo',
                                style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 10),
                      Transform.translate(
                        offset: Offset(-49, 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Image.asset('assets/images/catego7.png', width: 40, height: 40),
                            Transform.translate(
                              offset: Offset(-44, 5),
                              child:
                              Text('Santé & beauté',
                                style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
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
           
          ],
        ),
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
        padding: EdgeInsets.only( right: 2),
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
  Widget _buildCircularImage(String imagePath, {required double width, required double height}) {
    return Container(
      width: 60,
      height: 60,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Color(0xFFdcdcdc),
      ),
      child: ClipOval(
        child: Image.asset(
          imagePath,
          width: width,
          height: height,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}


