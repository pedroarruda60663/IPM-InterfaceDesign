import 'dart:async';

import 'package:flutter/material.dart';
import 'package:ipm_project/data/quiz_question.dart';
import 'package:shared_preferences/shared_preferences.dart';

class QuizThreePage extends StatefulWidget {
  const QuizThreePage({super.key});

  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizThreePage> {
  int currentQuestionIndex = 0;
  int score = 0;
  String? selectedOption;
  bool isAnswerSelected = false;
  bool isCorrect = false;
  Timer? _questionTimer;
  static const int questionTimeLimit = 20; // 20 seconds for each question
  int remainingTime = questionTimeLimit;

  @override
  void initState() {
    super.initState();
    _startQuestionTimer();
  }

  List<QuizQuestion> sampleQuestions = [
    QuizQuestion(
      question: 'Quais são os três critérios principais para identificar minerais?',
      options: ["Cor, peso, transparência", "Dureza, cor, brilho", "Brilho, densidade, forma", "Dureza, cor, clivagem"],
      correctAnswer: "Dureza, cor, clivagem",
    ),
    QuizQuestion(
      question: "Em que nível está o Topázio na escala de Mohs (Dureza)?",
      options: ["5", "7", "8", "2"],
      correctAnswer: "8",
    ),
    QuizQuestion(
      question: "Qual é considerada a pedra preciosa mais rara do mundo?",
      options: ["Diamante Vermelho", "Painita", "Alexandrita", "Tanzanita"],
      correctAnswer: "Painita",
    ),
    QuizQuestion(
      question: "Como se formam os diamantes naturalmente?",
      options: ["Condensação de gases", "Resfriamento de magma", "Alta pressão e temperatura", "Precipitação química"],
      correctAnswer: "Alta pressão e temperatura",
    ),
    QuizQuestion(
      question: "As pérolas são consideradas pedras preciosas? Por quê?",
      options: ["Sim, são minerais", "Não, são orgânicas", "Sim, são cristais", "Não, são rochas"],
      correctAnswer: "Não, são orgânicas",
    ),
  ];

  void _startQuestionTimer() {
    _questionTimer?.cancel(); // Cancel any existing timer.
    _questionTimer = Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      if (remainingTime > 0) {
        setState(() {
          remainingTime--;
        });
      } else {
        timer.cancel();
        _timeIsUp(); // Call this when the time is up.
      }
    });
  }

  void _timeIsUp() {
    // Handle what happens when the time is up, e.g., move to next question
    // or show a time's up message.
    if (currentQuestionIndex < sampleQuestions.length - 1) {
      _goToNextQuestion();
    } else {
      // End of quiz logic
      _showQuizCompletionDialog();
    }
  }

  void _checkAnswer(String option) {
    bool correct = sampleQuestions[currentQuestionIndex].correctAnswer == option;

    setState(() {
      selectedOption = option;
      isCorrect = correct;
      isAnswerSelected = true;
      remainingTime++;
      if (correct) {
        score++;
      }
    });

    Future.delayed(const Duration(seconds: 2), () {
      if (currentQuestionIndex < sampleQuestions.length - 1) {
        setState(() {
          currentQuestionIndex++;
          isAnswerSelected = false;
          remainingTime = questionTimeLimit;
        });
      } else {
        // Handle quiz completion here
        // For example, navigate to a result page or show a summary dialog
        _showQuizCompletionDialog();
      }
    });
  }

  void _goToNextQuestion() {
    // Logic to advance to the next question and reset timer
    setState(() {
      currentQuestionIndex++;
      selectedOption = null;
      isAnswerSelected = false;
      remainingTime = questionTimeLimit; // Reset the time for the next question
      _startQuestionTimer();
    });
  }

  @override
  void dispose() {
    _questionTimer?.cancel(); // Always cancel the timer to avoid memory leaks
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    QuizQuestion currentQuestion = sampleQuestions[currentQuestionIndex];

    return WillPopScope(
      onWillPop: () async {
        final shouldPop = await _showExitPopup(context);
        return shouldPop;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Quiz 2'),
          centerTitle: true,
          backgroundColor: const Color.fromARGB(255, 30, 30, 30),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () async {
              if (await _showExitPopup(context)) {
                Navigator.of(context).pop();
              }
            },
          ),
        ),
        body: Stack(
          children: [
        Container(
        decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color.fromARGB(255, 76, 94, 74),
            Color.fromARGB(255, 193, 182, 161),
            Color.fromARGB(255, 85, 105, 119),
          ],
        ),
      ),
    ),
          Align(
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: MediaQuery.sizeOf(context).height * 0.05,),
                SizedBox(
                  height: MediaQuery.sizeOf(context).height * 0.025,
                  width: MediaQuery.sizeOf(context).width * 0.7,
                  child: LinearProgressIndicator(
                    borderRadius: BorderRadius.circular(20),
                    value: (currentQuestionIndex + (isAnswerSelected ? 1 : 0)) / sampleQuestions.length,
                    backgroundColor: Colors.grey[300],
                    valueColor: const AlwaysStoppedAnimation<Color>(Colors.blue),
                  ),
                ),
                SizedBox(height: MediaQuery.sizeOf(context).height * 0.05,),
                SizedBox(
                  width: MediaQuery.sizeOf(context).width * 0.95, // Set the maximum width here
                  child: Card(
                    elevation: 10,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        currentQuestion.question,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: MediaQuery.sizeOf(context).height * 0.05,),
                Stack(
                  alignment: Alignment.center,
                  children: [
                    SizedBox(
                      width: 50.0, // Size of the circular progress indicator
                      height: 50.0,
                      child: CircularProgressIndicator(
                        value: 1 - remainingTime / questionTimeLimit, // Inverse the progress to decrease clockwise
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.grey[300]!),
                        backgroundColor: Colors.blue,
                        strokeWidth: 6, // Width of the progress indicator stroke
                      ),
                    ),
                    Text(
                      '$remainingTime', // Remaining time
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        color: Colors.grey[300], // Ensure the text color is visible on the progress indicator
                      ),
                    ),
                  ],
                ),
                // Reduced height for better layout
                SizedBox(height: MediaQuery.sizeOf(context).height * 0.05,),
                ...currentQuestion.options.map((option) {
                  bool isOptionCorrect = option == sampleQuestions[currentQuestionIndex].correctAnswer;
                  Color buttonColor = Colors.white; // Default color

                  if (isAnswerSelected) {
                    if (selectedOption == option) {
                      // User's selected option
                      buttonColor = isCorrect ? Colors.green : Colors.red;
                    } else if (isOptionCorrect) {
                      // Correct option when the user's choice is wrong
                      buttonColor = Colors.green;
                    }
                  }
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: SizedBox(
                      width: MediaQuery.sizeOf(context).width * 0.9,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: buttonColor,
                          textStyle: const TextStyle(fontSize: 18),
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20), // Adjust the corner radius
                          ),
                        ),
                        onPressed: !isAnswerSelected ? () => _checkAnswer(option) : () {},
                        child: Text(option),
                      ),
                    ),
                  );
                }),
                SizedBox(height: MediaQuery.sizeOf(context).height * 0.075,),

              ],
            ),
    ),
          ],
        ),
      ),
    );
  }

  Future<bool> _showExitPopup(BuildContext context) async {
    bool shouldPop = false;

    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: const Color.fromARGB(255, 30, 30, 30),
          title: const Text('Are you sure you want to leave the quiz?', style: TextStyle(color: Colors.white),),
          content: const Text("Your progress will be lost!", style: TextStyle(color: Colors.white),),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop(); // Dismiss the dialog
              },
            ),
            TextButton(
              child: const Text('Yes'),
              onPressed: () {
                shouldPop = true;
                Navigator.of(context).pop(); // Dismiss the dialog
              },
            ),
          ],
        );
      },
    );

    return shouldPop;
  }

  Future<void> _setQuizDone() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('quiz3', true);
  }

  Future<void> _setScore(int quizScore) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    // Retrieve the existing score or set it to 0 if it doesn't exist
    int existingScore = prefs.getInt('score') ?? 0;

    // Calculate the new total score by adding the current quiz score
    int totalScore = existingScore + quizScore*10;

    // Save the updated total score back to SharedPreferences
    await prefs.setInt('score', totalScore);
    await prefs.setInt('scoreQuiz3', score*10);
  }



  Future<void> _showQuizCompletionDialog() async {
    _setScore(score);
    _setQuizDone();

    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: const Color.fromARGB(255, 30, 30, 30),
          title: const Text(
            "Quiz Completed!",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: Colors.white,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min, // Use minimum space
            children: [
              const SizedBox(height: 10),
              const Text(
                "Your Score",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.white
                ),
              ),
              const SizedBox(height: 10), // Spacing
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white, width: 2), // Square border
                  borderRadius: BorderRadius.circular(4), // Slightly rounded corners
                ),
                child: Text(
                  "${score*10}",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(height: 20), // Spacing
              const Text("Quiz 3/3", style: TextStyle(color: Colors.white),), // Example quiz number
            ],
          ),
          actions: [
            Center(
              child: TextButton(
                child: const Text("CONTINUE EXPLORING"),
                onPressed: () {
                  Navigator.of(context).pop(); // Close the dialog
                  Navigator.of(context).pop();
                },
              ),
            ),
          ],
        );
      },
    );
  }


}