import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:small_business_app/core/api/api_Consumer.dart';
import 'package:small_business_app/core/api/end_point.dart';
import 'package:small_business_app/core/cache/cache_helper.dart';
import 'package:small_business_app/models/profiled_model.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit(this.api) : super(ProfileInitial());
  static ProfileCubit get(context) => BlocProvider.of(context);
  final ApiConsumer api;
  var formKey = GlobalKey<FormState>();
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController address = TextEditingController();

  XFile? logo;

  uploadProfilePic() async {
    final ImagePicker picker = ImagePicker();

    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      logo = image;
    }

    emit(UploadProfilePicSuccessState());
  }

  postProfile() async {
    try {
      emit(PostProfileStateLoadingState());
      final response = await api.post(
          url: brandEndPoint,
          data: {
            'name': '..',
          },
          isFormData: true);
      CacheHelper().saveData(key: 'idBrand', value: response['idBrand']);

      await api.post(
          url: profiledEndPoint,
          data: {
            'brandID': CacheHelper().getData(key: 'idBrand'),
            'name': name,
            'logo': '', //await uploadImageToApi(logo!),
            'description': description,
            'phone': phone,
            'address': address,
            'email': email
          },
          isFormData: true);

      emit(PostProfileSuccessState());
    } catch (e) {
      emit(PostProfileErrorState(error: e.toString()));
    }
  }

  getProfile() async {
    try {
      emit(GetProfileStateLoadingState());

      var response = await api.get(
        url: profiledEndPoint,
      );

      ProfiledModel profiledModel = ProfiledModel.fromJson(response);
      List<Data> profiled = profiledModel.data ?? [];

      emit(GetProfileSuccessState(profiledModel: profiled));
    } catch (e) {
      emit(GetProfileErrorState(error: e.toString()));
    }
  }
}
