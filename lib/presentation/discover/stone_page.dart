import 'package:flutter/material.dart';
import 'package:ipm_project/presentation/discover/AR_page.dart';

class StonePage extends StatefulWidget {
  final String picture;
  const StonePage({Key? key, required this.picture}) : super(key: key);
  @override
  _StonePage createState() => _StonePage(picture);
}

class _StonePage extends State<StonePage> {

  String dinoType = "";
  final String picture;
  _StonePage(this.picture);

  @override
  void initState(){

    switch(picture){
      case "tri": dinoType = "triceratops_dinosaur"; break;
      case "tex": dinoType = "tyrannosaur_fight"; break;
      case "long": dinoType = "brachiosaurus_ar_card"; break;
      case "velociraptor": dinoType = "velociraptor%20(1)"; break;
      case "mos": dinoType = "mosasaurus%20(1)"; break;
      case "pleio": dinoType = "plesio"; break;
      case "squid": dinoType = "squid"; break;
      case "espino": dinoType = "spinosaurus_animation"; break;
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor:  Color.fromARGB(255, 30, 30, 30),
        title: const Text('Explore the Museum',
            style: TextStyle(color: Colors.white)),
        centerTitle: true, // This centers the title
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Center(
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            // Positioned Base image
            Positioned.fill(
              child: Image.asset('assets/images/stones/$picture.png', fit: BoxFit.fill),
            ),
            Positioned(
              bottom: MediaQuery.of(context).size.height * 0.05, // Adjust this value to move the entire group
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => AugmentedRealityPage(dinoType: dinoType,)));
                },
                child: Container(
                padding: EdgeInsets.fromLTRB(25, 5, 25, 35), // Add some padding if needed
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.5), // Black color with 25% opacity
                      spreadRadius: 5, // Spread radius
                      blurRadius: 10, // Blur radius
                      offset: Offset(0, 0), // Changes position of shadow
                    ),
                  ],
                  shape: BoxShape.circle, // Circular shape
                  color: Colors.grey.withOpacity(0.5),
                ),
                child: const Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                     Icon(Icons.vrpano_outlined, size: 70.0, color: Colors.white,), // Camera icon
                     Text(
                      'Bring it to life!',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17, color: Colors.white),
                    ),
                  ],
                )),
              ),
            )
          ],
        ),
      ),
    );
  }


}
