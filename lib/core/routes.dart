import 'package:flutter/widgets.dart';
import 'package:flutter_base_app/views/contacts/contacts_page.dart';
import 'package:flutter_base_app/views/conversations/conversations_page.dart';
import 'package:flutter_base_app/views/sign_in/sign_in_page.dart';
import 'package:flutter_base_app/views/sign_up/sign_up_page.dart';

class Routes {

  static const String signIn = '/sign_in';
  static const String signUp = '/sign_up';
  static const String dashboard = '/dashboard';
  static const String conversations = '/conversations';
  static const String contacts = '/contacts';

  static Map<String, WidgetBuilder> getRoutes() {
    return {
      Routes.signIn : (context) => SignInPage(),
      Routes.signUp : (context) => SignUpPage(),
      Routes.conversations : (context) => ConversationPage(),
      Routes.contacts : (context) => ContactsPage()
    };
  }

}