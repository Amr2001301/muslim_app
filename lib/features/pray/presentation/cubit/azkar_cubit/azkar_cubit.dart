import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:muslim_app/features/pray/domain/entitiy/azkar_entity.dart/azkar_entity.dart';
import 'package:muslim_app/features/pray/domain/repo/azkar_repo.dart';
part 'azkar_state.dart';

class AzkarCubit extends Cubit<AzkarState> {
  AzkarCubit(this.azkarRepo) : super(AzkarInitial());
  final AzkarRepo azkarRepo;

  Future<void> getAzkar({required String azkarName}) async {
    emit(AzkarLoading());
    final failureOrAzkar = await azkarRepo.getAzkar(azkarName: azkarName);
    failureOrAzkar.fold(
      (failure) => emit(AzkarFailure(message: failure)),
      (azkar) => emit(AzkarSuccess(azkarEntity: azkar)),
    );
  }
}
