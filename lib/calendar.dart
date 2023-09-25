import 'package:flutter/material.dart';
import 'calendar_button.dart';
import 'calendar_pop_up.dart';
import 'backend.dart';

class Calendar extends StatelessWidget{

	final days;

	Calendar({this.days});

	@override
	Widget build (BuildContext context){ 
		return GridView.builder(
			itemCount: days.length,
			gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
				crossAxisCount: 7
			),
			itemBuilder: (BuildContext context, int index){
				return CalendarButton(
				buttonTapped: (){
					showDialog(
						context: context, 
						builder: (context) => CalendarPopUp(
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
				color: days[index].colorPicker(),
				buttonDate: days[index].date.day,
				note: days[index].notes,
				);

			}	
		);
	}
}

