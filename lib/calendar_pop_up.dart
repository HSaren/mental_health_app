import 'package:mental_health_app/calendar_pop_up_smiley.dart';
import 'package:mental_health_app/data_to_send_singleton.dart';

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
			content: null,//CalendarSmiley(),
			actions: [
        CalendarSmiley(date),
				Form(
              child: CalendarForm(date, date.note, index)
        ),
				TextButton(
					child: const Text("OK"),
					onPressed: () => {
            DataToSendSingleton().dataToSend = {},
            Navigator.pop(context),
          }
				)
			],
		);
	}
}