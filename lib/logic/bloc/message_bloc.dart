import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:botsta_app/models/message.dart';
import 'package:botsta_app/repositories/botsta_api_client.dart';
import 'package:equatable/equatable.dart';

import '../../startup.dart';

part 'message_event.dart';
part 'message_state.dart';

class MessageBloc extends Bloc<MessageEvent, MessageState> {
  MessageBloc() : super(MessageInitial()) {
  }

  @override
  Stream<MessageState> mapEventToState(
    MessageEvent event,
  ) async* {
    var client = getIt.get<BotstaApiClient>();
    if (event is InitialMessageEvent) {
      await client.messageSubscription();
    }
    else if (event is UpdateMessageEvent) {
      var messages = await client.getMessagesAsync(event.chatroomId);
      var msgMap = Map<String, List<Message>?>.from(state.messages);
      msgMap[event.chatroomId] = messages?.toList();
      yield MessageState(msgMap);
    } else if (event is AppendMessageEvent) {
      var msgMap = _addMessageToState(event.message);
      print(state.messages == msgMap);
      yield MessageState(msgMap);
    }
  }

  Future<Message?> postMessageAsync(String chatroomId, String message) async {
    var client = getIt.get<BotstaApiClient>();
    await client.postMessageAsync(chatroomId, message);
  }

  Map<String, List<Message>?> _addMessageToState(Message message) {
    var msgMap = Map<String, List<Message>?>.from(state.messages);
    if (msgMap.containsKey(message.chatroomId) && msgMap[message.chatroomId] != null) {
      var list = List<Message>.from(state.messages[message.chatroomId]!);
      list.insert(0, message);
      msgMap[message.chatroomId] = list;
    }

    return msgMap;
  }
}