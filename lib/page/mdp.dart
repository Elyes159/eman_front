import 'package:flutter/material.dart';
import 'sidebar.dart'; // Importez le fichier sidebar.dart contenant le contenu de la barre latérale

class MotDePassePage extends StatefulWidget {
  @override
  _MotDePassePageState createState() => _MotDePassePageState();
}

class _MotDePassePageState extends State<MotDePassePage> {
  
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
                        offset: Offset(-23, 0.0),
                        child: Text(
                          'Paramètre',
                          style: TextStyle(
                            fontSize: 30, // Augmentez la taille du titre
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20), // Ajoutez un espace entre les éléments
              Text(
                'Changer votre mot de passe',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF006583),
                ),
              ),
              SizedBox(height: 20),
              // Formulaire
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: EdgeInsets.all(20),
                child: Column(
                  children: [
                    _buildFormFieldWithTitle(
                      title: 'Ancien mot de passe',
                      hintText: 'Entrez votre ancien mot de passe',
                      icon: Icons.lock,
                    ),
                    SizedBox(height: 10),
                    _buildFormFieldWithTitle(
                      title: 'Nouveau mot de passe',
                      hintText: 'Entrez votre nouveau mot de passe',
                      icon: Icons.lock,
                    ),
                    SizedBox(height: 10),
                    _buildFormFieldWithTitle(
                      title: 'Confirmer le nouveau mot de passe',
                      hintText: 'Confirmez votre nouveau mot de passe',
                      icon: Icons.lock,
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        // A
                      },
                      child: Container(
                        width: 90, // Étendez le bouton sur toute la largeur
                        padding: EdgeInsets.symmetric(vertical: 8), // Ajustez le padding
                        child: Text(
                          'Confirmer',
                          style: TextStyle(
                            fontSize: 18, 
                            color: Colors.white// Augmentez la taille du texte du bouton
                          ),
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF006583), // Couleur d'arrière-plan du bouton
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      endDrawer: NavBar(), // Utiliser endDrawer pour afficher le drawer à droite
    );
  }

  // Fonction pour construire un champ de formulaire avec un titre, du texte et une icône
  Widget _buildFormFieldWithTitle({required String title, required String hintText, required IconData icon}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 5),
        Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.grey,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          child: TextFormField(
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 12,
              ),
              border: InputBorder.none,
              prefixIcon: Icon(icon),
              hintText: hintText,
            ),
          ),
        ),
      ],
    );
  }
}

