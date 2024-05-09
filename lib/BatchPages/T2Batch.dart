import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mentor_web/pages/loginPage.dart';

class T2Batch extends StatefulWidget {
  final String currentUserId;
  final String PRN;
  final String Mentoruid;

  const T2Batch({super.key, required this.currentUserId,required this.PRN,required this.Mentoruid});

  @override
  State<T2Batch> createState() => _T2BatchState();
}

class _T2BatchState extends State<T2Batch> {
  TextEditingController messageController = TextEditingController();
   bool attendanceMarked = false;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width*1;
    return Scaffold(
      appBar:AppBar(
        toolbarHeight: 120,
        backgroundColor: const Color.fromARGB(255, 43, 3, 24),
        title: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Image.asset("images/logo.png"),
        ),
        actions: [
          //Batch name
          Container(
            width: width * 0.3,
            child: ListTile(
              title: Text(
                'T2-Batch',
                style: GoogleFonts.habibi(
                    color: Colors.white, fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                '-Mrs.Jayamala Pakhre',
                style: GoogleFonts.habibi(
                    color: Colors.white, fontWeight: FontWeight.w400),
              ),
            ),
          ),
          // logout
          IconButton(
            icon: const Icon(
              Icons.logout,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginPage()),
                  (route) => false);
            },
            tooltip: "Logout",
          ),
          
          // Text("Helo",style: GoogleFonts.habibi(color:Colors.white,fontWeight:FontWeight.w400)),
          // SizedBox(width: width*0.2,)
        ],
      ),
      
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder(
              stream: FirebaseFirestore.instance.collection('messages-t2').orderBy('messageTimeStamp', descending: true).snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }

                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }

                final messages = snapshot.data!.docs;

                return ListView.builder(
                  reverse: true,
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    var message = messages[index];
                    var messageText = message['messageText'];
                    var messageTimestamp = (message['messageTimeStamp'] as Timestamp).toDate();
                    var messageUid = message['messageUid'];

                    bool isCurrentUser = messageUid == widget.currentUserId;

                    return Align(
                      alignment: isCurrentUser ? Alignment.centerRight : Alignment.centerLeft,
                      child: Container(
                        margin: EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
                        padding: EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          color: isCurrentUser ? Colors.blue.withOpacity(0.2) : Colors.grey.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              messageUid == widget.Mentoruid
                                  ? 'Mentor'
                                  : 'Student',
                              style: const TextStyle(color: Colors.black,fontWeight: FontWeight.bold),
                            ),
                            Text(
                              messageText,
                              style: TextStyle(
                                color: isCurrentUser ? Colors.blue : Colors.black,
                                fontWeight: isCurrentUser ? FontWeight.bold : FontWeight.normal,
                              ),
                            ),
                            SizedBox(height: 4.0),
                            Text(
                              '${messageTimestamp.hour}:${messageTimestamp.minute}:${messageTimestamp.second}',
                              style: TextStyle(color: Colors.grey),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: width*0.6,
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: messageController,
                      decoration: InputDecoration(
                        hintText: 'Type your message...',
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.send),
                    onPressed: _sendMessage,
                  ),
                  IconButton(
                        onPressed: () {
                          //create dialog box with red color attendance button
                          showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: const Center(
                                      child: Text('Add Attendance')),
                                  content: ElevatedButton(
                                    onPressed: () async{
                                      DateTime now = DateTime.now();
                                      DateTime attendanceStartTime = DateTime(
                                          now.year, now.month, now.day, 16, 30);
                                      DateTime attendanceEndTime = DateTime(
                                          now.year, now.month, now.day, 17, 30);

                                      if (now.weekday == DateTime.monday &&
                                          now.isAfter(attendanceStartTime) &&
                                          now.isBefore(attendanceEndTime) &&
                                          !attendanceMarked) {
                                            
                                        print(
                                            'Attendance marked successfully.');
                                            DocumentReference mydoc = FirebaseFirestore.instance.collection('student-t3').doc(widget.currentUserId);
                                            await mydoc.update({'attendance':true,'AttendanceDate':Timestamp.fromDate(DateTime.now())});
                                            print('Updated to Database');
                                     
                                        setState(() {
                                          attendanceMarked = true;
                                          
                                        });
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            backgroundColor: Colors.green[200],
                                            content: Center(
                                                child: Text(
                                              'Attendance Added',
                                              style: GoogleFonts.habibi(
                                                  fontWeight: FontWeight.bold),
                                            )),
                                            duration:
                                                const Duration(seconds: 2),
                                          ),
                                        );

                                        Navigator.of(context).pop();
                                      } else {
                                        if (attendanceMarked) {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            SnackBar(
                                              backgroundColor:
                                                  Colors.yellow[300],
                                              content: Center(
                                                  child: Text(
                                                'Attendance Already Marked',
                                                style: GoogleFonts.habibi(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black),
                                              )),
                                              duration:
                                                  const Duration(seconds: 2),
                                            ),
                                          );
                                          Navigator.of(context).pop();
                                        } else {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            SnackBar(
                                              backgroundColor: Colors.red[200],
                                              content: Center(
                                                  child: Text(
                                                'Attendance can only be marked between 4:30 PM and 5:30 PM on Mondays',
                                                style: GoogleFonts.habibi(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              )),
                                              duration:
                                                  const Duration(seconds: 2),
                                            ),
                                          );
                                          Navigator.of(context).pop();

                                          print(
                                              'Attendance can only be marked between 4:30 PM and 5:30 PM on Mondays.');
                                        }
                                      }
                                    },
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.red,
                                        shape: const StadiumBorder()),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        'Attendance',
                                        style: GoogleFonts.gabarito(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                );
                              });
                        },
                        tooltip: "attendance",
                        icon: const Icon(
                          Icons.person_add,
                          size: 45,
                          color: Colors.green,
                        ))
                  
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _sendMessage() {
    String messageText = messageController.text.trim();
    if (messageText.isNotEmpty) {
      FirebaseFirestore.instance.collection('messages-t2').add({
        'prn':widget.PRN,
        'messageText': messageText,
        'messageTimeStamp': Timestamp.now(),
        'messageUid': widget.currentUserId,
      });

      messageController.clear();
    }
  }

  @override
  void dispose() {
    messageController.dispose();
    super.dispose();
  }
}
