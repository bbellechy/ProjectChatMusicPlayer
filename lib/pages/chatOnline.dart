import 'package:chatmusic/models/chat_server.dart';
import 'package:chatmusic/pages/login.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ChatOnlinePage extends StatefulWidget {
  const ChatOnlinePage({super.key});
  // final String receiverUserEmail;
  // final String recieverUserID;
  @override
  State<ChatOnlinePage> createState() => _ChatOnlinePageState();
}

class _ChatOnlinePageState extends State<ChatOnlinePage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final TextEditingController _messageController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final ChatServer _chatServer = ChatServer();

  void sendMessage() async {
    if (_messageController.text.isNotEmpty) {
      await _chatServer.sendMessage(
          _auth.currentUser!.uid, _messageController.text);
      _messageController.clear();
    }
  }

String imageUrl = '';

Future<void> fetchUserProfileImage() async {
  QuerySnapshot querySnapshot = await _firestore.collection('userProfile').where('email').get();
  
  if (querySnapshot.docs.isNotEmpty) {
    imageUrl = querySnapshot.docs[0]['imageProfile']; 
    print("imagee = ${imageUrl}");
  } else {
    print('No user profile found for this email');
  }
}
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
  stream: FirebaseFirestore.instance.collection('Message').orderBy('timestamp', descending: true).snapshots(),
  builder: (context, snapshot) {
    // if (snapshot.hasError) {
    //   return Text("Error: ${snapshot.error}");
    // }
    if (snapshot.connectionState == ConnectionState.waiting) {
      return CircularProgressIndicator();
    }
    if (snapshot.data == null || snapshot.data!.docs.isEmpty) {
      return Login();
    }
    var messages = snapshot.data!.docs;
     return Column(
       children: [
        Padding(
                  padding: EdgeInsets.fromLTRB(30.0, 20.0, 8.0, 3.0),
                  child: Text(
                    'Online Chat',
                    style: TextStyle(
                      fontFamily: 'atma',
                      fontSize: 35,
                      color: Color(0xFFFF6B00),
                    ),
                  ),
                ),
         Expanded(
           child: ListView.builder(
            reverse: true,
            shrinkWrap: true,
            itemCount: messages.length,
            itemBuilder: (context, index) {
                    var alignment = (snapshot.data!.docs[index]['senderEmail'] ==
                            _auth.currentUser!.email)
                        ? Alignment.centerRight
                        : Alignment.centerLeft;
                    return Container(
                      alignment: alignment,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: (snapshot.data!.docs[index]
                                      ["senderId"] ==
                                  _auth.currentUser!.uid)
                              ? CrossAxisAlignment.end
                              : CrossAxisAlignment.start,
                          mainAxisAlignment: (snapshot.data!.docs[index]
                                      ["senderId"] ==
                                  _auth.currentUser!.uid)
                              ? MainAxisAlignment.end
                              : MainAxisAlignment.start,
                          children: [
                            CircleAvatar(
                backgroundImage: NetworkImage(imageUrl),
                ),
                            Text(
                              snapshot.data!.docs[index]["senderEmail"],
                              style: TextStyle(
                                  fontFamily: 'aBeeZee',
                                  fontSize: 16,
                                  color: Color(0xFFFF6B00)),
                            ),
                            Text(
                              snapshot.data!.docs[index]["message"],
                              style: TextStyle(
                                  fontFamily: 'aBeeZee',
                                  fontSize: 16,
                                  color: Color(0xFFFF6B00)),
                            ),
                          ],
                        ),
                      ),
                    );
                    
            },
               ),
         ),
              _buildMessageInput(),
       ],
     );
    
  },
  
);

  }
  // build message input
  Widget _buildMessageInput() {
    return Container(
      padding: const EdgeInsets.fromLTRB(30.0, 20.0, 30.0, 100.0),
      child: Row(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black,
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: Offset(0, 5),
                  ),
                ],
              ),
              child: TextField(
                controller: _messageController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: Theme.of(context).colorScheme.secondary,
                  contentPadding: const EdgeInsets.all(6),
                  hintText: 'chat',
                  hintStyle: const TextStyle(
                    fontFamily: 'Inter',
                    color: Color(0xFFFF6B00),
                    fontSize: 14,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(width: 8),
          IconButton(
            onPressed: sendMessage,
            icon: Icon(
              Icons.send,
              color: Color(0xFFFF6B00),
            ),
          ),
          SizedBox(height: 20),
          SizedBox(
            height: 20,
          )
        ],
      ),
    );
  }
}
