import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;


class Speak extends StatefulWidget {
  @override
  _SpeakState createState() => _SpeakState();
}

class _SpeakState extends State<Speak> {
  final String essayText =
      'This is the essay text that the user should read aloud.';
  final stt.SpeechToText speechToText = stt.SpeechToText();

  bool isListening = false;
  String transcript = '';
  List<TextSpan> textSpans = [];
  int highlightIndex = 0;

  @override
  void initState() {
    super.initState();
    initializeSpeechToText();
  }

  Future<void> initializeSpeechToText() async {
    speechToText.initialize(
      onStatus: (status) => print('Speech recognition status: $status'),
      onError: (error) => print('Speech recognition error: $error'),
    );
  }



  void startListening() async {
    if (!isListening) {
      bool available = await speechToText.initialize(
        onStatus: (status) => print('Speech recognition status: $status'),
        onError: (error) => print('Speech recognition error: $error'),
      );

      if (available) {
        setState(() {
          isListening = true;
          highlightIndex = 0;
          textSpans.clear();
        });

        speechToText.listen(
          onResult: (result) {
            setState(() {
              transcript += result.recognizedWords;
              validateSpeech(result.recognizedWords);
            });
          },
          listenFor: Duration(hours: 2),
        );

      }
    } else {
      setState(() {
        isListening = false;
      });
      speechToText.stop();
    }
  }

  void validateSpeech(String newTranscript) {
    final essayWords = essayText.split(' ');
    final transcriptWords = newTranscript.trim().split(' ');

    for (int i = 0; i < transcriptWords.length; i++) {
      final word = transcriptWords[i];
      if (word == essayWords[highlightIndex]) {
        textSpans.add(TextSpan(
          text: word + ' ',
          style: TextStyle(color: Colors.green),
        ));
        highlightIndex++;
      } else {
        textSpans.add(TextSpan(
          text: word + ' ',
          style: TextStyle(color: Colors.black),
        ));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Speech-to-Text Essay Validation'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RichText(
              text: TextSpan(
                style: TextStyle(fontSize: 18.0),
                children: textSpans,
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: startListening,
              child: Text(isListening ? 'Stop Listening' : 'Start Listening'),
            ),
          ],
        ),
      ),
    );
  }
}
