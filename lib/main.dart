import 'package:drawme/models/app_theme/app_colors.dart';
import 'package:drawme/models/avatar/avatar_list.dart';
import 'package:drawme/screens/avatar_form/avatar_form_screen.dart';
import 'package:drawme/screens/avatar_overview/tabs_avatar_screen.dart';
import 'package:drawme/utils/app_routes.dart';
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
          primaryColor: AppColors.primaryColor,
          primaryColorDark: AppColors.primaryColorDark,
          primaryColorLight: AppColors.primaryColorLight,
          indicatorColor: AppColors.indicatorColor,
          backgroundColor: AppColors.darkBackgroundColor,
          colorScheme: AppColors.darkColorScheme,
          primaryIconTheme: const IconThemeData(color: Colors.white),
          textTheme: ThemeData.dark().textTheme.copyWith(
                headline6: const TextStyle(
                  fontSize: 20,
                  fontFamily: 'RobotoCondensed',
                ),
              ),
          textSelectionTheme: const TextSelectionThemeData(
            selectionHandleColor: AppColors.indicatorColor,
            selectionColor: AppColors.primaryColorLight,
          ),
        ),
        routes: <String, WidgetBuilder>{
          AppRoutes.home: (BuildContext ctx) => const TabsAvatarScreen(),
          AppRoutes.avatarForm: (BuildContext ctx) => const AvatarFormScreen(),
        },
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
