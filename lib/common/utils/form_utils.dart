import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

GlobalKey<FormState> formKey1 = GlobalKey<FormState>();

final partValidatorProvider = Provider<PartValidator>((ref) {
  return PartValidator();
});

final exerciseValidatorProvider = Provider<ExerciseValidator>((ref) {
  return ExerciseValidator();
});

final formSubmitHelperProvider = Provider<FormSubmitHelper>((ref) {
  return FormSubmitHelper();
});

class FormUtils {}

class PartValidator extends FormUtils {
  String part = "";

  String? validate(String? value) {
    if (value == null) {
      return "추가할 부위를 입력해 주세요.";
    } else if (value.isEmpty) {
      return "추가할 부위를 입력해 주세요.";
    } else {
      part = value.trim();
      return null;
    }
  }
}

class ExerciseValidator extends FormUtils {
  String exercise = "";

  String? validate(String? value) {
    if (value == null) {
      return "추가할 부위를 입력해 주세요.";
    } else if (value.isEmpty) {
      return "추가할 부위를 입력해 주세요.";
    } else {
      exercise = value.trim();
      return null;
    }
  }
}

class FormSubmitHelper extends FormUtils {
  void submitForm({
    required GlobalKey<FormState> formKey,
    required void Function() onSubmit,
  }) {
    final bool? isValidForm = formKey.currentState?.validate();

    if (isValidForm!) {
      onSubmit();
    }
  }
}
