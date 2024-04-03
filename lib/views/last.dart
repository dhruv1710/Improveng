import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class LastPage extends ConsumerWidget {
  const LastPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Column(mainAxisAlignment: MainAxisAlignment.center,crossAxisAlignment: CrossAxisAlignment.center,children: [
        Icon(Icons.wifi_protected_setup,size: 100,),
        Center(child: Text('Rewrite & Speak',style: Theme.of(context).textTheme.displayMedium,)),
        SizedBox(height: 50,),
        IconButton.filled(onPressed: (){context.go('/home');}, icon: Icon(Icons.home_filled))
      ],),
    );
  }
}