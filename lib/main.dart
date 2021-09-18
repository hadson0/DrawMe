import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:drawme/models/avatar_list.dart';

import 'package:drawme/components/avatar/avatar_detail/avatar_detail_sheet.dart';
import 'package:drawme/screens/home_screen.dart';
import 'package:drawme/screens/avatar_overview/tabs_avatar_screen.dart';
import 'package:drawme/screens/avatar_form/layer_selection_form_screen.dart';

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
          colorScheme: ThemeData.light().colorScheme.copyWith(
                secondary: Colors.amber,
              ),
          appBarTheme: AppBarTheme(
            toolbarTextStyle: TextStyle(
              fontFamily: 'RobotoCondensed',
              fontSize: 25,
              color: Colors.white,
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
          AppRoutes.HOME: (ctx) => HomeScreen(),
          AppRoutes.AVATAR_LIST: (ctx) => TabsAvatarScreen(),
          AppRoutes.LAYER_SELECTION_FORM: (ctx) => LayerSelectionFormScreen(),
        },
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
