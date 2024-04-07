import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class LastPage extends ConsumerWidget {
  const LastPage({super.key, this.text});
  final String? text;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    print(text);

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            Icons.wifi_protected_setup,
            size: 100,
          ),
          Center(
            child: Text(
              'Rewrite & Speak',
              style: Theme.of(context).textTheme.displayMedium,
            ),
          ),
          SizedBox(
            height: 50,
          ),
          IconButton(
            onPressed: () {
              context.go('/home');
            },
            icon: Icon(Icons.home_filled),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: AnimatedTextKit(
              repeatForever: false,
              totalRepeatCount: 1,
              animatedTexts: [
                TyperAnimatedText(
                  text ?? "", // Use empty string if text is null
                  textStyle: const TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                  ),
                  speed: const Duration(milliseconds: 10),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
