import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController userInput_controller = TextEditingController();

  final SpeechToText speech = SpeechToText();
  String recordedText = '';
  bool isLoading = false;

  void initializeSpeechToText() async {
    await speech.initialize();
    setState(() {});
  }

  void startListining() async {
    FocusScope.of(context).unfocus();
    await speech.listen(onResult: (result));
    setState(() {});
  }

  void stopListening() async {
    await speech.stop();
    setState(() {});
  }

  void result(SpeechRecognitionResult recognitionResult) {
    setState(() {
      recordedText = recognitionResult.recognizedWords;
      print('result $recordedText');
    });
  }

  @override
  void initState() {
    super.initState();
    initializeSpeechToText();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print("object");
        },
        //child: Icon(Icons.mic),
        child: Image.asset(
          'assets/sound_on.png',
          height: 30,
          width: 30,
        ),
        backgroundColor: Colors.deepPurple,
      ),
      backgroundColor: Color.fromARGB(240, 206, 96, 240),
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.purple,
                Colors.deepPurple,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        //backgroundColor: Colors.black,
        title: Image.asset(
          'assets/farzine.png',
          height: 60,
          width: 140,
        ),
        titleSpacing: 5,
        elevation: 2,

        actions: [
          Padding(
            padding: EdgeInsets.only(right: 4, top: 4),
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(context, '/profile');
              },
              child: Icon(
                Icons.chat,
                size: 40,
                color: Color.fromARGB(255, 49, 128, 52),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(right: 8, left: 4),
            child: InkWell(
              onTap: () {},
              child: Icon(
                Icons.image,
                size: 40,
                color: Color.fromARGB(255, 49, 128, 52),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Center(
                child: InkWell(
                  onTap: () {
                    speech.isListening ? stopListening() : startListining();
                  },
                  child: Container(
                    height: 200,
                    width: 200,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 131, 71, 233),
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: speech.isListening
                        ? Center(
                            child: LoadingAnimationWidget.beat(
                                color: speech.isListening
                                    ? Color.fromARGB(255, 141, 3, 165)
                                    : isLoading
                                        ? Colors.green
                                        : Colors.lightGreen,
                                size: 150),
                          )
                        : Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                'assets/virtual_assistant.png',
                                height: 100,
                                width: 150,
                              ),
                              SizedBox(height: 2),
                              Text(
                                'Virtual Assistant',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 4),
                      child: TextField(
                        controller: userInput_controller,
                        decoration: InputDecoration(
                          hintText: 'How  can i help you?',
                          hintStyle: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          fillColor: Colors.grey[300],
                          filled: true,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  InkWell(
                    onTap: () {
                      stopListening();
                    },
                    child: AnimatedContainer(
                      duration: Duration(milliseconds: 1000),
                      curve: Curves.bounceIn,
                      padding: const EdgeInsets.all(10),
                      height: 60,
                      width: 60,
                      decoration: BoxDecoration(
                        color: Colors.deepPurple,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Icon(
                        Icons.send,
                        color: Color.fromARGB(255, 49, 128, 52),
                        size: 35,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
