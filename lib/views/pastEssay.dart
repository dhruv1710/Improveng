import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class PastEssayView extends StatelessWidget {
  PastEssayView(this.essay, this.grammar, this.improvements, {super.key});
  List grammar;
  Map essay;
  List improvements;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverList.list(children: [
            SizedBox(
              height: 50,
            ),
            Card(
              child: Column(
                children: [
                  Text(
                    'Essay #${essay['id']}',
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge!
                        .copyWith(color: Colors.black),
                  ),
                  Text(
                    essay['essay'] ?? '',
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(color: Colors.black),
                  ),
                ],
              ),
            ),
            Text(
              'Grammatical corrections:',
              style: Theme.of(context)
                  .textTheme
                  .titleLarge!
                  .copyWith(color: Colors.black),
            ),
            grammar.length == 0 ? Text('Great! no mistakes') : Text('')
          ]),
          SliverList.builder(
              itemCount: grammar.length,
              itemBuilder: (context, idx) => Text.rich(TextSpan(children: [
                    WidgetSpan(
                        child: InkWell(
                            child: Card(
                                color: Colors.deepPurple[50],
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(grammar[idx]['originalText']),
                                )))),
                    TextSpan(text: '->'),
                    TextSpan(text: grammar[idx]['suggestion'])
                  ]))),
          // Divider(),
          SliverList.list(children: [
            Text(
              'Text improvements:',
              style: Theme.of(context)
                  .textTheme
                  .titleLarge!
                  .copyWith(color: Colors.black),
            ),
            improvements.length == 0 ? Text('Great! no mistakes') : Text('')
          ]),
          SliverList.builder(
              itemCount: improvements.length,
              itemBuilder: (context, idx) => Text.rich(TextSpan(children: [
                    TextSpan(text: improvements[idx]['originalText']),
                    TextSpan(text: '->'),
                    TextSpan(text: improvements[idx]['suggestions'].last)
                  ])))
        ],
      ),
    );
  }
}
