import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:mentor_web/pages/loginPageMentor.dart';

class AttendanceList extends StatefulWidget {
  final String batchName;
  const AttendanceList({super.key,required this.batchName});

  @override
  State<AttendanceList> createState() => _AttendanceListState();
}

class _AttendanceListState extends State<AttendanceList> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 120,
        backgroundColor: const Color.fromARGB(255, 43, 3, 24),
        title: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Image.asset("images/logo.png"),
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.logout,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const MentorLogin()),
                  (route) => false);
            },
            tooltip: "Logout",
          ),
          
        ],
      ),

      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: <Widget>[
              //Student
              Expanded(
                child: StreamBuilder(
                  stream: FirebaseFirestore.instance.collection(widget.batchName).snapshots(), 
                  builder: (context, snapshot) {
                    if(snapshot.connectionState == ConnectionState.waiting){
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const CircularProgressIndicator(),
                            SizedBox(height: 4,),
                            Text('fetching data....',style: GoogleFonts.abel(),)
                          ],
                        ),
                      );
                    }
          
                    if(snapshot.hasError){
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.error),
                            const SizedBox(height: 4,),
                            Text(snapshot.error.toString(),style: GoogleFonts.abel(),)
                          ],
                        ),
                      );
                    }

                    if(snapshot.data==null || snapshot.data!.docs.isEmpty){
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.error),
                            const SizedBox(height: 4,),
                            Text('No Data Found',style: GoogleFonts.abel(),)
                          ],
                        ),
                      );
                    }

                    var count = snapshot.data!.docs.length;
                    return ListView.builder(
                      itemCount: count,
                      itemBuilder: (context, index) {
                        var Data = snapshot.data!.docs[index];
                        var prnData = Data['prn'];
                        var attendance = Data['attendance'];
                        // var date = Data['AttendanceDate'];
                        var date = (Data['AttendanceDate'] as Timestamp).toDate();
                        return Card(
                          elevation: 5,
                          shadowColor: Colors.red,
                          child: ListTile(
                            leading: attendance?const CircleAvatar(backgroundColor: Colors.green,):const CircleAvatar(backgroundColor: Colors.black,),
                            title: Text(prnData,style: GoogleFonts.abel(fontSize:20,fontWeight:FontWeight.bold ),),
                            subtitle: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(attendance ? 'Present' : 'Absent',style: GoogleFonts.abel(fontSize:18,fontWeight:FontWeight.bold ),), // Convert boolean to string
                                const SizedBox(width: 20,),
                                Text(date.toString(),style: GoogleFonts.abel(fontSize:18,fontWeight:FontWeight.bold ),),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },),
              )
            ],
          ),
        ),
      ),
    );
  }
}