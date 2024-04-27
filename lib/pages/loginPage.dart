import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:mentor_web/BatchPages/T1Label.dart';
import 'package:mentor_web/BatchPages/T2Label.dart';
import 'package:mentor_web/BatchPages/T3Label.dart';
import 'package:mentor_web/pages/loginPageMentor.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String Storedprn='';
  String Useruid='';
  String batchName = '';
  //get batchName
   getBatchName(){
    List<int> extractedInteger =
              extractIntegerFromString(PRNController.text);
          print(extractedInteger[1].toInt());
          for(int i=1;i<25;i++){
            if(i==extractedInteger[1].toInt()){
              batchName = 'student-t1';
              print(batchName);
              return batchName;
              
            }
          }
          for(int i=25;i<53;i++){
            if(i==extractedInteger[1].toInt()){
              batchName = 'student-t2';
              print(batchName);
              return batchName;
            }
          }
          for(int i=53;i<69;i++){
            if(i==extractedInteger[1].toInt()){
              batchName = 'student-t3';
              print(batchName);
              return batchName;
            }
          }
  }
  //add tha data to the cloud fireStore
  void addData(String prn, String password) async {
    try {
      String batchName = getBatchName();
      CollectionReference users =
          FirebaseFirestore.instance.collection(batchName);
      DocumentReference mydoc =
          await users.add({'prn': prn, 'password': password,'attendance':false,'AttendanceDate':Timestamp.fromDate(DateTime.now()), 'uid': ''});
      mydoc.update({'uid': mydoc.id});
      Useruid = mydoc.id;
      print('Before $Useruid');
      print('Data added to Firebase Firestore for user');
      
    } catch (e) {
      print(e);
    }
  }

  //create a flogin function
  Future<void> login() async {
    String prn = PRNController.text.toLowerCase();
    String password = PasswordController.text;
    String batchName = getBatchName();
    try {
      //check if the prn is already present
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await FirebaseFirestore.instance
              .collection(batchName)
              .where('prn', isEqualTo: prn)
              .get();

      if (querySnapshot.docs.isNotEmpty) {
        var studentData = querySnapshot.docs.first.data();
        String StoredPassword = studentData['password'];
        String userUid = studentData['uid'];
        setState(() {
        Useruid = userUid;
        Storedprn = studentData['prn'];
        });
        print('After $Useruid');
        print(StoredPassword);
        print(studentData['prn']);
        if (password == StoredPassword) {
          List<int> extractedInteger =
              extractIntegerFromString(PRNController.text);
          BatchWiseLogin(extractedInteger);
          print('Successfully signed In');
        } else {
          showErrorMessage('Incorrect password');
        }
      } else {
        showErrorMessage('PRN does not exist');
      }
    } catch (e) {
      showErrorMessage('An error occurred');
    }
  }

  //create a function tp login in the user that 1-24 T1 batch
  // 24-52 t2 batch and 53-69 t3 batch

  TextEditingController PRNController = TextEditingController();
  TextEditingController PasswordController = TextEditingController();
  bool istoggle = true;
  void checkpasswordVisibility() {
    setState(() {
      istoggle = !istoggle;
    });
  }

  void BatchWiseLogin(List<int> prndata) {
    // var prndata = int.tryParse(prn);
    //for t1-batch
    debugPrint(prndata[1].toString());
    var data = prndata.removeAt(1);
    var year = prndata.elementAt(0);
    debugPrint(data.toString());
    debugPrint(year.toString());
    for (int i = 1; i <= 24; i++) {
      if (data == i && year == 21 && PRNController.text.length == 8) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) =>  T1Label(getStoredPrn: PRNController.text.toUpperCase(),currentUserId: Useruid)));
        // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const T1Batch()));
        // Navigator.push(context, MaterialPageRoute(builder: (context)=>T1Batch(currentUserId: Useruid,PRN: PRNController.text.toLowerCase(),)));
        break;
      }
    }
    //for t2-batch
    for (int i = 25; i <= 52; i++) {
      if (data == i && year == 21 && PRNController.text.length == 8) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) =>  T2Label(getStoredPrn:PRNController.text.toUpperCase(),currentUserId: Useruid )));
        break;
      }
    }
    //for t3-batch
    for (int i = 53; i <= 69; i++) {
      if (data == i && year == 21 && PRNController.text.length == 8) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) =>  T3Label(getStoredprn: PRNController.text.toUpperCase() ,currentUserId: Useruid )));
        break;
      }
    }
    //for invalid prn
    if (year > 21 ||
        year < 21 ||
        PRNController.text.length > 8 ||
        PRNController.text.length < 8 ||
        data > 69 ||
        data <= 0) {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text("Invalid PRN"),
              content: const Text("Please enter a valid PRN"),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text("Ok"),
                ),
              ],
            );
          });
    }
  }

  //create a function to extract the integer from the String
  List<int> extractIntegerFromString(String InputPRN) {
    RegExp regExp = RegExp(r'\d+');
    Iterable<Match> matches = regExp.allMatches(InputPRN);
    List<int> prnInfo =
        matches.map((match) => int.parse(match.group(0)!)).toList();
    return prnInfo;
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height * 1;
    final widht = MediaQuery.of(context).size.width * 1;

    return Scaffold(
      backgroundColor: Colors.white30,
      body: Center(
        child: Container(
          height: height * 0.66,
          width: widht * 0.6,
          color: const Color.fromARGB(96, 253, 169, 169),
          child: Padding(
            padding: const EdgeInsets.all(11.0),
            child: Column(
              children: <Widget>[
                //login text
                SizedBox(
                  height: height * 0.01,
                ),
                Text(
                  'login as Student',
                  style: GoogleFonts.abel(
                      textStyle: const TextStyle(
                          fontSize: 25, fontWeight: FontWeight.bold)),
                ),
                SizedBox(
                  height: height * 0.02,
                ),
                //PRN textfield
                Padding(
                  padding: const EdgeInsets.all(11.0),
                  child: Container(
                    width: widht * 0.3,
                    child: TextFormField(
                      controller: PRNController,
                      decoration: InputDecoration(
                          labelText: "PRN",
                          prefixIcon: const Icon(Icons.person),
                          labelStyle:
                              GoogleFonts.abel(fontWeight: FontWeight.bold),
                          enabledBorder: const OutlineInputBorder(),
                          focusedBorder: const OutlineInputBorder()),
                    ),
                  ),
                ),

                SizedBox(
                  height: height * 0.01,
                ),
                Padding(
                  padding: const EdgeInsets.all(11.0),
                  child: Container(
                    width: widht * 0.3,
                    child: TextFormField(
                      controller: PasswordController,
                      obscureText: istoggle,
                      obscuringCharacter: "*",
                      decoration: InputDecoration(
                          labelText: "Password",
                          prefixIcon: const Icon(Icons.password),
                          suffixIcon: IconButton(
                            icon: istoggle
                                ? const Icon(Icons.visibility_off)
                                : const Icon(Icons.visibility),
                            onPressed: checkpasswordVisibility,
                          ),
                          labelStyle:
                              GoogleFonts.abel(fontWeight: FontWeight.bold),
                          enabledBorder: const OutlineInputBorder(),
                          focusedBorder: const OutlineInputBorder()),
                    ),
                  ),
                ),

                SizedBox(
                  height: height * 0.01,
                ),
                //red button for login
                Padding(
                  padding: const EdgeInsets.all(11.0),
                  child: Container(
                    width: widht * 0.3,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          shape: const RoundedRectangleBorder()),
                      onPressed: () {
                        //extract the integer from the string

                        addData(PRNController.text.toLowerCase(),
                            PasswordController.text.toString());
                      },
                      onLongPress: () {
                        login();
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('Login',
                            style: GoogleFonts.abel(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: Colors.white)),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: height * 0.01,
                ),
                //or

                Container(
                  width: widht * 0.45,
                  child: Row(
                    children: <Widget>[
                      const Expanded(child: Divider()),
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Text(
                          'or',
                          style: GoogleFonts.abel(fontSize: 16),
                        ),
                      ),
                      const Expanded(child: Divider())
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const MentorLogin())),
                  child: RichText(
                      text: TextSpan(
                          text: "Continue as Mentor, ",
                          style: GoogleFonts.abel(
                              fontSize: 18, fontWeight: FontWeight.w400),
                          children: [
                        TextSpan(
                          text: "Login",
                          style: GoogleFonts.abel(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.red),
                        ),
                      ])),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void showErrorMessage(String message) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Center(child: Text('Error')),
            content: Center(child: Text(message)),
            actions: [
              TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Ok'))
            ],
          );
        });
  }

}
