import 'package:flutter/material.dart';

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
                    'Essay #${essay['id']+1}',
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge!
                        .copyWith(color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    essay['essay'] ?? '',
                    textScaler: TextScaler.linear(1.2),
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Text(
                'Grammatical corrections:',
                style: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(color: Colors.black),
              ),
            ),
            grammar.isEmpty ? Text('Great! no mistakes') : Text('')
          ]),
          SliverList.builder(
              itemCount: grammar.length,
              
              itemBuilder: (context, idx) => Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text.rich(TextSpan(children: [
                      WidgetSpan(
                          child: InkWell(
                              child: Card(
                                  color: Colors.deepPurple[50],
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Text(grammar[idx]['originalText'], textScaler: TextScaler.linear(1.2),style: TextStyle(fontWeight: FontWeight.bold,decoration: TextDecoration.lineThrough),),
                                  )))),
                                WidgetSpan(child: Padding(padding: EdgeInsets.fromLTRB(5,10,5,10), child: Icon(Icons.arrow_right),)),
                      WidgetSpan(
                          child: InkWell(
                              child: Card(
                                  color: Colors.deepPurple[50],
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Text(
                                      grammar[idx]['suggestion'],
                                      textScaler: TextScaler.linear(1.2),
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  )))),
                    ])),
              )),
          // Divider(),
          SliverList.list(children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Text(
                'Text improvements:',
                style: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(color: Colors.black, fontWeight: FontWeight.bold),
              ),
            ),
            improvements.isEmpty ? Text('Great! no mistakes') : Text('')
          ]),
          SliverList.builder(
              itemCount: improvements.length,
              itemBuilder: (context, idx) => Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text.rich(TextSpan(children: [
                      WidgetSpan(
                          child: InkWell(
                              child: Card(
                                  color: Colors.deepPurple[50],
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Text(improvements[idx]['originalText'], textScaler: TextScaler.linear(1.2),style: TextStyle(fontWeight: FontWeight.bold,decoration: TextDecoration.lineThrough),),
                                  )))),
                                WidgetSpan(child: Padding(padding: EdgeInsets.fromLTRB(5,10,5,10), child: Icon(Icons.arrow_right),)),
                      WidgetSpan(
                          child: InkWell(
                              child: Card(
                                  color: Colors.deepPurple[50],
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Text(
                                      improvements[idx]['suggestions'].last,
                                      textScaler: TextScaler.linear(1.2),
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  )))),
                    ])),
              ))
        ],
      ),
    );
  }
}
