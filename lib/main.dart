import 'package:drawme/models/avatar/avatar_list.dart';
import 'package:drawme/screens/avatar_form/avatar_form_screen.dart';
import 'package:drawme/screens/avatar_overview/tabs_avatar_screen.dart';
import 'package:drawme/utils/AppRoutes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
    <DeviceOrientation>[
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ],
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: <SingleChildWidget>[
        ChangeNotifierProvider<AvatarList>(
          create: (_) => AvatarList(),
        ),
      ],
      child: MaterialApp(
        title: 'DrawMe!',
        theme: ThemeData(
          primaryColor: const Color.fromRGBO(24, 35, 73, 1),
          primaryColorDark: const Color.fromRGBO(0, 0, 47, 1),
          primaryColorLight: const Color.fromRGBO(2, 62, 115, 1),
          indicatorColor: const Color.fromRGBO(0, 187, 212, 1),
          backgroundColor: const Color.fromRGBO(17, 25, 52, 1),
          colorScheme: ThemeData.dark().colorScheme.copyWith(
                primary: const Color.fromRGBO(24, 35, 73, 1),
                secondary: const Color.fromRGBO(0, 187, 212, 1),
              ),
          primaryIconTheme: const IconThemeData(color: Colors.white),
          textTheme: ThemeData.dark().textTheme.copyWith(
                headline6: const TextStyle(
                  fontSize: 20,
                  fontFamily: 'RobotoCondensed',
                ),
              ),
        ),
        routes: <String, WidgetBuilder>{
          AppRoutes.HOME: (BuildContext ctx) => const TabsAvatarScreen(),
          AppRoutes.AVATAR_FORM: (BuildContext ctx) => const AvatarFormScreen(),
        },
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
