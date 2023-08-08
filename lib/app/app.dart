import 'package:smartnote/ui/bottom_sheets/notice/notice_sheet.dart';
import 'package:smartnote/ui/dialogs/info_alert/info_alert_dialog.dart';

import 'package:smartnote/ui/views/startup/startup_view.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:smartnote/services/authentication_service.dart';

import 'package:smartnote/ui/views/login/login_view.dart';

import 'package:smartnote/ui/views/signup/signup_view.dart';
import 'package:smartnote/services/firestore_service.dart';

import 'package:smartnote/ui/views/verify_email/verify_email_view.dart';
import 'package:smartnote/ui/views/home/home_view.dart';
// @stacked-import

@StackedApp(
  routes: [
    MaterialRoute(page: StartupView),
    MaterialRoute(page: LoginView),
    MaterialRoute(page: SignupView),
    MaterialRoute(page: VerifyEmailView),
    MaterialRoute(page: HomeView),
// @stacked-route
  ],
  dependencies: [
    LazySingleton(classType: BottomSheetService),
    LazySingleton(classType: DialogService),
    LazySingleton(classType: NavigationService),
    LazySingleton(classType: AuthenticationService),
    LazySingleton(classType: SnackbarService),
    LazySingleton(classType: FirestoreService),
// @stacked-service
  ],
  bottomsheets: [
    StackedBottomsheet(classType: NoticeSheet),
    // @stacked-bottom-sheet
  ],
  dialogs: [
    StackedDialog(classType: InfoAlertDialog),
    // @stacked-dialog
  ],
  logger: StackedLogger(),
)
class App {}
