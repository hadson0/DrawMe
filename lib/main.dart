import 'package:drawme/models/avatar_list.dart';
import 'package:drawme/screens/avatar_form/layer_selection_form_screen.dart';
import 'package:drawme/screens/avatar_overview/tabs_avatar_screen.dart';
import 'package:drawme/screens/home_screen.dart';
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
          primarySwatch: Colors.lightBlue,
          colorScheme: ThemeData.light().colorScheme.copyWith(
                secondary: Colors.amber,
              ),
          appBarTheme: const AppBarTheme(
            toolbarTextStyle: TextStyle(
              fontFamily: 'RobotoCondensed',
              fontSize: 25,
              color: Colors.white,
            ),
          ),
          primaryIconTheme: const IconThemeData(color: Colors.white),
          textTheme: ThemeData.light().textTheme.copyWith(
                headline6: const TextStyle(
                  fontSize: 20,
                  fontFamily: 'RobotoCondensed',
                ),
              ),
        ),
        routes: <String, WidgetBuilder> {
          AppRoutes.HOME: (BuildContext ctx) => const HomeScreen(),
          AppRoutes.AVATAR_LIST: (BuildContext ctx) => const TabsAvatarScreen(),
          AppRoutes.LAYER_SELECTION_FORM: (BuildContext ctx) =>
              const LayerSelectionFormScreen(),
        },
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
