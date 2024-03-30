import 'package:hooks_riverpod/hooks_riverpod.dart';
// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:health_plans/drift/database/database.dart';
import 'package:health_plans/exercise/provider/exercise_provider.dart';

import '../../../common/const/colors.dart';
import '../../../common/layout/default_layout.dart';
import '../../../common/utils/form_utils.dart';
import '../../../common/view/component/custom_text_form_field.dart';
import '../../../common/view/component/screen_util_text.dart';

class UpdateExerciseScreen extends HookConsumerWidget {
  final ExerciseData exerciseData;

  UpdateExerciseScreen({
    super.key,
    required this.exerciseData,
  });

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final TextEditingController textEditingController =
        useTextEditingController();

    return DefaultLayout(
      appBar: _renderAppBar(
        context,
        ref,
        textEditingController: textEditingController,
      ),
      child: Form(
        key: formKey,
        child: Column(
          children: [
            CustomTextFormField(
              textEditingController: textEditingController,
              hintText: exerciseData.exercise,
              validator: ref.read(exerciseValidatorProvider).validate,
            ),
          ],
        ),
      ),
    );
  }

  PreferredSizeWidget _renderAppBar(
    BuildContext context,
    WidgetRef ref, {
    required TextEditingController textEditingController,
  }) {
    return AppBar(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ScreenUtilText(
            exerciseData.exercise,
            size: 24,
            weight: FontWeight.w700,
          ),
          GestureDetector(
            onTap: () {
              ref.read(formSubmitHelperProvider).submitForm(
                    formKey: formKey,
                    onSubmit: () {
                      ref.read(exerciseNotifierProvider.notifier).updateExercisse(
                            exerciseData: exerciseData,
                            newExercise: textEditingController.text.trim(),
                          );
                      context.pop();
                    },
                  );
            },
            child: const ScreenUtilText(
              "완료",
              color: red,
              size: 18,
            ),
          ),
        ],
      ),
    );
  }
}
