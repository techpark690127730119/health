import 'package:hooks_riverpod/hooks_riverpod.dart';
// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:health_plans/exercise/provider/exercise_provider.dart';

import '../../../common/const/colors.dart';
import '../../../common/layout/default_layout.dart';
import '../../../common/utils/form_utils.dart';
import '../../../common/view/component/custom_text_form_field.dart';
import '../../../common/view/component/screen_util_text.dart';

class AddExerciseScreen extends HookConsumerWidget {
  final String part;

  AddExerciseScreen({
    super.key,
    required this.part,
  });

  static const String PATH = "/exercise_screen/add_exercise_screen";
  static const String ROUTE_NAME = "AddExerciseScreen";

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  void addExcercise(
    BuildContext context,
    WidgetRef ref, {
    required TextEditingController textEditingController,
  }) {
    ref.read(formSubmitHelperProvider).submitForm(
          formKey: formKey,
          onSubmit: () {
            ref.read(exerciseProvider.notifier).addExercise(
                  part: part,
                  newExercise: ref.read(exerciseValidatorProvider).exercise,
                );
            context.pop();
          },
        );
  }

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
        child: CustomTextFormField(
          hintText: "운동",
          validator: ref
              .read(
                exerciseValidatorProvider,
              )
              .validate,
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
            "$part 운동 추가",
            size: 24,
            weight: FontWeight.w700,
          ),
          GestureDetector(
            onTap: () => addExcercise(
              context,
              ref,
              textEditingController: textEditingController,
            ),
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
