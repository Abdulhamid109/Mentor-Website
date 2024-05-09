import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';

class ReportGeneration extends StatefulWidget {
  final String batchName;
  final String studentMessage;
  final int year;
  final int month; 
  const ReportGeneration({super.key, required this.batchName, required this.studentMessage,required this.month,required this.year});

  @override
  State<ReportGeneration> createState() => _ReportGenerationState();
}

class _ReportGenerationState extends State<ReportGeneration> {
  late DateTime startOfMonth;
  late DateTime endOfMonth;
  String ?month;

  @override
  void initState() {
    super.initState();
    startOfMonth = DateTime(widget.year, widget.month,1);
    endOfMonth = DateTime(widget.year,widget.month+1,1).subtract(const Duration(days: 1));
    month = getMonthfromint(widget.month);
  }
  

Future<QuerySnapshot<Map<String, dynamic>>> getChatsForMonth(DateTime startOfMonth, DateTime endOfMonth) {
  return FirebaseFirestore.instance
      .collection(widget.studentMessage)
      .where('messageTimeStamp', isGreaterThanOrEqualTo: Timestamp.fromDate(startOfMonth), isLessThan: Timestamp.fromDate(endOfMonth.add(Duration(days: 1))))
      .get();
}

  String getMonthfromint(int integermonth){
    switch (integermonth) {
      case 1:
      return "January";
      case 2:
      return "February";
      case 3:
      return "March";
      case 4:
      return "April";
      case 5:
      return "May";
      case 6:
      return "June";
      case 7:
      return "July";
      case 8:
      return "August";
      case 9:
      return "September";
      case 10:
      return "October";
      case 11:
      return "November";
      case 12:
      return "December";
        
      default:
       return 'Invalid Month';
    }
  }

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
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: Center(
            child: Card(
              shadowColor: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Text('$month , ${widget.year}',style: GoogleFonts.habibi(fontSize:16,fontWeight:FontWeight.bold,)),
              ),
            ),
          ),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: <Widget>[
              //Fetch data based on month
              Expanded(
                child: StreamBuilder<QuerySnapshot>(
                  stream: getChatsForMonth(startOfMonth, endOfMonth).asStream(),
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

                    if(snapshot.data == null || snapshot.data!.docs.isEmpty){
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

                    return ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                      var data = snapshot.data!.docs[index];
                      var allData = data['messageText'];
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Card(
                            elevation: 5,
                            shadowColor: Colors.green,
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Text(allData,style: GoogleFonts.habibi(fontSize:16,fontWeight:FontWeight.bold),),
                            ),
                          ),
                          SizedBox(height: 8,),
                        ],
                      );
                    });
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
