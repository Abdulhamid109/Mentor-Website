import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mentor_web/BatchPages/T3Batch.dart';

class T3Label extends StatelessWidget {
  final String getStoredprn;
  final String currentUserId;
  const T3Label({super.key,required this.getStoredprn,required this.currentUserId});

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
          Text(getStoredprn,style: GoogleFonts.abel(fontSize:20,fontWeight:FontWeight.bold),),
          SizedBox(width: width*0.05,)
        ],
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: InkWell(
              splashColor: Colors.green,
              onTap: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=> T3Batch(PRN: getStoredprn,currentUserId: currentUserId,Mentoruid: 'nLWTI3hhrGWlKi9eil6V',))),
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
          )
        ],
      ),
    );
  }
}