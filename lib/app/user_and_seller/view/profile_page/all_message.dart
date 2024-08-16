import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../../../constants/apiEndPoints.dart';

class Message {
  final String messageid;
  final String senderID;
  final String receiverID;
  final String body;
  final DateTime sentAt;

  Message({required this.messageid,required this.senderID, required this.receiverID, required this.body, required this.sentAt});

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      messageid: json['MessageID'].toString(),
      senderID: json['SenderID'],
      receiverID: json['ReceiverID'],
      body: json['Body'],
      sentAt: DateTime.parse(json['SentAt'])
    );
  }
}


Future<List<Message>> fetchMessages(String userID) async {
  final response = await http.post(
    Uri.parse(ApiEndPoints.baseURL +ApiEndPoints.get_allmessages),//getmymessages.php/
    body: {'senderID': userID},
  );
  // print("here");
  if (response.statusCode == 200) {
    print(response.body);
    // Parse response body
    final List<dynamic> responseData = json.decode(response.body);
    // Convert dynamic list to list of Message objects
    final List<Message> messages = responseData.map((e) => Message.fromJson(e)).toList();
    return messages;
  } else {
    throw Exception('Failed to load messages');
  }
}

class MessagesPage extends StatefulWidget {
  final String userID;

  MessagesPage({required this.userID});

  @override
  _MessagesPageState createState() => _MessagesPageState();
}

class _MessagesPageState extends State<MessagesPage> {
  late Future<List<Message>> _futureMessages;

  @override
  void initState() {
    super.initState();
    _futureMessages = fetchMessages(widget.userID);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Messages'),
      ),
      body: FutureBuilder<List<Message>>(
        future: _futureMessages,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final message = snapshot.data![index];
                return ListTile(
                  title: Text(message.receiverID),
                  subtitle: Text(message.body),
                  onTap: () {
                    // Navigate to message details page
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MessageDetailsPage(senderID: message.senderID,receiverID: message.receiverID),
                      ),
                    );
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}

class MessageDetailsPage extends StatefulWidget {
  final String senderID;
  final String receiverID;

  MessageDetailsPage({required this.senderID, required this.receiverID});

  @override
  _MessageDetailsPageState createState() => _MessageDetailsPageState();
}

class _MessageDetailsPageState extends State<MessageDetailsPage> {
  TextEditingController _messageController = TextEditingController();
  List<Message> _messages = [];

  @override
  void initState() {
    super.initState();
    // Fetch messages for senderID and receiverID
    fetchMessages();
  }
void fetchMessages() async {
  // Make API call to fetch messages from sender to receiver
  var senderToReceiverResponse = await http.post(
    Uri.parse(ApiEndPoints.baseURL + ApiEndPoints.getmessages),
    body: {
      'senderID': widget.senderID,
      'receiverID': widget.receiverID,
    },
  );

  // Make API call to fetch messages from receiver to sender
  var receiverToSenderResponse = await http.post(
    Uri.parse(ApiEndPoints.baseURL + ApiEndPoints.getmessages),
    body: {
      'senderID': widget.receiverID, // Swap sender and receiver
      'receiverID': widget.senderID, // Swap sender and receiver
    },
  );

  if (senderToReceiverResponse.statusCode == 200 && receiverToSenderResponse.statusCode == 200) {
    // Parse JSON responses
    var senderToReceiverJsonResponse = jsonDecode(senderToReceiverResponse.body);
    var receiverToSenderJsonResponse = jsonDecode(receiverToSenderResponse.body);

    // Combine messages from both directions
    var combinedMessages = [...senderToReceiverJsonResponse, ...receiverToSenderJsonResponse];

    // Convert each message to a Message object and add to _messages list
    setState(() {
      _messages = combinedMessages.map((messageJson) => Message.fromJson(messageJson)).toList();
      // Sort messages by 'sentAt' timestamp
      _messages.sort((a, b) => a.sentAt.compareTo(b.sentAt));
      // print(_messages);
    });
  } else {
    // Handle error
  }
}
  Future<void> sendMessage(String message) async {
    // Make API call to send message
    // Adjust the API URL as per your backend configuration
    var url = ApiEndPoints.baseURL +ApiEndPoints.insertmessage;
    var response = await http.post(
      Uri.parse(url),
      body: {
        'senderID': widget.senderID,
        'receiverID': widget.receiverID,
        'body': message,
      },
    );

    // Handle response
    if (response.statusCode == 200) {
      final res=jsonDecode(response.body);
      print(res);
      if(res['status']=='success'){
        fetchMessages();
        setState(() {
          
        });
      }
    } else {
      // Handle error
    }
  }

  @override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: Text('Message Details'),
    ),
    body: Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: _messages.length,
            itemBuilder: (context, index) {
              // Determine alignment based on sender or receiver
              CrossAxisAlignment alignment = CrossAxisAlignment.start;
              MainAxisAlignment mainAxisAlignment = MainAxisAlignment.start;
              if (_messages[index].senderID == widget.senderID) {
                alignment = CrossAxisAlignment.end;
                mainAxisAlignment = MainAxisAlignment.end;
              }

              return Container(
                padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                child: Row(
                  mainAxisAlignment: mainAxisAlignment,
                  crossAxisAlignment: alignment,
                  children: [
                    if (_messages[index].senderID != widget.senderID) // Show avatar for receiver's messages
                      CircleAvatar(
                        // You can use a profile image here instead of a placeholder
                        child: Text('R'),
                      ),
                    SizedBox(width: 8.0), // Add some spacing between avatar and message
                    Container(
                      padding: EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        color: _messages[index].senderID == widget.senderID ? Colors.blue : Colors.grey, // Change color based on sender
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Text(
                        _messages[index].body,
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
        Padding(
          padding: EdgeInsets.all(8.0),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _messageController,
                  decoration: InputDecoration(
                    hintText: 'Type your message...',
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () async{
                  String message = _messageController.text;
                  // print(message);
                  await sendMessage(message);
                  _messageController.clear();
                },
                child: Text('Send'),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
}