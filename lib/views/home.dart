import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:improveng/views/photo.dart';

class Home extends ConsumerWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            elevation: 0,
            backgroundColor: Colors.white,
            actions: [
              CircleAvatar(
                backgroundColor: Colors.blue,
              )
            ],
          ),
          SliverList(
              delegate: SliverChildListDelegate([
            Text(
              'Hello Dhruv',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            Divider(
              thickness: 3,
              color: Colors.black,
              endIndent: 200,
            ),
            Text('Start your session',
                style: Theme.of(context).textTheme.headlineLarge),
            SizedBox(
                height: 200,
                child: InkWell(
                  onTap: (){Navigator.of(context).push(MaterialPageRoute(builder: (context)=>TakePictureScreen()));},
                  child: Card(
                    color: Theme.of(context).primaryColor,
                    child: Center(
                      child: Text(
                        'Take Photo',
                        style: Theme.of(context)
                            .textTheme
                            .displaySmall!
                            .copyWith(color: Colors.white),
                      ),
                    ),
                  ),
                )),
                SizedBox(height: 20,),
                Text('Continue sessions',style: Theme.of(context).textTheme.headlineSmall,),
                SizedBox(
                height: 300,
                child: Card(
                  
                  child: Center(
                    child: Text(
                      'Essay 1',
                      style: Theme.of(context)
                          .textTheme
                          .displaySmall!
                          .copyWith(color: Colors.black),
                    ),
                  ),
                )),
          ])),
        ],
      ),
    );
  }
}
