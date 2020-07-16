
import 'dart:ui';


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'main.dart';


var Symptoms = [
  "cough",
  "fever",
  "nausea",
  "idk",
  "new symptom"
];

var shownSymptoms = [

];

class symptomFinder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Enter Symptoms',
      home: regularScreen(),
    );
  }
}

// ignore: camel_case_types
class regularScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new EqByVar();
}

class EqByVar extends State<regularScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Find By Symptoms"),
      ),

      body: Container(
//
        child: Center(
          child: Column(
            children: <Widget>[

              Text('Symptoms'),
//             Expanded(
//               child:
              SizedBox(
                width: MediaQuery.of(context).copyWith().size.width,
                height: MediaQuery.of(context).copyWith().size.height / 4,
                child: Wrap(
                  children: <Widget>[
                    for (var item in shownSymptoms)
                      Container(
                          margin: new EdgeInsets.all(2.5),
                          child: RaisedButton.icon(
                            icon: Icon(Icons.clear),
                            color: Colors.red,
                            label: Text(
                              item,
                              style: new TextStyle(
                                fontSize: 15.0,
                                color: Colors.green,
                              ),
                            ),
                            onPressed: () => {
                              setState(() {
                                shownSymptoms.remove(item);
                              })
                            },
                          ))
                  ],
                ),
              ),

              ButtonTheme(
                minWidth: MediaQuery.of(context).copyWith().size.width,
                child: RaisedButton.icon(
                    onPressed: () => {
                      showSearch(
                          context: context, delegate: VariableSearch())
                    },
                    icon: Icon(Icons.search),
                    label: Text("Search for Symptoms")),
              ),
              if (shownSymptoms.length > 0)
                CupertinoButton(child: Text('find disease'), onPressed: () => {

                }),

              new Padding(padding: EdgeInsets.all(10)),
              new Text('Possible Diseases'),
              new Container(

              )


            ],
          ),
        ),
      ),
    );
  }
}

class VariableSearch extends SearchDelegate<String> {


  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(icon: Icon(Icons.clear), onPressed: () => {query = " "}),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        icon: AnimatedIcon(
            icon: AnimatedIcons.menu_arrow, progress: transitionAnimation),
        onPressed: () => {
          close(context, null),
        });
  }

  @override
  Widget buildResults(BuildContext context) {
    return Text(query);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestionList = query.isEmpty
        ? Symptoms
        : Symptoms.where((p) => p.startsWith(query.toLowerCase())).toList();

    return ListView.builder(
      itemBuilder: (context, index) => ListTile(
        onTap: () => {
          shownSymptoms.add(suggestionList[index]),
          showResults(context),
          close(context, null)
        },
        leading: Icon(Icons.lightbulb_outline),
        title: Text(suggestionList[index]),
      ),
      itemCount: suggestionList.length,
    );
  }
}
