import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:health_plans/drift/database/database.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../common/const/colors.dart';
import '../../../common/layout/default_layout.dart';
import '../../../common/utils/form_utils.dart';
import '../../../common/view/component/custom_text_form_field.dart';
import '../../../common/view/component/screen_util_text.dart';
import '../../provider/exercise_provider.dart';

class UpdatePartScreen extends HookConsumerWidget {
  final PartData partData;

  UpdatePartScreen({
    super.key,
    required this.partData,
  });

  static const String PATH = "/exercise_screen/update_part_screen";
  static const String ROUTE_NAME = "UpdatePartScreen";

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  void updatePart(
    BuildContext context,
    WidgetRef ref, {
    required TextEditingController textEditingController,
  }) {
    ref
        .read(
          formSubmitHelperProvider,
        )
        .submitForm(
          formKey: formKey,
          onSubmit: () {
            ref
                .read(
                  exerciseProvider.notifier,
                )
                .updatePart(
                  id: partData.id,
                  newPart: textEditingController.text.trim(),
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
        child: Column(
          children: [
            CustomTextFormField(
              textEditingController: textEditingController,
              hintText: partData.part,
              validator: ref.read(partValidatorProvider).validate,
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
            partData.part,
            size: 24,
            weight: FontWeight.w700,
          ),
          GestureDetector(
            onTap: () => updatePart(
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

class Test1 extends StatefulWidget {
  const Test1({super.key});

  @override
  State<Test1> createState() => _Test1State();
}

class _Test1State extends State<Test1> {
  final TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: textEditingController,
    );
  }

  @override
  void dispose() {
    super.dispose();
    textEditingController.dispose();
  }
}

class Test2 extends HookWidget {
  const Test2({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController textEditingController =
        useTextEditingController();

    return TextField(
      controller: textEditingController,
    );
  }
}
