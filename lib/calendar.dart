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
		return GridView.builder(
			itemCount: days.length,
			gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
				crossAxisCount: 7
			),
			itemBuilder: (BuildContext context, int index){
				return FutureBuilder(
          future: Backend().fetchDaysFromDb(format.format(DateTime(days[index].date.year, days[index].date.month, days[index].date.day))),
          initialData: "Enter note here: ",
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.data != null){
              days[index].note = snapshot.data;
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
				      			title: "test",
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

