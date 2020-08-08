import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'detailspage.dart';
import 'model/employee.dart';

class RemoteJson extends StatefulWidget {
  @override
  _RemoteJsonState createState() => _RemoteJsonState();
}

class _RemoteJsonState extends State<RemoteJson> {
  Future<List<Employee>> _getEmployee() async {
    var empData = await http
        .get("http://www.json-generator.com/api/json/get/bUtYFddVea?indent=2");
    var jsonData = json.decode(empData.body);
    List<Employee> employees = [];
    for (var emp in jsonData) {
      Employee employee = Employee(emp["empname"], emp["department"], emp["picture"]);
      employees.add(employee);
    }
    return employees;
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("hjhjhjhj"),
      ),
      body: Container(
        child: FutureBuilder(
          future: _getEmployee(),
          builder: (BuildContext context, AsyncSnapshot snapshot){
            print(snapshot.data);
            if(snapshot.data == null){
              return Container(
                  child: Center(
                      child: Text("Loading...")
                  )
              );
            } else {
              return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(
                          snapshot.data[index].empimg
                      ),
                    ),
                    title: Text(snapshot.data[index].empname),
                    subtitle: Text(snapshot.data[index].department),
                    onTap: (){

                      Navigator.push(context,
                          new MaterialPageRoute(builder: (context) => DetailPage(snapshot.data[index]))
                      );

                    },
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}

