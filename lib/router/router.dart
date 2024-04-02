import 'package:go_router/go_router.dart';
import 'package:improveng/views/grammar.dart';
import 'package:improveng/views/home.dart';

final router = GoRouter(initialLocation: '/', routes: [
  GoRoute(path: '/', builder: (context, state) => Home(), name: 'home'),
  GoRoute(
      path: '/grammar_correction',
      builder: (context, state) => Grammar(),
      name: 'grammar')
]);
