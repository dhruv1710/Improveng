import 'package:go_router/go_router.dart';
import 'package:improveng/views/grammar.dart';
import 'package:improveng/views/home.dart';
import 'package:improveng/views/intro.dart';
import 'package:improveng/views/profile.dart';
import 'package:improveng/views/speak.dart';
import 'package:improveng/views/text_improvements.dart';

final router = GoRouter(initialLocation: '/profile', routes: [
  GoRoute(path: '/', builder: (context, state) => Intro(), name: 'introduction'),
  GoRoute(path: '/home', builder: (context, state) => Home(), name: 'homepage'),
  GoRoute(
      path: '/grammar_correction',
      builder: (context, state) => Grammar(),
      name: 'grammar'),
  GoRoute(
      path: '/text-improvement',
      builder: (context, state) => TextImprovement('Hello I am Dhruv good to see you I was waiting for your response good that it came'),
      name: 'text-improvement'),
    GoRoute(
      path: '/profile',
      builder: (context, state) => ProfilePage(
          ),
      name: 'profile'),
]);
