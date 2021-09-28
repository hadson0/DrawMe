import 'package:drawme/models/avatar/avatar_list.dart';
import 'package:drawme/screens/home/home_screen.dart';
import 'package:drawme/utils/Theme/theme_colors.dart';
import 'package:drawme/utils/Theme/theme_styles.dart';
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
        theme: ThemeData.light().copyWith(
          primaryColor: ThemeColors.primaryColor,
          backgroundColor: ThemeColors.backgroundColor,
          colorScheme: ThemeColors.colorScheme,
          indicatorColor: ThemeColors.indicatorColor,
          iconTheme: ThemeColors.iconTheme,
          textTheme: ThemeStyles.textTheme,
          elevatedButtonTheme: ThemeStyles.elevatedButtonTheme,
        ),
        home: const HomeScreen(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
