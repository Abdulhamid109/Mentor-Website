
class member{
  final String prn;
  final String password;
  final String uid;
  
   member({
    required this.prn,
    required this.password,
    required this.uid,
   });

   factory member.fromMap(Map<String,dynamic> map){
    return member(
      prn: map['prn'] ?? '',
      password: map['password'] ?? '',
      uid: map['uid'] ?? '',
    );
   }
}

class Message {
  final String message;
  final DateTime time;

  Message({
    required this.message,
    required this.time,
  });

  factory Message.fromMap(Map<String, dynamic> map) {
    return Message(
      message: map['message'] ?? '',
      time: (map['time'] as DateTime),
    );
  }
}