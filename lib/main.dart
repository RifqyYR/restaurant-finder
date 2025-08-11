import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:submission_restaurant_app_1/data/api/api_services.dart';
import 'package:submission_restaurant_app_1/pages/restaurant_detail_screen.dart';
import 'package:submission_restaurant_app_1/pages/restaurant_list_screen.dart';
import 'package:submission_restaurant_app_1/pages/splash_screen.dart';
import 'package:submission_restaurant_app_1/providers/restaurant_detail_provider.dart';
import 'package:submission_restaurant_app_1/providers/restaurant_search_provider.dart';
import 'package:submission_restaurant_app_1/providers/theme_provider.dart';
import 'package:submission_restaurant_app_1/providers/restaurant_list_provider.dart';
import 'package:submission_restaurant_app_1/utils/theme_scheme.dart';

void main(List<String> args) {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(
          create: (_) => RestaurantListProvider(ApiServices()),
        ),
        ChangeNotifierProvider(
          create: (_) => RestaurantSearchProvider(ApiServices()),
        ),
        ChangeNotifierProvider(
          create: (_) => RestaurantDetailProvider(ApiServices()),
        ),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return DynamicColorBuilder(
      builder: (lightDynamic, darkDynamic) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          initialRoute: '/',
          routes: {
            '/': (context) => SplashScreen(),
            '/home': (context) => RestaurantListScreen(),
          },
          onGenerateRoute: (settings) {
            if (settings.name == '/detail') {
              final args = settings.arguments as String;
              return MaterialPageRoute(
                builder: (context) {
                  return RestaurantDetailScreen(restaurantId: args);
                },
              );
            }
            return null; // Let the OS handle the request if the route doesn't match
          },
          theme: ThemeData(
            colorScheme: lightColorScheme,
            textTheme: GoogleFonts.poppinsTextTheme().copyWith(
              titleMedium: GoogleFonts.lato(
                textStyle: GoogleFonts.poppinsTextTheme().titleMedium,
              ),
              titleLarge: GoogleFonts.lato(
                textStyle: GoogleFonts.poppinsTextTheme().titleLarge,
              ),
              titleSmall: GoogleFonts.lato(
                textStyle: GoogleFonts.poppinsTextTheme().titleSmall,
              ),
            ),
            useMaterial3: true,
          ),
          darkTheme: ThemeData(
            colorScheme: darkColorScheme,
            textTheme: GoogleFonts.poppinsTextTheme().copyWith(
              titleMedium: GoogleFonts.lato(
                textStyle: GoogleFonts.poppinsTextTheme().titleMedium,
              ),
              titleLarge: GoogleFonts.lato(
                textStyle: GoogleFonts.poppinsTextTheme().titleLarge,
              ),
              titleSmall: GoogleFonts.lato(
                textStyle: GoogleFonts.poppinsTextTheme().titleSmall,
              ),
            ),
            useMaterial3: true,
          ),
          themeMode: themeProvider.themeMode,
        );
      },
    );
  }
}
