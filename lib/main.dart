import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smartnote/app/app.bottomsheets.dart';
import 'package:smartnote/app/app.dialogs.dart';
import 'package:smartnote/app/app.locator.dart';
import 'package:smartnote/app/app.router.dart';
import 'package:smartnote/ui/common/app_colors.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await setupLocator();
  setupDialogUi();
  setupBottomSheetUi();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: Routes.startupView,
      onGenerateRoute: StackedRouter().onGenerateRoute,
      navigatorKey: StackedService.navigatorKey,
      navigatorObservers: [
        StackedService.routeObserver,
      ],
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          colorScheme: ColorScheme.fromSwatch(
            primarySwatch: MaterialColor(
              0xFF0D121D,
              colorSwatch,
            ),
          ).copyWith(
            secondary: const Color(0xFF0D121D),
          ),
          textTheme: TextTheme(
            headlineSmall: GoogleFonts.spaceMono(
              color: const Color(0xFF0D121D),
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
            headlineMedium: GoogleFonts.spaceMono(
              color: const Color(0xFF0D121D),
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
            headlineLarge: GoogleFonts.spaceMono(
              color: const Color(0xFF0D121D),
              fontSize: 32,
              fontWeight: FontWeight.w500,
            ),
            bodyLarge: GoogleFonts.spaceMono(
              color: const Color(0xFF0D121D),
              fontSize: 16,
              fontWeight: FontWeight.normal,
            ),
            bodyMedium: GoogleFonts.spaceMono(
              color: const Color(0xFF0D121D),
              fontSize: 14,
              fontWeight: FontWeight.normal,
            ),
            titleMedium: GoogleFonts.spaceMono(
              color: const Color(0xFF0D121D),
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
            titleSmall: GoogleFonts.spaceMono(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
            labelLarge: GoogleFonts.spaceMono(
              color: const Color(0xFF0D121D),
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
            bodySmall: GoogleFonts.spaceMono(
              color: const Color(0xFF0D121D),
              fontSize: 12,
              fontWeight: FontWeight.normal,
            ),
            labelSmall: const TextStyle(
              fontFamily: 'Roboto',
              color: Color(0xFF0D121D),
              fontSize: 10,
              fontWeight: FontWeight.normal,
            ),
          )),
    );
  }
}
