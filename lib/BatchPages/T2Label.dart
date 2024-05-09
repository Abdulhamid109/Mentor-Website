import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mentor_web/BatchPages/T2Batch.dart';

class T2Label extends StatelessWidget {
  final String getStoredPrn;
  final String currentUserId;
  const T2Label({super.key,required this.getStoredPrn,required this.currentUserId});

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
              splashColor: Colors.green,
              onTap: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=> T2Batch(PRN: getStoredPrn,currentUserId: currentUserId,Mentoruid: 'U3dJn2bVfUV1wcktEIrl',))),
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
          )
        ],
      ),
    );
  }
}