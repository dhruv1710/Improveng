import 'dart:io';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:improveng/apis/photoApi.dart';
import 'package:improveng/controllers/grammarProvider.dart';
import 'package:improveng/controllers/photoProvider.dart';

class TextImprovements extends ConsumerWidget {
  const TextImprovements({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
              title: Text('Text Improvements'), ),
              SliverList.list(children: [Text('text')])
        ],
      ),
    );
  }
}
