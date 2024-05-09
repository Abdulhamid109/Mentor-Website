import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mentor_web/BatchPages/chatdemo.dart';

class T1Label extends StatelessWidget {
  final String getStoredPrn;
  final String currentUserId;
  const T1Label({super.key,required this.getStoredPrn,required this.currentUserId });

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height*1;
    final width = MediaQuery.of(context).size.width*1;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 120,
        backgroundColor: const Color.fromARGB(255, 43, 3, 24),
        title: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Image.asset("images/logo.png"),
        ),
        actions: [
          Text(getStoredPrn,style: GoogleFonts.abel(fontSize:20,fontWeight:FontWeight.bold),),
          SizedBox(width: width*0.05,)
        ],
      ),
      
      body: Column(
        children: <Widget>[
          
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: InkWell(
              onTap: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>T1Batch(currentUserId: currentUserId, PRN: getStoredPrn,Mentoruid: 'VX0hkR4eXIyhHDwAEJXh',))),
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
          )
        ],
      ),
    
    
    );
  }
}