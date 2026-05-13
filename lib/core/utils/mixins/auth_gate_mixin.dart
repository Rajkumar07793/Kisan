import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kisan_app/core/constants/enums/app_enums.dart';
import 'package:kisan_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:kisan_app/features/auth/presentation/widgets/login_gate_bottom_sheet.dart';

mixin AuthGateMixin {
  /// Runs the provided [action] only if the user is authenticated.
  /// Otherwise, it displays the [LoginGateBottomSheet].
  void runGatedAction(BuildContext context, VoidCallback action) {
    final authState = context.read<AuthBloc>().state;

    if (authState.status == AuthStatus.authenticated) {
      action();
    } else {
      LoginGateBottomSheet.show(context);
    }
  }
}
