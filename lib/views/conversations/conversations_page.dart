/*
 * Created by Batara Kanaydo on 24/11/2020
 * email: batara.girsang@outlook.com
 * Copyright © 2020 Batara Kanaydo. All rights reserved.
 * Last modified 11/24/20, 7:07 PM
 */

import 'package:flutter/material.dart';
import 'package:flutter_base_app/core/const/app_color.dart';
import 'package:flutter_base_app/core/routes.dart';
import 'package:flutter_base_app/views/conversations/bloc/conversations_cubit.dart';
import 'package:flutter_base_app/views/conversations/conversation_list.dart';
import 'package:flutter_base_app/views/conversations/user_image.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ConversationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Row(
          children: [
            Expanded(
                child: Text(
              'Chats',
              style: textTheme.headline5.apply(color: AppColor.BASE_COLOR),
            )),
            InkWell(
                onTap: () => Navigator.pushNamed(context, Routes.profile),
                child: UserImage()),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        onPressed: () => Navigator.pushNamed(context, Routes.contacts),
        child: Icon(Icons.message_outlined),
      ),
      body: BlocProvider(
        create: (context) => ConversationsCubit(),
        child: BlocBuilder<ConversationsCubit, ConversationsState>(
          builder: (conversationContext, state) {
            if (state is ConversationsLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is ConversationsIdle) {
              return ConversationList(conversations: state.conversations, userId: state.userId,);
            } else if (state is ConversationsError) {
              return Center(
                child: Text(state.message.toString()),
              );
            } else if (state is ConversationsFatalError) {
              return Center(
                child: Text(state.message.toString()),
              );
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }
}
