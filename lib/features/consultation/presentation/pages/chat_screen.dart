import 'package:drugs_ng/core/utils/app_utils.dart';
import 'package:flutter/material.dart';
// import 'package:pubnub/pubnub.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  // late PubNub pubnub;
  // late Subscription subscription;
  final String channelName = AppUtils.pubNubChatChannelName;
  final TextEditingController _controller = TextEditingController();
  List<String> messages = [];

  @override
  void initState() {
    super.initState();
    _initializePubNub();
  }

  void _initializePubNub() async {
    // pubnub = PubNub(
    //     defaultKeyset: Keyset(
    //         subscribeKey: AppUtils.pubNubSubscribeKey,
    //         publishKey: AppUtils.pubNubPublishKey,
    //         userId: const UserId('userId') // change to userId,

    //         ));

    // subscription = pubnub.subscribe(channels: {channelName});
    // subscription.messages.listen((envelope) {
    //   setState(() {
    //     messages.add(envelope.content.toString());
    //   });
    // });
  }

  void _sendMessage() async {
    // if (_controller.text.isNotEmpty) {
    //   await pubnub.publish(channelName, _controller.text);
    //   _controller.clear();
    // }
  }

  @override
  void dispose() {
    // subscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Chat')),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: messages.length,
              itemBuilder: (context, index) {
                return ListTile(title: Text(messages[index]));
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: const InputDecoration(
                      hintText: 'Type a message...',
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: _sendMessage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
