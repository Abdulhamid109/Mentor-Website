import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mentor_web/pages/loginPageMentor.dart';

class StudentList extends StatefulWidget {
  final String batchName;
  const StudentList({super.key,required this.batchName});

  @override
  State<StudentList> createState() => _StudentListState();
}

class _StudentListState extends State<StudentList> {
  
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
                        return Card(
                          elevation: 5,
                          shadowColor: Colors.red,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ListTile(
                              leading: const CircleAvatar(backgroundColor: Colors.black,),
                              title: Text(prnData,style: GoogleFonts.abel(fontSize:20,fontWeight:FontWeight.bold ),)
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