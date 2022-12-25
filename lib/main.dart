import 'package:crimson/providers/index_provider.dart';
import 'package:crimson/providers/video_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/homepage.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => IndexProvider()),
    ChangeNotifierProvider(create: (_) => VideoProvider())
  ], child: MyApp()));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Crimson Video Player',
      theme: ThemeData(
          fontFamily: 'Nunito',
          brightness: Brightness.dark,
          useMaterial3: true,
          colorScheme: ColorScheme(
            brightness: Brightness.dark,
            primary: Color(0xFFFFB4AB),
            onPrimary: Color(0xFF690006),
            primaryContainer: Color(0xFF93000C),
            onPrimaryContainer: Color(0xFFFFDAD6),
            secondary: Color(0xFFE7BDB8),
            onSecondary: Color(0xFF442926),
            secondaryContainer: Color(0xFF5D3F3C),
            onSecondaryContainer: Color(0xFFFFDAD6),
            tertiary: Color(0xFFE0C38C),
            onTertiary: Color(0xFF3F2E04),
            tertiaryContainer: Color(0xFF584419),
            onTertiaryContainer: Color(0xFFFDDFA6),
            error: Color(0xFFFFB4AB),
            errorContainer: Color(0xFF93000A),
            onError: Color(0xFF690005),
            onErrorContainer: Color(0xFFFFDAD6),
            background: Color(0xFF201A19),
            onBackground: Color(0xFFEDE0DE),
            surface: Color(0xFF201A19),
            onSurface: Color(0xFFEDE0DE),
            surfaceVariant: Color(0xFF534341),
            onSurfaceVariant: Color(0xFFD8C2BF),
            outline: Color(0xFFA08C8A),
            onInverseSurface: Color(0xFF201A19),
            inverseSurface: Color(0xFFEDE0DE),
            inversePrimary: Color(0xFFC00013),
            shadow: Color(0xFF000000),
            surfaceTint: Color(0xFFFFB4AB),
          )),
      builder: (context, child) => MediaQuery(
          data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
          child: child!),
      home: Homepage(),
    );
  }
}
