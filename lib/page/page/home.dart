import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:untitled2/page/CategoryPage1.dart';
import 'package:untitled2/page/CategoryPage2.dart';

import 'package:untitled2/page/CategoryPage3.dart';
import 'package:untitled2/page/CategoryPage4.dart';
import 'package:untitled2/page/CategoryPage5.dart';
import 'package:untitled2/page/favoris.dart';
import 'package:untitled2/page/footer.dart';
import 'package:untitled2/page/page/modelproduct.dart';
import 'package:untitled2/page/page/notification.dart';
import 'package:untitled2/page/recheche.dart';
import 'package:http/http.dart' as http;

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const Home(),
    );
  }
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late final PageController pageController;
  ScrollController _scrollController = ScrollController();
  int pageNo = 0;
  Timer? carasouelTmer;
  late List<bool> showFullTitles;
  late List<bool> favoriteStates;

  String _displayText = '';
  String _currentContent = '';
  bool _isButtonClicked = false;
  bool _isLogoClicked =
      false; // Ajout d'une variable pour suivre l'état de l'image du logo

  Timer getTimer() {
    return Timer.periodic(const Duration(seconds: 3), (timer) {
      if (pageNo == 4) {
        pageNo = 0;
      }
      pageController.animateToPage(
        pageNo,
        duration: const Duration(seconds: 1),
        curve: Curves.easeInOutCirc,
      );
      pageNo++;
    });
  }

  @override
  void initState() {
    pageController = PageController(initialPage: 0, viewportFraction: 0.85);
    carasouelTmer = getTimer();
    _scrollController.addListener(() {
      if (_scrollController.position.userScrollDirection ==
          ScrollDirection.reverse) {
        showBtmAppBr = false;
        setState(() {});
      } else {
        showBtmAppBr = true;
        setState(() {});
      }
    });
    super.initState();
    showFullTitles = List.generate(4, (_) => false);
    favoriteStates = List.generate(4, (_) => false);
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  bool showBtmAppBr = true;
  String selectedImage = 'assets/images/TV1.jpg';
  bool isFavorited = false;
  bool isLiked = false;

  final List<Map<String, dynamic>> categories = [
    {'title': 'Eléctromenagers', 'imagePath': 'assets/images/menager.png'},
    {'title': 'TV', 'imagePath': 'assets/images/tele.png'},
    {'title': 'Smartphones', 'imagePath': 'assets/images/smartphones.png'},
    {'title': 'Bureautiques', 'imagePath': 'assets/images/bureau.png'},
    {'title': 'Infomatique', 'imagePath': 'assets/images/info.png'},
    {'title': 'Impression', 'imagePath': 'assets/images/imprimante.png'},
    {'title': 'Jeux vidéo', 'imagePath': 'assets/images/video.png'},
    {'title': 'Santé & Beauté', 'imagePath': 'assets/images/beaute.png'},
    {'title': 'Maison & Brico', 'imagePath': 'assets/images/maisonn.png'},
    {'title': 'Sport & Loisir', 'imagePath': 'assets/images/sport.png'},
    {'title': 'Animalerie', 'imagePath': 'assets/images/animalerie.png'}
  ];

  final List<Map<String, dynamic>> categorie = [
    {
      'title': 'Infomatiques',
      'imagePath': 'assets/images/catt1.png',
      'width': 260.0,
      'height': 450.0,
      'right': -150
    },
    {
      'title': 'Smartphones',
      'imagePath': 'assets/images/catt2.png',
      'width': 220.0,
      'height': 180.0,
      'top': 10.0,
    },
    {
      'title': 'Eléctroménager',
      'imagePath': 'assets/images/catt3.png',
      'width': 180.0,
      'height': 160.0,
      'top': 35,
      'left': -150,
    },
  ];

  final List<Map<String, dynamic>> gridMap = [
    {
      "price": "TND219",
      "title": "Hachoir à Viande Touch",
      "imagePath": "assets/images/ramadhan1.png",
      "discount": "-70%",
    },
    {
      "title": "FOUR TOPMATIC NOIR",
      "price": "TND299",
      "imagePath": "assets/images/panierr.png",
      "discount": "-60%",
    },
    {
      "title": "LIVOO ROBOT PÂTISSIER MULTIFONCTION",
      "price": "TND183",
      "imagePath": "assets/images/clima.png",
      "discount": "-26%",
    },
    {
      "title": "KORKMAZ SET 8 PCS HERA INOX VIOLET",
      "price": "TND159.3",
      "imagePath": "assets/images/montre.png",
      "discount": "-26%",
    },
  ];
  final List<String> imagePaths = [
    'assets/images/sams.png',
    'assets/images/arti.png',
    'assets/images/asus.png',
    'assets/images/lgg.png',
    'assets/images/hpp.png',
    'assets/images/log.png',
    'assets/images/xiom.png',
    'assets/images/opp.png',
    'assets/images/huawi.png',
  ];

  void toggleFavoriteState(int index) {
    setState(() {
      favoriteStates[index] = !favoriteStates[index];
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(145),
          child: AppBar(
            backgroundColor: Color(0xFF006583),
            elevation: 0,
            flexibleSpace: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 45),
                Row(
                  children: [
                    Transform.translate(
                      offset: Offset(24, 0),
                      child: Image.asset(
                        'assets/images/logo.png',
                        scale: 6,
                      ),
                    ),
                    Spacer(),
                    Padding(
                      padding: EdgeInsets.only(right: 15, top: 5),
                      child: IconButton(
                        icon: Icon(
                          Icons.menu,
                          color: Colors.white,
                          size: 40,
                        ),
                        onPressed: () {
                          print('Sidebar icon tapped');
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 15),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: TextFormField(
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(vertical: 10.0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        borderSide:
                            BorderSide(color: Color(0xFF006583), width: 1.2),
                      ),
                      filled: true,
                      fillColor: Color(0xFF9ebcc0),
                      hintText: 'Chercher un produit',
                      hintStyle: TextStyle(color: Color(0xFF506d6e)),
                      prefixIcon: Icon(Icons.search,
                          size: 30, color: Color(0xFF506d6e)),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        body: Stack(
          children: [
            Container(
              color: Color(0xFF006583),
              child: ListView.separated(
                padding:
                    const EdgeInsets.symmetric(horizontal: 21, vertical: 10),
                scrollDirection: Axis.horizontal,
                separatorBuilder: (context, index) => SizedBox(width: 20),
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      // Naviguer vers la page correspondante en fonction de l'index
                      switch (index) {
                        case 0:
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CategoryPage1()),
                          );
                          break;
                        case 1:
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CategoryPage1()),
                          );
                          break;
                        case 2:
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CategoryPage3()),
                          );
                          break;
                        case 3:
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CategoryPage4()),
                          );
                          break;
                        case 4:
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CategoryPage5()),
                          );
                          break;
                      }
                    },
                    child: Column(
                      children: [
                        SizedBox(height: 5),
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.white,
                            border: Border.all(
                              color: Colors.transparent,
                              width: 1.2,
                            ),
                          ),
                          child: Image.asset(
                            categories[index]['imagePath'] as String,
                            width: 40,
                            height: 40,
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          categories[index]['title'] as String,
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            Positioned.fill(
              child: Transform.translate(
                offset: Offset(0, 130),
                child: SingleChildScrollView(
                  child: Container(
                    height: 4900,
                    decoration: BoxDecoration(
                      color: Color(0xFFEFEFEF),
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(50.0),
                        // Radius pour les coins supérieurs
                        bottom: Radius.circular(50.0),
                        // Radius pour les coins inférieurs
                      ),
                    ),
                    margin: EdgeInsets.only(bottom: 350),
                    child: SafeArea(
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 42.0),
                            SizedBox(
                              height: 160,
                              child: PageView.builder(
                                controller: pageController,
                                onPageChanged: (index) {
                                  pageNo = index;
                                  setState(() {});
                                },
                                itemBuilder: (_, index) {
                                  // Liste des chemins des images
                                  List<String> imagePaths = [
                                    'assets/images/image1.jpg',
                                    'assets/images/image2.jpg',
                                    'assets/images/image3.jpg',
                                  ];

                                  return AnimatedBuilder(
                                    animation: pageController,
                                    builder: (ctx, child) {
                                      return child!;
                                    },
                                    child: Container(
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 8.0),
                                      // Espacement horizontal entre les images
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.vertical(
                                          top: Radius.circular(12.0),
                                          // Rayon pour les coins supérieurs
                                          bottom: Radius.circular(
                                              12.0), // Rayon pour les coins inférieurs
                                        ),
                                        child: Image.asset(
                                          imagePaths[index],
                                          // Utilisation du chemin de l'image pour l'index actuel
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  );
                                },
                                itemCount: 3,
                              ),
                            ),
                            const SizedBox(height: 12.0),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: List.generate(
                                3,
                                (index) => GestureDetector(
                                  child: Container(
                                    margin: const EdgeInsets.all(2.0),
                                    width: 30.0, // Largeur du rectangle
                                    height: 6.0, // Hauteur du rectangle
                                    decoration: BoxDecoration(
                                      color: pageNo == index
                                          ? Color(0xFF006583)
                                          : Colors.grey.shade300,
                                      // Couleur du rectangle en fonction de la page
                                      borderRadius: BorderRadius.circular(2.0),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.all(24.0),
                              child: GridB(),
                            ),
                            SizedBox(height: 2.0),
                            Stack(
                              children: [
                                Container(
                                  margin: EdgeInsets.only(right: 14.0),
                                  // Margin right ajouté
                                  decoration: BoxDecoration(
                                    color: Color(0xFFFFD902),
                                    // Couleur de fond du Container
                                    borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(50.0),
                                      // Border radius coin supérieur droit
                                      bottomRight: Radius.circular(
                                          50.0), // Border radius coin inférieur droit
                                    ),
                                  ),
                                  height: 430,
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 28.0, vertical: 15.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Nouveautés",
                                        style: TextStyle(
                                          fontSize: 25.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(height: 2.0),
                                      Text(
                                        "Découvrez les derniers produits - SAMSUNG",
                                        style: TextStyle(
                                          fontSize: 12.0,
                                          fontWeight: FontWeight.w600,
                                          color: Color(0xFF666666),
                                        ),
                                      ),

                                      GestureDetector(
                                        onTap: () {
                                          // Action à effectuer lorsque le bouton "Voir plus" est pressé
                                        },
                                        child: Row(
                                          children: [
                                            Text(
                                              "Voir plus",
                                              style: TextStyle(
                                                fontSize: 13.0,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            SizedBox(width: 5.0),
                                            // Espacement entre le texte et l'icône
                                            IconButton(
                                              onPressed: () {
                                                // Action à effectuer lorsque le bouton IconButton est pressé
                                              },
                                              icon: Icon(Icons.arrow_forward),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(height: 2.0),
                                      // Espacement entre le texte "Voir plus" et l'image
                                      ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        // Rayon du border radius pour l'image
                                        child: Image.asset(
                                          'assets/images/1.png',
                                          // Chemin de l'image
                                          fit: BoxFit
                                              .cover, // Redimensionner l'image pour couvrir toute la largeur
                                        ),
                                      ),
                                      Transform.translate(
                                        offset: Offset(-0.5, 20),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                              children: [
                                                Container(
                                                  width: 90,
                                                  height: 90,
                                                  decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                  ),
                                                  child: Image.asset(
                                                    'assets/images/smart.png',
                                                    width: 20,
                                                    height: 20,
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                                SizedBox(height: 4.0),
                                                Text(
                                                  "Galaxy Z Fold",
                                                  style: TextStyle(
                                                      fontSize: 11,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: Colors.black),
                                                ),
                                              ],
                                            ),
                                            SizedBox(width: 6.0),
                                            Column(
                                              children: [
                                                Container(
                                                  width: 90,
                                                  height: 90,
                                                  decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                  ),
                                                  child: Image.asset(
                                                    'assets/images/smartz.png',
                                                    width: 20,
                                                    height: 20,
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                                SizedBox(height: 4.0),
                                                Text(
                                                  "Galaxy Z Flip",
                                                  style: TextStyle(
                                                      fontSize: 11,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: Colors.black),
                                                ),
                                              ],
                                            ),
                                            SizedBox(width: 6.0),
                                            Column(
                                              children: [
                                                Container(
                                                  width: 90,
                                                  height: 90,
                                                  decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                  ),
                                                  child: Image.asset(
                                                    'assets/images/ultra.png',
                                                    width: 20,
                                                    height: 20,
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                                SizedBox(height: 4.0),
                                                Text(
                                                  "Galaxy S24 Ultra",
                                                  style: TextStyle(
                                                      fontSize: 11,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: Colors.black),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Stack(
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 10.0, vertical: 15.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Top Catégories",
                                        style: TextStyle(
                                          fontSize: 23.0,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        ),
                                      ),
                                      SizedBox(height: 10),
                                      Container(
                                        height: 200,
                                        // Hauteur de votre ListView
                                        child: ListView.builder(
                                          scrollDirection: Axis.horizontal,
                                          itemCount: categorie.length,
                                          itemBuilder: (context, index) {
                                            return Stack(
                                              children: [
                                                Container(
                                                  width: 160,
                                                  // Largeur du conteneur (plus petit que l'image)
                                                  height: 160,
                                                  // Hauteur du conteneur (plus petit que l'image)
                                                  margin: EdgeInsets.symmetric(
                                                      horizontal: 15),
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20),
                                                    color: Colors
                                                        .white, // Couleur de fond blanche pour chaque image
                                                  ),
                                                ),
                                                Container(
                                                  width: categorie[index][
                                                      'width'], // Width of the image
                                                  height: categorie[index][
                                                      'height'], // Height of the image
                                                  decoration: BoxDecoration(
                                                    image: DecorationImage(
                                                      image: AssetImage(categorie[
                                                                  index]
                                                              ['imagePath']
                                                          as String), // Image path from the list
                                                      fit: BoxFit
                                                          .cover, // Cover the container with the image
                                                    ),
                                                  ),
                                                ),
                                                Positioned(
                                                  bottom: 3,
                                                  // Offset downwards to place the title below the image
                                                  left: 0,
                                                  right: 0,
                                                  child: Text(
                                                    categorie[index]['title']
                                                        as String,
                                                    // Assuming 'title' is a key in your categorie map
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      fontSize: 18.0,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.black,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            );
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 20.0),
                            Stack(
                              children: [
                                Container(
                                  margin: EdgeInsets.only(left: 15.0),
                                  // Margin right ajouté
                                  decoration: BoxDecoration(
                                    color: Color(0xFFac9ece),
                                    // Couleur de fond du Container
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(50.0),
                                      // Border radius coin supérieur droit
                                      bottomLeft: Radius.circular(
                                          50.0), // Border radius coin inférieur droit
                                    ),
                                  ),
                                  height: 470,
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 20.0, vertical: 15.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Gaming",
                                        style: TextStyle(
                                          fontSize: 25.0,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                      SizedBox(height: 1.0),
                                      Text(
                                        "Plongez dans l'univers du Gaming",
                                        style: TextStyle(
                                          fontSize: 12.0,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.black,
                                        ),
                                      ),
                                      SizedBox(height: 1.0),
                                      Row(
                                        children: [
                                          Text(
                                            "Voir plus",
                                            style: TextStyle(
                                              fontSize: 13.0,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                            ),
                                          ),
                                          SizedBox(width: 5.0),
                                          // Espacement entre le texte et l'image
                                          IconButton(
                                            onPressed: () {
                                              // Action à effectuer lorsque le bouton est pressé
                                            },
                                            icon: Image.asset(
                                              'assets/images/blanc.png',
                                              width: 20,
                                              // Ajustez la largeur selon vos besoins
                                              height:
                                                  20, // Ajustez la hauteur selon vos besoins
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 4.0),
                                      // Espacement entre le texte "Voir plus" et l'image
                                      ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        // Rayon du border radius pour l'image
                                        child: Image.asset(
                                          'assets/images/2.png',
                                          // Chemin de l'image
                                          fit: BoxFit
                                              .cover, // Redimensionner l'image pour couvrir toute la largeur
                                        ),
                                      ),

                                      Transform.translate(
                                        offset: Offset(1.5, 12),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                              children: [
                                                Container(
                                                  width: 100,
                                                  height: 100,
                                                  decoration: BoxDecoration(
                                                    color: Color(0xFF8d79a0),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                  ),
                                                  child: Image.asset(
                                                    'assets/images/gamer.png',
                                                    width: 30,
                                                    height: 30,
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                                SizedBox(height: 4.0),
                                                Text(
                                                  "PC gamer",
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: Colors.white),
                                                ),
                                              ],
                                            ),
                                            SizedBox(width: 9.0),
                                            Column(
                                              children: [
                                                Container(
                                                  width: 100,
                                                  height: 100,
                                                  decoration: BoxDecoration(
                                                    color: Color(0xFF8d79a0),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                  ),
                                                  child: Image.asset(
                                                    'assets/images/clavier.png',
                                                    width: 30,
                                                    height: 30,
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                                SizedBox(height: 4.0),
                                                Text(
                                                  "Accéssoires",
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: Colors.white),
                                                ),
                                              ],
                                            ),
                                            SizedBox(width: 9.0),
                                            Column(
                                              children: [
                                                Container(
                                                  width: 100,
                                                  height: 100,
                                                  decoration: BoxDecoration(
                                                    color: Color(0xFF8d79a0),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                  ),
                                                  child: Image.asset(
                                                    'assets/images/son.png',
                                                    width: 30,
                                                    height: 30,
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                                SizedBox(height: 4.0),
                                                Text(
                                                  "son & Audio",
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: Colors.white),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 25.0),
                            Stack(
                              children: [
                                Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 20.0, vertical: 15.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Stack(
                                          children: [
                                            Container(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 20.0,
                                                  vertical: 15.0),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    children: [
                                                      Image.asset(
                                                        'assets/images/ramadan.png',
                                                        width: 25,
                                                        height: 25,
                                                      ),
                                                      SizedBox(width: 5.0),
                                                      Text(
                                                        "Offre Ramadhan 2024",
                                                        style: TextStyle(
                                                          fontSize: 23.0,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.black,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(height: 4.0),
                                                  // Add some space between row and grid
                                                  Gri(),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    )),
                              ],
                            ),
                            SizedBox(height: 20.0),
                            Stack(
                              children: [
                                Container(
                                  margin: EdgeInsets.only(right: 14.0),
                                  // Margin right ajouté
                                  decoration: BoxDecoration(
                                    color: Color(0xFFADC1BC),
                                    // Couleur de fond du Container
                                    borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(50.0),
                                      // Border radius coin supérieur droit
                                      bottomRight: Radius.circular(
                                          50.0), // Border radius coin inférieur droit
                                    ),
                                  ),
                                  height: 650,
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 20.0, vertical: 15.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Notre séléction",
                                        style: TextStyle(
                                          fontSize: 25.0,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        ),
                                      ),

                                      Row(
                                        children: [
                                          Text(
                                            "Voir plus",
                                            style: TextStyle(
                                              fontSize: 13.0,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                            ),
                                          ),
                                          SizedBox(width: 5.0),
                                          // Espacement entre le texte et l'image
                                          IconButton(
                                            onPressed: () {
                                              // Action à effectuer lorsque le bouton est pressé
                                            },
                                            icon: Image.asset(
                                              'assets/images/black.png',
                                              width: 20,
                                              // Ajustez la largeur selon vos besoins
                                              height:
                                                  20, // Ajustez la hauteur selon vos besoins
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 2.0),
                                      // Add some space between row and grid
                                      GridA(),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Stack(
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 20.0, vertical: 15.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Tendances",
                                        style: TextStyle(
                                          fontSize: 23.0,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        ),
                                      ),
                                      SizedBox(height: 5.0),
                                      // Add some space between row and grid
                                      GriA(),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 2.0),
                            Stack(
                              children: [
                                Container(
                                  margin: EdgeInsets.only(left: 14.0),
                                  // Margin right ajouté
                                  decoration: BoxDecoration(
                                    color: Color(0xFF00A3FF).withOpacity(0.43),
                                    // Couleur de fond du Container
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(50.0),
                                      // Border radius coin supérieur droit
                                      bottomLeft: Radius.circular(
                                          50.0), // Border radius coin inférieur droit
                                    ),
                                  ),
                                  height: 490,
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 20.0, vertical: 15.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Electroménager",
                                        style: TextStyle(
                                          fontSize: 25.0,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        ),
                                      ),
                                      SizedBox(height: 4.0),
                                      Text(
                                        "Découvrez notre gamme d'électroménagers intelligents",
                                        style: TextStyle(
                                          fontSize: 12.0,
                                          fontWeight: FontWeight.w600,
                                          color: Color(0xFF666666),
                                        ),
                                      ),
                                      SizedBox(height: 2.0),
                                      Row(
                                        children: [
                                          Text(
                                            "Voir plus",
                                            style: TextStyle(
                                              fontSize: 13.0,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                            ),
                                          ),
                                          SizedBox(width: 5.0),
                                          // Espacement entre le texte et l'image
                                          IconButton(
                                            onPressed: () {
                                              // Action à effectuer lorsque le bouton est pressé
                                            },
                                            icon: Image.asset(
                                              'assets/images/black.png',
                                              width: 20,
                                              // Ajustez la largeur selon vos besoins
                                              height:
                                                  20, // Ajustez la hauteur selon vos besoins
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 3.0),
                                      // Espacement entre le texte "Voir plus" et l'image
                                      ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        // Rayon du border radius pour l'image
                                        child: Image.asset(
                                          'assets/images/electro1.png',
                                          // Chemin de l'image
                                          fit: BoxFit
                                              .cover, // Redimensionner l'image pour couvrir toute la largeur
                                        ),
                                      ),

                                      Transform.translate(
                                        offset: Offset(2, 12),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                              children: [
                                                Container(
                                                  width: 100,
                                                  height: 100,
                                                  decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                  ),
                                                  child: Image.asset(
                                                    'assets/images/electro2.png',
                                                    width: 30,
                                                    height: 30,
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                                SizedBox(height: 2.0),
                                                Text(
                                                  "Gros électro",
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: Colors.white),
                                                ),
                                              ],
                                            ),
                                            SizedBox(width: 9.0),
                                            Column(
                                              children: [
                                                Container(
                                                  width: 100,
                                                  height: 100,
                                                  decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                  ),
                                                  child: Image.asset(
                                                    'assets/images/electro3.png',
                                                    width: 30,
                                                    height: 30,
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                                SizedBox(height: 4.0),
                                                Text(
                                                  "Machine à café",
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: Colors.white),
                                                ),
                                              ],
                                            ),
                                            SizedBox(width: 9.0),
                                            Column(
                                              children: [
                                                Container(
                                                  width: 100,
                                                  height: 100,
                                                  decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                  ),
                                                  child: Image.asset(
                                                    'assets/images/electro4.png',
                                                    width: 30,
                                                    height: 30,
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                                SizedBox(height: 4.0),
                                                Text(
                                                  "Robot de cuisine",
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: Colors.white),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Stack(
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 20.0, vertical: 15.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Image.asset(
                                            'assets/images/argent.png',
                                            width: 25,
                                            height: 25,
                                          ),
                                          SizedBox(width: 5.0),
                                          Text(
                                            "Offre de la semaine",
                                            style: TextStyle(
                                              fontSize: 23.0,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 4.0),
                                      // Add some space between row and grid
                                      Grid(),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 8.0),
                            Stack(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 10.0),
                                      child: SizedBox(
                                        height: 35.0,
                                        child: ListView(
                                          scrollDirection: Axis.horizontal,
                                          children: [
                                            BrandItem(
                                                imageUrl:
                                                    'assets/images/sams.jpg'),
                                            BrandItem(
                                                imageUrl:
                                                    'assets/images/arti.jpg'),
                                            BrandItem(
                                                imageUrl:
                                                    'assets/images/asu.jpg'),
                                            BrandItem(
                                                imageUrl:
                                                    'assets/images/lgg.jpg'),
                                            BrandItem(
                                                imageUrl:
                                                    'assets/images/hpp.jpg'),
                                            BrandItem(
                                                imageUrl:
                                                    'assets/images/log.jpg'),
                                            BrandItem(
                                                imageUrl:
                                                    'assets/images/xiom.jpg'),
                                            BrandItem(
                                                imageUrl:
                                                    'assets/images/opp.jpg'),
                                            BrandItem(
                                                imageUrl:
                                                    'assets/images/huawi.jpg'),
                                            MyHomePage(),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Positioned(
                                  bottom: -5.0,
                                  left: 0,
                                  right: 0,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: List.generate(
                                      4,
                                      (index) => GestureDetector(
                                        onTap: () {
                                          // Mettre à jour l'indice de la page ici
                                        },
                                        child: Container(
                                          margin: const EdgeInsets.all(2.0),
                                          width: 10.0,
                                          height: 10.0,
                                          decoration: BoxDecoration(
                                            color: Colors.grey.shade300,
                                            shape: BoxShape.circle,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            MyHomePage(),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Color(0xFFEFEFEF),
          selectedItemColor: Color(0xFF006E7F),
          unselectedItemColor: Color(0xFF006E7F),
          selectedLabelStyle: TextStyle(color: Color(0xFF006E7F)),
          type: BottomNavigationBarType.fixed,
          items: [
            // bottomNavigationBarItem(
            //   image: 'assets/images/pani.png',
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
              image: 'assets/images/maison.png',
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

class FabExt extends StatelessWidget {
  const FabExt({
    Key? key,
    required this.showFabTitle,
  }) : super(key: key);

  final bool showFabTitle;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      onPressed: () {},
      label: AnimatedContainer(
        duration: const Duration(seconds: 2),
        padding: const EdgeInsets.all(12.0),
      ),
    );
  }
}

class GridB extends StatefulWidget {
  const GridB({Key? key}) : super(key: key);

  @override
  _GridBState createState() => _GridBState();
}

class _GridBState extends State<GridB> {
  Future<List<Product>> getdatafromserver() async {
    final resp = await http.get(
      Uri.parse("http://192.168.1.22:3003/product/products"),
    );
    if (resp.statusCode == 200) {
      final List<dynamic> reponse = json.decode(resp.body);
      print(reponse);
      return reponse.map((json) => Product.fromJson(json)).toList();
    } else {
      return [];
    }
  }

  late List<bool> showFullTitles;
  late List<bool> favoriteStates;

  @override
  void initState() {
    super.initState();
    // Initialiser la liste showFullTitles avec des valeurs par défaut à false
    showFullTitles = List.generate(4, (_) => false);
    favoriteStates = List.generate(4, (_) => false);
  }

  void toggleFavoriteState(int index) {
    setState(() {
      favoriteStates[index] = !favoriteStates[index];
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> gridMap = [
      {
        "price": "TND799",
        "title": "TV SAMSUNG 32'' SMART-LED HD-T5300",
        "imagePath": "assets/images/img1.jpg",
        "discount": "-11%",
      },
      {
        "title": "WHIRLPOOL PLAQUE CHAUFFANTE 4 Feux 60 CM",
        "price": "TND323.4",
        "imagePath": "assets/images/img4.jpg",
        "discount": "-40%",
      },
      {
        "title": "PC Portable LENOVO IdeapPad AMD RYZEN 3 8GO",
        "price": "TND439.6",
        "imagePath": "assets/images/img2.jpg",
        "discount": "-60%",
      },
      {
        "title": "CARTE GRAPHIQUE GIGABYTE GEFORCE RTX2060",
        "price": "TND159.3",
        "imagePath": "assets/images/img3.jpg",
        "discount": "-30%",
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "Meilleures Ventes",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        FutureBuilder<List<Product>>(
          future: getdatafromserver(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else {
              final products = snapshot.data!;
              return GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // Nombre de colonnes dans la grille
                  mainAxisSpacing: 10.0, // Espace vertical entre les cellules
                  crossAxisSpacing:
                      10.0, // Espace horizontal entre les cellules
                  childAspectRatio:
                      0.7, // Ratio largeur/hauteur de chaque cellule
                ),
                itemCount: products.length,
                itemBuilder: (context, index) {
                  final product = products[index];
                  return Card(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.network(
                          product.image, // Utilisez l'URL de l'image
                          fit: BoxFit
                              .cover, // Ajuste l'image pour couvrir le conteneur
                          height: 150, // Hauteur de l'image
                        ),
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                product.name,
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Text(
                                  'Price: \$${product.price.toStringAsFixed(2)}'),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            }
          },
        ),
      ],
    );
  }

  String _calculateDiscountedPrice(String price, String discount) {
    double originalPrice = double.parse(price.substring(3));
    double discountPercentage = double.parse(discount.replaceAll('%', ''));
    double discountedPrice =
        originalPrice - (originalPrice * discountPercentage / 100);
    return discountedPrice.toStringAsFixed(1);
  }

  static String _truncateTitle(String title, int maxLength) {
    if (title.length > maxLength) {
      int lastIndex = title.lastIndexOf(' ', maxLength);
      return title.substring(0, lastIndex) + '...';
    }
    return title;
  }
}

class Gri extends StatefulWidget {
  const Gri({Key? key}) : super(key: key);

  @override
  _GriState createState() => _GriState();
}

class _GriState extends State<Gri> {
  late List<bool> showFullTitles;
  late List<bool> favoriteStates;

  @override
  void initState() {
    super.initState();
    // Initialiser la liste showFullTitles avec des valeurs par défaut à false
    showFullTitles = List.generate(6, (_) => false);
    favoriteStates = List.generate(6, (_) => false);
  }

  void toggleFavoriteState(int index) {
    setState(() {
      favoriteStates[index] = !favoriteStates[index];
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> gridMap = [
      {
        "price": "TND219",
        "title": "Hachoir à Viande Touch Avec Accessoires",
        "imagePath": "assets/images/ramadhan1.jpg",
        "discount": "-24%",
      },
      {
        "title": "KONIX DRAKKAR pack sorcerer",
        "price": "TND68",
        "imagePath": "assets/images/manette.jpg",
        "discount": "-34%",
      },
      {
        "title": "Montre connecté LINWEAR LW03 ",
        "price": "TND149",
        "imagePath": "assets/images/montre.jpg",
        "discount": "-54%",
      },
      {
        "title": "Whirpool hotte murale 60CM INOX",
        "price": "TND499",
        "imagePath": "assets/images/hotte.jpg",
        "discount": "-30%",
      },
      {
        "price": "TND799",
        "title": "TV SAMSUNG 32'' SMART-LED HD-T5300",
        "imagePath": "assets/images/img1.jpg",
        "discount": "-11%",
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 250,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: gridMap.length,
            itemBuilder: (_, index) {
              final item = gridMap[index];
              final showFullTitle = showFullTitles[index];

              final isFavorite = favoriteStates[index];

              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5.0),
                child: GestureDetector(
                  onTap: () {
                    // Action à effectuer lors du clic sur l'élément de la grille
                  },
                  child: Container(
                    width: 160,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 170,
                          width: 300,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 10.0),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Transform.translate(
                                    offset: Offset(-7, -2),
                                    child: Text(
                                      'TND ',
                                      style: TextStyle(
                                        color: Color(0xFF006583),
                                        fontSize: 13,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 2),
                                  Transform.translate(
                                    offset: Offset(-9, -2),
                                    child: Text(
                                      item['price'].substring(3),
                                      style: TextStyle(
                                        color: Color(0xFF006583),
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  Transform.translate(
                                    offset: Offset(-2, -1),
                                    child: Text(
                                      'TND ${_calculateDiscountedPrice(item['price'], item['discount'])}',
                                      style: TextStyle(
                                        decoration: TextDecoration.lineThrough,
                                        decorationColor: Colors.red,
                                        color: Colors.grey,
                                        fontSize: 10,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Transform.translate(
                                offset: Offset(-6, -1),
                                child: Text(
                                  item['title'],
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: Color(0xFF666666),
                                    fontSize: 10,
                                  ),
                                ),
                              ),
                              Transform.translate(
                                offset: Offset(117, -65),
                                child: IconButton(
                                  onPressed: () {
                                    // Action à effectuer lors du clic sur l'icône du panier
                                  },
                                  icon: Icon(
                                    CupertinoIcons.cart,
                                    size: 18,
                                    color: Color(
                                        0xFF006583), // Couleur de l'icône du panier
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Positioned(
                          top: 17,
                          left: 6,
                          child: Container(
                            padding: EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              color: Color(0xFFF6D776),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              item['discount'],
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 10,
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          top: 17,
                          // Ajustez la position supérieure de l'icône de cœur
                          right: 10,
                          child: GestureDetector(
                            onTap: () {
                              // Appel de la méthode pour basculer l'état du produit favori
                              toggleFavoriteState(index);
                            },
                            child: Image.asset(
                              isFavorite
                                  ? 'assets/images/cor.png'
                                  : 'assets/images/hear.png',
                              // Changez le chemin de l'image en fonction de l'état du produit favori
                              width: 22,
                              height: 22,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  String _calculateDiscountedPrice(String price, String discount) {
    double originalPrice = double.parse(price.substring(3));
    double discountPercentage = double.parse(discount.replaceAll('%', ''));
    double discountedPrice =
        originalPrice - (originalPrice * discountPercentage / 100);
    return discountedPrice.toStringAsFixed(1);
  }
}

class GridA extends StatefulWidget {
  const GridA({Key? key}) : super(key: key);

  @override
  _GridAState createState() => _GridAState();
}

class _GridAState extends State<GridA> {
  late List<bool> showFullTitles;
  late List<bool> favoriteStates;

  @override
  void initState() {
    super.initState();
    // Initialiser la liste showFullTitles avec des valeurs par défaut à false
    showFullTitles = List.generate(4, (_) => false);
    favoriteStates = List.generate(4, (_) => false);
  }

  void toggleFavoriteState(int index) {
    setState(() {
      favoriteStates[index] = !favoriteStates[index];
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> gridMap = [
      {
        "price": "TND299",
        "title": "CECOTEC BLENDER POWER BLACK TITANIUM",
        "imagePath": "assets/images/select1.jpg",
      },
      {
        "title": "CASQUE CELLY KIDSBEAT FILAIRE",
        "price": "TND42",
        "imagePath": "assets/images/select2.jpg",
      },
      {
        "title": "SMARTPHONE IKU A6",
        "price": "TND191",
        "imagePath": "assets/images/select3.jpg",
      },
      {
        "title": "CARTE MERE MSI B560M-A PRO",
        "price": "TND299",
        "imagePath": "assets/images/select4.jpg",
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GridView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10.0,
            mainAxisSpacing: 0.0,
            mainAxisExtent: 270,
          ),
          itemCount: gridMap.length > 4 ? 4 : gridMap.length,
          itemBuilder: (_, index) {
            final item = gridMap[index];
            final showFullTitle = showFullTitles[index];
            final title = showFullTitle
                ? item['title']
                : _truncateTitle(item['title'], 30);
            final isFavorite = favoriteStates[index];

            return Container(
              margin: EdgeInsets.only(top: 1.0),
              child: Stack(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 190,
                        width: 310,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 13.0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20.0),
                            child: Container(
                              margin: EdgeInsets.only(bottom: 8.0),
                              child: Image.asset(
                                item['imagePath'],
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Transform.translate(
                                  offset: Offset(-7, -2),
                                  child: Text(
                                    'TND ',
                                    style: TextStyle(
                                      color: Color(0xFF006583),
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                                SizedBox(width: 2),
                                Transform.translate(
                                  offset: Offset(-9, -2),
                                  child: Text(
                                    item['price'].substring(3),
                                    style: TextStyle(
                                      color: Color(0xFF006583),
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Transform.translate(
                              offset: Offset(-6, -1),
                              child: Text(
                                title,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xFF666666),
                                  fontSize: 10,
                                ),
                              ),
                            ),
                            Transform.translate(
                              offset: Offset(117, -43),
                              child: IconButton(
                                onPressed: () {
                                  // Action à effectuer lors du clic sur l'icône du panier
                                },
                                icon: Icon(
                                  CupertinoIcons.cart,
                                  size: 18,
                                  color: Color(
                                      0xFF006583), // Couleur de l'icône du panier
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Positioned(
                    top:
                        17, // Ajustez la position supérieure de l'icône de cœur
                    right: 10,
                    child: GestureDetector(
                      onTap: () {
                        // Appel de la méthode pour basculer l'état du produit favori
                        toggleFavoriteState(index);
                      },
                      child: Image.asset(
                        isFavorite
                            ? 'assets/images/cor.png'
                            : 'assets/images/hear.png', // Changez le chemin de l'image en fonction de l'état du produit favori
                        width: 22,
                        height: 22,
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }

  static String _truncateTitle(String title, int maxLength) {
    if (title.length > maxLength) {
      int lastIndex = title.lastIndexOf(' ', maxLength);
      return title.substring(0, lastIndex) + '...';
    }
    return title;
  }
}

class GriA extends StatefulWidget {
  const GriA({Key? key}) : super(key: key);

  @override
  _GriAState createState() => _GriAState();
}

class _GriAState extends State<GriA> {
  late List<bool> showFullTitles;
  late List<bool> favoriteStates;

  @override
  void initState() {
    super.initState();
    // Initialiser la liste showFullTitles avec des valeurs par défaut à false
    showFullTitles = List.generate(6, (_) => false);
    favoriteStates = List.generate(6, (_) => false);
  }

  void toggleFavoriteState(int index) {
    setState(() {
      favoriteStates[index] = !favoriteStates[index];
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> gridMap = [
      {
        "price": "TND799",
        "title": "TV SAMSUNG 32'' SMART-LED HD-T5300",
        "imagePath": "assets/images/img1.jpg",
        "discount": "-11%",
      },
      {
        "title": "WHIRLPOOL PLAQUE CHAUFFANTE 4 Feux 60 CM",
        "price": "TND323.4",
        "imagePath": "assets/images/img4.jpg",
        "discount": "-40%",
      },
      {
        "title": "PC Portable LENOVO IdeapPad AMD RYZEN 3 8GO",
        "price": "TND439.6",
        "imagePath": "assets/images/img2.jpg",
        "discount": "-60%",
      },
      {
        "title": "CARTE GRAPHIQUE GIGABYTE GEFORCE RTX2060",
        "price": "TND159.3",
        "imagePath": "assets/images/img3.jpg",
        "discount": "-30%",
      },
      {
        "title": "CARTE GRAPHIQUE GIGABYTE GEFORCE RTX2060",
        "price": "TND159.3",
        "imagePath": "assets/images/img3.jpg",
        "discount": "-30%",
      },
      {
        "title": "WHIRLPOOL PLAQUE CHAUFFANTE 4 Feux 60 CM",
        "price": "TND323.4",
        "imagePath": "assets/images/img4.jpg",
        "discount": "-40%",
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GridView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10.0,
            mainAxisSpacing: 0.0,
            mainAxisExtent: 290,
          ),
          itemCount: gridMap.length,
          itemBuilder: (_, index) {
            final item = gridMap[index];
            final showFullTitle = showFullTitles[index];
            final title = showFullTitle
                ? item['title']
                : _truncateTitle(item['title'], 30);
            final isFavorite = favoriteStates[index];

            return GestureDetector(
              onTap: () {
                // Action à effectuer lors du clic sur l'élément de la grille
              },
              child: Container(
                margin: EdgeInsets.only(top: 1.0),
                child: Stack(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 170,
                          width: 300,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 10.0),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20.0),
                              child: Container(
                                margin: EdgeInsets.only(bottom: 8.0),
                                child: Image.asset(
                                  item['imagePath'],
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Transform.translate(
                                    offset: Offset(-7, -2),
                                    child: Text(
                                      'TND ',
                                      style: TextStyle(
                                        color: Color(0xFF006583),
                                        fontSize: 13,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 2),
                                  Transform.translate(
                                    offset: Offset(-9, -2),
                                    child: Text(
                                      item['price'].substring(3),
                                      style: TextStyle(
                                        color: Color(0xFF006583),
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  Transform.translate(
                                    offset: Offset(-2, -1),
                                    child: Text(
                                      'TND ${_calculateDiscountedPrice(item['price'], item['discount'])}',
                                      style: TextStyle(
                                        decoration: TextDecoration.lineThrough,
                                        decorationColor: Colors.red,
                                        color: Colors.grey,
                                        fontSize: 10,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Transform.translate(
                                offset: Offset(-6, -1),
                                child: Text(
                                  title,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: Color(0xFF666666),
                                    fontSize: 10,
                                  ),
                                ),
                              ),
                              Transform.translate(
                                offset: Offset(117, -43),
                                child: IconButton(
                                  onPressed: () {
                                    // Action à effectuer lors du clic sur l'icône du panier
                                  },
                                  icon: Icon(
                                    CupertinoIcons.cart,
                                    size: 18,
                                    color: Color(
                                        0xFF006583), // Couleur de l'icône du panier
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Positioned(
                      top: 17,
                      left: 6,
                      child: Container(
                        padding: EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: Color(0xFFF6D776),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          item['discount'],
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 10,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top:
                          17, // Ajustez la position supérieure de l'icône de cœur
                      right: 10,
                      child: GestureDetector(
                        onTap: () {
                          // Appel de la méthode pour basculer l'état du produit favori
                          toggleFavoriteState(index);
                        },
                        child: Image.asset(
                          isFavorite
                              ? 'assets/images/cor.png'
                              : 'assets/images/hear.png', // Changez le chemin de l'image en fonction de l'état du produit favori
                          width: 22,
                          height: 22,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  String _calculateDiscountedPrice(String price, String discount) {
    double originalPrice = double.parse(price.substring(3));
    double discountPercentage = double.parse(discount.replaceAll('%', ''));
    double discountedPrice =
        originalPrice - (originalPrice * discountPercentage / 100);
    return discountedPrice.toStringAsFixed(1);
  }

  static String _truncateTitle(String title, int maxLength) {
    if (title.length > maxLength) {
      int lastIndex = title.lastIndexOf(' ', maxLength);
      return title.substring(0, lastIndex) + '...';
    }
    return title;
  }
}

class Grid extends StatefulWidget {
  const Grid({Key? key}) : super(key: key);

  @override
  _GridState createState() => _GridState();
}

class _GridState extends State<Grid> {
  late List<bool> showFullTitles;
  late List<bool> favoriteStates;

  Future<List<dynamic>> getProducts() async {
    final response =
        await http.get(Uri.parse("http://192.168.1.17:3003/product/products"));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as List<dynamic>;
      favoriteStates = List.generate(data.length,
          (_) => false); // Generate favoriteStates based on data length
      return data;
    } else {
      throw Exception('Failed to get data: ${response.statusCode}');
    }
  }

  @override
  void initState() {
    super.initState();
    futureProducts = getProducts();
    favoriteStates = [];
    // Initialiser la liste showFullTitles avec des valeurs par défaut à false
    showFullTitles = List.generate(6, (_) => false);
  }

  late Future<List<dynamic>> futureProducts;

  void toggleFavoriteState(int index) {
    setState(() {
      favoriteStates[index] = !favoriteStates[index];
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> gridMap = [
      {
        "price": "TND219",
        "title": "Hachoir à Viande Touch Avec Accessoires",
        "imagePath": "assets/images/ramadhan1.jpg",
        "discount": "-24%",
      },
      {
        "title": "KONIX DRAKKAR pack sorcerer",
        "price": "TND68",
        "imagePath": "assets/images/manette.jpg",
        "discount": "-34%",
      },
      {
        "title": "Montre connecté LINWEAR LW03 ",
        "price": "TND149",
        "imagePath": "assets/images/montre.jpg",
        "discount": "-54%",
      },
      {
        "title": "Whirpool hotte murale 60CM INOX",
        "price": "TND499",
        "imagePath": "assets/images/hotte.jpg",
        "discount": "-30%",
      },
      {
        "price": "TND799",
        "title": "TV SAMSUNG 32'' SMART-LED HD-T5300",
        "imagePath": "assets/images/img1.jpg",
        "discount": "-11%",
      },
    ];

    return Padding(
      padding: const EdgeInsets.only(bottom: 30.0),
      child: FutureBuilder<List<dynamic>>(
        future: futureProducts,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final List<dynamic> gridMap = snapshot.data!;
            final filteredGridMap = gridMap
                .where((item) => item['type'] == "offre de la semaine")
                .toList();

            if (filteredGridMap.isEmpty) {
              return Container(); // Retourner une vue vide si aucun produit de type "Meilleures Ventes" n'est trouvé
            }

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10.0,
                    mainAxisSpacing: 10.0,
                    mainAxisExtent: 200,
                  ),
                  itemCount: filteredGridMap.length,
                  itemBuilder: (_, index) {
                    final item = filteredGridMap[index];
                    final isFavorite = favoriteStates[index];
                    final String imageDataString = item[
                        'image']; // Supposons que les données binaires de l'image sont stockées dans un champ 'imageData' sous forme de chaîne de caractères

                    // Convertir la chaîne de caractères en Uint8List
                    final Uint8List imageData = base64Decode(
                        imageDataString); // Vous devez importer 'dart:convert' pour utiliser base64Decode

                    return GestureDetector(
                      onTap: () {
                        // Gérer l'action de clic sur un produit
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 2,
                              blurRadius: 5,
                              offset:
                                  Offset(0, 3), // changes position of shadow
                            ),
                          ],
                        ),
                        margin: EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(right: 8.0, top: 8),
                              child: Center(
                                child: Align(
                                  alignment: Alignment.centerRight,
                                  child: GestureDetector(
                                    onTap: () {
                                      toggleFavoriteState(index);
                                    },
                                    child: Image.asset(
                                      isFavorite
                                          ? 'assets/images/cor.png'
                                          : 'assets/images/hear.png',
                                      width: 24,
                                      height: 24,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: ClipRRect(
                                borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(20.0),
                                ),
                                child: Image.memory(
                                  imageData, // Utilisez vos données binaires ici
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                item['title'],
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xFF666666),
                                  fontSize: 14,
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'TND ${item['price']}',
                                    style: TextStyle(
                                      color: Color(0xFF006583),
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ],
            );
          }
        },
      ),
    );
  }

  String _calculateDiscountedPrice(String price, String discount) {
    double originalPrice = double.parse(price.substring(3));
    double discountPercentage = double.parse(discount.replaceAll('%', ''));
    double discountedPrice =
        originalPrice - (originalPrice * discountPercentage / 100);
    return discountedPrice.toStringAsFixed(1);
  }
}

class BrandItem extends StatelessWidget {
  const BrandItem({
    Key? key,
    required this.imageUrl,
  }) : super(key: key);

  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10.0),
        child: Image.asset(
          imageUrl,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
