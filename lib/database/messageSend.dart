//here we will be creating a function for sending the message to the database

import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseDB{
  final String? messageText;
  final DateTime? messageTime;
  final String? UserId;
  const FirebaseDB({ this.messageText, this.messageTime, this.UserId});

  //function to send the message to the database
  void sendMessage(String messageText, DateTime messageTime,String UserId)async{
    try {
      //for userid 
      DocumentReference myuserDoc = FirebaseFirestore.instance.collection('users').doc(UserId);
    await myuserDoc.collection('messages').add({
      'messageText':messageText,
      'messageTime':messageTime,
      'messageUid':''
    });
    myuserDoc.update({'messageUid':myuserDoc.id});
    print('Message Successfully Added to the database');
    } catch (e) {
      print('Error Occured');
    }
    
  }

  

   static Future<void> DBHelper(String prn,String password) async {
    
    try {
      //check if the prn is already present
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await FirebaseFirestore.instance
              .collection('users')
              .where('prn', isEqualTo: prn)
              .get();

      if (querySnapshot.docs.isNotEmpty) {
        var studentData = querySnapshot.docs.first.data();
        String StoredPassword = studentData['password'];
        String userUid = studentData['uid'];
        
        print(StoredPassword);
        print(userUid);
        print(studentData['prn']);
        if (password == StoredPassword) {
          
          print('Successfully signed In');
        } else {
          print('Incorrect password');
        }
      } else {
        print('PRN does not exist');
      }
    } catch (e) {
      print('An error occurred');
    }
  }



  
}