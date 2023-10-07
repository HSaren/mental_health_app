import 'package:flutter/material.dart';

class ButtonData{
	DateTime date;
	String note;
  int mood;
	Color color;
  final index;
	final currentMonth;
	final activeColor = const Color.fromARGB(255, 102, 98, 98);
	final inactiveColor = const Color.fromARGB(87, 190, 190, 190);
	final outsideMonthColor = const Color.fromARGB(86, 93, 93, 93);
	

	ButtonData(this.date, this.note, this.currentMonth, this.index, {this.color = Colors.black, this.mood = 0});
	Color colorPicker(){
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
}