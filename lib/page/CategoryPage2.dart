import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:untitled2/page/page/favoris.dart';
import 'package:untitled2/page/page/home.dart';
import 'package:untitled2/page/parametre.dart';
import 'package:untitled2/page/recheche.dart';

class CategoryPage2 extends StatelessWidget {
  final List<Map<String, dynamic>> categories = [
    {'title': 'Eléctromenagers', 'imagePath': 'assets/images/menager.png'},
    {'title': 'TV', 'imagePath': 'assets/images/tele2.png'},
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
                  return Column(
                    children: [
                      SizedBox(height: 5),
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.white,
                          border:
                              Border.all(color: Colors.transparent, width: 1.2),
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
                  );
                },
              ),
            ),
            Positioned.fill(
              child: Transform.translate(
                offset: Offset(0, 130),
                child: SingleChildScrollView(
                  child: Container(
                    height: 800,
                    decoration: BoxDecoration(
                      color: Color(0xFFEFEFEF),
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(50.0),
                        // Radius pour les coins supérieurs
                        bottom: Radius.circular(50.0),
                        // Radius pour les coins inférieurs
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(24.0),
                      child: GridB(),
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

class GridB extends StatefulWidget {
  const GridB({Key? key}) : super(key: key);

  @override
  _GridBState createState() => _GridBState();
}

class _GridBState extends State<GridB> {
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
        "title": "TV SAMSUNG 32'SMART-LED HD-T5300",
        "imagePath": "assets/images/img1.jpg",
        "discount": "-11%",
      },
      {
        "title": "TV TCL 43 BASIC- LED FULL HD- D3200",
        "price": "TND759",
        "imagePath": "assets/images/tev.jpg",
        "discount": "-11%",
      },
      {
        "title": "TV TORNADO 32 SMART-RECEPTEUR INTEGRE-LED HD",
        "price": "TND1871",
        "imagePath": "assets/images/tevv.jpg",
        "discount": "-11%",
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Home()),
            ); // Retour à la page précédente (page d'accueil)
          },
          icon: Image.asset(
            'assets/images/flech1.png', // Remplacez 'home_icon.png' par le chemin de votre icône de page d'accueil
            width: 30,
            height: 30,
          ),
        ),
        GridView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10.0,
            mainAxisSpacing: 0.0,
            mainAxisExtent: 290,
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
