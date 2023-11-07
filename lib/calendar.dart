import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mental_health_app/buttonData.dart';
import 'package:mental_health_app/main.dart';
import 'calendar_button.dart';
import 'calendar_pop_up.dart';
import 'backend.dart';
import 'days.dart';
import 'months.dart';

class Calendar extends StatefulWidget{
  var currentMonth;

	Calendar({this.currentMonth});

  @override CalendarState createState() => CalendarState();
}

class CalendarState extends State<Calendar>{
	
  void awaitMonths() async{
    await setMonths(widget.currentMonth);
    setState(() {
      
    });
  }

  @override
  void initState() {
    super.initState();
    awaitMonths();
  }
  
	@override
	Widget build (BuildContext context){ 
    final format = DateFormat.yMMMd();
    final monthFormat = DateFormat.MMMM();
    final dayTitleFormat = DateFormat.MMMd();
    
    var days = MonthsSingleton().months[2];
    var currentMonth = widget.currentMonth;
    if (MonthsSingleton().months[2] == null){
      return Text("Loading");
    }
    else
		  return Column(children: <Widget>[
	  		    	Container(
	  		    		alignment: Alignment.bottomCenter,
	  		    		child: Text(DateFormat.y().format(currentMonth)),
	  		    	),
	  		    	Container(
	  		    		child: Row(
	  		    			mainAxisAlignment: MainAxisAlignment.center,
	  		    			children: [
	  		    				GestureDetector(
	  		    					onTap: () {
	  		    						setState(() {
                          MonthsSingleton().months[3] = MonthsSingleton().months[2];
                          MonthsSingleton().months[2] = MonthsSingleton().months[1];
                          MonthsSingleton().months[1] = setDays(DateTime(currentMonth.year, currentMonth.month - 2), 1);
	  		    							widget.currentMonth = DateTime(currentMonth.year, currentMonth.month - 1);
	  		    							days = MonthsSingleton().months[2];
	  		    						  });

	  		    					},
	  		    					child: Padding(
	  		    						padding: const EdgeInsets.all(0.2),
	  		    						child: ClipRRect(
	  		    							child: Container(
	  		    								alignment: Alignment.bottomRight,
	  		    								child: Text("< ", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
	  		    							),
	  		    						)
	  		    					)
	  		    				),
	  		    				Container(
	  		    					alignment: Alignment.bottomCenter,
	  		    					child: Text(monthFormat.format(currentMonth)),
	  		    				),
	  		    				GestureDetector(
	  		    					onTap: () {
	  		    						setState(() {
                          MonthsSingleton().months[1] = MonthsSingleton().months[2];
                          MonthsSingleton().months[2] = MonthsSingleton().months[3];
                          MonthsSingleton().months[3] = setDays(DateTime(currentMonth.year, currentMonth.month - 2), 1);
	  		    							widget.currentMonth = DateTime(currentMonth.year, currentMonth.month + 1);
	  		    							days = MonthsSingleton().months[2];
	  		    						  });

	  		    					},
	  		    					child: Padding(
	  		    						padding: const EdgeInsets.all(0.2),
	  		    						child: ClipRRect(
	  		    							child: Container(
	  		    								alignment: Alignment.bottomRight,
	  		    								child: Text(" >", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
	  		    							),
	  		    						)
	  		    					)
	  		    				),
	  		    			],
	  		    		) 
	  		    	),
	  		    	Row(
	  		    		mainAxisAlignment: MainAxisAlignment.spaceBetween,
	  		    		children: [
	  		    			Container(
	  		    				alignment: Alignment.center,
	  		    				child: Text("   Mon"),
	  		    			),
	  		    			Container(
	  		    				alignment: Alignment.center,
	  		    				child: Text("Tue"),
	  		    			),
	  		    			Container(
	  		    				alignment: Alignment.center,
	  		    				child: Text("Wed"),
	  		    			),
	  		    			Container(
	  		    				alignment: Alignment.center,
	  		    				child: Text("Thu"),
	  		    			),
	  		    				Container(
	  		    				alignment: Alignment.center,
	  		    				child: Text("Fri  "),
	  		    			),
	  		    			Container(
	  		    				alignment: Alignment.center,
	  		    				child: Text("Sat  "),
	  		    			),
	  		    			Container(
	  		    				alignment: Alignment.center,
	  		    				child: Text("Sun   "),
	  		    			),
	  		    		],
	  		    	),
	  		    	Expanded(
	  		    		child: GridView.builder(
			                  itemCount: days.length,
		                  	gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
		                  		crossAxisCount: 7
		                  	),
		                  	itemBuilder: (BuildContext context, int index){
                             return CalendarButton(
                               index: index,
		                  		      color: days[index].colorPicker(),
		                  		      buttonDate: days[index].date.day,
		                  		      note: days[index].note,
                                buttonMood: days[index].moodInString,
                               // TODO: 
		                  		      buttonTapped: (){
                                  currentMonth = widget.currentMonth;
                                  days = MonthsSingleton().months[2];
                                  if (days[index].date.month != currentMonth.month){
                                    if (days[index].date.isBefore(currentMonth)){
                                      MonthsSingleton().months[3] = MonthsSingleton().months[2];
                                      MonthsSingleton().months[2] = MonthsSingleton().months[1];
                                      MonthsSingleton().months[1] = setDays(DateTime(currentMonth.year, currentMonth.month - 2), 1);
                                      setState(() {
                                        days = MonthsSingleton().months[2];
                                        widget.currentMonth = DateTime(currentMonth.year, currentMonth.month - 1);
                                      });
                                   }
                                   else{
                                      MonthsSingleton().months[1] = MonthsSingleton().months[2];
                                      MonthsSingleton().months[2] = MonthsSingleton().months[3];
                                      MonthsSingleton().months[3] = setDays(DateTime(currentMonth.year, currentMonth.month + 2), 3);
                                      setState(() {
                                        days = MonthsSingleton().months[2];
                                        widget.currentMonth = DateTime(currentMonth.year, currentMonth.month + 1);

                                      });
                                   }
                                 }
                                 else {
                                   showDialog(
		                  		      		context: context, 
		                  		      		builder: (context) => CalendarPopUp(
                                     index: index,
		                  		      			date: days[index],
		                  		      			title: dayTitleFormat.format(DateTime(days[index].date.year ,days[index].date.month ,days[index].date.day)),
		                  		      			text: FutureBuilder(
		                  		      			  future: Backend().getDeviceId(),
		                  		      			  builder: (BuildContext context, AsyncSnapshot snapshot) {
		                  		      				  return Text('${days[index].date.weekday}  ');
		                  		      			  },
		                  		      			),
		                  		      		));
                                 }
		                  		      },
		                  		    );
                           },
                         )
              )
            ]
          );
	}
}
ButtonData setDay(data, i){
  var note = "";
  var mood = 0;
  if (data != null){
    if (data["Note"] != null){
      note = data["Note"];
    }
    if (data["Mood"] != null){
      mood = data["Mood"];
    }
  }
  return ButtonData(data["date"], note, data["date"].month, i, Backend().moodPicker(mood), mood);
}
Future<List<ButtonData>> setDays(DateTime currentMonth, month) async{
	DateTime currentDateBeingGenerated = DateTime(currentMonth.year, currentMonth.month, 1);
	DateTime lastDay = DateTime(currentMonth.year, currentMonth.month + 1, 0);
  final format = DateFormat.yMMMd();
  var i = 0;
  List<Future> emptyList = [];
	List<ButtonData> daysBeingGenerated = <ButtonData>[];
	if (currentDateBeingGenerated.weekday != 1){
		while (currentDateBeingGenerated.weekday != 1){
			currentDateBeingGenerated = DateTime(currentDateBeingGenerated.year, currentDateBeingGenerated.month, currentDateBeingGenerated.day - 1);
		}
    emptyList.add(awaitData(format.format(currentDateBeingGenerated), currentDateBeingGenerated, i, month).then((value) => daysBeingGenerated.add(setDay(value, i))));
    i++;
	}
	else{
    emptyList.add(awaitData(format.format(currentDateBeingGenerated), currentDateBeingGenerated, i, month).then((value) => daysBeingGenerated.add(setDay(value, i))));
    i++;
	}
	while(currentDateBeingGenerated.isBefore(DateTime(currentMonth.year, currentMonth.month + 1, 0).add(Duration(days: 7 - lastDay.weekday)))){
		currentDateBeingGenerated = DateTime(currentDateBeingGenerated.year, currentDateBeingGenerated.month, currentDateBeingGenerated.day + 1);
    emptyList.add(awaitData(format.format(currentDateBeingGenerated), currentDateBeingGenerated, i, month).then((value) => daysBeingGenerated.add(setDay(value, i))));
    i++;
	}
  await Future.wait(emptyList);
	return daysBeingGenerated;
}

Future<dynamic> awaitData (date, currentDateBeingGenerated, i, month) async {
  var dataToReturn;
  await Backend().fetchDaysFromDb(date).then((value) => dataToReturn = value);
  if (dataToReturn != null){
    dataToReturn["date"] = currentDateBeingGenerated;
  }
  else{
    dataToReturn = {"date": currentDateBeingGenerated};
  }
  return dataToReturn;
}

Future setMonths(DateTime now) async{
  var month1, month2, month3;
 
  Future future1 = setDays(DateTime(now.year, now.month - 1), 1);
  future1.then((value) => month1 = value);
  Future future2 = setDays(DateTime(now.year, now.month - 1), 1);
  future2.then((value) => month2 = value);
  Future future3 = setDays(DateTime(now.year, now.month - 1), 1);
  future3.then((value) => month3 = value);
  await future1;
  await future2;
  await future3;
  MonthsSingleton().months = {
    1 : month1,
    2 : month2,
    3 : month3
  };
}
