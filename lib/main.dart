import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:smartnote/app/app.bottomsheets.dart';
import 'package:smartnote/app/app.dialogs.dart';
import 'package:smartnote/app/app.locator.dart';
import 'package:smartnote/app/app.router.dart';
import 'package:smartnote/ui/common/app_colors.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:firebase_auth_platform_interface/src/action_code_settings.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseUIAuth.configureProviders([
    EmailAuthProvider(),
    // GoogleProvider(
    //     clientId:
    //         '187372280063-4s9s9i44jlvr8cg9j5jpm27g4h1n7s6d.apps.googleusercontent.com',
    //     redirectUri:
    //         'https://smart-notes-5682c.firebaseapp.com/__/auth/handler'),
  ]);

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
          // primarySwatch:  Color(0xFF0D121D),
          colorScheme: ColorScheme.fromSwatch(
            primarySwatch: MaterialColor(0xFF0D121D, colorSwatch),
          ),
          textTheme: const TextTheme(
            headlineSmall: TextStyle(
              fontFamily: 'Roboto',
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.w500,
            ),
            headlineMedium: TextStyle(
              fontFamily: 'Roboto',
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
            headlineLarge: TextStyle(
              fontFamily: 'Roboto',
              color: Colors.white,
              fontSize: 32,
              fontWeight: FontWeight.w500,
            ),
            bodyLarge: TextStyle(
              fontFamily: 'Roboto',
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.normal,
            ),
            bodyMedium: TextStyle(
              fontFamily: 'Roboto',
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.normal,
            ),
            titleMedium: TextStyle(
              fontFamily: 'Roboto',
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
            titleSmall: TextStyle(
              fontFamily: 'Roboto',
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
            labelLarge: TextStyle(
              fontFamily: 'Roboto',
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
            bodySmall: TextStyle(
              fontFamily: 'Roboto',
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.normal,
            ),
            labelSmall: TextStyle(
              fontFamily: 'Roboto',
              color: Colors.white,
              fontSize: 10,
              fontWeight: FontWeight.normal,
            ),
          )),
      routes: {
        // '/login-view': (context) {
        //   return SignInScreen();
        // }
        '/login': (context) {
          return SignInScreen(
            actions: [
              AuthStateChangeAction<UserCreated>((context, state) {
                if (!state.credential.user!.emailVerified) {
                  final snackbarService = locator<SnackbarService>();
                  snackbarService.showSnackbar(
                    message: 'Please verify your email address',
                    duration: const Duration(seconds: 5),
                  );
                  Navigator.pushNamed(context, '/verify-email');
                } else {
                  final snackbarService = locator<SnackbarService>();
                  snackbarService.showSnackbar(
                    message: 'Email verified',
                    duration: const Duration(seconds: 5),
                  );
                  // Navigator.pushReplacementNamed(context, '/profile');
                }
              }),
            ],
          );
        },
        '/verify-email': (context) {
          return EmailVerificationScreen(
            actionCodeSettings: ActionCodeSettings(
              url: 'https://smart-notes-5682c.firebaseapp.com/__/auth/handler',
              handleCodeInApp: true,
              // iOSBundleId: 'com.smartnote',
              androidPackageName: 'com.smartnote',
              androidInstallApp: true,
              androidMinimumVersion: '16',
            ),
            actions: [
              EmailVerifiedAction(() {
                final snackbarService = locator<SnackbarService>();
                snackbarService.showSnackbar(
                  message: 'Email verified',
                  duration: const Duration(seconds: 5),
                );
              })
            ],
          );
        }
      },
    );
  }
}
