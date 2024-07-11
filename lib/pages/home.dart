import 'package:appgbd/pages/employee.dart';
import 'package:appgbd/service/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController nameController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  Stream? EmployeeStream;

  getontheload() async {
    EmployeeStream = await DatabaseMethods().getEmployeeDetails();
    setState(() {});
  }

  @override
  void initState() {
    getontheload();
    super.initState();
  }

  Widget allEmployeeDetails() {
    return StreamBuilder(
        stream: EmployeeStream,
        builder: (context, AsyncSnapshot snapshot) {
          return snapshot.hasData
              ? ListView.builder(
                  itemCount: snapshot.data.docs.length,
                  itemBuilder: (context, index) {
                    DocumentSnapshot ds = snapshot.data.docs[index];
                    return Container(
                      margin: EdgeInsets.only(bottom: 30.0),
                      child: Material(
                        elevation: 5.0,
                        borderRadius: BorderRadius.circular(10.0),
                        child: Container(
                          padding: EdgeInsets.all(20.0),
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                
                                children: [
                                  Text(
                                    "Name: ${ds["name"]}",
                                    style: TextStyle(
                                        color: const Color.fromARGB(
                                            255, 23, 23, 24),
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Spacer(),
                                  GestureDetector(
                                      onTap: () {
                                        nameController.text =ds["name"];
                                        ageController.text = ds["age"];
                                        locationController.text = ds["location"];
                                        EditEmployeeDetail(ds["Id"]);
                                      },
                                      child:
                                          Icon(Icons.edit, color: Colors.blue)),
                                          SizedBox(width: 5.0,),
                                          GestureDetector(
                                            onTap: ()async{
                                              print("Entrando aca");
                                              print("Intentando eliminar el documento con ID: ${ds["Id"]}");
                                              await DatabaseMethods().deleteEmployeeDetails(ds["Id"]);
                                            },
                                            child: Icon(Icons.delete, color: Colors.red)),
                                ],
                              ),
                              Text(
                                "Age: ${ds["age"]}",
                                style: TextStyle(
                                    color:
                                        const Color.fromARGB(255, 23, 23, 24),
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "Location: ${ds["location"]}",
                                style: TextStyle(
                                    color:
                                        const Color.fromARGB(255, 23, 23, 24),
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  })
              : Container();
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Employee()));
        },
        backgroundColor: Colors.red,
        child: Icon(Icons.add),
      ),
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Flutter',
              style: TextStyle(
                  color: Colors.blue,
                  fontSize: 30.0,
                  fontWeight: FontWeight.bold),
            ),
            Text(
              'FireBase',
              style: TextStyle(
                  color: Color.fromARGB(255, 230, 111, 0),
                  fontSize: 30.0,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
      body: Container(
          margin: EdgeInsets.only(left: 20.0, right: 20.0, top: 30.0),
          child: Column(
            children: [
              Expanded(child: allEmployeeDetails()),
            ],
          )),
    );
  }

  Future EditEmployeeDetail(String id) => showDialog(
      context: context,
      builder: (context) => AlertDialog(
              content: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Icon(Icons.cancel)),
                    SizedBox(
                      width: 60.0,
                    ),
                    Text(
                      'Edit',
                      style: TextStyle(
                          color: Colors.blue,
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Details',
                      style: TextStyle(
                          color: Color.fromARGB(255, 230, 111, 0),
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                SizedBox(height: 20.0),
                Text(
                  "Name",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold),
                ),
                Container(
                  margin: EdgeInsets.only(top: 10.0),
                  child: TextField(
                    controller: nameController,
                    decoration: InputDecoration(
                      hintText: "Enter your name",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10.0),
                Text(
                  "Age",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold),
                ),
                Container(
                  margin: EdgeInsets.only(top: 10.0),
                  child: TextField(
                    keyboardType: TextInputType.number,
                    controller: ageController,
                    decoration: InputDecoration(
                      hintText: "Enter your age",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10.0),
                Text(
                  "Location",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold),
                ),
                Container(
                  margin: EdgeInsets.only(top: 10.0),
                  child: TextField(
                    controller: locationController,
                    decoration: InputDecoration(
                      hintText: "Enter your location",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10.0),
                ElevatedButton(onPressed: ()async{
                  Map<String, dynamic>updateInfo = {
                    "name": nameController.text,
                    "age": ageController.text,
                    "Id": id,
                    "location": locationController.text,
                  };
                  await DatabaseMethods().updateEmployeeDetails(id, updateInfo).then((value){
                    Navigator.pop(context);
                  });
                }, child: Text("Update"))
              ],
            ),
          )));
}
