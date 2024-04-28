import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled2/page/CategoryPage1.dart';
import 'package:untitled2/page/CategoryPage2.dart';
import 'package:untitled2/page/CategoryPage3.dart';
import 'package:untitled2/page/CategoryPage4.dart';
import 'package:untitled2/page/CategoryPage5.dart';
import 'package:untitled2/page/favoris.dart';
import 'package:untitled2/page/page/home.dart';
import 'package:untitled2/page/page/notification.dart';
import 'package:untitled2/page/page/productpage.dart';
import 'package:untitled2/page/recheche.dart';
import 'package:untitled2/page/sidebar.dart';
import 'dart:typed_data';

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
  TextEditingController _rechercheController = TextEditingController();
  List<dynamic> _searchResults = [];

  void recherche() async {
    Map<String, String> headers = {
      'Content-Type': 'application/json',
    };

    try {
      final resp = await http.post(
        Uri.parse("http://192.168.1.17:3003/product/recherche"),
        headers: headers,
        body: jsonEncode({"terme": _rechercheController.text}),
      );

      if (resp.statusCode == 200) {
        List<dynamic> decodedResponse = jsonDecode(resp.body);
        List<dynamic> searchResults = decodedResponse;
        setState(() {
          _searchResults = searchResults;
        });
        print(_searchResults);
      } else {
        print('Erreur ${resp.statusCode}');
      }
    } catch (e) {
      print('Erreur: $e');
    }
  }

  int pageNo = 0;
  Timer? carasouelTmer;

  // Timer getTimer() {
  //   return Timer.periodic(const Duration(seconds: 2), (timer) {
  //     if (pageNo == 4) {
  //       pageNo = 0;
  //     }
  //     pageController.animateToPage(
  //       pageNo,
  //       duration: const Duration(seconds: 1),
  //       curve: Curves.easeInOutCirc,
  //     );
  //     pageNo++;
  //   });
  // }

  late Future<List<dynamic>> futureProducts;
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
    pageController = PageController(initialPage: 0, viewportFraction: 0.85);
    // carasouelTmer = getTimer();
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
    futureProducts = getProducts();
    favoriteStates = [];
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  bool showBtmAppBr = true;

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
      'title': 'Eléctroménager',
      'imagePath': 'assets/images/catt2.png',
      'width': 200.0,
      'height': 160.0
    },
    {
      'title': 'Smartphones',
      'imagePath': 'assets/images/catt1.png',
      'width': 220.0,
      'height': 400.0
    },
    {
      'title': 'Infomatiques',
      'imagePath': 'assets/images/catt3.png',
      'width': 200.0,
      'height': 160.0
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
      "imagePath": "assets/images/ramadhan2.png",
      "discount": "-60%",
    },
    {
      "title": "LIVOO ROBOT PÂTISSIER",
      "price": "TND183",
      "imagePath": "assets/images/ramadhan3.png",
      "discount": "-26%",
    },
  ];

  final List<Map<String, dynamic>> Brands = [
    {
      "imagePath": "assets/images/recherche5.png",
      "width": 100.0,
      "height": 57.0,
    },
    {
      "imagePath": "assets/images/recherche10.png",
      "width": 100.0,
      "height": 60.0,
    },
    {
      "imagePath": "assets/images/recherche22.png",
      "width": 80.0,
      "height": 60.0,
    },
    {
      "imagePath": "assets/images/opp.png",
      "width": 100.0,
      "height": 50.0,
    },
    {
      "imagePath": "assets/images/asus.png",
      "width": 90.0,
      "height": 50.0,
    },
    {
      "imagePath": "assets/images/recherche3.png",
      "width": 80.0,
      "height": 60.0,
    },
    {
      "imagePath": "assets/images/recherche8.png",
      "width": 90.0,
      "height": 60.0,
    },
  ];
  Future<String?> getTokenFromSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  Future<void> addToFavorites(String userId, String productId) async {
    String? token =
        await getTokenFromSharedPreferences(); // Obtenez le token de l'utilisateur depuis les préférences partagées

    if (token != null) {
      Map<String, String> headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token', // Envoyer le token dans les en-têtes
      };

      try {
        final resp = await http.put(
          Uri.parse("http://:3003/user/add-to-favorites/$userId/$productId"),
          headers: headers,
        );
        if (resp.statusCode == 200) {
          print('Produit ajouté aux favoris avec succès');
        } else if (resp.statusCode == 400) {
          print('Le produit existe déjà dans les favoris');
        } else if (resp.statusCode == 404) {
          print('Utilisateur ou produit non trouvé');
        } else {
          print('Erreur: ${resp.statusCode}');
        }
      } catch (e) {
        print('Erreur: $e');
      }
    } else {
      print('Token non trouvé localement');
    }
  }

  Future<String?> getUserIdFromToken(String token) async {
    Map<String, String> headers = {
      'Content-Type': 'application/json',
    };

    try {
      final resp = await http.get(
        Uri.parse("http://:3003/user/getByToken/$token"),
        headers: headers,
      );
      if (resp.statusCode == 200) {
        // Analyser la réponse JSON pour extraire le userId
        final userData = jsonDecode(resp.body);
        final userId = userData['_id'] as String;
        return userId;
      } else {
        print('Erreur lors de la récupération du userId: ${resp.statusCode}');
        return null;
      }
    } catch (e) {
      print('Erreur lors de la récupération du userId: $e');
      return null;
    }
  }

  Future<void> removeFromFavorites(String userId, String productId) async {
    String? token =
        await getTokenFromSharedPreferences(); // Récupérer le token de l'utilisateur
    if (token != null) {
      Map<String, String> headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token', // Envoyer le token dans les en-têtes
      };

      try {
        final resp = await http.delete(
          Uri.parse(
              "http://:3003/user/remove-from-favorites/$userId/$productId"),
          headers: headers,
        );
        if (resp.statusCode == 200) {
          print('Produit retiré des favoris avec succès');
        } else if (resp.statusCode == 400) {
          print("Le produit n'existe pas dans les favoris");
        } else if (resp.statusCode == 404) {
          print('Utilisateur non trouvé');
        } else {
          print('Erreur: ${resp.statusCode}');
        }
      } catch (e) {
        print('Erreur: $e');
      }
    } else {
      print('Token non trouvé localement');
    }
  }

  void toggleFavoriteState(int index, String userId, String products) {
    setState(() {
      // Vous pouvez maintenant utiliser userId pour ajouter ou supprimer le produit des favoris pour cet utilisateur
      favoriteStates[index] = !favoriteStates[index];

      // Ajouter ou supprimer le produit des favoris dans la base de données en utilisant le userId
      if (favoriteStates[index]) {
        addToFavorites(userId, products); // Ajouter le produit aux favoris
      } else {
        removeFromFavorites(
            userId, products); // Supprimer le produit des favoris
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
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
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => NavBar()),
                          );
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 15),
                Row(
                  children: [
                    Container(
                      width: 300,
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: TextFormField(
                        controller: _rechercheController,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(vertical: 10.0),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.0),
                            borderSide: BorderSide(
                                color: Color(0xFF006583), width: 1.2),
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
                    IconButton(
                      onPressed: () async {
                        recherche();
                      },
                      icon: Icon(Icons.search),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                // Display search results here
                Expanded(
                  child: ListView.builder(
                    itemCount: _searchResults.length,
                    itemBuilder: (context, index) {
                      // Render each search result item
                      return ListTile(
                        title: Text(_searchResults[index]['name']),
                        subtitle: Text(_searchResults[index]['description']),
                      );
                    },
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
                                builder: (context) => CategoryPage2()),
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
                    height: 5000,
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

                            SizedBox(height: 1.0),
                            Stack(
                              children: [
                                Container(
                                  margin: EdgeInsets.only(right: 14.0),
                                  decoration: const BoxDecoration(
                                    color: Color(0xFFFFD902),
                                    borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(50.0),
                                      bottomRight: Radius.circular(50.0),
                                    ),
                                  ),
                                  height: 430,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 28.0, vertical: 15.0),
                                  child: FutureBuilder<List<dynamic>>(
                                    future: futureProducts,
                                    builder: (context, snapshot) {
                                      if (snapshot.connectionState ==
                                          ConnectionState.waiting) {
                                        return Center(
                                            child: CircularProgressIndicator());
                                      } else if (snapshot.hasError) {
                                        return Center(
                                            child: Text(
                                                'Error: ${snapshot.error}'));
                                      } else {
                                        final List<dynamic> nouveautes =
                                            snapshot.data!;
                                        final List<dynamic> filteredNouveautes =
                                            nouveautes
                                                .where((item) =>
                                                    item['type'] == 'Nouveauté')
                                                .toList();

                                        if (filteredNouveautes.isEmpty) {
                                          return Container(); // Retourner une vue vide si aucune nouveauté n'est trouvée
                                        }

                                        // Convertir la chaîne de caractères en Uint8List
                                        final Uint8List imageData =
                                            base64Decode(
                                                filteredNouveautes[0]['image']);

                                        return Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const Text(
                                              "Nouveautés",
                                              style: TextStyle(
                                                fontSize: 25.0,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            Transform.translate(
                                              offset: Offset(0, -4),
                                              child: const Text(
                                                "Découvrez les derniers produits",
                                                style: TextStyle(
                                                  fontSize: 12.0,
                                                  fontWeight: FontWeight.w600,
                                                  color: Color(0xFF666666),
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 20,
                                            ),
                                            Transform.translate(
                                              offset: Offset(0, -14),
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                                child: Image.memory(
                                                  imageData,
                                                  width: 100,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                            Transform.translate(
                                              offset: Offset(-0.5, 10),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  // Afficher d'autres nouveautés ici en utilisant les données filtrées
                                                ],
                                              ),
                                            ),
                                          ],
                                        );
                                      }
                                    },
                                  ),
                                )
                              ],
                            ), //Fin de Nouveaute
                            SizedBox(
                              height: 10,
                            ),
                            Stack(
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 1.0, vertical: 1.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Transform.translate(
                                        offset: Offset(5, 0),
                                        child: Text(
                                          "Top catégories",
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 10),
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 1.0, vertical: 1.0),
                                        child: FutureBuilder<List<dynamic>>(
                                          future: futureProducts,
                                          builder: (context, snapshot) {
                                            if (snapshot.connectionState ==
                                                ConnectionState.waiting) {
                                              return Center(
                                                  child:
                                                      CircularProgressIndicator());
                                            } else if (snapshot.hasError) {
                                              return Center(
                                                  child: Text(
                                                      'Error: ${snapshot.error}'));
                                            } else {
                                              final List<dynamic> categorie =
                                                  snapshot.data!;
                                              final filteredCategories =
                                                  categorie
                                                      .where((item) =>
                                                          item['type'] ==
                                                          "top categorie")
                                                      .toList();

                                              if (filteredCategories.isEmpty) {
                                                return Container(); // Retourner une vue vide si aucune catégorie de type "Top Catégories" n'est trouvée
                                              }

                                              return Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  SizedBox(height: 10),
                                                  Container(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 25.0,
                                                            vertical: 15.0),
                                                    child: FutureBuilder<
                                                        List<dynamic>>(
                                                      future: futureProducts,
                                                      builder:
                                                          (context, snapshot) {
                                                        if (snapshot
                                                                .connectionState ==
                                                            ConnectionState
                                                                .waiting) {
                                                          return Center(
                                                              child:
                                                                  CircularProgressIndicator());
                                                        } else if (snapshot
                                                            .hasError) {
                                                          return Center(
                                                              child: Text(
                                                                  'Error: ${snapshot.error}'));
                                                        } else {
                                                          final List<dynamic>
                                                              gridMap =
                                                              snapshot.data!;
                                                          final filteredGridMap = gridMap
                                                              .where((item) =>
                                                                  item[
                                                                      'type'] ==
                                                                  "top categorie")
                                                              .toList();

                                                          if (filteredGridMap
                                                              .isEmpty) {
                                                            return Container(); // Retourner une vue vide si aucun produit de type "Meilleures Ventes" n'est trouvé
                                                          }

                                                          return Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              GridView.builder(
                                                                physics:
                                                                    const NeverScrollableScrollPhysics(),
                                                                shrinkWrap:
                                                                    true,
                                                                gridDelegate:
                                                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                                                  crossAxisCount:
                                                                      2,
                                                                  crossAxisSpacing:
                                                                      10.0,
                                                                  mainAxisSpacing:
                                                                      10.0,
                                                                  mainAxisExtent:
                                                                      200,
                                                                ),
                                                                itemCount:
                                                                    filteredGridMap
                                                                        .length,
                                                                itemBuilder:
                                                                    (_, index) {
                                                                  final item =
                                                                      filteredGridMap[
                                                                          index];
                                                                  final isFavorite =
                                                                      favoriteStates[
                                                                          index];
                                                                  final String
                                                                      imageDataString =
                                                                      item[
                                                                          'image']; // Supposons que les données binaires de l'image sont stockées dans un champ 'imageData' sous forme de chaîne de caractères

                                                                  // Convertir la chaîne de caractères en Uint8List
                                                                  final Uint8List
                                                                      imageData =
                                                                      base64Decode(
                                                                          imageDataString); // Vous devez importer 'dart:convert' pour utiliser base64Decode

                                                                  return GestureDetector(
                                                                    onTap: () {
                                                                      // Gérer l'action de clic sur un produit
                                                                    },
                                                                    child:
                                                                        Container(
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        borderRadius:
                                                                            BorderRadius.circular(20.0),
                                                                        color: Colors
                                                                            .white,
                                                                        boxShadow: [
                                                                          BoxShadow(
                                                                            color:
                                                                                Colors.grey.withOpacity(0.5),
                                                                            spreadRadius:
                                                                                2,
                                                                            blurRadius:
                                                                                5,
                                                                            offset:
                                                                                Offset(0, 3), // changes position of shadow
                                                                          ),
                                                                        ],
                                                                      ),
                                                                      margin: EdgeInsets
                                                                          .all(
                                                                              8.0),
                                                                      child:
                                                                          Column(
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.start,
                                                                        children: [
                                                                          Padding(
                                                                            padding:
                                                                                const EdgeInsets.only(right: 8.0, top: 8),
                                                                            child:
                                                                                Center(
                                                                              child: Align(
                                                                                  alignment: Alignment.centerRight,
                                                                                  child: GestureDetector(
                                                                                    onTap: () async {
                                                                                      String? token = await getTokenFromSharedPreferences(); // Récupérer le token de l'utilisateur
                                                                                      if (token != null) {
                                                                                        String? userId = await getUserIdFromToken(token); // Récupérer le userId à partir du token
                                                                                        if (userId != null) {
                                                                                          // String productId = products[index].id; // Récupérer l'ID du produit à partir de la liste des produits
                                                                                          toggleFavoriteState(index, userId, item['_id']); // Appeler toggleFavoriteState avec index, userId et productId
                                                                                        } else {
                                                                                          print('Impossible de récupérer le userId');
                                                                                        }
                                                                                      } else {
                                                                                        print('Token non trouvé localement');
                                                                                      }
                                                                                    },
                                                                                    child: Image.asset(
                                                                                      isFavorite ? 'assets/images/cor.png' : 'assets/images/hear.png',
                                                                                      width: 24,
                                                                                      height: 24,
                                                                                    ),
                                                                                  )),
                                                                            ),
                                                                          ),
                                                                          Expanded(
                                                                            child:
                                                                                ClipRRect(
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
                                                                            padding:
                                                                                const EdgeInsets.all(8.0),
                                                                            child:
                                                                                Text(
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
                                                                            child:
                                                                                Row(
                                                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                                  )
                                                ],
                                              );
                                            }
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ), //fin category

                            SizedBox(height: 1.0),
                            Stack(
                              children: [
                                Container(
                                  margin: EdgeInsets.only(left: 14.0),
                                  decoration: const BoxDecoration(
                                    color: Color(0xFFac9ece),
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(50.0),
                                      bottomLeft: Radius.circular(50.0),
                                    ),
                                  ),
                                  height: 430,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 28.0, vertical: 15.0),
                                  child: FutureBuilder<List<dynamic>>(
                                    future: futureProducts,
                                    builder: (context, snapshot) {
                                      if (snapshot.connectionState ==
                                          ConnectionState.waiting) {
                                        return Center(
                                            child: CircularProgressIndicator());
                                      } else if (snapshot.hasError) {
                                        return Center(
                                            child: Text(
                                                'Error: ${snapshot.error}'));
                                      } else {
                                        final List<dynamic> nouveautes =
                                            snapshot.data!;
                                        final List<dynamic> filteredNouveautes =
                                            nouveautes
                                                .where((item) =>
                                                    item['type'] == 'gaming')
                                                .toList();

                                        if (filteredNouveautes.isEmpty) {
                                          return Container(); // Retourner une vue vide si aucune nouveauté n'est trouvée
                                        }

                                        // Convertir la chaîne de caractères en Uint8List
                                        final Uint8List imageData =
                                            base64Decode(
                                                filteredNouveautes[0]['image']);

                                        return Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const Text(
                                              "Gaming",
                                              style: TextStyle(
                                                fontSize: 25.0,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            Transform.translate(
                                              offset: Offset(0, -4),
                                              child: const Text(
                                                "Plongez dans l'univers de gaming",
                                                style: TextStyle(
                                                  fontSize: 12.0,
                                                  fontWeight: FontWeight.w600,
                                                  color: Color(0xFF666666),
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 20,
                                            ),
                                            Transform.translate(
                                              offset: Offset(0, -14),
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                                child: Image.memory(
                                                  imageData,
                                                  width: 100,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                            Transform.translate(
                                              offset: Offset(-0.5, 10),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  // Afficher d'autres nouveautés ici en utilisant les données filtrées
                                                ],
                                              ),
                                            ),
                                          ],
                                        );
                                      }
                                    },
                                  ),
                                )
                              ],
                            ), //fin gaming

                            SizedBox(height: 1),
                            Stack(
                              children: [
                                Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 1.0, vertical: 1.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Stack(
                                          children: [
                                            Container(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 18.0,
                                                  vertical: 15.0),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    children: [
                                                      Image.asset(
                                                        'assets/images/ramadan.png',
                                                        width: 20,
                                                        height: 20,
                                                      ),
                                                      SizedBox(width: 5.0),
                                                      Text(
                                                        "Offre Ramadhan 2024",
                                                        style: TextStyle(
                                                          fontSize: 18.0,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          color: Colors.black,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 5),
                                        Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 1.0, vertical: 1.0),
                                          child: FutureBuilder<List<dynamic>>(
                                            future: futureProducts,
                                            builder: (context, snapshot) {
                                              if (snapshot.connectionState ==
                                                  ConnectionState.waiting) {
                                                return Center(
                                                    child:
                                                        CircularProgressIndicator());
                                              } else if (snapshot.hasError) {
                                                return Center(
                                                    child: Text(
                                                        'Error: ${snapshot.error}'));
                                              } else {
                                                final List<dynamic> categorie =
                                                    snapshot.data!;
                                                final filteredCategories =
                                                    categorie
                                                        .where((item) =>
                                                            item['type'] ==
                                                            "offre")
                                                        .toList();

                                                if (filteredCategories
                                                    .isEmpty) {
                                                  return Container(); // Retourner une vue vide si aucune catégorie de type "Top Catégories" n'est trouvée
                                                }

                                                return Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    SizedBox(height: 10),
                                                    Container(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 15.0,
                                                              vertical: 10.0),
                                                      child: FutureBuilder<
                                                          List<dynamic>>(
                                                        future: futureProducts,
                                                        builder: (context,
                                                            snapshot) {
                                                          if (snapshot
                                                                  .connectionState ==
                                                              ConnectionState
                                                                  .waiting) {
                                                            return Center(
                                                                child:
                                                                    CircularProgressIndicator());
                                                          } else if (snapshot
                                                              .hasError) {
                                                            return Center(
                                                                child: Text(
                                                                    'Error: ${snapshot.error}'));
                                                          } else {
                                                            final List<dynamic>
                                                                gridMap =
                                                                snapshot.data!;
                                                            final filteredGridMap = gridMap
                                                                .where((item) =>
                                                                    item[
                                                                        'type'] ==
                                                                    "offre")
                                                                .toList();

                                                            if (filteredGridMap
                                                                .isEmpty) {
                                                              return Container(); // Retourner une vue vide si aucun produit de type "Meilleures Ventes" n'est trouvé
                                                            }

                                                            return Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                GridView
                                                                    .builder(
                                                                  physics:
                                                                      const NeverScrollableScrollPhysics(),
                                                                  shrinkWrap:
                                                                      true,
                                                                  gridDelegate:
                                                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                                                    crossAxisCount:
                                                                        2,
                                                                    crossAxisSpacing:
                                                                        10.0,
                                                                    mainAxisSpacing:
                                                                        10.0,
                                                                    mainAxisExtent:
                                                                        200,
                                                                  ),
                                                                  itemCount:
                                                                      filteredGridMap
                                                                          .length,
                                                                  itemBuilder:
                                                                      (_, index) {
                                                                    final item =
                                                                        filteredGridMap[
                                                                            index];
                                                                    final isFavorite =
                                                                        favoriteStates[
                                                                            index];
                                                                    final String
                                                                        imageDataString =
                                                                        item[
                                                                            'image']; // Supposons que les données binaires de l'image sont stockées dans un champ 'imageData' sous forme de chaîne de caractères

                                                                    // Convertir la chaîne de caractères en Uint8List
                                                                    final Uint8List
                                                                        imageData =
                                                                        base64Decode(
                                                                            imageDataString); // Vous devez importer 'dart:convert' pour utiliser base64Decode

                                                                    return GestureDetector(
                                                                      onTap:
                                                                          () {
                                                                        // Gérer l'action de clic sur un produit
                                                                      },
                                                                      child:
                                                                          Container(
                                                                        decoration:
                                                                            BoxDecoration(
                                                                          borderRadius:
                                                                              BorderRadius.circular(20.0),
                                                                          color:
                                                                              Colors.white,
                                                                          boxShadow: [
                                                                            BoxShadow(
                                                                              color: Colors.grey.withOpacity(0.5),
                                                                              spreadRadius: 2,
                                                                              blurRadius: 5,
                                                                              offset: Offset(0, 3), // changes position of shadow
                                                                            ),
                                                                          ],
                                                                        ),
                                                                        margin:
                                                                            EdgeInsets.all(8.0),
                                                                        child:
                                                                            Column(
                                                                          crossAxisAlignment:
                                                                              CrossAxisAlignment.start,
                                                                          children: [
                                                                            Padding(
                                                                              padding: const EdgeInsets.only(right: 8.0, top: 8),
                                                                              child: Center(
                                                                                child: Align(
                                                                                    alignment: Alignment.centerRight,
                                                                                    child: GestureDetector(
                                                                                      onTap: () async {
                                                                                        String? token = await getTokenFromSharedPreferences(); // Récupérer le token de l'utilisateur
                                                                                        if (token != null) {
                                                                                          String? userId = await getUserIdFromToken(token); // Récupérer le userId à partir du token
                                                                                          if (userId != null) {
                                                                                            // String productId = products[index].id; // Récupérer l'ID du produit à partir de la liste des produits
                                                                                            toggleFavoriteState(index, userId, item['_id']); // Appeler toggleFavoriteState avec index, userId et productId
                                                                                          } else {
                                                                                            print('Impossible de récupérer le userId');
                                                                                          }
                                                                                        } else {
                                                                                          print('Token non trouvé localement');
                                                                                        }
                                                                                      },
                                                                                      child: Image.asset(
                                                                                        isFavorite ? 'assets/images/cor.png' : 'assets/images/hear.png',
                                                                                        width: 24,
                                                                                        height: 24,
                                                                                      ),
                                                                                    )),
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
                                                                              padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                                                              child: Row(
                                                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                                    )
                                                  ],
                                                );
                                              }
                                            },
                                          ),
                                        ),
                                      ],
                                    )),
                              ],
                            ), //fin ramadhan

                            SizedBox(height: 1.0),
                            Stack(
                              children: [
                                Container(
                                  margin: EdgeInsets.only(right: 14.0),
                                  decoration: const BoxDecoration(
                                    color: Color(0xFFADC1BC),
                                    borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(50.0),
                                      bottomRight: Radius.circular(50.0),
                                    ),
                                  ),
                                  height: 430,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 28.0, vertical: 15.0),
                                  child: FutureBuilder<List<dynamic>>(
                                    future: futureProducts,
                                    builder: (context, snapshot) {
                                      if (snapshot.connectionState ==
                                          ConnectionState.waiting) {
                                        return Center(
                                            child: CircularProgressIndicator());
                                      } else if (snapshot.hasError) {
                                        return Center(
                                            child: Text(
                                                'Error: ${snapshot.error}'));
                                      } else {
                                        final List<dynamic> nouveautes =
                                            snapshot.data!;
                                        final List<dynamic> filteredNouveautes =
                                            nouveautes
                                                .where((item) =>
                                                    item['type'] ==
                                                    'notre selection')
                                                .toList();

                                        if (filteredNouveautes.isEmpty) {
                                          return Container(); // Retourner une vue vide si aucune nouveauté n'est trouvée
                                        }

                                        // Convertir la chaîne de caractères en Uint8List
                                        final Uint8List imageData =
                                            base64Decode(
                                                filteredNouveautes[0]['image']);

                                        return Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const Text(
                                              "Notre sélection",
                                              style: TextStyle(
                                                fontSize: 25.0,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            SizedBox(
                                              height: 20,
                                            ),
                                            Transform.translate(
                                              offset: Offset(0, -14),
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                                child: Image.memory(
                                                  imageData,
                                                  width: 100,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                            Transform.translate(
                                              offset: Offset(-0.5, 10),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  // Afficher d'autres nouveautés ici en utilisant les données filtrées
                                                ],
                                              ),
                                            ),
                                          ],
                                        );
                                      }
                                    },
                                  ),
                                )
                              ],
                            ), //fin selection

                            SizedBox(
                              height: 10,
                            ),
                            Stack(
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 25.0, vertical: 15.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Transform.translate(
                                        offset: Offset(5, 0),
                                        child: Text(
                                          "Tendances",
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 4.0),
                                      // Add some space between row and grid
                                      GriA(),
                                    ],
                                  ),
                                ),
                              ],
                            ), //fin tendance

                            SizedBox(height: 1.0),
                            Stack(
                              children: [
                                Container(
                                  margin: EdgeInsets.only(left: 14.0),
                                  decoration: const BoxDecoration(
                                    color: Color(0xFF00A3FF),
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(50.0),
                                      bottomLeft: Radius.circular(50.0),
                                    ),
                                  ),
                                  height: 430,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 28.0, vertical: 15.0),
                                  child: FutureBuilder<List<dynamic>>(
                                    future: futureProducts,
                                    builder: (context, snapshot) {
                                      if (snapshot.connectionState ==
                                          ConnectionState.waiting) {
                                        return Center(
                                            child: CircularProgressIndicator());
                                      } else if (snapshot.hasError) {
                                        return Center(
                                            child: Text(
                                                'Error: ${snapshot.error}'));
                                      } else {
                                        final List<dynamic> nouveautes =
                                            snapshot.data!;
                                        final List<dynamic> filteredNouveautes =
                                            nouveautes
                                                .where((item) =>
                                                    item['type'] ==
                                                    'electromenager')
                                                .toList();

                                        if (filteredNouveautes.isEmpty) {
                                          return Container(); // Retourner une vue vide si aucune nouveauté n'est trouvée
                                        }

                                        // Convertir la chaîne de caractères en Uint8List
                                        final Uint8List imageData =
                                            base64Decode(
                                                filteredNouveautes[0]['image']);

                                        return Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const Text(
                                              "Électroménager",
                                              style: TextStyle(
                                                fontSize: 25.0,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            Transform.translate(
                                              offset: Offset(0, -4),
                                              child: const Text(
                                                "Découvrez notre gamme d'électroménagers intelligents",
                                                style: TextStyle(
                                                  fontSize: 12.0,
                                                  fontWeight: FontWeight.w600,
                                                  color: Color(0xFF666666),
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 20,
                                            ),
                                            Transform.translate(
                                              offset: Offset(0, -14),
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                                child: Image.memory(
                                                  imageData,
                                                  width: 100,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                            Transform.translate(
                                              offset: Offset(-0.5, 10),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  // Afficher d'autres nouveautés ici en utilisant les données filtrées
                                                ],
                                              ),
                                            ),
                                          ],
                                        );
                                      }
                                    },
                                  ),
                                )
                              ],
                            ), //fin electro

                            SizedBox(
                              height: 10,
                            ),
                            Stack(
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 25.0, vertical: 15.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Image.asset(
                                            'assets/images/argent.png',
                                            width: 20,
                                            height: 20,
                                          ),
                                          SizedBox(width: 5.0),
                                          Text(
                                            "Offre de la semaine",
                                            style: TextStyle(
                                              fontSize: 18.0,
                                              fontWeight: FontWeight.w600,
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
                            ), //fin de offre

                            Transform.translate(
                              offset: Offset(0, -80),
                              child: Stack(
                                children: [
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 5.0, vertical: 15.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          height: 100,
                                          child: ListView.builder(
                                            scrollDirection: Axis.horizontal,
                                            itemCount: Brands.length,
                                            itemBuilder: (context, index) {
                                              return Stack(
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 5.0),
                                                    child: ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20.0),
                                                      child: Container(
                                                        width: Brands[index]
                                                            ['width'],
                                                        height: Brands[index]
                                                            ['height'],
                                                        margin: EdgeInsets.only(
                                                            bottom: 15.0,
                                                            left: 5,
                                                            right: 5),
                                                        child: Image.asset(
                                                          Brands[index]
                                                              ['imagePath'],
                                                          fit: BoxFit.cover,
                                                        ),
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
                            ),
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

  String _calculateDiscountedPrice(String price, String discount) {
    double originalPrice = double.parse(price.substring(3));
    double discountPercentage = double.parse(discount.replaceAll('%', ''));
    double discountedPrice =
        originalPrice - (originalPrice * discountPercentage / 100);
    return discountedPrice.toStringAsFixed(1);
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
              MaterialPageRoute(builder: (context) => RecherchePage()),
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
        padding: const EdgeInsets.all(20.0),
      ),
    );
  }
}

class Product {
  final String id;
  final String title;
  final double price;
  final String imageUrl;

  Product(
      {required this.id,
      required this.title,
      required this.price,
      required this.imageUrl});

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['_id'],
      title: json['title'],
      price: json['price'].toDouble(),
      imageUrl: json['Image'] ??
          'assets/images/1.png', // Use a placeholder if no image provided
    );
  }
}

class GridB extends StatefulWidget {
  const GridB({Key? key}) : super(key: key);

  @override
  _GridBState createState() => _GridBState();
}

class _GridBState extends State<GridB> {
  late Future<List<dynamic>> futureProducts;
  late List<bool> favoriteStates;

  @override
  void initState() {
    super.initState();
    futureProducts = getProducts();
    favoriteStates = [];
  }

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

  void toggleFavoriteState(int index) {
    setState(() {
      favoriteStates[index] = !favoriteStates[index];
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<dynamic>>(
      future: futureProducts,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          final List<dynamic> gridMap = snapshot.data!;
          final filteredGridMap = gridMap
              .where((item) => item['type'] == "Meilleurs ventes")
              .toList();

          if (filteredGridMap.isEmpty) {
            return Container(); // Retourner une vue vide si aucun produit de type "Meilleures Ventes" n'est trouvé
          }

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  "Meilleurs ventes",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
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
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProductPage(
                            title: item['title'],
                            id: item['_id'],
                            name: item['name'],
                            description: item['description'],
                            price: item['price'],
                            brands: item['brands'],
                            cupons: item['cupons'],
                            disponibilite: item['disponibilite'],
                            caracteristique: item['caracteristique'],
                            image: item['image'],
                            type: item['type'],
                          ),
                        ),
                      );
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
                            offset: Offset(0, 3), // changes position of shadow
                          ),
                        ],
                      ),
                      margin: EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 8.0, top: 8),
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
    );
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
        "title": "CARTE GRAPHIQUE GIGABYTE GEFORCE",
        "price": "TND159.3",
        "imagePath": "assets/images/img3.jpg",
        "discount": "-30%",
      },
      {
        "title": "CARTE GRAPHIQUE GIGABYTE GEFORCE",
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

    late List<bool> favoriteStates;
    Future<List<dynamic>> getProducts() async {
      final response = await http
          .get(Uri.parse("http://192.168.1.17:3003/product/products"));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body) as List<dynamic>;
        favoriteStates = List.generate(data.length, (_) => false);
        return data;
      } else {
        throw Exception('Failed to get data: ${response.statusCode}');
      }
    }

    late Future<List<dynamic>> futureProducts =
        getProducts(); // Initialisation directe

    @override
    void initState() {
      super.initState();
      favoriteStates = [];
    }

    void toggleFavoriteState(int index) {
      setState(() {
        favoriteStates[index] = !favoriteStates[index];
      });
    }

    return FutureBuilder<List<dynamic>>(
      future: futureProducts,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          final List<dynamic> gridMap = snapshot.data!;
          final filteredGridMap =
              gridMap.where((item) => item['type'] == "tendance").toList();

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
                            offset: Offset(0, 3), // changes position of shadow
                          ),
                        ],
                      ),
                      margin: EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 8.0, top: 8),
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
