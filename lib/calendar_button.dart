import 'package:flutter/material.dart';

class CalendarButton extends StatelessWidget{
	final buttonDate;
	final note;
	final buttonTapped;
	final color;

	CalendarButton({this.buttonDate, this.color, this.note, this.buttonTapped});

	@override
	Widget build(BuildContext context){
		return GestureDetector(
			onTap: buttonTapped,
			child: Padding(
				padding: const EdgeInsets.all(0.2),
				child: ClipRRect(
					child: Container(
						color: color,
						child: Column(children: <Widget>[
							Container(
								alignment: Alignment.topLeft,
								child: Text(buttonDate.toString(), style: TextStyle(color: Colors.black, fontSize: 10, fontWeight: FontWeight.bold),),
							)
						]),
					)
					
					
						
				),
			)
		);
	}
}