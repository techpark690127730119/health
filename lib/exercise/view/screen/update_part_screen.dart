import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../common/const/colors.dart';
import '../../../common/layout/default_layout.dart';
import '../../../common/utils/form_utils.dart';
import '../../../common/view/component/custom_text_form_field.dart';
import '../../../common/view/component/screen_util_text.dart';
import '../../provider/exercise_provider.dart';

class UpdatePartScreen extends ConsumerWidget {
  const UpdatePartScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DefaultLayout(
      appBar: _renderAppBar(context: context, ref: ref),
      child: Form(
        key: formKey1,
        child: Column(
          children: [
            CustomTextFormField(
              hintText: ref.read(exerciseProvider).partData!.part,
              validator: ref.read(partValidatorProvider).validate,
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
            ref.read(exerciseProvider).partData!.part,
            size: 24,
            weight: FontWeight.w700,
          ),
          GestureDetector(
            onTap: () {
              ref.read(formSubmitHelperProvider).submitForm(
                    formKey: formKey1,
                    onSubmit: () {
                      ref.read(exerciseProvider.notifier).updatePart(
                            id: ref.read(exerciseProvider).partData!.id,
                            newPart: ref.read(partValidatorProvider).part,
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
