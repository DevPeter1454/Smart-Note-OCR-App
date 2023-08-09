import 'package:flutter/material.dart';
import 'package:smartnote/ui/common/app_colors.dart';
import 'package:smartnote/ui/common/ui_helpers.dart';
import 'package:smartnote/ui/widgets/common/custom_back_button/custom_back_button.dart';
import 'package:smartnote/ui/widgets/common/loader/loader.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter_quill/flutter_quill.dart' hide Text;
import 'add_note_viewmodel.dart';

class AddNoteView extends StackedView<AddNoteViewModel> {
  AddNoteView({Key? key}) : super(key: key);

  final FocusNode focusNode = FocusNode();
  @override
  Widget builder(
    BuildContext context,
    AddNoteViewModel viewModel,
    Widget? child,
  ) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: WillPopScope(
        onWillPop: viewModel.onWillPop,
        child: Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0.5,
              leading: Padding(
                padding: const EdgeInsets.all(8.0),
                child: CustomBackButton(onPressed: viewModel.pop),
              ),
              title: const Text(
                'Add Note',
                style: TextStyle(color: Colors.black),
              ),
              centerTitle: true,
              actions: [
                IconButton(
                  icon: const Icon(
                    Icons.check,
                    color: Colors.black,
                  ),
                  onPressed: viewModel.addNote,
                ),
              ],
            ),
            body: Stack(
              children: [
                Column(
                  children: [
                    verticalSpaceSmall,
                    QuillToolbar.basic(
                      controller: viewModel.notesController,
                      showFontFamily: false,
                      showFontSize: false,
                      showHeaderStyle: false,
                      showSearchButton: false,
                      showColorButton: false,
                      showBackgroundColorButton: false,
                      showLink: false,
                      showUnderLineButton: false,
                      showListCheck: true,
                      showQuote: false,
                      showStrikeThrough: false,
                      showDividers: false,
                      showIndent: false,
                      showClearFormat: false,
                      customButtons: const [
                        QuillCustomButton(
                          icon: Icons.delete,
                          // onTap: viewModel.clearNotes,
                        ),
                      ],
                      iconTheme: const QuillIconTheme(
                        borderRadius: 12,
                        iconSelectedFillColor: kcPrimaryColor,
                        iconUnselectedFillColor: kcPrimaryColor,
                      ),
                      multiRowsDisplay: false,
                    ),
                    Expanded(
                      child: QuillEditor(
                        controller: viewModel.notesController,
                        focusNode: FocusNode(),
                        scrollController: ScrollController(),
                        readOnly: false,
                        scrollable: true,
                        expands: false,
                        padding: const EdgeInsets.all(8.0),
                        autoFocus: false,
                        showCursor: true,
                        placeholder: 'Start typing here...',
                      ),
                    ),
                  ],
                ),
                if (viewModel.isBusy) const Loader()
              ],
            )),
      ),
    );
  }

  @override
  AddNoteViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      AddNoteViewModel();
}
