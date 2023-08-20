import 'package:clipboard/clipboard.dart';
import 'package:smartnote/app/app.locator.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class NoticeSheetModel extends BaseViewModel {
  final _snackbarService = locator<SnackbarService>();
  final _navigationService = locator<NavigationService>();
  void copyText(String text) {
    FlutterClipboard.copy(text).then((value) {
      _snackbarService.showSnackbar(
          message: "Text successfully copied to your clipboard",
          duration: const Duration(seconds: 2));
    });
    _navigationService.back();
  }
}
