import 'package:flutter/material.dart';

class ButtonData{
	DateTime date;
	String note;
  String moodInString;
	Color color;
  int mood;
  final index;
	final currentMonth;
	final activeColor = const Color.fromARGB(255, 102, 98, 98);
	final inactiveColor = const Color.fromARGB(87, 190, 190, 190);
	final outsideMonthColor = const Color.fromARGB(86, 93, 93, 93);
	

	ButtonData(this.date, this.note, this.currentMonth, this.index, this.moodInString, this.mood, {this.color = Colors.black});
	Color colorPicker(){
		DateTime now = DateTime.now();
		Color chosenColor;
		if (this.date.isBefore(DateTime(date.year, currentMonth, 1)) || this.date.isAfter(DateTime(date.year, currentMonth + 1, 0))){
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
  
}