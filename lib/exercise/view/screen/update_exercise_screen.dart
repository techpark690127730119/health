import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:health_plans/exercise/provider/exercise_provider.dart';

import '../../../common/const/colors.dart';
import '../../../common/layout/default_layout.dart';
import '../../../common/utils/form_utils.dart';
import '../../../common/view/component/custom_text_form_field.dart';
import '../../../common/view/component/screen_util_text.dart';

class UpdateExerciseScreen extends ConsumerWidget {
  const UpdateExerciseScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DefaultLayout(
      appBar: _renderAppBar(context: context, ref: ref),
      child: Form(
        key: formKey1,
        child: Column(
          children: [
            CustomTextFormField(
              hintText: ref.read(exerciseProvider).exercise!.exercise,
              validator: ref.read(exerciseValidatorProvider).validate,
            ),
          ],
        ),
      ),
    );
  }

  PreferredSizeWidget _renderAppBar({
    required BuildContext context,
    required WidgetRef ref,
  }) {
    return AppBar(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ScreenUtilText(
            ref.read(exerciseProvider).exercise!.exercise,
            size: 24,
            weight: FontWeight.w700,
          ),
          GestureDetector(
            onTap: () {
              ref.read(formSubmitHelperProvider).submitForm(
                    formKey: formKey1,
                    onSubmit: () {
                      ref.read(exerciseProvider.notifier).updateExercisse(
                            newExercise:
                                ref.read(exerciseValidatorProvider).exercise,
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
