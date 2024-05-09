import 'package:datepicker_dropdown/datepicker_dropdown.dart';
import 'package:datepicker_dropdown/order_format.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mentor_web/BatchPages/T2Batch.dart';
import 'package:mentor_web/BatchPages/T3Batch.dart';
import 'package:mentor_web/BatchPages/chatdemo.dart';
import 'package:mentor_web/Mentor%20Panel/AttendancePage.dart';
import 'package:mentor_web/Mentor%20Panel/ReportGeneration.dart';
import 'package:mentor_web/Mentor%20Panel/StudentList.dart';

class MentorFeatures extends StatefulWidget {
  final String currentUserId;
  final String Username;
  final String batchName;
  final String studentMessage;
  const MentorFeatures({super.key,required this.batchName,required this.currentUserId,required this.Username,required this.studentMessage});

  @override
  State<MentorFeatures> createState() => _MentorFeaturesState();
}

class _MentorFeaturesState extends State<MentorFeatures> {
  late int _selectedDay ;
  late int _selectedMonth ;
  late int _selectedYear ;
  bool isMentor = false ;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    DateTime date = DateTime.now();
    _selectedDay = 1;
    _selectedMonth = date.month;
    _selectedYear = date.year;
  }
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
                      if(widget.Username=='Mentor1'){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>T1Batch(currentUserId: widget.currentUserId, PRN: widget.Username,Mentoruid:'VX0hkR4eXIyhHDwAEJXh' ,)));
                      }
                    }else if(widget.batchName == 'student-t2'){
                      if(widget.Username=='Mentor2'){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>T2Batch(currentUserId: widget.currentUserId, PRN: widget.Username,Mentoruid:'U3dJn2bVfUV1wcktEIrl' ,)));
                      }
                    }else if(widget.batchName == 'student-t3'){
                      if(widget.Username=='Mentor3'){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>T3Batch(currentUserId: widget.currentUserId, PRN: widget.Username,Mentoruid:'nLWTI3hhrGWlKi9eil6V' ,)));
                      }
                    }else{
                      showDialog(
                        context: context, 
                        builder: (context) {
                          return AlertDialog(
                            title: const Text('Error'),
                            content: const Text('Invalid Mentor UserId'),
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
           
           const SizedBox(height: 15,),
            Row(
              mainAxisAlignment:MainAxisAlignment.start,
              children: <Widget>[
                Card(
                  elevation: 4,
                  shadowColor: Colors.green.shade100,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Monthly Report List',style: GoogleFonts.abel(fontSize:20,fontWeight:FontWeight.bold),),
                  ),
                ),
                SizedBox(width: width*0.23,),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    shadowColor: Colors.black,
                    shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10)))
                  ),
                  onPressed: (){
                    showDialog(context: context, builder:(context) {
                      return AlertDialog(
                        title: Text('Select Date',style: GoogleFonts.abel(fontSize:20,fontWeight:FontWeight.bold),),
                        content: DropdownDatePicker(
                          dateformatorder: OrderFormat.DMY,
                          startYear: 1900,
                          endYear: 2024,
                          isDropdownHideUnderline: true,
                          selectedDay: _selectedDay, 
                selectedMonth: _selectedMonth, 
                selectedYear: _selectedYear, 
                onChangedDay: (value) {
                  _selectedDay = int.parse(value!);
                  print('onChangedDay: $value');
                },
                onChangedMonth: (value) {
                  _selectedMonth = int.parse(value!);
                  print('onChangedMonth: $value');
                },
                onChangedYear: (value) {
                  _selectedYear = int.parse(value!);
                  print('onChangedYear: $value');
                },
                        ),
                        scrollable: true,
                        actions: [
                          
                          TextButton(onPressed: (){
                            if(_selectedMonth == null && _selectedYear==null){
                              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Kindly Select the month and year'),duration: Duration(seconds: 4),));
                            }else{

                    Navigator.push(context, MaterialPageRoute(builder: (context)=>ReportGeneration(batchName: widget.batchName,studentMessage: widget.studentMessage,month: _selectedMonth,year: _selectedYear,)));
                            }
                          }, child: Text('Generate',style: GoogleFonts.abel(fontSize:20,fontWeight:FontWeight.bold),)),
                        ],
                      );
                    }, );
                  },
                child: Center(child: Text('Generate',style: GoogleFonts.abel(fontSize:20,fontWeight:FontWeight.bold,color:Colors.white)),))
              ],
            ),
           
          ],
        ),
      ),
    );
  }
}