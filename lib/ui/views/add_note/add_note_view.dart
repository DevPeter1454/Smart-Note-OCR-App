import 'package:flutter/material.dart';
import 'package:smartnote/ui/common/app_colors.dart';
import 'package:smartnote/ui/common/ui_helpers.dart';
import 'package:smartnote/ui/widgets/common/custom_back_button/custom_back_button.dart';
import 'package:smartnote/ui/widgets/common/loader/loader.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter_quill/flutter_quill.dart' hide Text;
import 'add_note_viewmodel.dart';
import 'package:chips_choice/chips_choice.dart';

class AddNoteView extends StatelessWidget {
  const AddNoteView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
        onViewModelReady: (viewModel) => viewModel.init(),
        builder: (context, viewModel, child) {
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
                    title: Text(
                      viewModel.title,
                      style: const TextStyle(color: Colors.black),
                    ),
                    centerTitle: true,
                    actions: [
                      IconButton(
                        icon: const Icon(
                          Icons.check,
                          color: Colors.black,
                        ),
                        onPressed: () {
                          FocusScope.of(context).unfocus();
                          viewModel.saveNote();
                        },
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
                          SizedBox(
                            height: 60,
                            child: ChipsChoice<int>.single(
                                choiceStyle: C2ChipStyle.filled(
                                  selectedStyle: C2ChipStyle(
                                    backgroundColor:
                                        viewModel.optionColors[viewModel.tag],
                                    backgroundOpacity: 0.25,
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(25),
                                    ),
                                    height: 30,
                                  ),
                                ),
                                value: viewModel.tag,
                                choiceItems: C2Choice.listFrom<int, String>(
                                  source: viewModel.options,
                                  value: (i, v) => i,
                                  label: (i, v) => v,
                                  avatarText: (index, item) => Icon(
                                    viewModel.optionIcons[index],
                                    color: viewModel.optionColors[index],
                                    size: 16,
                                  ),
                                ),
                                // choiceStyle: C2ChipStyle(),
                                onChanged: (val) =>
                                    viewModel.setSelectedCategory(val)),
                          )
                        ],
                      ),
                      if (viewModel.isBusy) const Loader()
                    ],
                  )),
            ),
          );
        },
        viewModelBuilder: () => AddNoteViewModel());
  }
}
