import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:smartnote/app/app.bottomsheets.dart';
import 'package:smartnote/app/app.dialogs.dart';
import 'package:smartnote/app/app.locator.dart';
import 'package:smartnote/app/app.router.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

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
      routes: {
        // '/login-view': (context) {
        //   return SignInScreen();
        // }
        '/login': (context) {
          return SignInScreen(
            actions: [
              AuthStateChangeAction<UserCreated>((context, state) {
                if (!state.credential.user!.emailVerified) {
                  // final snackbarService = locator<SnackbarService>();
                  // snackbarService.showSnackbar(
                  //   message: 'Please verify your email address',
                  //   duration: const Duration(seconds: 5),
                  // );
                  Navigator.pushNamed(context, '/verify-email');
                } else {
                  Navigator.pushReplacementNamed(context, '/profile');
                }
              }),
            ],
          );
        },
        '/verify-email': (context) {
          return EmailVerificationScreen(
            // actionCodeSettings: ,
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
