import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:small_business_app/configuration/colors.dart';
import 'package:small_business_app/cubit/ideas_cubit/ideas_cubit.dart';
import 'package:small_business_app/widget/custom_button_click.dart';
import 'package:small_business_app/widget/custom_text_file.dart';

class AddIdeasBottomSheet extends StatelessWidget {
  const AddIdeasBottomSheet({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> formKey = GlobalKey();
    TextEditingController title = TextEditingController();
    TextEditingController description = TextEditingController();
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: backgroundColor,
      ),
      child: Padding(
        padding: EdgeInsets.only(
            left: 16,
            right: 16,
            bottom: MediaQuery.of(context).viewInsets.bottom),
        child: SingleChildScrollView(
            child: Form(
          key: formKey,
          child: Column(
            children: [
              const SizedBox(
                height: 32,
              ),
              CustomTextFiled(
                hint: 'العنوان',
                controller: title,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'هذا الحقل مطلوب';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 16,
              ),
              CustomTextFiled(
                hint: 'الوصف',
                maxLine: 5,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'هذا الحقل مطلوب';
                  }
                  return null;
                },
                controller: description,
              ),
              const SizedBox(
                height: 32,
              ),
              BlocConsumer<IdeasCubit, IdeasState>(
                listener: (context, state) {
                  if (state is PostIdeaSuccessState) {
                    Navigator.pop(context);
                  }
                },
                builder: (context, state) {
                  return CustomButtonClick(
                    isLoading: state is PostIdeaStateLoadingState,
                    onTap: () async {
                      if (formKey.currentState!.validate()) {
                        await IdeasCubit.get(context).postIdea(
                            title: title.text, description: description.text);
                      }
                    },
                    sizeWidth: MediaQuery.sizeOf(context).width,
                    title: 'انشاء',
                  );
                },
              ),
              const SizedBox(
                height: 16,
              ),
            ],
          ),
        )),
      ),
    );
  }
}
