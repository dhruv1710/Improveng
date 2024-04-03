
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:improveng/apis/grammarApi.dart';
import 'package:improveng/controllers/pastEsssays.dart';
import 'package:improveng/views/last.dart';

class TextImprovement extends ConsumerStatefulWidget {
  TextImprovement(this.text,{super.key});
  String text;
  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _TextImprovementState();
}

class _TextImprovementState extends ConsumerState<TextImprovement> {

  bool runnedAI = false;
  List<InlineSpan> ts = [];
  @override
  void initState() {
    super.initState();
    runTextAI();
  }
  runTextAI() async {
    print('running AI');
    final response = await TextAPI().text_improvement(widget.text);
    print(response);
    List errors = response['errors'];
    
    List<dynamic> texts = response['text'].split('');
    
    List<InlineSpan>? textSpans = texts.map<InlineSpan>((e) {
      return TextSpan(text: e);
      
    }).toList();
    
    for (final e in errors.reversed) {
      textSpans.replaceRange(
          e['startIndex'], e['endIndex'], [TextSpan(text: e['suggestions'].last,
    style: Theme.of(context)
        .textTheme
        .bodyMedium!
        .copyWith(decoration: TextDecoration.underline),recognizer: TapGestureRecognizer()..onTap = ()=>errorDialog(context,e))]);
    }
    String t = response['text'];
    for (final e in errors.reversed) {
      t = t.replaceRange(e['startIndex'], e['endIndex'], e['suggestions'].last);
    }
    var essayBox = await Hive.openBox('essays');
    Map data = essayBox.getAt(essayBox.length-1);
    // need to provide list as hive does not accept string
    data['text'] = [t];
    data['improvements'] = errors;
    essayBox.putAt(essayBox.length-1,data);
    ref.read(pastEssayProvider.notifier).addEssay(data, essayBox.length - 1);
    print(ref.watch(pastEssayProvider));
    print(texts);
    setState(() {
      runnedAI=true;
      ts = textSpans;
    });
  }
  @override
  Widget build(BuildContext context,) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
              title: Text('Text Improvements'), ),
              SliverList.list(children: [!runnedAI?Column(children: [CircularProgressIndicator(),Text('Running AI')],):Text.rich(TextSpan(
                        children: ts,
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
                    )
                    )])
        ],
      ),
      floatingActionButton: FloatingActionButton(onPressed: (){
        Navigator.of(context).push(MaterialPageRoute(builder: (context)=>LastPage()));
      },child: Text('Next'),),
    );
  }
  errorDialog(context,error){
    return showDialog(context: context, builder: (context)=>AlertDialog(title: Text.rich(TextSpan(children: [TextSpan(text: error['originalText'],
                    style: Theme.of(context)
                        .textTheme
                        .titleSmall!
                        .copyWith(decoration: TextDecoration.lineThrough,color: Colors.red)),TextSpan(text: '-> ${error['suggestions'].last}')])),content: Text(error['improvementType']),));
  }
}
