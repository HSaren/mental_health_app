import 'package:flutter/material.dart';

class ButtonData{
	DateTime date;
	String note;
  String moodInString = " ";
	Color color;
	final activeColor = const Color.fromARGB(255, 102, 98, 98);
	final inactiveColor = const Color.fromARGB(87, 190, 190, 190);
	final outsideMonthColor = const Color.fromARGB(86, 93, 93, 93);
  int mood;
	

	ButtonData(this.date, {this.note = " ", this.mood = 0, this.color = Colors.black});
	Color colorPicker(currentMonth){
		DateTime now = DateTime.now();
		Color chosenColor;
		if (this.date.isBefore(DateTime(currentMonth.year, currentMonth.month, 1)) || this.date.isAfter(DateTime(currentMonth.year, currentMonth.month + 1, 0))){
			chosenColor = outsideMonthColor;
		}
		else if(this.date.isBefore(now)){
			chosenColor = activeColor;
		}
		else{
			chosenColor = inactiveColor;
		}
		return chosenColor;
	}
  void moodPicker(){
    var chosenMood;
    switch(mood){
      case 1:
        chosenMood = "\u{1F641}"; // Sad
        break;
      case 2:
        chosenMood = "\u{1F611}"; // Neutral
        break;
      case 3:
        chosenMood = "\u{1F603}"; // Happy
        break;
      default:
        chosenMood = "";
        break;
    }
    moodInString = chosenMood;
  }
}