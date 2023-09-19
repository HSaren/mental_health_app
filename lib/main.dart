import 'package:flutter/material.dart';
import 'calendarbutton.dart';
import 'package:intl/intl.dart';

void main() {
	runApp(MentalHealthApp());
}

class MentalHealthApp extends StatelessWidget{
	@override
	Widget build(BuildContext context) {
	  return MaterialApp(
		title: "Mental Health App",
		home: FrontPage(),
	  );
	}
}

class FrontPage extends StatefulWidget{
	@override
	FrontPageState createState() => FrontPageState();
}

class FrontPageState extends State<FrontPage>{

	@override
	Widget build(BuildContext context){
		DateTime now = DateTime.now();
		DateTime currentMonth = DateTime(now.year,now.month);
		List<ButtonData> days = setDays(now);
		var format = DateFormat.MMMM();
		
		return Scaffold(
			appBar: AppBar(
				title: const Text("Mental Health App"),
				backgroundColor: const Color.fromARGB(255, 116, 116, 116),
			),
			backgroundColor: Colors.grey,
			body: Column(children: <Widget>[
				Container(
					height:100,
					child: Container(
						alignment: Alignment.bottomLeft,
						child: Text(format.format(currentMonth)),
					),
				),
				Expanded(
					child: GridView.builder(
						itemCount: days.length,
						gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
							crossAxisCount: 7
						),
						itemBuilder: (BuildContext context, int index){
							return CalendarButton(
							buttonTapped: (){
							},
							color: days[index].colorPicker(),
							buttonDate: days[index].date.day,
							note: days[index].notes,
							);
							
						}	
					),
				)
			]),
		);
	}
}

class ButtonData{
	DateTime date;
	String notes;
	Color color;
	final activeColor = const Color.fromARGB(255, 102, 98, 98);
	final inactiveColor = const Color.fromARGB(87, 190, 190, 190);
	final outsideMonthColor = const Color.fromARGB(86, 93, 93, 93);
	

	ButtonData(this.date, this.notes, {this.color = Colors.black});
	Color colorPicker(){
		DateTime now = DateTime.now();
		Color chosenColor;
		if (this.date.isBefore(DateTime(now.year, now.month, 1)) || this.date.isAfter(DateTime(now.year, now.month + 1, 0))){
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

List<ButtonData> setDays(DateTime now){
	DateTime currentDateBeingGenerated = DateTime(now.year, now.month, 1);
	DateTime lastDay = DateTime(now.year, now.month + 1, 0);
	String fetchedNote = "";
	List<ButtonData> days = <ButtonData>[];
	if (currentDateBeingGenerated.weekday != 1){
		while (currentDateBeingGenerated.weekday != 1){
			currentDateBeingGenerated = DateTime(currentDateBeingGenerated.year, currentDateBeingGenerated.month, currentDateBeingGenerated.day - 1);
		}
		days.add(ButtonData(currentDateBeingGenerated, fetchedNote));
		}
		while(currentDateBeingGenerated.isBefore(DateTime(now.year, now.month + 1, 0).add(Duration(days: 7 - lastDay.weekday)))){
			currentDateBeingGenerated = DateTime(currentDateBeingGenerated.year, currentDateBeingGenerated.month, currentDateBeingGenerated.day + 1);
			days.add(ButtonData(currentDateBeingGenerated, fetchedNote));
		}
	return days;
}

String monthIntToString(int month){
	String stringMonth = "";
	switch(month){
		case 1:
			stringMonth = "January";
	}

	return stringMonth;
}