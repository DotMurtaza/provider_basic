import 'package:device_preview/device_preview.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled/model/list_data.dart';

import 'model/data.dart';

void main() {
  runApp(DevicePreview(
    enabled: !kReleaseMode,
    builder: (context) => MyApp(), // Wrap your app
  ),);
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<Data>(
      create: (BuildContext context)=>Data(),
      child: MaterialApp(
        useInheritedMediaQuery: true,
        locale: DevicePreview.locale(context),
        builder: DevicePreview.appBuilder,
        title: 'Flutter Demo',
        theme: ThemeData(
               primarySwatch: Colors.blue,
        ),
        home: const MyHomePage(title: 'Flutter Demo Home Page'),
      ),
    );
  }
}


class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}
class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  void _incrementCounter() {
    setState(() {
         _counter++;
    });
  }
  List<String> itemHeight=['Inches','Feet','Meter','Centimeter'];
  var selectedHeight;
  List<String> itemWeight=['Gigatonne','Kilogram','Gram','Milligram',"Microgram"];
  var selectedWeight;
late String newTask;
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(Provider.of<Data>(context,listen: true).data,),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: SingleChildScrollView(
          child: Column(

            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ListWidget(),
            // TextField(
            //   onChanged: (newVal){
            //     Provider.of<Data>(context,listen: false).changeString(newVal);
            //
            //   },
            // ),
              Text(Provider.of<Data>(context,listen: true).data),

              CupertinoButton(


                  child: Text("Hello There"), onPressed: (){})
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //   children: [
              //    const  Text(
              //       'Height:',
              //     ),
              //     DropdownButton(
              //       hint:const Text('Please choose your height'),
              //       value: selectedHeight,
              //       onChanged: (newValue) {
              //         setState(() {
              //           selectedHeight = newValue!;
              //         });
              //       },
              //       items: itemHeight.map((location) {
              //         return DropdownMenuItem(
              //           child:  Text(location),
              //           value: location,
              //         );
              //       }).toList(),
              //     ),
              //   ],
              // ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //   children: [
              //   const  Text(
              //       'Weights:',
              //     ),
              //     DropdownButton<String>(
              //       hint:const Text('Please choose your weight'),
              //       value: selectedWeight,
              //       items: itemWeight.map((String value) {
              //         return DropdownMenuItem<String>(
              //           value: value,
              //           child: Text(value),
              //         );
              //       }).toList(),
              //       onChanged: (newVal) {
              //         setState(() {
              //           selectedWeight=newVal!;
              //         });
              //
              //       },
              //     )
              //   ],
              // ),

            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
         showModalBottomSheet(context: context, builder: (item){
           return Container(
             height: MediaQuery.of(context).size.height/2.5,
             color: Colors.white,
             child: Column(children: [
               CupertinoTextField(
                 onChanged: (val){
                   newTask=val;
                 },
               ),
               CupertinoButton(child: Text("Add Task"), onPressed: (){
                 Provider.of<Data>(context,listen: false).addTask(newTask, false);
                 Navigator.pop(context);
               })
             ],),
           );
         });
        },
        tooltip: 'Add Tasks',
        child: const Icon(CupertinoIcons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
class ListWidget extends StatelessWidget {
  const ListWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<Data>(builder: (BuildContext context, data, Widget? child) {
      return ListView.builder(
        shrinkWrap: true,
          itemCount: Provider.of<Data>(context).taskLengh(),
          itemBuilder:(ctx,index){
        return ListTile(
          title: Text(data.task[index].title),
          trailing: Checkbox(value: data.task[index].isDone , onChanged: (bool? value) {
            data.onToggle(
              index: index,
              val: value
            );
          },),
        );
      });
    },);

  }
}

