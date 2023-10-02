import 'dart:ffi';

import 'package:flutter/material.dart';

class CalendarSmiley extends StatefulWidget{
    var smileyButtons = SmileyButtons().smileyButtons;
    CalendarSmiley({super.key});

    @override
    State<CalendarSmiley> createState() => _CalendarSmileyState();
}
class _CalendarSmileyState extends State<CalendarSmiley>{
    final smileys = [
      "\u{1F641}", // Sad
      "\u{1F611}", // Neutral
      "\u{1F603}" // Happy
    ];
    @override
    Widget build(BuildContext context){
      var smileyButtons = widget.smileyButtons;
      var index = 0;
      if (smileyButtons.isEmpty){
        for (var smiley in smileys){
        var smileyToAdd = SmileyButtonData(index, smiley);
        smileyButtons.add(smileyToAdd);
        index++;
      }
      }
      
      return Row(
          children: [
            GestureDetector(
                onTap: (){
                  smileyButtons = smileyColorChanger(0, smileyButtons);
                  setState(() {
                    
                  });
                },
                child: Padding(
                  padding: const EdgeInsets.all(0.2), 
                  child: ClipRRect(
                    child: Container(
                      alignment: Alignment.center,
                      height: 40,
                      width: 40,
                      color: smileyButtons[0].color,
                      child: Text(smileyButtons[0].text, style: TextStyle(fontSize: 30),),
                    )
                    
                  ),
                )
              ),
              GestureDetector(
                onTap: (){
                  smileyButtons = smileyColorChanger(1, smileyButtons);
                  setState(() {
                    
                  });
                },
                child: Padding(
                  padding: const EdgeInsets.all(0.2), 
                  child: ClipRRect(
                    child: Container(
                      alignment: Alignment.center,
                      height: 40,
                      width: 40,
                      color: smileyButtons[1].color,
                      child: Text(smileyButtons[1].text, style: TextStyle(fontSize: 30)),
                    )
                    
                  ),
                )
              ),
              GestureDetector(
                onTap: (){
                  smileyButtons = smileyColorChanger(2, smileyButtons);
                  setState(() {
                    
                  });
                },
                child: Padding(
                  padding: const EdgeInsets.all(0.2), 
                  child: ClipRRect(
                    child: Container(
                      alignment: Alignment.center,
                      height: 40,
                      width: 40,
                      color: smileyButtons[2].color,
                      child: Text(smileyButtons[2].text, style: TextStyle(fontSize: 30)),
                    )
                    
                  ),
                )
              ),
          ],
        );
    }
    
    List smileyColorChanger(index, buttons){
      for (var button in buttons){
        button.color = button.notSelectedColor;
      }
      buttons[index].color = buttons[index].selectedColor;
      return buttons;
    }

}

class SmileyButtonData{
  var selectedColor = Colors.green;
  var notSelectedColor = Colors.transparent;
  Color color;
  var text;
  var index;

  SmileyButtonData(this.index, this.text,{this.color = Colors.transparent});
}
class SmileyButtons{
  var smileyButtons = List.empty(growable: true);
}