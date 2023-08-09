import 'package:smartnote/app/app.locator.dart';
import 'package:smartnote/app/app.router.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class NotesViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();

  void navigateToCreateNoteView() {
    _navigationService.navigateTo(Routes.addNoteView);
  }
}
