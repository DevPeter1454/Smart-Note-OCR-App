import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:smartnote/ui/common/app_colors.dart';
import 'package:smartnote/ui/views/chats/chats_view.dart';
import 'package:smartnote/ui/views/notes/notes_view.dart';
import 'package:smartnote/ui/views/profile/profile_view.dart';
import 'package:stacked/stacked.dart';

import 'home_viewmodel.dart';

class HomeView extends StackedView<HomeViewModel> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    HomeViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: PageTransitionSwitcher(
        duration: const Duration(milliseconds: 300),
        reverse: viewModel.reverse,
        transitionBuilder: (
          Widget child,
          Animation<double> animation,
          Animation<double> secondaryAnimation,
        ) {
          return SharedAxisTransition(
            animation: animation,
            secondaryAnimation: secondaryAnimation,
            transitionType: SharedAxisTransitionType.horizontal,
            child: child,
          );
        },
        child: getViewForIndex(viewModel.currentIndex),
      ),
      bottomNavigationBar: AnimatedBottomNavigationBar(
          activeColor: kcButtonColor,
          icons: getIconList(),
          activeIndex: viewModel.currentIndex,
          // blurEffect: true,
          elevation: 0.0,
          gapLocation: GapLocation.none,
          notchSmoothness: NotchSmoothness.defaultEdge,
          onTap: (value) => viewModel.setIndex(value)),
    );
  }

  @override
  HomeViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      HomeViewModel();

  Widget getViewForIndex(int index) {
    switch (index) {
      case 0:
        return const NotesView();
      case 1:
        return const ChatsView();
      case 2:
        return const ProfileView();
      default:
        return const NotesView();
    }
  }

  List<IconData> getIconList() {
    final List<IconData> iconList = [Icons.notes, Icons.chat, Icons.person];
    return iconList;
  }
}
