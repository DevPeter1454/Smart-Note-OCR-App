import 'package:flutter/material.dart';
import 'package:smartnote/ui/common/text_validators.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';

import 'signup_viewmodel.dart';
import 'package:smartnote/ui/views/signup/signup_view.form.dart';

@FormView(fields: [
  FormTextField(name: 'email', validator: TextValidators.validateEmail),
  FormTextField(name: 'password', validator: TextValidators.validatePassword),
  FormTextField(
    name: 'displayName',
  )
])
class SignupView extends StackedView<SignupViewModel> with $SignupView {
  const SignupView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    SignupViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Container(
        padding: const EdgeInsets.only(left: 25.0, right: 25.0),
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
