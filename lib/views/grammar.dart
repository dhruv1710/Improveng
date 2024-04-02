import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:improveng/apis/photoApi.dart';
import 'package:improveng/controllers/photoProvider.dart';

class Grammar extends ConsumerWidget {
  const Grammar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final photo = ref.watch(photoProvider);
    print(photo);
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            title: Text('Grammar correction'),
          ),
          SliverList.list(children: [
            FutureBuilder(
                future: PhotoAPI().extract_text(File(photo.toString())),
                builder: (context, snapshot) {
                  return snapshot.hasData?Text(snapshot.data.toString()):
                  CircularProgressIndicator();
                })
          ])
        ],
      ),
    );
  }
}
