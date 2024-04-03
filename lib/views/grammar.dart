import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:improveng/controllers/grammarProvider.dart';
import 'package:improveng/views/text_improvements.dart';

class Grammar extends ConsumerWidget {
  Grammar({super.key});

  String ctext = '';
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final grammar = ref.watch(grammarProvider);
    print(grammar);
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            title: Text('Grammar correction'),
          ),
          SliverList.list(
            children: [
              grammar.when(
                  data: (value) {
                    // List errors = value['errors'];
                    // List starts = [];
                    // List ends = [];
                    // String text = value['text'];
                    // for (final e in errors) {
                    //   text = text.replaceRange(e['startIndex'], e['endIndex'], e['suggestion']);
                    // }
                    // List texts = text.split('');
                    // print(texts);
                    // // return Text('loloolo');
                    // int index = 0;
                    // int errorsIdx = 0;
                    print("$value HEREROKAOKFKSODKFOCAKMOAKMCOFKMA");
                    List errors = value['errors'];

                    List<dynamic> texts = value['text'].split('');

                    List<InlineSpan>? textSpans = texts.map<InlineSpan>((e) {
                      return TextSpan(text: e);
                    }).toList();
                    for (final e in errors.reversed) {
                      textSpans.replaceRange(e['startIndex'], e['endIndex'], [
                        TextSpan(
                            text: e['suggestion'],
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(decoration: TextDecoration.underline),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () => errorDialog(context, e))
                      ]);
                    }
                    String correctText = value['text'];

                    for (final e in errors.reversed) {
                      correctText = correctText.replaceRange(
                          e['startIndex'], e['endIndex'], e['suggestion']);
                    }
                    ctext = correctText;
                    print(ctext);
                    Hive.openBox('essays').then(
                        (Box essayBox) => essayBox.add({'grammar': errors}));

                    // return Text('loloolo');

                    // print('lol');
                    return Text.rich(TextSpan(
                      children: textSpans,
                      //texts.map<InlineSpan>((e) {
                      // index += 1;
                      // if (starts.contains(index)) {
                      //   starts.removeAt(errorsIdx);
                      //   texts.removeRange(index, ends[errorsIdx]);
                      //   errorsIdx += 1;
                      //   print(errorsIdx);
                      //   return TextSpan(text: errors[errorsIdx-1]['suggestion']);
                      // } else {
                      // return TextSpan(text: e);
                      // }
                      // }).toList()
                    ));
                  },
                  // Text(value['errors'][0]['suggestion']),
                  error: (error, trace) => Text('An error occured'),
                  loading: () => Column(
                        children: [
                          CircularProgressIndicator(),
                          Text('Running AI')
                        ],
                      )),
            ],
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => TextImprovement(ctext)));
        },
        child: Text('Next'),
      ),
    );
  }

  errorDialog(context, error) {
    return showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text.rich(TextSpan(children: [
                TextSpan(
                    text: error['originalText'],
                    style: Theme.of(context).textTheme.titleSmall!.copyWith(
                        decoration: TextDecoration.lineThrough,
                        color: Colors.red)),
                TextSpan(text: '-> ${error['suggestion']}')
              ])),
              content: Text(error['correctionType']),
            ));
  }
}
