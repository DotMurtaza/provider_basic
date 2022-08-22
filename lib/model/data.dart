import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:untitled/model/list_data.dart';

class Data extends ChangeNotifier{
  String data="some Data";
  void changeString(String newString){
    data=newString;
    notifyListeners();
  }
  void onToggle({val, index}){
    _task[index].isDone=val;
    if(_task[index].isDone==true){
      removeTask(index);
    }
    notifyListeners();
  }
  List<ListData> _task=[
    ListData(isDone: false,title: "First task")
  ];
  UnmodifiableListView get task{
    return UnmodifiableListView(_task);
  }
  int taskLengh(){
    return _task.length;
  }
  void addTask(String title,bool isDone){
    _task.add(ListData(title: title, isDone: isDone));
    notifyListeners();
  }
  void removeTask(index){
    _task.removeAt(index);
    notifyListeners();
  }

}