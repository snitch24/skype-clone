import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  String message = "";
  String type = "text";
  String senderId = "";
  String receiverId = "";
  Timestamp timeStamp  = Timestamp.now()
  ;
  String photoURL = "";

  Message({
    required this.message,
    required this.receiverId,
    required this.senderId,
    required this.type,
    required this.timeStamp,
  });

  Message.imageMessage({
    required this.message,
    required this.photoURL,
    required this.receiverId,
    required this.senderId,
    required this.timeStamp,
    required this.type,
  });

  Map<String, dynamic> toMap() {
    Map<String, dynamic> data = {};
    data['message'] = message;
    data['type'] = type;
    data['senderid'] = senderId;
    data['receiverid'] = receiverId;
    data['timestamp'] = timeStamp;
    return data;
  }

  Message.fromMap(Map<String, dynamic> data) {
    message = data['message'];
    receiverId = data['receiverid'];
    senderId = data['senderid'];
    type = data['type'];
    timeStamp = data['timestamp'];
  }
}
