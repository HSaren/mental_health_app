import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:mental_health_app/buttonData.dart';
import 'package:mental_health_app/firebase_options.dart';
import 'package:mental_health_app/main.dart';
import 'calendar_button.dart';
import 'calendar_pop_up.dart';
import 'backend.dart';
import 'days.dart';
import 'months.dart';

class Calendar extends StatefulWidget{

	Calendar({super.key});

  @override CalendarState createState() => CalendarState();
}

class CalendarState extends State<Calendar>{
  DateTime currentMonth = DateTime.now();

  @override
  void initState() {
    super.initState();
    var now = DateTime.now();
    generateMonths(DateTime(now.year, now.month, 1));
    fetchDataForMonths();
  }
  
	@override
	Widget build (BuildContext context){ 
    final monthFormat = DateFormat.MMMM();
    final dayTitleFormat = DateFormat.MMMd();
    var days = MonthsSingleton().months[2];
    if (MonthsSingleton().months[2] == null || MonthsSingleton().months[1] == null || MonthsSingleton().months[3] == null){
      return const Text("Loading");
    }
    else{
		  return Column(children: <Widget>[
	  		    	Container(
	  		    		alignment: Alignment.bottomCenter,
	  		    		child: Text(DateFormat.y().format(currentMonth)),
	  		    	),
	  		    	Row(
	  		    			mainAxisAlignment: MainAxisAlignment.center,
	  		    			children: [
	  		    				GestureDetector(
	  		    					onTap: () {
	  		    						setState(() {
                          MonthsSingleton().months[3] = MonthsSingleton().months[2];
                          MonthsSingleton().months[2] = MonthsSingleton().months[1];
                          MonthsSingleton().months[1] = null;
                          handleMonthChange(1, currentMonth);
	  		    							currentMonth = DateTime(currentMonth.year, currentMonth.month - 1);
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
                          MonthsSingleton().months[3] = null;
                          handleMonthChange(3, currentMonth);
	  		    							currentMonth = DateTime(currentMonth.year, currentMonth.month + 1);
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
		                  		      color: days[index].colorPicker(currentMonth),
		                  		      buttonDate: days[index].date.day,
		                  		      note: days[index].note,
                                buttonMood: days[index].moodInString,
                               // TODO: 
		                  		      buttonTapped: (){
                                  days = MonthsSingleton().months[2];
                                  if (days[index].date.month != currentMonth.month){
                                    if (days[index].date.isBefore(currentMonth)){
                                      MonthsSingleton().months[3] = MonthsSingleton().months[2];
                                      MonthsSingleton().months[2] = MonthsSingleton().months[1];
                                      MonthsSingleton().months[1] = null;
                                      handleMonthChange(1, currentMonth);
                                      setState(() {
                                        days = MonthsSingleton().months[2];
                                        currentMonth = DateTime(currentMonth.year, currentMonth.month - 1);
                                      });
                                   }
                                   else{
                                      MonthsSingleton().months[1] = MonthsSingleton().months[2];
                                      MonthsSingleton().months[2] = MonthsSingleton().months[3];
                                      MonthsSingleton().months[3] = null;
                                      handleMonthChange(3, currentMonth);
                                      setState(() {
                                        days = MonthsSingleton().months[2];
                                        currentMonth = DateTime(currentMonth.year, currentMonth.month + 1);

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
}

List<ButtonData> generateMonth(DateTime monthDate){
  List<ButtonData> month = [];
  DateTime lastDayOfTheMonth = DateTime(monthDate.year, monthDate.month+ 1, 0);
  DateTime currentDateBeingGenerated = DateTime(monthDate.year, monthDate.month, 1);
  if (currentDateBeingGenerated.weekday != 1){
    while(currentDateBeingGenerated.weekday != 1){
      currentDateBeingGenerated = currentDateBeingGenerated.subtract(Duration(days: 1));
    }
    month.add(ButtonData(currentDateBeingGenerated));
  }
  else {
    month.add(ButtonData(currentDateBeingGenerated));
  }
  while(currentDateBeingGenerated.isBefore(DateTime(lastDayOfTheMonth.year, lastDayOfTheMonth.month, lastDayOfTheMonth.day + (7 - lastDayOfTheMonth.weekday)))){
    currentDateBeingGenerated = currentDateBeingGenerated.add(const Duration(days: 1));
    month.add(ButtonData(currentDateBeingGenerated));
  }
  return month;
}

void handleMonthChange(int index, DateTime monthDate){
  var difference  = 0;
  switch(index){
    case 1: 
     difference = -2;
     break;
    case 2:
     difference = 2;
     break;
    default:
     difference = 0;
     break;
  }
  MonthsSingleton().months[index] = generateMonth(DateTime(monthDate.year, monthDate.month + difference, 1));
  fetchDataForMonth(index);
}

void fetchDataForMonth(index) async{
  RootIsolateToken rootIsolateToken = RootIsolateToken.instance!;
  var month = MonthsSingleton().months[index];
  Map<int, dynamic> values = {1: rootIsolateToken};
  for (ButtonData day in month){
    values[2] = day;
    day = await compute(fetchDataForDay, values);
  }
  print("Fetched data");
  MonthsSingleton().months[index] = month;
}

FutureOr<ButtonData> fetchDataForDay(Map<int, dynamic> values) async {
  var day = values[2];
  var token = values[1];
  BackgroundIsolateBinaryMessenger.ensureInitialized(token);
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform,);
  await  Backend().fetchDaysFromDb(day.date).then((value) =>{
      if (value != null){
        if (value["Note"] != null){
        day.note = value["Note"],
        },
        if (value["Mood"] != null){
          day.mood = value["Mood"],
          day.moodPicker()
        }
      }
      
    });
  return day;
}


//TODO: Implement isolate multithreading to speed up data fetching, for example Future<ButtonData> fetchDayForMonth() that runs as an isolate
void generateMonths(DateTime monthDate){
  MonthsSingleton().months = {
    1 : generateMonth(DateTime(monthDate.year, monthDate.month - 1, 1)),
    2 : generateMonth(monthDate),
    3 : generateMonth(DateTime(monthDate.year, monthDate.month + 1, 1))
  };
}

void fetchDataForMonths(){
  for (int i = 1; i <= MonthsSingleton().months.length; i++){
    fetchDataForMonth(i);
  }
}

