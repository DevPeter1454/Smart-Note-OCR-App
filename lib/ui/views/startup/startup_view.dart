import 'package:flutter/material.dart';
import 'package:smartnote/ui/views/home/home_view.dart';
import 'package:smartnote/ui/views/login/login_view.dart';
import 'package:smartnote/ui/views/notes/notes_view.dart';
import 'package:stacked/stacked.dart';

import 'startup_viewmodel.dart';

// class StartupView extends StackedView<StartupViewModel> {
//   const StartupView({Key? key}) : super(key: key);

//   @override
//   Widget builder(
//     BuildContext context,
//     StartupViewModel viewModel,
//     Widget? child,
//   ) {
//     return ViewModelBuilder<StartupViewModel>.reactive(
//       builder: (context, v) {
//         return const Scaffold(
//           body: Center(
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 Text(
//                   'STACKED',
//                   style: TextStyle(fontSize: 40, fontWeight: FontWeight.w900),
//                 ),
//                 Row(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     Text('Loading ...', style: TextStyle(fontSize: 16)),
//                     horizontalSpaceSmall,
//                     SizedBox(
//                       width: 16,
//                       height: 16,
//                       child: CircularProgressIndicator(
//                         color: Colors.black,
//                         strokeWidth: 6,
//                       ),
//                     )
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         );
//       }
//     );
//   }

//   @override
//   StartupViewModel viewModelBuilder(
//     BuildContext context,
//   ) =>
//       StartupViewModel();

//   @override
//   void onViewModelReady(StartupViewModel viewModel) => SchedulerBinding.instance
//       .addPostFrameCallback((timeStamp) => viewModel.runStartupLogic());
// }

// View
class StartupView extends StatelessWidget {
  const StartupView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<StartupViewModel>.reactive(
      builder: (context, viewModel, child) {
        if (viewModel.data != null) {
          return const HomeView();
        }
        return const LoginView();
      },
      viewModelBuilder: () => StartupViewModel(),
    );
  }
}
