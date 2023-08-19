
import 'package:flutter/material.dart';
import 'package:hawk_fab_menu/hawk_fab_menu.dart';
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
      onViewModelReady: (viewModel) => viewModel.init(),
      builder: (context, viewModel, child) {
        return Scaffold(
            // backgroundColor: Theme.of(context).colorScheme.background,
            body: HawkFabMenu(
              icon: AnimatedIcons.menu_close,
              fabColor: kcButtonColor,
              
              iconColor: Colors.white,
              backgroundColor: Theme.of(context).colorScheme.background.withOpacity(0.2),
              openIcon: Icons.menu,
              closeIcon: Icons.close,
              items: [
                HawkFabMenuItem(label: 'Scan Note', ontap: viewModel.navigateToSelectImageVIew, icon: const Icon(Icons.camera_alt)),
                HawkFabMenuItem(label: 'Add Note', ontap: viewModel.navigateToCreateNoteView, icon: const Icon(Icons.add)),
                
              ],
              body: Container(
                height: screenHeight(context),
                decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/images/background.png'),
                      fit: BoxFit.cover),
                ),
                child: viewModel.isBusy
                    ? const Loader()
                    : SafeArea(
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
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      DateTime.now().hour < 12
                                          ? 'Good Morning, ${viewModel.name.split(' ').first} 👋'
                                          : DateTime.now().hour < 17
                                              ? 'Good Afternoon, ${viewModel.name.split(' ').first}👋'
                                              : 'Good Evening, ${viewModel.name.split(' ').first} 👋',
                                      style:
                                          Theme.of(context).textTheme.headlineMedium,
                                    ),
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
                                                  viewModel.copyText(viewModel.data
                                                      .docs[index]['plainText']);
                                                },
                                                title: const Text('Copy'),
                                                trailing: const Icon(Icons.copy),
                                              ),
                                              const Divider(
                                                  color: Colors.blueGrey,
                                                  height: 5.0),
                                              ListTile(
                                                onTap: () {
                                                  viewModel.deleteNote(viewModel
                                                      .data.docs[index].id);
                                                },
                                                title: const Text('Delete'),
                                                trailing: const Icon(
                                                    Icons.delete_forever),
                                              ),
                                              const Divider(
                                                  color: Colors.blueGrey,
                                                  height: 5.0),
                                              ListTile(
                                                onTap: () {
                                                  viewModel.shareContent(
                                                      context,
                                                      viewModel.data.docs[index]
                                                          ['plainText']);
                                                },
                                                title: const Text('Share'),
                                                trailing: const Icon(Icons.share),
                                              ),
                                              const Divider(
                                                  color: Colors.blueGrey,
                                                  height: 5.0),
                                              const ListTile(
                                                title: Text('Edit'),
                                                trailing: Icon(Icons.edit),
                                              ),
                                              const Divider(
                                                  color: Colors.blueGrey,
                                                  height: 5.0),
                                            ],
                                          ),
                                          child: GestureDetector(
                                            child: Card(
                                              child: ListTile(
                                                onTap: () {
                                                  viewModel.navigateToEditNoteView(
                                                      viewModel.data.docs[index]);
                                                },
                                                tileColor:
                                                    viewModel.getCategoryColor(
                                                        viewModel.data.docs[index]
                                                            ['category']),
                                                title: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Text(
                                                    viewModel.data.docs[index]
                                                        ['plainText'],
                                                    maxLines: 10,
                                                    overflow: TextOverflow.ellipsis,
                                                  ),
                                                ),
                                                titleTextStyle: Theme.of(context)
                                                    .textTheme
                                                    .bodyLarge,
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
              ),
            ),
            
            );
      },
      viewModelBuilder: () => NotesViewModel(),
    );
  }
}
