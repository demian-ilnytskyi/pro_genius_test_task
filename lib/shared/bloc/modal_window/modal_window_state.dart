part of 'modal_window_bloc.dart';

@freezed
sealed class ModalWindowState with _$ModalWindowState {
  const factory ModalWindowState({
    required double height,
    required double dragBarHeight,
    required double maxWebViewHeight,
    double? screenHeight,
  }) = _ModalWindowState;
}
