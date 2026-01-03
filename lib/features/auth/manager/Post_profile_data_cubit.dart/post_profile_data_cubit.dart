import 'package:bloc/bloc.dart';
import 'package:foods_app/features/auth/data/model/post_profile_data_model.dart';
import 'package:foods_app/features/auth/data/repo/repo.dart';

part 'post_profile_data_state.dart';

class PostProfileDataCubit extends Cubit<PostProfileDataState> {
  final Repo repo;

  PostProfileDataCubit(this.repo) : super(PostProfileDataInitial());

  Future<void> postProfileData({
    required String token,
    required String email,
    String? name,
    String? address,
    String? phone,
    String? imagePath,
  }) async {
    if (isClosed) return;

    emit(PostProfileDataLoading());

    final result = await repo.postProfileData(
      token: token,
      email: email,
      name: name,
      address: address,
      phone: phone,
      imagePath: imagePath,
    );

    if (isClosed) return;

    result.fold(
      (failure) {
        emit(
          PostProfileDataFailure(
            errorMessage: failure.errMessage,
          ),
        );
      },
      (response) {
        emit(
          PostProfileDataSuccess(
            response: response,
          ),
        );
      },
    );
  }
}
