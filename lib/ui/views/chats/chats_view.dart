import 'package:flutter/material.dart';
import 'package:smartnote/models/chat_model.dart';
import 'package:smartnote/ui/common/ui_helpers.dart';
import 'package:smartnote/ui/widgets/common/chat_widget/chat_bubble.dart';
import 'package:smartnote/ui/widgets/common/chat_widget/chat_textfeild.dart';
import 'package:smartnote/ui/widgets/common/loader/loader.dart';
import 'package:stacked/stacked.dart';

import 'chats_viewmodel.dart';

class ChatsView extends StatelessWidget {
  const ChatsView({Key? key}) : super(key: key);

  @override
  Widget build(
    BuildContext context,
  ) {
    return ViewModelBuilder<ChatsViewModel>.reactive(
      onViewModelReady: (viewModel) => viewModel.init(),
      builder: (context, viewModel, child) {
        return Scaffold(
          // backgroundColor: Theme.of(context).colorScheme.background,
          body: Column(
            children: [
              Flexible(
                child: Container(
                  height: screenHeight(context),
                  width: screenWidth(context),
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/images/background.png'),
                        fit: BoxFit.cover),
                  ),
                  child: viewModel.isBusy
                      ? const Loader()
                      : Builder(
                          builder: (context) {
                            if (viewModel.isBusy) {
                              return const Loader();
                            }
                            if (viewModel.hasError) {
                              return Text(
                                viewModel.error.toString(),
                                style: const TextStyle(color: Colors.red),
                              );
                            }
                            if (viewModel.data == null && viewModel.dataReady) {
                              return const Center(
                                  child: Text('No notes added yet'));
                            }
                            if (viewModel.dataReady) {
                              return ListView.builder(
                                shrinkWrap: true,
                                physics: const BouncingScrollPhysics(),
                                itemBuilder: (context, index) {
                                  final data = viewModel.data.docs[index];
                                  ChatModel chatModel = ChatModel(
                                    prompt: data['prompt'] ?? '',
                                    response: data['response'] ?? '',
                                    createTime: data['createTime'] != null
                                        ? data['createTime'].toString()
                                        : '',
                                  );
                                  return ChatBubble(
                                    chat: chatModel,
                                    profileInitial:
                                        viewModel.profileInitial![0],
                                  );
                                },
                                itemCount: viewModel.data.docs.length,
                              );
                            }

                            return const Loader();
                          },
                        ),
                ),
              ),
              BottomTextField(
                onPressed: () {
                  viewModel.addChat();
                },
                txt: viewModel.promptController,
              ),
            ],
          ),
        );
      },
      viewModelBuilder: () => ChatsViewModel(),
    );
  }
}
