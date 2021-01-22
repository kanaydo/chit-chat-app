/*
 * Created by Batara Kanaydo on 24/11/2020
 * email: batara.girsang@outlook.com
 * Copyright © 2020 Batara Kanaydo. All rights reserved.
 * Last modified 11/24/20, 7:45 PM
 */

import 'package:flutter/material.dart';
import 'package:flutter_base_app/core/arguments/chat_arguments.dart';
import 'package:flutter_base_app/core/const/app_color.dart';
import 'package:flutter_base_app/data/model/conversation.dart';
import 'package:flutter_base_app/data/model/user.dart';
import 'package:flutter_base_app/views/chat/bloc/chat_cubit.dart';
import 'package:flutter_base_app/views/chat/message_list.dart';
import 'package:flutter_base_app/widget/loa_image_bubble.dart';
import 'package:flutter_base_app/widget/loa_text_field.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatPage extends StatelessWidget {
  final _newMessageFocusNode = FocusNode();
  final _newMessageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final ChatArgument arguments = ModalRoute.of(context).settings.arguments;
    final textTheme = Theme.of(context).textTheme;
    final User friend = arguments.friend;
    final Conversation conversation = arguments.conversation;
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: AppColor.BASE_COLOR),
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Row(
          children: [
            LoaImageBubble(url: friend.image),
            SizedBox(width: 8),
            Text(
              friend.name,
              style: textTheme.bodyText1.apply(color: AppColor.BASE_COLOR),
            ),
          ],
        ),
      ),
      body: BlocProvider(
        create: (context) => ChatCubit(conversation.id, friend),
        child: BlocConsumer<ChatCubit, ChatState>(
          listener: (listenerContext, state) {
            if (state is ChatMessageSent) {
              _newMessageController.clear();
            }
          },
          builder: (chatContext, state) {
            if (state is ChatLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is ChatError) {
              return Center(child: Text(state.message));
            } else if (state is ChatFatalError) {
              return Center(child: Text(state.message));
            } else if (state is ChatIdle) {
              return Column(
                children: [
                  Expanded(
                    child: MessageList(
                      messages: state.messages,
                      userId: state.userId,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Flexible(
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 8.0),
                            margin: EdgeInsets.symmetric(vertical: 4.0),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: AppColor.SOFT_COLOR),
                            child: TextField(
                              controller: _newMessageController,
                              focusNode: _newMessageFocusNode,
                              onChanged: (_) => chatContext
                                  .read<ChatCubit>()
                                  .sendTypingStatus(),
                              style: TextStyle(color: AppColor.BASE_COLOR),
                              decoration:
                                  InputDecoration(border: InputBorder.none),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        MaterialButton(
                            padding: EdgeInsets.all(16),
                            minWidth: 0,
                            shape: CircleBorder(),
                            onPressed: () {
                              String content = _newMessageController.text;
                              chatContext.read<ChatCubit>().addMessage(content);
                            },
                            color: AppColor.BASE_COLOR,
                            child: Icon(Icons.send, color: AppColor.SOFT_COLOR))
                      ],
                    ),
                  )
                ],
              );
            } else {
              return Container();
            }
          }
        ),
      ),
    );
  }
}
