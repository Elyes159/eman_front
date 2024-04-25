import 'package:flutter/material.dart';
import 'package:untitled2/page/sidebar.dart';

class PaimentPage extends StatefulWidget {
  @override
  _PaimentPageState createState() => _PaimentPageState();
}

class _PaimentPageState extends State<PaimentPage> {
  String _selectedPaymentMethod = 'Espèces';

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
      body: Center(
        child: Container(
          constraints: BoxConstraints(maxWidth: 600),
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 208, 208, 219),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(50),
              topRight: Radius.circular(50),
            ),
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 5.0, top: 16.0),
                  child: Row(
                    children: [
                      IconButton(
                        icon: Icon(Icons.arrow_back),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                      Expanded(
                        child: Transform.translate(
                          offset: Offset(-25.0, 0.0),
                          child: Transform.scale(
                            scale: 0.9,
                            child: Text(
                              'Votre Panier',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Color.fromRGBO(8, 0, 0, 1),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                // Ajout des éléments du panier et des détails de paiement
                _buildImageItem(
                  'assets/images/img1.jpg',
                  'SKU: 43ES1502X \nTV TORNADO 43" SMART- RECEPTEUR INTEGRE- FULL HD \nQte:1',
                ),
                SizedBox(height: 5),
                _buildImageItem(
                  'assets/images/img2.jpg',
                  'SKU: UA32T5300 \nPC portable LENOVO ideapad AMD \nRYZEN 3 8GO 512GOssd \nQte:1',
                ),
                SizedBox(height: 5),
                _buildImageItem(
                  'assets/images/img3.jpg',
                  'SKU: MT726E\nBABYLISS TONDEUSE A CHEVEUX MT726E \nQte:1',
                  true,
                ),
                SizedBox(height: 20),
                _buildPriceDetails(),
                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                        onPressed: () {
                          _showConfirmationDialog();
                        },
                        child: Text(
                          'Valider',
                          style: TextStyle(color: Colors.white),
                        ),
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Color(0xFF006583)),
                          padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                              EdgeInsets.symmetric(horizontal: 160, vertical: 10)),
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                          ),
                        ),
                      ),
                      Spacer(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      endDrawer: NavBar(), // Utiliser endDrawer pour afficher le drawer à droite
    );
  }

  Widget _buildImageItem(String imagePath, String description,
      [bool isThirdItem = false]) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.asset(
                    imagePath,
                    height: 100,
                  ),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Text(
                  description,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 8),
        if (isThirdItem)
          Container(
            constraints: BoxConstraints(maxWidth: 370),
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30),
            ),
            padding: EdgeInsets.all(10),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: TextField(
                          textAlign: TextAlign.center,
                          decoration: InputDecoration(
                            hintText: 'Avez-vous un code promo ?',
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    ElevatedButton(
                      onPressed: () {
                        // Action lorsque le bouton Appliquer est appuyé
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF006583),
                      ),
                      child: Text(
                        'Appliquer',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
              ],
            ),
          ),
        SizedBox(height: 10),
      ],
    );
  }

  Widget _buildPriceDetails() {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _buildPriceDetailRow('Prix HT', '500TND ',
              fontWeight: FontWeight.bold, color: Colors.black, fontSize: 18),
          SizedBox(height: 10),
          _buildPriceDetailRow('TVA (20%)', '100TND ',
              fontWeight: FontWeight.bold, color: Colors.black, fontSize: 18),
          SizedBox(height: 10),
          _buildPriceDetailRow('Économisez', ' -50TND ',
              fontWeight: FontWeight.bold, color: Colors.black, fontSize: 18),
          SizedBox(height: 10),
          _buildPriceDetailRow('Total', '550TND ',
              fontWeight: FontWeight.bold,
              color: Color(0xFF006583),
              fontSize: 18),
          SizedBox(height: 10),
          Divider(color: Colors.black),
          SizedBox(height: 10),
          _buildPriceDetailRow('Méthode de paiement', _selectedPaymentMethod,
              fontWeight: FontWeight.bold,
              color: Color(0xFF006583),
              fontSize: 18),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Checkbox(
                        value: _selectedPaymentMethod == 'Espèces',
                        onChanged: (newValue) {
                          setState(() {
                            _selectedPaymentMethod =
                                // ignore: null_check_always_fails
                                (newValue ?? false) ? 'Espèces' : null!;
                          });
                        },
                      ),
                      Text(
                        'Espèces',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 2, 2, 2),
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Checkbox(
                        value: _selectedPaymentMethod == 'Paiement à la livraison',
                        onChanged: (newValue) {
                          setState(() {
                            // ignore: null_check_always_fails
                            _selectedPaymentMethod = (newValue ?? false) ? 'Paiement à la livraison' : null!;
                          });
                        },
                      ),
                      Text(
                        'Paiement à la livraison',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 6, 6, 6),
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 10),
          _buildPriceDetailRow('Adresse de Livraison ', 'Changer',
              fontWeight: FontWeight.bold,
              color: Color(0xFF006583),
              fontSize: 18),
          SizedBox(height: 10),
          _buildPriceDetailRow('+216 55 489 753 ', '',
              fontWeight: FontWeight.bold,
              color: Colors.black,
              fontSize: 18),
          SizedBox(height: 10),
          _buildPriceDetailRow('25.Rue Matériaux , charguia 1- Tunis ', '',
              fontWeight: FontWeight.bold,
              color: Colors.black,
              fontSize: 18),
        ],
      ),
    );
  }

  Widget _buildPriceDetailRow(String label, String amount,
      {FontWeight fontWeight = FontWeight.normal,
      Color color = const Color.fromARGB(255, 212, 210, 210),
      double fontSize = 16}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: color,
            fontSize: fontSize,
          ),
        ),
        Text(
          amount,
          style: TextStyle(
            fontWeight: fontWeight,
            color: color,
            fontSize: fontSize,
          ),
        ),
      ],
    );
  }

  void _showConfirmationDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Icon(Icons.shopping_cart, size: 70, color: Color(0xFF006583)),
          content: Text(
            "Votre commande a été effectuée avec succès. \nVos articles seront bientôt expédiés.",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          actions: <Widget>[
            TextButton(
              child: Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
