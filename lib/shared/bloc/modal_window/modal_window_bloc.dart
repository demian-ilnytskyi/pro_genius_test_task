import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'modal_window_event.dart';
part 'modal_window_state.dart';
part 'modal_window_bloc.freezed.dart';

@injectable
class ModalWindowBloc extends Bloc<ModalWindowEvent, ModalWindowState> {
  ModalWindowBloc()
    : _widgetsBinding = WidgetsBinding.instance,
      super(
        const _ModalWindowState(
          height: minHeight,
          dragBarHeight: 0,
          maxWebViewHeight: 0,
          showCloseIcon: false,
          animationTime: 0,
        ),
      ) {
    on<_ChangeSize>(_onChangeSize);
    on<_SetScreenScreenHeight>(_onSetScreenScreenHeight);
    on<_SetHeighState>(_onSetHeighState);
    on<_Hide>(_onHide);
    _init();
  }
  final WidgetsBinding _widgetsBinding;

  static const _dragBarHeighScreenPercent = 0.1;
  static const _webViewHeighScreenPercent = 1;
  static const minHeight = 0.10;
  // in Miliseconds
  static const minAnimationTime = 100;
  // in Miliseconds
  static const maxAnimationTime = 500;
  final _webViewCenterHeightScreenPercent =
      (_webViewHeighScreenPercent - _dragBarHeighScreenPercent) / 2;

  int animationTimeValue(double newHeight) => (newHeight - state.height)
      .abs()
      .toInt()
      .clamp(minAnimationTime, maxAnimationTime);

  void _init() {
    try {
      final views = _widgetsBinding.platformDispatcher.views;
      final view = views.elementAtOrNull(0);

      if (view != null) {
        final height = view.physicalSize.height / view.devicePixelRatio;
        final padding = view.padding;

        add(
          ModalWindowEvent.setScreenScreenHeight(
            screenHeight: height,
            topPadding: padding.top / view.devicePixelRatio,
          ),
        );
        return;
      }
      add(
        const ModalWindowEvent.setScreenScreenHeight(
          screenHeight: 0,
          topPadding: 0,
        ),
      );
    } catch (e, stack) {
      log('Model Window Error ', error: e, stackTrace: stack);
      add(
        const ModalWindowEvent.setScreenScreenHeight(
          screenHeight: 0,
          topPadding: 0,
        ),
      );
    }
  }

  void _onSetScreenScreenHeight(
    _SetScreenScreenHeight event,
    Emitter<ModalWindowState> emit,
  ) {
    final screenHeight = event.screenHeight - event.topPadding;
    final dragBarHeight = screenHeight * _dragBarHeighScreenPercent;
    final height = screenHeight * _webViewCenterHeightScreenPercent;
    emit(
      _ModalWindowState(
        screenHeight: screenHeight,
        height: height,
        dragBarHeight: dragBarHeight,
        maxWebViewHeight:
            (screenHeight * _webViewHeighScreenPercent) - dragBarHeight,
        showCloseIcon: false,
        animationTime: animationTimeValue(height),
      ),
    );
  }

  void _onChangeSize(_ChangeSize event, Emitter<ModalWindowState> emit) {
    final screenHeight = state.screenHeight;
    if (screenHeight != null && screenHeight > 0) {
      if (event.height.abs() > 1) {
        final newHeight = state.height - event.height;
        // WebView has bug with 0 when change size from min to other because set
        // 0.1
        if (newHeight > minHeight && newHeight < state.maxWebViewHeight) {
          emit(
            state.copyWith(height: newHeight, animationTime: minAnimationTime),
          );
        }
      }
    }
  }

  void _onSetHeighState(_SetHeighState event, Emitter<ModalWindowState> emit) {
    final screenHeight = state.screenHeight;
    if (screenHeight != null && screenHeight > 0) {
      final screenCentralPoint =
          screenHeight * _webViewCenterHeightScreenPercent;

      // WebView has bug with 0 when change size from min to other because set
      // 0.1
      final max = state.maxWebViewHeight;
      final center = screenCentralPoint;

      final current = state.height;

      final distances = {
        minHeight: (current - minHeight).abs(),
        center: (current - center).abs(),
        max: (current - max).abs(),
      };

      final targetHeight = distances.entries
          .reduce((a, b) => a.value < b.value ? a : b)
          .key;

      emit(
        state.copyWith(
          height: targetHeight,
          showCloseIcon: targetHeight == minHeight,
          animationTime: animationTimeValue(targetHeight),
        ),
      );
    }
  }

  void _onHide(_Hide event, Emitter<ModalWindowState> emit) {
    emit(
      state.copyWith(
        height: minHeight,
        showCloseIcon: true,
        animationTime: animationTimeValue(minHeight),
      ),
    );
  }
}
