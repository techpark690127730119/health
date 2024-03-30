import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:health_plans/common/utils/snack_bar_util.dart';
import 'package:health_plans/exercise/state/exercise_state.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:health_plans/common/layout/default_layout.dart';
import 'package:health_plans/common/utils/form_utils.dart';
import 'package:health_plans/exercise/provider/exercise_provider.dart';
import '../../../common/const/colors.dart';
import '../../../common/view/component/custom_text_form_field.dart';
import '../../../common/view/component/screen_util_text.dart';

class AddPartScreen extends HookConsumerWidget {
  AddPartScreen({
    super.key,
  });

  static const String PATH = "/exercise_screen/add_part_screen";
  static const String ROUTE_NAME = "AddPartScreen";

  void addPart(
    BuildContext context,
    WidgetRef ref, {
    required TextEditingController textEditingController,
  }) {
    ref.read(formSubmitHelperProvider).submitForm(
          formKey: formKey,
          onSubmit: () {
            ref
                .read(exerciseNotifierProvider.notifier)
                .addPart(newPart: textEditingController.text.trim())
                .then((value) {
              if (value) {
                context.pop();
              }
            });
          },
        );
  }

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(exerciseNotifierProvider, (previous, next) {
      if (next is ExerciseError) {
        SnackBarUtils.snackBar(context, text: "잠시 후 다시 시도해 주세요");
      }
    });

    final TextEditingController textEditingController =
        useTextEditingController();

    return DefaultLayout(
      appBar: renderAppBar(
        context,
        ref,
        textEditingController: textEditingController,
      ),
      child: Form(
        key: formKey,
        child: CustomTextFormField(
          textEditingController: textEditingController,
          hintText: "부위",
          validator: ref.read(partValidatorProvider).validate,
        ),
      ),
    );
  }

  PreferredSizeWidget renderAppBar(
    BuildContext context,
    WidgetRef ref, {
    required TextEditingController textEditingController,
  }) {
    return AppBar(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const ScreenUtilText(
            "부위 추가",
            size: 24,
            weight: FontWeight.w700,
          ),
          GestureDetector(
            onTap: () => addPart(
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
