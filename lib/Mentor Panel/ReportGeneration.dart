import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';

class ReportGeneration extends StatefulWidget {
  final String batchName;
  final String studentMessage;
  final int startYear;
  final int startMonth;
  final int endYear;
  final int endMonth;

  const ReportGeneration({
    Key? key,
    required this.batchName,
    required this.studentMessage,
    required this.startYear,
    required this.startMonth,
    required this.endYear,
    required this.endMonth,
  }) : super(key: key);

  @override
  State<ReportGeneration> createState() => _ReportGenerationState();
}

class _ReportGenerationState extends State<ReportGeneration> {
  late DateTime startDate;
  late DateTime endDate;
  late String startMonth;
  late String endMonth;

  @override
  void initState() {
    super.initState();
    startDate = DateTime(widget.startYear, widget.startMonth, 1);
    endDate = DateTime(widget.endYear, widget.endMonth + 1, 1).subtract(const Duration(days: 1));
    startMonth = getMonthFromInt(widget.startMonth);
    endMonth = getMonthFromInt(widget.endMonth);
  }

  Future<QuerySnapshot<Map<String, dynamic>>> getChatsForDateRange(DateTime startDate, DateTime endDate) {
    return FirebaseFirestore.instance
        .collection(widget.studentMessage)
        .where('messageTimeStamp', isGreaterThanOrEqualTo: Timestamp.fromDate(startDate), isLessThan: Timestamp.fromDate(endDate.add(Duration(days: 1))))
        .get();
  }

  String getMonthFromInt(int integerMonth) {
    switch (integerMonth) {
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
                child: Text('$startMonth ${widget.startYear} - $endMonth ${widget.endYear}', style: GoogleFonts.habibi(fontSize: 16, fontWeight: FontWeight.bold)),
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
              //Fetch data based on date range
              Expanded(
                child: FutureBuilder<QuerySnapshot>(
                  future: getChatsForDateRange(startDate, endDate),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircularProgressIndicator(),
                            SizedBox(height: 4),
                            Text('Fetching data...', style: GoogleFonts.abel()),
                          ],
                        ),
                      );
                    }

                    if (snapshot.hasError) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.error),
                            SizedBox(height: 4),
                            Text(snapshot.error.toString(), style: GoogleFonts.abel()),
                          ],
                        ),
                      );
                    }

                    if (snapshot.data == null || snapshot.data!.docs.isEmpty) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.error),
                            SizedBox(height: 4),
                            Text('No Data Found', style: GoogleFonts.abel()),
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
                                child: Text(allData, style: GoogleFonts.habibi(fontSize: 16, fontWeight: FontWeight.bold)),
                              ),
                            ),
                            SizedBox(height: 8),
                          ],
                        );
                      },
                    );
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
