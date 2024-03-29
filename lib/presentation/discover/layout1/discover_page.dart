import 'package:flutter/material.dart';
import 'package:ipm_project/presentation/discover/camera_page.dart';
import 'package:ipm_project/presentation/discover/dinosaur_page.dart';
import 'package:ipm_project/presentation/discover/layout1/quiz1_page.dart';
import 'package:ipm_project/presentation/discover/layout2/map2_page.dart';
import 'package:ipm_project/presentation/discover/picture_taken_page.dart';
import 'package:ipm_project/presentation/welcome_page.dart';
import 'package:ipm_project/presentation/discover/quiz_done_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:showcaseview/showcaseview.dart';

class DiscoverPage extends StatefulWidget {
  const DiscoverPage({super.key});

  @override
  _MyDiscoverPage createState() => _MyDiscoverPage();
}

class _MyDiscoverPage extends State<DiscoverPage> {
  final GlobalKey _oneKey = GlobalKey();
  final GlobalKey _twoKey = GlobalKey();
  final GlobalKey _threeKey = GlobalKey();
  final GlobalKey _fourKey = GlobalKey();
  final GlobalKey _fiveKey = GlobalKey();
  final GlobalKey _sixKey = GlobalKey();
  final GlobalKey _sevenKey = GlobalKey();

  Future<bool> _checkIfTutorialShown() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool('tutorial') ?? false;
  }

  Future<void> _setTutorialShown() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('tutorial', true);
  }

  @override
  Widget build(BuildContext context) {
    _checkIfTutorialShown().then((tutorialShown) {
      if (!tutorialShown) {
        Future.delayed(Duration.zero, () {
          ShowCaseWidget.of(context).startShowCase([
            _oneKey,
            _twoKey,
            _threeKey,
            _fourKey,
            _fiveKey,
            _sixKey,
            _sevenKey,
          ]);
          _setTutorialShown();
        });
      }
    });

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 30, 30, 30),
        title: const Text(
          'Explore the Museum',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
            // alignment: Alignment.centerRight,
            icon: const Icon(Icons.question_mark, color: Colors.white),
            onPressed: () async {
              final SharedPreferences prefs =
                  await SharedPreferences.getInstance();
              await prefs.setBool('tutorial', false);
              setState(() {});
            },
          ),
        ],
        centerTitle: true, // This centers the title
        leading: IconButton(
            icon: const Icon(Icons.home, color: Colors.white),
            onPressed: () => Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const WelcomePage()))),
      ),
      body: Center(
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            // Positioned Base image
            Positioned.fill(
              child: Image.asset('assets/images/mapa1.jpg', fit: BoxFit.fill),
            ),
            _buildCenteredShowcase(context,
                '    Welcome to\n     The National History Museum!', _oneKey),
            _buildCenteredShowcase(
                context,
                'Throughout your journey different challenges will be available to you',
                _fourKey),
            _buildCenteredShowcase(
                context,
                'Complete them to earn points and be able to unlock rewards at our store!',
                _fiveKey),
            Positioned(
              top: MediaQuery.of(context).size.height * 0.36,
              right: MediaQuery.of(context).size.width * 0.005,
              child: GestureDetector(
                onTap: () {
                  print("Clicked Arrow 2");
                  Navigator.of(context).replace(
                    oldRoute: ModalRoute.of(context)!,
                    newRoute:
                        MaterialPageRoute(builder: (context) => const Map2Page()),
                  );
                },
                child: Container(
                  width: MediaQuery.of(context).size.width *
                      0.1, // Specify the width
                  height: MediaQuery.of(context).size.height *
                      0.05, // Use width to ensure the container is a circle
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.30),
                        spreadRadius: 5,
                        blurRadius: 15,
                        offset:
                            const Offset(0, 0), // changes position of shadow
                      ),
                    ],
                    color: Colors
                        .transparent, // Set to transparent or any other color
                    shape: BoxShape.rectangle, // Set the shape to a circle
                  ),
                ),
              ),
            ),
            Positioned(
              top: MediaQuery.of(context).size.height * 0.145,
              right: MediaQuery.of(context).size.width * 0.005,
              child: Showcase(
                  key: _threeKey,
                  description: 'Use the arrows to move through the museum',
                  descriptionAlignment: TextAlign.center,
                  child: GestureDetector(
                    onTap: () {
                      print("Clicked Arrow 1");
                      Navigator.of(context).replace(
                        oldRoute: ModalRoute.of(context)!,
                        newRoute:
                            MaterialPageRoute(builder: (context) => const Map2Page()),
                      );
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width *
                          0.1, // Specify the width
                      height: MediaQuery.of(context).size.height *
                          0.05, // Use width to ensure the container is a circle
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.30),
                            spreadRadius: 5,
                            blurRadius: 15,
                            offset: const Offset(
                                0, 0), // changes position of shadow
                          ),
                        ],
                        color: Colors
                            .transparent, // Set to transparent or any other color
                        shape: BoxShape.rectangle, // Set the shape to a circle
                      ),
                    ),
                  )),
            ),
            Positioned(
                top: 0,
                right: 0,
                width: MediaQuery.of(context).size.width * 0.64,
                height: MediaQuery.of(context).size.height * 0.13,
                child: Showcase(
                  key: _twoKey,
                  description:
                      'Click to learn more about the exhibits shown or bring them to life with our Augmented Reality!',
                  descriptionAlignment: TextAlign.center,
                  child: GestureDetector(
                    onTap: () {
                      print("Clicked Dinosaur 4");
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) =>
                              const DinosaurPage(picture: "tri")));
                    },
                    child: Container(
                      color: Colors.transparent,
                    ),
                  ),
                )),
            Positioned(
              top: MediaQuery.of(context).size.height * 0.208,
              right: 0,
              width: MediaQuery.of(context).size.width * 0.525,
              height: MediaQuery.of(context).size.height * 0.115,
              child: GestureDetector(
                onTap: () {
                  print("Clicked Dinosaur 3");
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) =>
                          const DinosaurPage(picture: "tex")));
                },
                child: Container(
                  color: Colors.transparent,
                ),
              ),
            ),
            // Clickable area 1 (Top-Left quarter)
            Positioned(
              bottom: MediaQuery.of(context).size.height * 0.0925,
              left: 0,
              width: MediaQuery.of(context).size.width * 0.21,
              height: MediaQuery.of(context).size.height * 0.335,
              child: GestureDetector(
                onTap: () {
                  print("Clicked Dinosaur 2");
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) =>
                          const DinosaurPage(picture: "long")));
                },
                child: Container(
                  color: Colors.transparent,
                ),
              ),
            ),
            // Clickable area 2 (Bottom-Right quarter)
            Positioned(
              bottom: MediaQuery.of(context).size.height * 0.092,
              right: 0,
              width: MediaQuery.of(context).size.width * 0.295,
              height: MediaQuery.of(context).size.height * 0.265,
              child: GestureDetector(
                onTap: () {
                  print("Clicked Dinosaur 1");
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) =>
                          const DinosaurPage(picture: "velociraptor")));
                },
                child: Container(
                  color: Colors.transparent,
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: const Color.fromARGB(255, 30, 30, 30),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: <Widget>[
              Expanded(
                // Expanded widget for the search bar
                child: TextFormField(
                  enabled: true,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    labelText: 'Search',
                    labelStyle: const TextStyle(color: Colors.white),
                    prefixIcon: const Icon(Icons.search, color: Colors.white),
                    contentPadding: const EdgeInsets.symmetric(vertical: 5),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide:
                      const BorderSide(color: Colors.white), // Border color
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide:
                          const BorderSide(color: Colors.white), // Border color
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12.0),
              Showcase(
                key: _sevenKey,
                onBarrierClick: () => Future.delayed(const Duration(seconds: 1), () {
                  itemPopup(context);
                }),
                onTargetClick: () => Future.delayed(const Duration(seconds: 1), () {
                  itemPopup(context);
                }),
                disposeOnTap: true,
                description:
                    'Look for specific items and take a photo of them when you find them!',
                descriptionAlignment: TextAlign.center,
                child: IconButton(
                  icon: const Icon(Icons.camera_alt), // Camera icon
                  onPressed: () async {
                    if (await getPictureTaken()) {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const PictureTakenPage(
                            page: 1,
                            color1: Color.fromARGB(255, 180, 175, 133),
                            color2: Color.fromARGB(255, 130, 172, 121),
                            color3: Color.fromARGB(255, 180, 175, 133),
                          )));
                    } else {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) =>
                          const CameraApp(
                            page: 1,
                            picture: 'page1find',
                            color1: Color.fromARGB(255, 180, 175, 133),
                            color2: Color.fromARGB(255, 130, 172, 121),
                            color3: Color.fromARGB(255, 180, 175, 133),
                          )));
                    }
                  },
                  color:
                      Colors.white, // Choose a color that's visible on your map
                ),
              ),
              Showcase(
                key: _sixKey,
                description:
                    'Here you can access the quiz challenges!\nThere is one for every section of the museum',
                descriptionAlignment: TextAlign.center,
                child: IconButton(
                  padding: const EdgeInsets.fromLTRB(2, 2, 2, 2),
                  icon: Image.asset(
                    'assets/icons/quiz_icon.png',
                  ), // Camera icon
                  onPressed: () async {
                    if (await _checkIfQuizDone()) {
                      final SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      int score = prefs.getInt('scoreQuiz1') ?? 0;
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => QuizDonePage(
                                page: "1",
                                score: score,
                                color1: const Color.fromARGB(255, 180, 175, 133),
                                color2: const Color.fromARGB(255, 130, 172, 121),
                                color3: const Color.fromARGB(255, 180, 175, 133),
                              )));
                    } else {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const QuizOnePage()));
                    }
                  },
                  color:
                      Colors.white, // Choose a color that's visible on your map
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCenteredShowcase(
      BuildContext context, String text, GlobalKey key) {
    return Align(
      alignment: Alignment.center,
      child: Showcase(
        key: key, // Replace with your GlobalKey
        showArrow: false,
        title: text,
        titleAlignment: TextAlign.center,
        description: '',
        child: const SizedBox(
            width: 0, height: 0), // Empty Container as a placeholder
        // Other properties...
      ),
    );
  }

  Future<bool> _checkIfQuizDone() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool('quiz1') ?? false;
  }

  Future<bool> _checkIfPopupShown() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool('popup1') ?? false;
  }

  void _setPopupShown(bool value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('popup1', value);
  }

  void itemPopup(BuildContext context) async {
    _setPopupShown(false);
    _checkIfPopupShown().then((popupShown) {
      if (!popupShown) {
        _setPopupShown(true);
        showDialog(
          barrierDismissible: false,
          context: context,
          builder: (BuildContext context) {
            return Dialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0)), // this right here
              child: Container(
                padding: const EdgeInsets.all(15.0),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color.fromARGB(255, 180, 175, 133),
                      Color.fromARGB(
                          255, 130, 172, 121), // Replace with your start color
                      Color.fromARGB(
                          255, 180, 175, 133), // Replace with your end color
                    ],
                  ),
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    const Text(
                      "CHALLENGE!",
                      style: TextStyle(
                          fontSize: 24.0, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 15.0),
                    Container(
                      decoration: BoxDecoration(
                        // Rounded corners
                        borderRadius: BorderRadius.circular(
                            10), // Adjust radius to your preference
                        // Optional: Add a border, shadow, etc.
                      ),
                      clipBehavior: Clip
                          .antiAlias, // Ensures the image is clipped to the border radius
                      child: Image.asset(
                          'assets/images/find_items/page1find.png',
                          height: 100),
                    ),
                    const SizedBox(height: 15.0),
                    const Text(
                      "Find the item in the picture and take a photo of it to earn 50 points!",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 18.0),
                    ),
                    const SizedBox(height: 15.0),
                    const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Use the ",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 18.0),
                          ),
                          Icon(Icons.camera_alt),
                          Text(
                            " icon.",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 18.0),
                          ),
                        ]),
                    const SizedBox(height: 20.0),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text('OK'),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      }
    });
  }

  Future<bool> getPictureTaken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool('camera1') ?? false;
  }
}
