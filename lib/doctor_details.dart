import 'dart:convert';

import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/material.dart';

class DoctorDetails extends StatefulWidget {
  @override
  _DoctorDetailsState createState() => _DoctorDetailsState();
}

class _DoctorDetailsState extends State<DoctorDetails> {
  DatePickerController _controller = DatePickerController();
  DateTime _selectedValue = DateTime.now();

  final String url = "assets/appointmentList.json";
  List<dynamic> allData = [];
  List<dynamic> appointmentData = [];
  Map<String, dynamic> appointment;
  var isLoading = false;

  @override
  void initState() {
    super.initState();
   this.getjsondata();
  }

  Future<String> getjsondata() async {
    String jsonData = await DefaultAssetBundle.of(context)
        .loadString("assets/details.json");
    final jsonResult = json.decode(jsonData);

    // print(jsonResult)
    allData = jsonResult;
    appointmentData = allData;
    setState(() {});
  }

  getSelectedDateAppointments() {
    appointmentData = allData.where((element) {
      print(element);
      Map<String, dynamic> appItem = element;
      return appItem['appointmentDate'] == _selectedValue.toString();
    }).toList();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final _PatientSearchCard = Card(
      elevation: 4.0,
      margin: EdgeInsets.fromLTRB(10, 5, 10, 5),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
      child: Container(
        margin: EdgeInsets.only(top: 0.0),
        height: 60.0,
        width: 300.0,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            ListTile(
              trailing: Icon(Icons.search),
              title: new TextField(
                decoration: InputDecoration(
                  border: InputBorder.none,
                    hintText: "Search Patients"),
                style: TextStyle(color: Colors.black),
              ),
            )
          ],
        ),
      ),
    );


    return Scaffold(
      drawer: Container(),
      appBar: AppBar(
        elevation: 0.5,
        backgroundColor: Color.fromRGBO(34, 82, 160, 1),
        title: ListTile(
          leading: CircleAvatar(
            radius: 18,
            child: ClipOval(
              child: Image.network(
                  "http://tineye.com/images/widgets/mona.jpg"),
            ),
          ),
          title: Text(
            "Welcome Dr.Sciliaris",
            style: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
                fontWeight: FontWeight.bold),
          ),
          trailing: Icon(
            Icons.filter_list_outlined,
            color: Colors.white,
          ),
        ),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        //color: Colors.black,
        child: Stack(
          alignment: Alignment.topCenter,
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.10,
              color: Color.fromRGBO(34, 82, 160, 1),
            ),
            Positioned(
              top: MediaQuery.of(context).size.width * 0.10,
              child: Container(
                width: MediaQuery.of(context).size.width * 0.90,
                child: Column(
                  children: <Widget>[
                    _PatientSearchCard,
                    Container(
                      child: DatePicker(
                        DateTime.now(),
                        width: 50,
                        height: 80,
                        controller: _controller,
                        initialSelectedDate: DateTime.now(),
                        selectionColor: Color.fromRGBO(34, 82, 160, 1),
                        selectedTextColor: Colors.white,

                        onDateChange: (date) {
                          // New date selected

                          setState(() {
                            _selectedValue = date;
                            getSelectedDateAppointments();
                          });
                          print(_selectedValue);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              child: Stack(
                children: <Widget>[
                  SafeArea(
                    bottom: false,
                    child: Stack(
                      children: <Widget>[
                        DraggableScrollableSheet(
                          maxChildSize: .8,
                          initialChildSize: .6,
                          minChildSize: .6,
                          builder: (context, scrollController) {
                            return Container(
                              height: 100,
                              padding: EdgeInsets.only(
                                  left: 19,
                                  right: 19,
                                  top:
                                  16), //symmetric(horizontal: 19, vertical: 16),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(30),
                                    topRight: Radius.circular(30)),
                                color: Colors.white,
                              ),
                              child: SingleChildScrollView(
                                scrollDirection: Axis.vertical,
                                physics: BouncingScrollPhysics(),
                                controller: scrollController,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "HEASC 54-DEAN (4)",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18.0),
                                        )
                                      ],
                                    ),
                                    appointmentData != null &&
                                        appointmentData.isNotEmpty
                                        ? ListView.separated(
                                      separatorBuilder:
                                          (context, index) => Divider(
                                        color: Colors.black,
                                      ),
                                      shrinkWrap: true,
                                      itemCount: appointmentData.length,
                                      itemBuilder: (context, index) {
                                        Map<String, dynamic> item =
                                        appointmentData[index];
                                        return ListTile(
                                          contentPadding:
                                          EdgeInsets.all(0),
                                          leading: Icon(
                                            Icons.bookmark,
                                            color: Colors.green,
                                          ),
                                          title: Text(item["patientName"]),
                                          subtitle: Text(
                                              item["providerName"] +
                                                  "\n" +
                                                  item["status"]),
                                          trailing: Column(
                                            children: [
                                              Text(item[
                                              "appointmentTime"]),
                                              Spacer(),
                                              RichText(
                                                text: TextSpan(
                                                  text: '• ',
                                                  style: TextStyle(
                                                      color: Colors.red,
                                                      fontSize: 14),
                                                  children: <TextSpan>[
                                                    TextSpan(
                                                      text:
                                                          item[
                                                          "dictationStatus"],
                                                    ),
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                        );
                                      },
                                    )
                                        : Container(
                                        child: Text(
                                          "No Appointments",
                                          style: TextStyle(
                                              fontSize: 18.0,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.blueGrey),
                                        )),
                                    Divider(
                                      thickness: .5,
                                      color: Colors.grey,
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Increment',
        onPressed: () {},
        child: Icon(Icons.add),
      ),
    );
  }
}

class MyBullet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Container(
      height: 20.0,
      width: 20.0,
      decoration: new BoxDecoration(
        color: Colors.black,
        shape: BoxShape.circle,
      ),
    );
  }
}

//     return Scaffold(
//       body: Stack(
//         children: [
//           Column(
//             children: [
//               Container(
//                 color: Colors.blue,
//                 height: MediaQuery.of(context).size.height * 0.20,
//                 child: Padding(
//                   padding: const EdgeInsets.all(20.0),
//                   child: Row(
//                     children: [
//                       IconButton(
//                           icon: Icon(
//                             Icons.menu,
//                             color: Colors.white,
//                           ),
//                           onPressed: () {}),
//                       CircleAvatar(
//                         radius: 18.0,
//                         backgroundImage: NetworkImage(
//                             'http://tineye.com/images/widgets/mona.jpg'),
//                         backgroundColor: Colors.transparent,
//                       ),
//                       Text(
//                         'Welcome Dr. Sahana',
//                         style: TextStyle(color: Colors.white),
//                       ),
//                       Align(
//                           alignment: Alignment.centerRight,
//                           child: IconButton(
//                               icon: Icon(
//                                 Icons.filter_list_outlined,
//                                 color: Colors.white,
//                               ),
//                               onPressed: () {}))
//                     ],
//                   ),
//                 ),
//               ),
//
//               // Date Picker
//               Container(
//                 height: MediaQuery.of(context).size.height * 0.80,
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   children: <Widget>[
//                     SizedBox(height: 39),
//                     DatePicker(
//                       DateTime.now(),
//                       initialSelectedDate: DateTime.now(),
//                       selectionColor: Colors.black,
//                       selectedTextColor: Colors.white,
//                       onDateChange: (date) {
//                         // New date selected
//                         setState(() {
//                           _selectedValue = date;
//                           print('Selected date is $date');
//                         });
//                       },
//                     ),
//                     Container(
//                       height: MediaQuery.of(context).size.height * 0.64,
//                       decoration: BoxDecoration(
//                         color: Colors.white,
//                         borderRadius: BorderRadius.only(
//                           topLeft: Radius.circular(16.0),
//                           topRight: Radius.circular(16.0),
//                         ),
//                       ),
//                       child: Padding(
//                         padding: const EdgeInsets.all(8.0),
//                         child: Align(
//                           alignment: Alignment.topCenter,
//                           child: Column(
//                             children: [
//                               Container(
//                                 height: 450,
//                                 child: FutureBuilder(
//                                   future: DefaultAssetBundle.of(context)
//                                       .loadString('assets/details.json'),
//                                   builder: (context, index) {
//                                     var newData =
//                                         json.decode(index.data.toString());
//
//                                     return ListView.separated(
//                                       itemCount: newData == null ? 0: newData.length,
//                                       itemBuilder: (context, int index) {
//                                         return
//                                           ListTile(
//                                           title: Text(newData[index]['name'],
//                                               style: TextStyle()),
//                                           subtitle: Text(
//                                             newData[index]['doctorname'] + '\n' + newData[index]['hospital'],
//                                             style: TextStyle(),
//                                           ),
//                                           trailing:
//                                               Text(newData[index]['time']),
//                                         );
//                                       },
//                                       separatorBuilder: (context, index) {
//                                         return Divider(color: Colors.black);
//                                       },
//                                     );
//                                   },
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//           Positioned(
//             top: MediaQuery.of(context).size.height * 0.18,
//             child: Card(
//               color: Colors.grey,
//               shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.all(Radius.circular(20.0))),
//               margin: const EdgeInsets.fromLTRB(35, 0, 35, 0),
//               elevation: 30,
//               child: Container(
//                 decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.all(Radius.circular(10))),
//                 width: MediaQuery.of(context).size.width * 0.8,
//                 height: 50,
//                 // height: MediaQuery.of(context).size.height *0.1,
//                 //color: Colors.white,
//                 child: Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: TextField(
//                     decoration: InputDecoration(
//                         border: InputBorder.none, hintText: 'Search Patients'),
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
