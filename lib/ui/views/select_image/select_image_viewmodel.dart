import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:smartnote/app/app.locator.dart';
import 'package:smartnote/app/app.logger.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class SelectImageViewModel extends BaseViewModel {
  final _snackbarService = locator<SnackbarService>();
  final log = getLogger('SelectImageViewModel');
  File? _image;

  Future<void> getImageFromGallery() async {
    final picker = ImagePicker();
    final XFile? pickedImage = await picker.pickImage(source: ImageSource.gallery);
   
      if (pickedImage != null) {
        _image = File(pickedImage.path);
        notifyListeners();
      } else {
        _snackbarService.showSnackbar(
          message: 'No image selected',
          duration: const Duration(seconds: 1),
        );
      }
      log.i('Image: $_image');
  }

  Future<void> getImageFromCamera()async{
    final picker = ImagePicker();
    final XFile? pickedImage = await picker.pickImage(source: ImageSource.camera);
    
   
      if (pickedImage != null) {
        _image = File(pickedImage.path);
        notifyListeners();
      } else {
        _snackbarService.showSnackbar(
          message: 'No image selected',
          duration: const Duration(seconds: 1),
        );
      }
      log.i('Image: $_image');
  }
    
  
  


}
