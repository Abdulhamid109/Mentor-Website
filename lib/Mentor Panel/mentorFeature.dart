import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mentor_web/BatchPages/T2Batch.dart';
import 'package:mentor_web/BatchPages/T3Batch.dart';
import 'package:mentor_web/BatchPages/chatdemo.dart';
import 'package:mentor_web/Mentor%20Panel/AttendancePage.dart';
import 'package:mentor_web/Mentor%20Panel/StudentList.dart';

class MentorFeatures extends StatefulWidget {
  final String currentUserId;
  final String Username;
  final String batchName;
  const MentorFeatures({super.key,required this.batchName,required this.currentUserId,required this.Username});

  @override
  State<MentorFeatures> createState() => _MentorFeaturesState();
}

class _MentorFeaturesState extends State<MentorFeatures> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width*1;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 120,
        backgroundColor: const Color.fromARGB(255, 43, 3, 24),
        title: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Image.asset("images/logo.png"),
        ),
      ),
      

      body: Padding(
        padding: const EdgeInsets.all(28.0),
        child: Column(
          children: <Widget>[
            //features
            Row(
              mainAxisAlignment:MainAxisAlignment.start,
              children: <Widget>[
                Card(
                  elevation: 4,
                  shadowColor: Colors.green.shade100,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Generate Student list',style: GoogleFonts.abel(fontSize:20,fontWeight:FontWeight.bold),),
                  ),
                ),
                SizedBox(width: width*0.22,),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    shadowColor: Colors.black,
                    shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10)))
                  ),
                  onPressed:()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>StudentList(batchName: widget.batchName))), 
                child: Center(child: Text('Generate',style: GoogleFonts.abel(fontSize:20,fontWeight:FontWeight.bold,color:Colors.white)),))
              ],
            ),
           
           const SizedBox(height: 15,),
            Row(
              mainAxisAlignment:MainAxisAlignment.start,
              children: <Widget>[
                Card(
                  elevation: 4,
                  shadowColor: Colors.green.shade100,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Generate Attendance List',style: GoogleFonts.abel(fontSize:20,fontWeight:FontWeight.bold,),),
                  ),
                ),
                SizedBox(width: width*0.2,),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    shadowColor: Colors.black,
                    shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10)))
                  ),
                  onPressed: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>AttendanceList(batchName: widget.batchName))), 
                child: Center(child: Text('Generate',style: GoogleFonts.abel(fontSize:20,fontWeight:FontWeight.bold,color:Colors.white)),))
              ],
            ),
           
           const SizedBox(height: 15,),
            Row(
              mainAxisAlignment:MainAxisAlignment.start,
              children: <Widget>[
                Card(
                  elevation: 4,
                  shadowColor: Colors.green.shade100,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Problem Discussion Portal ',style: GoogleFonts.abel(fontSize:20,fontWeight:FontWeight.bold,),),
                  ),
                ),
                SizedBox(width: width*0.2,),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    shadowColor: Colors.black,
                    shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10)))
                  ),
                  onPressed: (){
                    if(widget.batchName == 'student-t1' ){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>T1Batch(currentUserId: widget.currentUserId, PRN: widget.Username)));
                    }else if(widget.batchName == 'student-t2'){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>T2Batch(currentUserId: widget.currentUserId, PRN: widget.Username)));
                    }else if(widget.batchName == 'student-t3'){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>T3Batch(currentUserId: widget.currentUserId, PRN: widget.Username)));
                    }else{
                      showDialog(
                        context: context, 
                        builder: (context) {
                          return AlertDialog(
                            title: const Text('Error'),
                            content: const Text('No Batch Found'),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () => Navigator.of(context).pop(),
                                child: const Text('Ok'),
                              ),
                            ],
                          );
                        },
                        );
                    }
                  // Navigator.push(context, MaterialPageRoute(builder: (context)=>AttendanceList(batchName: widget.batchName))), 

                  },
                child: Center(child: Text('Open',style: GoogleFonts.abel(fontSize:20,fontWeight:FontWeight.bold,color:Colors.white)),))
              ],
            ),
           
          ],
        ),
      ),
    );
  }
}