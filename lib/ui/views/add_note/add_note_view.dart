import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'add_note_viewmodel.dart';

class AddNoteView extends StackedView<AddNoteViewModel> {
  const AddNoteView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    AddNoteViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Container(
        padding: const EdgeInsets.only(left: 25.0, right: 25.0),
      ),
    );
  }

  @override
  AddNoteViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      AddNoteViewModel();
}
