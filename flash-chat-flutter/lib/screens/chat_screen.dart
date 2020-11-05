import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flash_chat/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ChatScreen extends StatefulWidget {
  static const id = 'chat_screen';
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final messageEditController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final _fireStore = Firestore.instance;
  FirebaseUser currentUser;

  String messageText;

  @override
  void initState() {
   getCurrentUser();
  }
  void getCurrentUser() async {
    try {
      currentUser = await _auth.currentUser();
      if (currentUser != null) {
        print(currentUser.email);
      }
    } catch(err) {
      print(err);
    }
  }

//  void messageStream() async {
//    await for(var snapshot in ) {
//      for (final document in snapshot.documents) {
//        print(document.data);
//      }
//    }
//  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
                //Implement logout functionality
              }),
        ],
        title: Text('⚡️Chat'),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
             child: StreamBuilder<QuerySnapshot>(
               stream: _fireStore.collection('messages').snapshots(),
               builder: (context, snapshot) {
                 if (!snapshot.hasData) {
                   return CircularProgressIndicator(
                     backgroundColor: Colors.lightBlueAccent,
                   );
                 }
                 List<MessageBuble> messages = [];
                 for (final message in snapshot.data.documents.reversed) {
                   final  text = message['message'];
                   final sender = message['sender'];
                   final currentUserEmail = currentUser.email;
                   messages.add(MessageBuble(text: text, sender: sender, isMe: currentUserEmail == sender,));
                 }
                 return Expanded(
                   child: ListView(
                     reverse: true,
                     children: messages,
                   ),
                 );
               },
             ),
            ),
            Container(
              decoration: kMessageContainerDecoration,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: messageEditController,
                      onChanged: (value) {
                        //Do something with the user input.
                        messageText = value;
                      },
                      decoration: kMessageTextFieldDecoration,
                    ),
                  ),
                  FlatButton(
                    onPressed: () {
                      messageEditController.clear();
                      //Implement send functionality.
                      _fireStore.collection('messages')
                          .add({
                        'message': messageText,
                        'sender': currentUser.email
                      });
                    },
                    child: Text(
                      'Send',
                      style: kSendButtonTextStyle,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MessageBuble extends StatelessWidget {

  final text;
  final sender;
  bool isMe;

  MessageBuble({this.text, this.sender, this.isMe});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Text(sender, style: TextStyle(
            fontSize: 12.0,
            color: Colors.black54
          ),),
          Material(
            elevation: 5.0,
            borderRadius: BorderRadius.only(topLeft: isMe ? Radius.circular(30.0) : Radius.circular(0), bottomLeft: Radius.circular(30.0), bottomRight: Radius.circular(30.0), topRight: isMe ? Radius.circular(0) : Radius.circular(30)),
            color: isMe ? Colors.lightBlueAccent : Colors.grey,
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Text('$text'),
            ), textStyle: TextStyle(
            fontSize: 15.0,
            color: Colors.white,
          ),),
        ],
      ),
    );
  }
}
