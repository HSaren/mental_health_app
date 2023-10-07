import 'package:mental_health_app/calendar_pop_up_smiley.dart';

import 'calendar_form.dart';
import 'package:flutter/material.dart';

class CalendarPopUp extends StatelessWidget{
	final title;
	final text;
	final date;
  final index;

	CalendarPopUp({this.text, this.date, this.title, this.index});
	final textController = TextEditingController();
	@override
	Widget build(BuildContext context){
    
		return AlertDialog(
			title: Text(title),
			content: Text("hi"),//CalendarSmiley(),
			actions: [
        CalendarSmiley(date),
				Form(
              child: CalendarForm(date, date.note, index)
        ),
				TextButton(
					child: const Text("OK"),
					onPressed: () => {
            Navigator.pop(context),
          }
				)
			],
		);
	}
}