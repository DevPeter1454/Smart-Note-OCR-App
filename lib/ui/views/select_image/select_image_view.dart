import 'package:flutter/material.dart';
import 'package:smartnote/ui/common/ui_helpers.dart';
import 'package:smartnote/ui/widgets/common/loader/loader.dart';
import 'package:stacked/stacked.dart';

import 'select_image_viewmodel.dart';

class SelectImageView extends StackedView<SelectImageViewModel> {
  const SelectImageView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    SelectImageViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      // backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: Text(
          'Select Image',
          style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                color: Theme.of(context).colorScheme.onBackground,
              ),
        ),
      ),
      body: Container(
        height: screenHeight(context),
                decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/images/background.png'),
                      fit: BoxFit.cover),
                ),
        padding: const EdgeInsets.only(left: 25.0, right: 25.0),
        child: Center(
          child: viewModel.isBusy?const Loader() : Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () => viewModel.getImageFromGallery(),
                child: const Text('Select Image from Gallery'),
              ),
              verticalSpaceMedium,
              ElevatedButton(
                onPressed: () => viewModel.getImageFromCamera(),
                child: const Text('Select Image from Camera'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  SelectImageViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      SelectImageViewModel();
}
