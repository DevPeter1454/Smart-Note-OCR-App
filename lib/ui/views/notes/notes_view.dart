import 'package:flutter/material.dart';
import 'package:smartnote/ui/common/app_colors.dart';
import 'package:smartnote/ui/common/ui_helpers.dart';
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
    return ViewModelBuilder<NotesViewModel>.reactive(
      builder: (context, viewModel, child) {
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
                child: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        if (viewModel.isBusy) const Loader(),
                        if (viewModel.hasError)
                          Text(
                            viewModel.error.toString(),
                            style: const TextStyle(color: Colors.red),
                          ),
                        if (viewModel.data == null)
                          const Text('No notes added yet'),
                        if (viewModel.dataReady)
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(DateTime.now().hour < 12
                                    ? 'Good Morning 👋'
                                    : 'Good Aftenoon'),
                                verticalSpaceSmall,
                                MasonryGridView.builder(
                                  shrinkWrap: true,
                                  gridDelegate:
                                      const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 2),
                                  itemBuilder: (context, index) {
                                    return Card(
                                      child: ListTile(
                                        title: Text(
                                          viewModel.data.docs[index]
                                              ['plainText'],
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium,
                                          maxLines: 10,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        onTap: () {},
                                      ),
                                    );
                                  },
                                  itemCount: viewModel.data.docs.length,
                                )
                              ],
                            ),
                          ),
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
