
class MonthsSingleton{
  static final MonthsSingleton _instance = MonthsSingleton._internal();

  factory MonthsSingleton(){
    return _instance;
  }

  MonthsSingleton._internal(){
    months = {};
  }

  Map<int, dynamic> months = {
    
  };
}


