import 'package:flutter/material.dart';

class PastEssayView extends StatelessWidget {
  PastEssayView(this.grammar,this.improvements,{super.key});
  List grammar;
  List improvements;
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: CustomScrollView(slivers: [
      SliverList.list(
        children: [
          Text('Grammatical corrections:'),
          grammar.length==0?Text('Great! no mistakes'):Text('')]),
          SliverList.builder(itemCount: grammar.length,itemBuilder: (context,idx)=>Text.rich(TextSpan(children: [TextSpan(text:grammar[idx]['originalText']),TextSpan(text: '->'),
                        TextSpan(text:grammar[idx]['suggestion'])
                      ]))),
          SliverList.list(
        children: [
          Text('Text improvements:'),
          improvements.length==0?Text('Great! no mistakes'):Text('')]),
          SliverList.builder(itemCount: improvements.length,itemBuilder: (context,idx)=>Text.rich(TextSpan(children: [TextSpan(text:improvements[idx]['originalText']),TextSpan(text: '->'),
                        TextSpan(text:improvements[idx]['suggestions'].last)
                      ])))
                    
        ],
      
    ),);
  }
}