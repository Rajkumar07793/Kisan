import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:kisan_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:kisan_app/features/chat/presentation/bloc/groups_chat_bloc/groups_chat_bloc.dart';
import 'package:kisan_app/l10n/generated/app_localizations.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'core/constants/env_config.dart';
import 'core/localization/locale_bloc.dart';
import 'core/network/connectivity_bloc.dart';
import 'core/services/injection_container.dart';
import 'core/theme/app_themes.dart';
import 'core/theme/theme_bloc.dart';
import 'core/utils/app_router.dart';
import 'core/widgets/common/no_internet_screen.dart';
import 'features/chat/presentation/bloc/chat_bloc/chat_bloc.dart';
import 'features/chat/presentation/bloc/chat_message_bloc/chat_messages_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // 1. Initialize Dependency Injection
  await initDI();

  // 2. Initialize Environment Variables
  await EnvConfig.init();

  // 3. Initialize Supabase
  await Supabase.initialize(
    url: EnvConfig.supabaseUrl,
    anonKey: EnvConfig.supabaseAnonKey,
    authOptions: const FlutterAuthClientOptions(
      authFlowType: AuthFlowType.implicit,
    ),
  );

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => sl<ThemeBloc>()..add(const LoadTheme()),
        ),
        BlocProvider(create: (context) => sl<ConnectivityBloc>()),
        BlocProvider(
          create: (context) => sl<LocaleBloc>()..add(const LoadLocale()),
        ),
        BlocProvider(create: (context) => sl<ChatBloc>()),
        BlocProvider(create: (context) => sl<ChatMessagesBloc>()),
        BlocProvider(create: (context) => sl<AuthBloc>()),
        BlocProvider(create: (context) => sl<GroupsChatBloc>()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, themeState) {
        return BlocBuilder<LocaleBloc, LocaleState>(
          builder: (context, localeState) {
            return MaterialApp.router(
              title: EnvConfig.appName,
              debugShowCheckedModeBanner: EnvConfig.isDebug,

              // Theme
              theme: AppThemes.light,
              darkTheme: AppThemes.dark,
              themeMode: themeState.themeMode,

              // Localization
              locale: localeState.locale,
              localizationsDelegates: const [
                AppLocalizations.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              supportedLocales: AppLocalizations.supportedLocales,

              // Router
              routerConfig: AppRouter.router,

              builder: (context, child) {
                return BlocBuilder<ConnectivityBloc, ConnectivityState>(
                  builder: (context, state) {
                    if (state is ConnectivityOffline) {
                      return const NoInternetScreen();
                    }
                    return child ?? const SizedBox.shrink();
                  },
                );
              },
            );
          },
        );
      },
    );
  }
}
