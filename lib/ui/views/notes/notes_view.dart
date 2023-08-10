import 'package:flutter/material.dart';
import 'package:smartnote/ui/common/app_colors.dart';
import 'package:smartnote/ui/common/ui_helpers.dart';
import 'package:smartnote/ui/views/focused_menu/focused_menu_handler.dart';
import 'package:smartnote/ui/widgets/common/loader/loader.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'notes_viewmodel.dart';

class NotesView extends StatelessWidget {
  const NotesView({Key? key}) : super(key: key);

  @override
  Widget build(
    BuildContext context,
  ) {
    ScrollController scrollController = ScrollController();
    return ViewModelBuilder<NotesViewModel>.reactive(
      builder: (context, viewModel, child) {
        return Scaffold(
            // backgroundColor: Theme.of(context).colorScheme.background,
            body: Container(
              height: screenHeight(context),
              decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/background.png'),
                    fit: BoxFit.cover),
              ),
              child: SingleChildScrollView(
                // controller: scrollController,
                physics: const BouncingScrollPhysics(),
                child: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Text(
                          DateTime.now().hour < 12
                              ? 'Good Morning 👋'
                              : DateTime.now().hour < 17
                                  ? 'Good Afternoon 👋'
                                  : 'Good Evening 👋',
                          style: Theme.of(context).textTheme.headlineMedium,
                        ),
                        if (viewModel.isBusy) const Loader(),
                        if (viewModel.hasError)
                          Text(
                            viewModel.error.toString(),
                            style: const TextStyle(color: Colors.red),
                          ),
                        if (viewModel.data == null && viewModel.dataReady)
                          const Center(child: Text('No notes added yet')),
                        if (viewModel.dataReady)
                          MasonryGridView.builder(
                            controller: scrollController,
                            shrinkWrap: true,
                            gridDelegate:
                                const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2),
                            itemBuilder: (context, index) {
                              return FocusedMenuHandler(
                                menuContent: Column(
                                  children: [
                                    ListTile(
                                      onTap: () {
                                        viewModel.copyText(viewModel
                                            .data.docs[index]['plainText']);
                                       
                                      },
                                      title: const Text('Copy'),
                                      trailing: const Icon(Icons.copy),
                                    ),
                                    const Divider(
                                        color: Colors.blueGrey, height: 5.0),
                                    const ListTile(
                                      title: Text('Delete'),
                                      trailing: Icon(Icons.delete_forever),
                                    ),
                                    const Divider(
                                        color: Colors.blueGrey, height: 5.0),
                                    const ListTile(
                                      title: Text('Share'),
                                      trailing: Icon(Icons.share),
                                    ),
                                    const Divider(
                                        color: Colors.blueGrey, height: 5.0),
                                    const ListTile(
                                      title: Text('Edit'),
                                      trailing: Icon(Icons.edit),
                                    ),
                                    const Divider(
                                        color: Colors.blueGrey, height: 5.0),
                                  ],
                                ),
                                child: GestureDetector(
                                  child: Card(
                                    child: ListTile(
                                      onTap: () {
                                        viewModel.navigateToEditNoteView(
                                            viewModel.data.docs[index]);
                                      },
                                      tileColor: viewModel.getCategoryColor(
                                          viewModel.data.docs[index]
                                              ['category']),
                                      title: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          viewModel.data.docs[index]
                                              ['plainText'],
                                          maxLines: 10,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      titleTextStyle:
                                          Theme.of(context).textTheme.bodyLarge,
                                      subtitle: Text(
                                          'Category:${viewModel.data.docs[index]['category']}'),
                                      subtitleTextStyle: Theme.of(context)
                                          .textTheme
                                          .labelSmall,
                                      // onTap: () {},
                                    ),
                                  ),
                                ),
                              );
                            },
                            itemCount: viewModel.data.docs.length,
                          )
                      ],
                    ),
                  ),
                ),
              ),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                viewModel.navigateToCreateNoteView();
              },
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              backgroundColor: kcButtonColor,
              child: const Icon(Icons.add),
            ));
      },
      viewModelBuilder: () => NotesViewModel(),
    );
  }
}
