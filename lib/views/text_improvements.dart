
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:improveng/apis/grammarApi.dart';

class TextImprovements extends StatefulWidget {
  const TextImprovements(this.text, {super.key,});
final String text;
  @override
  State<TextImprovements> createState() => _TextImprovementsState();
}

class _TextImprovementsState extends State<TextImprovements> {
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
    print(texts);
    setState(() {
      runnedAI=true;
      ts = textSpans;
    });
  }
  @override
  Widget build(BuildContext context) {
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
