import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:drawme/models/avatar_list.dart';

import 'package:drawme/screens/avatar_detail_screen.dart';
import 'package:drawme/screens/options_screen.dart';
import 'package:drawme/screens/tabs_avatar_screen.dart';

import 'package:drawme/utils/AppRoutes.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => AvatarList(),
        ),
      ],
      child: MaterialApp(
        title: 'DrawMe!',
        theme: ThemeData(
          primarySwatch: Colors.lightBlue,
          accentColor: Colors.amber,
          appBarTheme: AppBarTheme(
            textTheme: ThemeData.light().textTheme.copyWith(
                  headline6: TextStyle(
                    fontFamily: 'RobotoCondensed',
                    fontSize: 25,
                    color: Colors.white,
                  ),
                ),
          ),
          primaryIconTheme: IconThemeData(color: Colors.white),
          textTheme: ThemeData.light().textTheme.copyWith(
                headline6: TextStyle(
                  fontSize: 20,
                  fontFamily: 'RobotoCondensed',
                ),
              ),
        ),
        routes: {
          AppRoutes.HOME: (ctx) => OptionsScreen(),
          AppRoutes.AVATAR_LIST: (ctx) => TabsAvatarScreen(),
          AppRoutes.AVATAR_DETAIL: (ctx) => AvatarDetailScreen(),
        },
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
