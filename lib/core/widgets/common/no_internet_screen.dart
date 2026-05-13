import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kisan_app/core/network/connectivity_bloc.dart';
import 'package:kisan_app/core/utils/extensions/context_extensions.dart';
import 'package:kisan_app/core/widgets/common/gradient_button.dart';

class NoInternetScreen extends StatelessWidget {
  const NoInternetScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: context.colorScheme.surface,
      width: double.infinity,
      height: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 30.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.signal_wifi_off_rounded,
            size: 100,
            color: context.colorScheme.primary.withOpacity(0.2),
          ),
          40.heightBox,
          Text(
            context.l10n.noInternetTitle,
            style: context.textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: context.colorScheme.primary,
            ),
            textAlign: TextAlign.center,
          ),
          16.heightBox,
          Text(
            context.l10n.noInternetDesc,
            style: context.textTheme.bodyLarge?.copyWith(
              color: context.colorScheme.onSurface.withOpacity(0.6),
            ),
            textAlign: TextAlign.center,
          ),
          60.heightBox,
          GradientButton(
            text: context.l10n.noInternetButton,
            onPressed: () {
              context.read<ConnectivityBloc>().add(ConnectivityStarted());
            },
            icon: Icons.refresh_rounded,
          ),
        ],
      ),
    );
  }
}
