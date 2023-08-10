import 'package:flutter/material.dart';
import 'package:smartnote/ui/common/app_colors.dart';
import 'package:smartnote/ui/common/app_strings.dart';
import 'package:smartnote/ui/common/text_validators.dart';
import 'package:smartnote/ui/common/ui_helpers.dart';
import 'package:smartnote/ui/widgets/common/custom_button/custom_button.dart';
import 'package:smartnote/ui/widgets/common/custom_textfield/custom_textfield.dart';
import 'package:smartnote/ui/widgets/common/loader/loader.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';

import 'signup_viewmodel.dart';
import 'package:smartnote/ui/views/signup/signup_view.form.dart';

@FormView(
  fields: [
    FormTextField(name: 'email', validator: TextValidators.validateEmail),
    FormTextField(name: 'password', validator: TextValidators.validatePassword),
    FormTextField(
        name: 'displayName', validator: TextValidators.validateDisplayName)
  ],
  autoTextFieldValidation: false,
)
class SignupView extends StackedView<SignupViewModel> with $SignupView {
  const SignupView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    SignupViewModel viewModel,
    Widget? child,
  ) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        body: SafeArea(
          top: true,
          child: Align(
            alignment: const AlignmentDirectional(0, -1),
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Container(
                height: screenHeight(context),
                width: screenWidth(context),
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/background.png'),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Stack(
                  children: [
                    Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Padding(
                          padding:
                              const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                          child: Container(
                            width: double.infinity,
                            constraints: const BoxConstraints(
                              maxWidth: 570,
                            ),
                            decoration: const BoxDecoration(
                                // color: Theme.of(context).colorScheme.background,
                                ),
                            child: Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  20, 0, 20, 0),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding:
                                        const EdgeInsetsDirectional.fromSTEB(
                                            0, 0, 0, 5),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Image.asset(
                                          'assets/images/pen-logo.png',
                                          width: 50,
                                          height: 100,
                                          fit: BoxFit.fitWidth,
                                        )
                                      ],
                                    ),
                                  ),
                                  Text(
                                    ksSignUpViewWelcomeText,
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineLarge,
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsetsDirectional.fromSTEB(
                                            0, 4, 0, 0),
                                    child: Text(
                                      ksSignUpViewWelcomeSubtitle,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall!
                                          .copyWith(color: kcMediumGrey),
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsetsDirectional.fromSTEB(
                                            0, 16, 0, 0),
                                    child: CustomTextfield(
                                      controller: emailController,
                                      labelText: ksEmailControllerLabel,
                                      hintText: ksEmailControllerHintText,
                                      textInputType: TextInputType.emailAddress,
                                      // validator: TextValidators.validateEmail,
                                    ),
                                  ),
                                  if (viewModel.hasEmailValidationMessage) ...[
                                    // verticalSpaceTiny,
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 4.0, horizontal: 8.0),
                                      child: Text(
                                        viewModel.emailValidationMessage!,
                                        style: const TextStyle(
                                          color: Colors.red,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ),
                                  ],
                                  //Password
                                  Padding(
                                    padding:
                                        const EdgeInsetsDirectional.fromSTEB(
                                            0, 16, 0, 0),
                                    child: CustomTextfield(
                                      controller: passwordController,
                                      labelText: ksPasswordControllerLabel,
                                      hintText: ksPasswordControllerHintText,
                                      textInputType:
                                          TextInputType.visiblePassword,
                                      isPassword: true,
                                      // validator: ,
                                    ),
                                  ),
                                  if (viewModel
                                      .hasPasswordValidationMessage) ...[
                                    // verticalSpaceTiny,
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        viewModel.passwordValidationMessage!,
                                        style: const TextStyle(
                                          color: Colors.red,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ),
                                  ],
                                  //display name
                                  Padding(
                                    padding:
                                        const EdgeInsetsDirectional.fromSTEB(
                                            0, 16, 0, 0),
                                    child: CustomTextfield(
                                      controller: displayNameController,
                                      labelText: ksDisplayNameController,
                                      hintText: ksDisplayNameControllerHintText,
                                      textInputType:
                                          TextInputType.visiblePassword,

                                      // validator: ,
                                    ),
                                  ),
                                  if (viewModel
                                      .hasDisplayNameValidationMessage) ...[
                                    // verticalSpaceTiny,
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        viewModel.displayNameValidationMessage!,
                                        style: const TextStyle(
                                          color: Colors.red,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ),
                                  ],
                                  Padding(
                                    padding:
                                        const EdgeInsetsDirectional.fromSTEB(
                                            0, 16, 0, 0),
                                    child: Center(
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          CustomButton(
                                              onPressed:
                                                  viewModel.createAccount,
                                              backgroundColor: kcButtonColor,
                                              text: ksSignUpButtonText,
                                              size: Size(
                                                  thirdScreenWidth(context),
                                                  50),
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .labelLarge!
                                                  .copyWith(
                                                      color: Colors.white)),
                                        ],
                                      ),
                                    ),
                                  ),
                                  verticalSpaceLarge,
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Text(
                                        ksAlreadyHaveAccount,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyLarge,
                                      ),
                                      InkWell(
                                        onTap: viewModel.navigateToLogin,
                                        child: Text(
                                          ksLoginText,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyLarge!
                                              .copyWith(color: kcTertiaryColor),
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    if (viewModel.isBusy) const Loader()
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void onViewModelReady(SignupViewModel viewModel) {
    syncFormWithViewModel(viewModel);
  }

  @override
  SignupViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      SignupViewModel();
}
