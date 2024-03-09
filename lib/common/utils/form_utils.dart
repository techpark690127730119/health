import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
  String? validate(String? value) {
    if (value == null) {
      return "추가할 부위를 입력해 주세요.";
    } else if (value.isEmpty) {
      return "추가할 부위를 입력해 주세요.";
    } else {
      return null;
    }
  }
}

class ExerciseValidator extends FormUtils {
  String exercise = "";

  String? validate(String? value) {
    if (value == null) {
      return "추가할 운동을 입력해 주세요.";
    } else if (value.isEmpty) {
      return "추가할 운동을 입력해 주세요.";
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
