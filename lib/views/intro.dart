import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:improveng/views/photo.dart';
import 'package:introduction_screen/introduction_screen.dart';


class Intro extends StatefulWidget {
  const Intro({super.key});

  @override
  State<Intro> createState() => _IntroState();
}

class _IntroState extends State<Intro> {
  List pages = [
    {'title':'Improveng','desc':'In 30 mins for 30 days','image': "assets/imgs/english.png"
    },
    {
      'title': "Sessions",
      'desc': "Do everyday to improve english and better express yourself",
      'image': "assets/imgs/session.png"
    },
    {
      'title': 'Improveng',
      'desc': 'In 30 mins for 30 days',
      'image': "assets/imgs/english.png"
    },
    {
      'title': 'Improveng',
      'desc': 'In 30 mins for 30 days',
      'image': "assets/imgs/english.png"
    },
    {
      'title': 'Improveng',
      'desc': 'In 30 mins for 30 days',
      'image': "assets/imgs/english.png"
    },
    {
      'title': 'Improveng',
      'desc': 'In 30 mins for 30 days',
      'image': "assets/imgs/english.png"
    },
    {
      'title': 'Improveng',
      'desc': 'In 30 mins for 30 days',
      'image': "assets/imgs/english.png"
    },
  ];
  @override
  Widget build(BuildContext context) {
    return IntroductionScreen(
      overrideDone: Container(),
      globalBackgroundColor: Colors.white,
      allowImplicitScrolling: true,
      // autoScrollDuration: 3000,
      curve: Curves.fastLinearToSlowEaseIn,
      // controlsMargin: const EdgeInsets.fromLTRB(0,0,0,0 ),
      // controlsPadding: const EdgeInsets.all(16.0),
      dotsDecorator: const DotsDecorator(
        // spacing: EdgeInsets.fromLTRB(0, 0, 20, 0),
        size: Size(10.0, 10.0),
        color: Color(0xFFBDBDBD),
        activeSize: Size(22.0, 10.0),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
        ),
      ),
      dotsContainerDecorator: const ShapeDecoration(
        color: Colors.transparent,
        
        shape: RoundedRectangleBorder(
          
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
        ),
      ),
      pages: [
        PageViewModel(
          useScrollView: true,
          title: "Improveng",
          body:
              "In 30 mins for 30 days",
          image: Center(
            child: Image.asset("assets/imgs/english.png", height: 200.0),
          ),
          decoration: const PageDecoration(
            // bodyTextStyle:
            //     TextStyle(fontWeight: FontWeight.w700, fontSize: 20.0),
          ),
        ),
        PageViewModel(
          title: "Sessions",
          body: "Do everyday to improve english and better express yourself",
          image:  Center(
            child: Image.asset("assets/imgs/session.png", height: 200.0),
          ),
          decoration: const PageDecoration(
            bodyTextStyle:
                TextStyle(fontWeight: FontWeight.w700, fontSize: 20.0),
          ),
        ),
        PageViewModel(
          title: "Write Essay",
          body:
              "Take photo to upload into improveng",
          image:  Center(
            child: Image.asset("assets/imgs/essay.png", height: 200.0),
          ),
          decoration: const PageDecoration(
            titleTextStyle: TextStyle(color: Colors.orange),
            bodyTextStyle:
                TextStyle(fontWeight: FontWeight.w700, fontSize: 20.0),
          ),
        ),
        PageViewModel(
          title: "Grammar Correction",
          body: "See what grammatical mistakes you did and understand",
          image:  Center(
            child: Image.asset("assets/imgs/grammar.png", height: 200.0),
          ),
          decoration: const PageDecoration(
            bodyTextStyle:
                TextStyle(fontWeight: FontWeight.w700, fontSize: 20.0),
          ),
        ),
        PageViewModel(
          title: "Fluency and Clarity Improvement",
          body: "Rewrite your essay after looking at improvements",
          image:  Center(
            child: Image.asset("assets/imgs/fluency.png", height: 200.0),
          ),
          decoration:  PageDecoration(
            bodyTextStyle:
                TextStyle(fontWeight: FontWeight.w700, fontSize: 20.0),
          ),
        ),
        PageViewModel(
          title: "Finish off with Speaking",
          body: "Read aloud to fit the grammar and improvements in your brain",
          image:  Center(
            child: Image.asset("assets/imgs/speak.png", height: 200.0),
          ),
          decoration: const PageDecoration(
            bodyTextStyle:
                TextStyle(fontWeight: FontWeight.w700, fontSize: 20.0),
          ),
        ),
        PageViewModel(
          title: "Repeat",
          body: "Consistently and you will change yourself",
          image:  Center(
            child: Image.asset("assets/imgs/technique.png", height: 200.0),
          ),
          footer: Padding(padding: EdgeInsets.all(20),child: FilledButton(style: ButtonStyle(elevation: MaterialStatePropertyAll(10)),child: Text('Login'),onPressed: (){context.go('/home');},)),
          decoration: const PageDecoration(
            bodyTextStyle:
                TextStyle(fontWeight: FontWeight.w700, fontSize: 20.0),
          ),
        )
      ],
      showBackButton: false,
      showNextButton: false,
      back: const Icon(Icons.arrow_back),
      // done: const Text("Login"),
      // onDone: (){
        // context.go('/home');
      // },
    );
  }
}