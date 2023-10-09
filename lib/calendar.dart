import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'calendar_button.dart';
import 'calendar_pop_up.dart';
import 'backend.dart';

class Calendar extends StatelessWidget{

	final days;

	Calendar({this.days});

	@override
	Widget build (BuildContext context){ 
    final format = DateFormat.yMMMd();
    final dayTitleFormat = DateFormat.MMMd();
		return GridView.builder(
			itemCount: days.length,
			gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
				crossAxisCount: 7
			),
			itemBuilder: (BuildContext context, int index){
				return FutureBuilder(
          future: Backend().fetchDaysFromDb(format.format(DateTime(days[index].date.year, days[index].date.month, days[index].date.day))),
          initialData: {"Note" : "Enter note here: ", "Mood" : 0},
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.data != null){
              if (snapshot.data["Note"] != null){
                days[index].note = snapshot.data["Note"];
              }
              if (snapshot.data["Mood"] != null){
                days[index].mood = snapshot.data["Mood"];
              }
            }
            else {
              days[index].note = "Enter note here:";
            }
            return CalendarButton(
				      buttonTapped: (){
				      	showDialog(
				      		context: context, 
				      		builder: (context) => CalendarPopUp(
                    index: index,
				      			date: days[index],
				      			title: dayTitleFormat.format(DateTime(days[index].date.year ,days[index].date.month ,days[index].date.day)),
				      			text: FutureBuilder(
				      			  future: Backend().getDeviceId(),
				      			  builder: (BuildContext context, AsyncSnapshot snapshot) {
				      				  return Text('${this.days[index].date.weekday}  ');
				      			  },
				      			),
				      		));
				      },
            index: index,
				    color: days[index].colorPicker(),
				    buttonDate: days[index].date.day,
				    note: days[index].note,
				    );
          },
        );

			}	
		);
	}
}

