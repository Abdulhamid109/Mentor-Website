import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mentor_web/Mentor%20Panel/mentorFeature.dart';

class MentorHomePage extends StatefulWidget {
  final String Username;
  final String currentUserId;
  
  const MentorHomePage({super.key,required this.Username,required this.currentUserId});

  @override
  State<MentorHomePage> createState() => _MentorHomePageState();
}

class _MentorHomePageState extends State<MentorHomePage> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height*1;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 120,
        backgroundColor: const Color.fromARGB(255, 43, 3, 24),
        title: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Image.asset("images/logo.png"),
        ),
      ),

      body: Column(
        children: <Widget>[
          
          widget.Username=='Mentor1'?Padding(
            padding: const EdgeInsets.all(15.0),
            child: InkWell(
              onTap: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=> MentorFeatures(batchName:'student-t1',Username: widget.Username,currentUserId:widget.currentUserId ,studentMessage: "messages-t1",))),
              splashColor: Colors.green,
              child: Card(
                elevation: 5,
                shadowColor: Colors.black,
                child: Container(
                  height: height*0.1,
                  decoration: BoxDecoration(
                    color: Colors.lightBlue,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child:  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Text('T1-Batch',style: GoogleFonts.abel(fontSize:20,fontWeight:FontWeight.bold,color:Colors.white),),
                        Text('Mrs Jaymala Pakhare',style: GoogleFonts.abel(fontSize:18,fontWeight:FontWeight.w500,color:Colors.white),)
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ):Container(),
        
          
          widget.Username=='Mentor2'?Padding(
            padding: const EdgeInsets.all(15.0),
            child: InkWell(
              // onTap: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>T1Batch())),
              onTap: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=> MentorFeatures(batchName: 'student-t2',Username: widget.Username,currentUserId: widget.currentUserId,studentMessage: "messages-t2",))),
              splashColor: Colors.green,
              child: Card(
                elevation: 5,
                shadowColor: Colors.black,
                child: Container(
                  height: height*0.1,
                  decoration: BoxDecoration(
                    color: Colors.lightBlue,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child:  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Text('T2-Batch',style: GoogleFonts.abel(fontSize:20,fontWeight:FontWeight.bold,color:Colors.white),),
                        Text('Mrs Jaymala Pakhare',style: GoogleFonts.abel(fontSize:18,fontWeight:FontWeight.w500,color:Colors.white),)
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ):Container(),
        

          widget.Username=='Mentor3'?Padding(
            padding: const EdgeInsets.all(15.0),
            child: InkWell(
              // onTap: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>T1Batch())),
              onTap: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=> MentorFeatures(batchName: 'student-t3',Username: widget.Username,currentUserId: widget.currentUserId,studentMessage: "messages-t3",))),
              splashColor: Colors.green,
              child: Card(
                elevation: 5,
                shadowColor: Colors.black,
                child: Container(
                  height: height*0.1,
                  decoration: BoxDecoration(
                    color: Colors.lightBlue,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child:  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Text('T3-Batch',style: GoogleFonts.abel(fontSize:20,fontWeight:FontWeight.bold,color:Colors.white),),
                        Text('Mrs Priyanka More',style: GoogleFonts.abel(fontSize:18,fontWeight:FontWeight.w500,color:Colors.white),)
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ):Container(),
        
        ],
      ),
    
      
    );
  }
}