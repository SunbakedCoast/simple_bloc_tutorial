import 'dart:async';

import 'package:simple_bloc_tutorial/src/model/message.dart';

abstract class MessageRepository {
  Future<Message> getName();
}

class MsgRepo extends MessageRepository {
 
  @override
  Future<Message> getName() async {
    return Message(value: 'Hello There!');
  }
  
}