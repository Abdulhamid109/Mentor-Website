import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mentor_web/Mentor%20Panel/mentorHomePage.dart';
import 'package:mentor_web/pages/loginPage.dart';

class MentorLogin extends StatefulWidget {
  const MentorLogin({super.key});

  @override
  State<MentorLogin> createState() => _MentorLoginState();
}

class _MentorLoginState extends State<MentorLogin> {

  TextEditingController UsernameController = TextEditingController();
  TextEditingController PasswordController = TextEditingController();
  String batchName = '';
  String Useruid='';
   getBatchName(){
    String username1 = 'Mentor1';
    String username2 = 'Mentor2';
    String username3 = 'Mentor3';
    if(username1==UsernameController.text){
      batchName = 'Mentor1';
      return batchName;
    }else if(username2==UsernameController.text){
      batchName = 'Mentor2';
      return batchName;
    }else if(username3==UsernameController.text){
      batchName = 'Mentor3';
      return batchName;
    }else{
      return showDialog(
        context: context, 
      builder: (context) {
        return AlertDialog(
          title: const Text('Batch Error'),
          content: const Text('Batch Not found'),
          actions: [
            TextButton(onPressed: ()=>Navigator.pop(context), child: const Text('OK'))
          ],
        );
      },);
          }
  }

  void addData(String username, String password) async {
    try {
      String batchName = getBatchName();
      CollectionReference users =
          FirebaseFirestore.instance.collection(batchName);
      DocumentReference mydoc =
          await users.add({'username': username, 'password': password, 'uid': ''});
      mydoc.update({'uid': mydoc.id});
      Useruid = mydoc.id;
      print('Before $Useruid');
      print('Data added to Firebase Firestore for user');
      
    } catch (e) {
      print(e);
    }
  }

  Future<void> login() async {
    String username = UsernameController.text;
    String password = PasswordController.text;
    String batchName = getBatchName();
    try {
      //check if the prn is already present
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await FirebaseFirestore.instance
              .collection(batchName)
              .where('username', isEqualTo: username)
              .get();

      if (querySnapshot.docs.isNotEmpty) {
        var mentorData = querySnapshot.docs.first.data();
        String StoredPassword = mentorData['password'];
        String userUid = mentorData['uid'];
        setState(() {
        Useruid = userUid;
        // Storedprn = studentData['prn'];
        });
        print('After $Useruid');
        print(StoredPassword);
        print(mentorData['username']);
        if (password == StoredPassword) {
          Navigator.push(context, MaterialPageRoute(builder: (context)=> MentorHomePage(Username: UsernameController.text,currentUserId: userUid,)));
          print('Successfully signed In');
        } else {
          showErrorMessage('Incorrect password');
        }
      } else {
        showErrorMessage('Username does not exist');
      }
    } catch (e) {
      showErrorMessage('An error occurred');
    }
  }



  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height*1;
    final widht = MediaQuery.of(context).size.width*1;
  
    return Scaffold(
      backgroundColor: Colors.white30,
      body: Center(
        child: Container(
          height: height*0.66,
          width: widht*0.6,
          color: const Color.fromARGB(96, 253, 169, 169),
          
          child: Padding(
            padding: const EdgeInsets.all(11.0),
            child: Column(
              children: <Widget>[
                //login text
                SizedBox(height: height*0.01,),
                Text('login as Mentor',style:GoogleFonts.abel(textStyle:const TextStyle(fontSize: 25,fontWeight: FontWeight.bold)),),
                SizedBox(height: height*0.02,),
                //PRN textfield
                Padding(
                  padding: const EdgeInsets.all(11.0),
                  child: Container(
                    width: widht*0.3,
                    child: TextFormField(
                      controller: UsernameController,
                      decoration: InputDecoration(
                        labelText: "username",
                        prefixIcon: const Icon(Icons.person),
                        labelStyle: GoogleFonts.abel(fontWeight:FontWeight.bold),
                        enabledBorder:const OutlineInputBorder(),
                        focusedBorder:const OutlineInputBorder()
                      ),
                    ),
                  ),
                ),
              
                SizedBox(height: height*0.01,),
                Padding(
                  padding: const EdgeInsets.all(11.0),
                  child: Container(
                    width: widht*0.3,
                    child: TextFormField(
                      controller: PasswordController,
                      decoration: InputDecoration(
                        labelText: "Password",
                        prefixIcon: const Icon(Icons.password),
                        suffixIcon: IconButton(icon:const Icon(Icons.visibility_off),onPressed: (){},),
                        labelStyle: GoogleFonts.abel(fontWeight:FontWeight.bold),
                        enabledBorder:const OutlineInputBorder(),
                        focusedBorder:const OutlineInputBorder()
                      ),
                    ),
                  ),
                ),

                SizedBox(height: height*0.01,),
                //red button for login
                Padding(
                  padding: const EdgeInsets.all(11.0),
                  child: Container(
                    width: widht*0.3,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor:  Colors.red,
                        shape: const RoundedRectangleBorder()
                      ),
                      onPressed: (){
                        // addData(UsernameController.text, PasswordController.text);
                        login();
                      },
                      
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child:  Text('Login',style:GoogleFonts.abel(fontWeight:FontWeight.bold,fontSize:20,color:Colors.white)),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: height*0.01,),
                //or 
                
                Container(
                  width: widht*0.45,
                  child: Row(
                    children: <Widget>[
                      const Expanded(child: Divider()),
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Text('or',style: GoogleFonts.abel(fontSize:16),),
                      ),
                      const Expanded(child: Divider())
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: ()=>Navigator.push(context,MaterialPageRoute(builder: (context)=>const LoginPage())),
                  child: RichText(
                    text:TextSpan(
                      text: "Continue as Student, ",
                      style: GoogleFonts.abel(fontSize:18,fontWeight:FontWeight.w400), 
                      children: [
                        TextSpan(
                          text: "Login",
                          style: GoogleFonts.abel(fontSize:20,fontWeight:FontWeight.bold,color:Colors.red), 
                  
                        ),
                      ]
                    ) ),
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