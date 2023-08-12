import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:smartnote/ui/common/app_colors.dart';
import 'package:smartnote/ui/common/ui_helpers.dart';
import 'package:smartnote/ui/views/profile/profile_view.form.dart';
import 'package:smartnote/ui/widgets/common/custom_textfield/custom_textfield.dart';
import 'package:smartnote/ui/widgets/common/loader/loader.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';

import 'profile_viewmodel.dart';

@FormView(fields: [
  FormTextField(name: 'name'),
  FormTextField(name: 'email'),
  FormTextField(name: 'password'),
])
class ProfileView extends StackedView<ProfileViewModel> with $ProfileView {
  const ProfileView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    ProfileViewModel viewModel,
    Widget? child,
  ) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
          body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: SingleChildScrollView(
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
                : Column(
                    children: [
                      verticalSpaceLarge,
                      AvatarGlow(
                        endRadius: 90,
                        duration: const Duration(seconds: 2),
                        glowColor: kcButtonColor,
                        repeat: true,
                        repeatPauseDuration: const Duration(seconds: 1),
                        startDelay: const Duration(seconds: 1),
                        child: Stack(
                          clipBehavior: Clip.none,
                          children: [
                            Material(
                                elevation: 8.0,
                                shape: const CircleBorder(
                                    side: BorderSide(
                                        color: kcButtonColor, width: 2)),
                                child: CircleAvatar(
                                  backgroundColor: Colors.grey[100],
                                  radius: 80.0,
                                  backgroundImage: viewModel.photoUrl != null
                                      ? NetworkImage(
                                          viewModel.photoUrl!,
                                        )
                                      : null,
                                  child: viewModel.photoUrl == null
                                      ? Text(viewModel.profileInitial![0],
                                          style: Theme.of(context)
                                              .textTheme
                                              .headlineMedium!
                                              .copyWith(
                                                  color: kcButtonColor,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 50))
                                      : null,
                                )),
                            Positioned(
                              bottom: 1.0,
                              right: 10.0,
                              child: CircleAvatar(
                                radius: 20,
                                backgroundColor: kcButtonColor,
                                child: IconButton.filled(
                                    // color: kcButtonColor,
                                    onPressed: viewModel.pickImages,
                                    icon: const Icon(Icons.camera_alt_rounded)),
                              ),
                            )
                          ],
                        ),
                      ),
                      verticalSpaceMedium,
                      CustomTextfield(
                        controller: nameController,
                        labelText: 'Display name',
                      ),
                      verticalSpaceMedium,
                      CustomTextfield(
                        controller: emailController,
                        labelText: 'Email',
                      ),
                      verticalSpaceMedium,
                      CustomTextfield(
                        controller: passwordController,
                        labelText: 'Password',
                      ),
                      verticalSpaceMedium,
  
                    ],
                  ),
          ),
        ),
      )),
    );
  }

  @override
  ProfileViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      ProfileViewModel();

  @override
  void onViewModelReady(ProfileViewModel viewModel) => viewModel.init();
}
