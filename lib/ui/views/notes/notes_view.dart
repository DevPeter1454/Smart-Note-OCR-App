import 'package:flutter/material.dart';
import 'package:smartnote/ui/common/app_colors.dart';
import 'package:smartnote/ui/common/ui_helpers.dart';
import 'package:stacked/stacked.dart';

import 'notes_viewmodel.dart';

class NotesView extends StackedView<NotesViewModel> {
  const NotesView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    NotesViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
        // backgroundColor: Theme.of(context).colorScheme.background,
        body: SingleChildScrollView(
          child: Container(
            height: screenHeight(context),
            width: screenWidth(context),
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/background.png'),
                  fit: BoxFit.cover),
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            // viewModel.navigateToCreateNoteView();
          },
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          backgroundColor: kcButtonColor,
          child: const Icon(Icons.add),
        ));
  }

  @override
  NotesViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      NotesViewModel();
}
