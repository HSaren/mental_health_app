

class DataToSendSingleton{
  static final DataToSendSingleton _instance = DataToSendSingleton._internal();

  factory DataToSendSingleton(){
    return _instance;
  }

  DataToSendSingleton._internal(){
    dataToSend = {};
  }

  var dataToSend = <String, dynamic>{

  };
}