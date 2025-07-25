import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
part 'setting_state.dart';

class SettingCubit extends Cubit<SettingState> {
  SettingCubit() : super(SettingInitial()) {
    scrollController.addListener(_onScroll);
  }
  ScrollController scrollController = ScrollController();
  Timer? timer;
  bool isVisiblBottomSheet = true;

  void startAnimatioScroll(int numberPages) {
    scrollController.animateTo(
      scrollController.position.maxScrollExtent,
      duration: Duration(seconds: numberPages * 43),
      curve: Curves.linear,
    );
  }

  void _onScroll() {
    if (isVisiblBottomSheet) {
      isVisiblBottomSheet = false;
      emit(AutomaticAnimationState(isAutomaticAnimation: false));
    }
    timer?.cancel();
    timer = Timer(const Duration(milliseconds: 300), () {
      isVisiblBottomSheet = true;
      emit(AutomaticAnimationState(isAutomaticAnimation: true));
    });
  }

  @override
  Future<void> close() {
    scrollController.dispose();
    return super.close();
  }
}
