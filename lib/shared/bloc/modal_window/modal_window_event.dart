part of 'modal_window_bloc.dart';

@freezed
sealed class ModalWindowEvent with _$ModalWindowEvent {
  const factory ModalWindowEvent.changeSize(double height) = _ChangeSize;
  const factory ModalWindowEvent.setScreenScreenHeight({
    required double screenHeight,
    required double topPadding,
  }) = _SetScreenScreenHeight;
  const factory ModalWindowEvent.setHeighState() = _SetHeighState;
  const factory ModalWindowEvent.hide() = _Hide;
}
