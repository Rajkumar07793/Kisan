import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:kisan_app/features/chat/presentation/bloc/groups_chat_bloc/groups_chat_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../data/providers/local/storage_service.dart';
import '../../features/auth/data/repositories/auth_repository_impl.dart';
import '../../features/auth/domain/repositories/auth_repository.dart';
import '../../features/auth/domain/usecases/login_usecase.dart';
import '../../features/auth/domain/usecases/resend_otp_usecase.dart';
import '../../features/auth/domain/usecases/reset_password_usecase.dart';
import '../../features/auth/domain/usecases/signup_usecase.dart';
import '../../features/auth/domain/usecases/update_password_usecase.dart';
import '../../features/auth/domain/usecases/verify_otp_usecase.dart';
import '../../features/auth/presentation/bloc/auth_bloc.dart';
import '../../features/chat/presentation/bloc/chat_bloc/chat_bloc.dart';
import '../../features/chat/presentation/bloc/chat_message_bloc/chat_messages_bloc.dart';
import '../../features/profile/data/repositories/app_content_repository_impl.dart';
import '../../features/profile/data/repositories/faq_repository_impl.dart';
import '../../features/profile/domain/repositories/app_content_repository.dart';
import '../../features/profile/domain/repositories/faq_repository.dart';
import '../../features/profile/domain/usecases/get_faqs_usecase.dart';
import '../../features/home/domain/repositories/home_repository.dart';
import '../../features/home/data/repositories/home_repository_impl.dart';
import '../../features/home/presentation/bloc/home_bloc.dart';
import '../../features/profile/presentation/bloc/faqs/faqs_bloc.dart';
import '../localization/locale_bloc.dart';
import '../network/api_client.dart';
import '../network/connectivity_bloc.dart';
import '../network/location_service.dart';
import '../theme/theme_bloc.dart';

final sl = GetIt.instance;

Future<void> initDI() async {
  // --- Core ---
  final prefs = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => prefs);
  sl.registerLazySingleton(() => const FlutterSecureStorage());
  sl.registerLazySingleton(() => Dio());
  sl.registerLazySingleton(() => Supabase.instance.client);

  sl.registerLazySingleton(
    () => StorageService(prefs: sl(), secureStorage: sl()),
  );

  sl.registerLazySingleton(() => ApiClient(dio: sl(), storageService: sl()));
  sl.registerLazySingleton(() => LocationService(sl()));

  // --- Features: Auth ---
  sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(sl()));
  sl.registerLazySingleton(() => LoginUseCase(sl()));
  sl.registerLazySingleton(() => SignUpUseCase(sl()));
  sl.registerLazySingleton(() => VerifyOTPUseCase(sl()));
  sl.registerLazySingleton(() => ResendOTPUseCase(sl()));
  sl.registerLazySingleton(() => ResetPasswordUseCase(sl()));
  sl.registerLazySingleton(() => UpdatePasswordUseCase(sl()));

  // --- Features: Profile Content ---
  sl.registerLazySingleton<AppContentRepository>(
    () => AppContentRepositoryImpl(sl()),
  );
  sl.registerLazySingleton<FaqRepository>(() => FaqRepositoryImpl(sl()));
  sl.registerLazySingleton(() => GetFaqsUseCase(sl()));

  // --- Features: Home ---
  sl.registerLazySingleton<HomeRepository>(() => HomeRepositoryImpl(sl()));

  // --- Blocs ---
  sl.registerLazySingleton(
    () => ConnectivityBloc()..add(ConnectivityStarted()),
  );
  sl.registerLazySingleton(() => ThemeBloc(storageService: sl()));
  sl.registerLazySingleton(() => LocaleBloc(storageService: sl()));
  sl.registerLazySingleton(() => ChatBloc());
  sl.registerLazySingleton(() => GroupsChatBloc());
  sl.registerLazySingleton(() => ChatMessagesBloc());
  sl.registerLazySingleton(
    () => AuthBloc(
      authRepository: sl(),
      loginUseCase: sl(),
      signUpUseCase: sl(),
      verifyOTPUseCase: sl(),
      resendOTPUseCase: sl(),
      resetPasswordUseCase: sl(),
      updatePasswordUseCase: sl(),
    ),
  );

  sl.registerFactory(() => HomeBloc(homeRepository: sl()));
  sl.registerFactory(() => FaqsBloc(getFaqsUseCase: sl()));
}
