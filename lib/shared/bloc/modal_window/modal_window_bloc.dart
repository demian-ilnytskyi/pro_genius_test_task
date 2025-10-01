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
          height: 100,
          dragBarHeight: 0,
          maxWebViewHeight: 0,
        ),
      ) {
    on<_ChangeSize>(_onChangeSize);
    on<_SetScreenScreenHeight>(_onSetScreenScreenHeight);
    on<_SetHeighState>(_onSetHeighState);
    _init();
  }
  final WidgetsBinding _widgetsBinding;

  static const _dragBarHeighScreenPercent = 0.1;
  static const _webViewHeighScreenPercent = 1;
  final _webViewCenterHeightScreenPercent =
      (_webViewHeighScreenPercent - _dragBarHeighScreenPercent) / 2;

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
    emit(
      _ModalWindowState(
        screenHeight: screenHeight,
        height: screenHeight * _webViewCenterHeightScreenPercent,
        dragBarHeight: dragBarHeight,
        maxWebViewHeight:
            (screenHeight * _webViewHeighScreenPercent) - dragBarHeight,
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
        if (newHeight > 0.1 && newHeight < state.maxWebViewHeight) {
          emit(state.copyWith(height: newHeight));
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
      const min = 0.10;
      final max = state.maxWebViewHeight;
      final center = screenCentralPoint;

      final current = state.height;

      final distances = {
        min: (current - min).abs(),
        center: (current - center).abs(),
        max: (current - max).abs(),
      };

      final targetHeight = distances.entries
          .reduce((a, b) => a.value < b.value ? a : b)
          .key;

      emit(state.copyWith(height: targetHeight));
    }
  }
}
