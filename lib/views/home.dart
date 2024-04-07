import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:improveng/controllers/pastEsssays.dart';
import 'package:improveng/views/pastEssay.dart';
import 'package:improveng/views/photo.dart';

class Home extends ConsumerWidget {
  Home({super.key});
  final profile = Hive.box('profile');

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    final pastEssays = ref.watch(pastEssayProvider);
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: screenHeight / 5,
            flexibleSpace: Container(
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.vertical(
                        bottom: Radius.circular(40.0)),
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Color.fromARGB(255, 140, 86, 231),
                        Color.fromARGB(244, 96, 47, 178),
                      ],
                    )),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: screenHeight / 25),
                    Text(
                      'Hello ${profile.get('name')}',
                      textScaler: TextScaler.linear(2),
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w500),
                    ),
                    SizedBox(height: 5),
                    Text(
                      "Ready to be fluent today?",
                      textScaler: TextScaler.linear(1.2),
                      style: TextStyle(
                          color: Color.fromARGB(120, 255, 255, 255),
                          fontWeight: FontWeight.w500),
                    ),
                  ],
                )),
            elevation: 0,
            backgroundColor: Colors.white,
            actions: [
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 15, 0),
                child: CircleAvatar(
                  backgroundImage: MemoryImage(profile.get('image')),
                ),
              )
            ],
          ),
          SliverList.list(children: [
            // Text(
            //   'Hello Dhruv',
            //   style: Theme.of(context).textTheme.headlineSmall,
            // ),

            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
              child: Text('Start your session',
                  style: Theme.of(context).textTheme.headlineMedium),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
              child: SizedBox(
                  height: 200,
                  child: InkWell(
                    onTap: () {
                      // Hive.openBox('essays').then((Box value) => value.clear());
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => TakePictureScreen()));
                    },
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      color: Theme.of(context).primaryColor,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.photo_camera,
                            color: Color.fromARGB(120, 255, 255, 255),
                            size: 50,
                          ),
                          Text(
                            'Upload Essay',
                            style: Theme.of(context)
                                .textTheme
                                .headlineMedium!
                                .copyWith(color: Colors.white),
                          ),
                          Text(
                            'Take photo of your essay',
                            style: TextStyle(
                                color: Color.fromARGB(120, 255, 255, 255),
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ),
                  )),
            ),

            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
              child: Text(
                'Past sessions',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ),
            FutureBuilder(
              future: pastEssays,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (snapshot.hasData) {
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: snapshot.data!.keys.length,
                    itemBuilder: (context, idx) {
                      print('wn ${snapshot.data}');
                      return Padding(
                        padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                        child: SizedBox(
                            child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  'Essay #${idx + 1}',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleLarge!
                                      .copyWith(color: Colors.black),
                                ),
                                Center(
                                  child: Text(
                                    snapshot.data![(snapshot.data!.keys.length - 1)-idx]['text'][0] ??
                                        'No text',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyLarge!
                                        .copyWith(color: Colors.black),
                                  ),
                                ),
                                SizedBox(
                                    width: 300,
                                    child: FilledButton(
                                        onPressed: () {
                                          Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      PastEssayView(
                                                          {
                                                            'essay': snapshot
                                                                .data![(snapshot
                                                                        .data!
                                                                        .length -
                                                                    1) -
                                                                idx]['text'][0],
                                                            'id': idx,
                                                          },
                                                          snapshot.data![idx]
                                                              ['grammar'],
                                                          snapshot.data![idx][
                                                              'improvements'])));
                                        },
                                        child: Text('Mistakes & Improvements')))
                              ],
                            ),
                          ),
                        )),
                      );
                    },
                  );
                } else {
                  return Center(child: Text('No data'));
                }
              },
            )
          ]),
        ],
      ),
    );
  }
}
