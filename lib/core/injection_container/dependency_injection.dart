import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:rentit/core/constants/constants.dart';
import 'package:rentit/features/authentication/data/datasources/firebase_auth_datasource.dart';
import 'package:rentit/features/authentication/data/datasources/local_storage_datasource.dart';
import 'package:rentit/features/authentication/data/repositories/auth_repo_imple.dart';
import 'package:rentit/features/authentication/domain/repositories/auth_repository.dart';
import 'package:rentit/features/authentication/domain/usecases/auth_use_case.dart';
import 'package:rentit/features/authentication/presentation/bloc/authentication_bloc.dart';
import 'package:rentit/features/location/data/datasources/location_datasource.dart';
import 'package:rentit/features/location/data/repositories/location_repodata.dart';
import 'package:rentit/features/location/domain/repositories/location_repository.dart';
import 'package:rentit/features/location/domain/usecases/location_usecases.dart';
import 'package:rentit/features/location/presentation/bloc/location_bloc.dart';
import 'package:rentit/features/payments/data/datasources/stripe_datasource.dart';
import 'package:rentit/features/payments/data/repository/payment_repository_impl.dart';
import 'package:rentit/features/payments/domain/repository/payment_repository.dart';
import 'package:rentit/features/payments/domain/usecases/payment_usecases.dart';
import 'package:rentit/features/payments/presentation/bloc/stripe/stripe_bloc.dart';
import 'package:rentit/features/returncar/data/datasource/return_car_datasource.dart';
import 'package:rentit/features/returncar/data/repository/return_car_repo_impl.dart';
import 'package:rentit/features/returncar/domain/repository/return_car_repository.dart';
import 'package:rentit/features/returncar/domain/usecases/return_car_confirm_usecases.dart';
import 'package:rentit/features/returncar/domain/usecases/return_car_initial_usecases.dart';
import 'package:rentit/features/reviews/data/datasource/review_datasource.dart';
import 'package:rentit/features/reviews/data/repository/reviewrepo_impl.dart';
import 'package:rentit/features/reviews/domain/repository/review_repository.dart';
import 'package:rentit/features/reviews/domain/usecases/addreview_usecase.dart';
import 'package:rentit/features/reviews/domain/usecases/uploadimage_usecase.dart';
import 'package:rentit/features/reviews/presentation/bloc/review_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;
final Dio dio = Dio();
final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
final FirebaseAuth firebaseAuthInstance = FirebaseAuth.instance;

Future<void> init() async {
  //SharedPreferences============================================
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
// FirebaseAuth===========================================
  final firebaseAuth = FirebaseAuth.instance;
  sl.registerLazySingleton(() => firebaseAuth);

  final firestore = FirebaseFirestore.instance;
  sl.registerLazySingleton(() => firestore);
// GoogleSignIn===========================================
  final googleSignIn = GoogleSignIn();
  sl.registerLazySingleton(() => googleSignIn);
  // DataSources===========================================
  sl.registerLazySingleton<LocalStorageDatasource>(
    () => SharedPreferencesDataSource(sl()),
  );
  sl.registerLazySingleton<FirebaseDataSource>(
    () => FirebaseDataSource(
        firebaseAuth: sl<FirebaseAuth>(), googleSignIn: sl<GoogleSignIn>()),
  );
// Repositories===========================================================================================
  sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(
      firebaseDataSource: sl<FirebaseDataSource>(),
      localStorageDatasource: sl<LocalStorageDatasource>()));
//Usecases======================================================================
  sl.registerLazySingleton(() => SignInWithGoogle(repositrory: sl()));
  sl.registerLazySingleton(() => SignInWithEmailAndPassword(repository: sl()));
  sl.registerLazySingleton(() => SignUpWithEmailAndPassword(repository: sl()));
  sl.registerLazySingleton(() => VerifyPhoneNumber(repository: sl()));
  sl.registerLazySingleton(() => SignInWithPhoneNumber(repository: sl()));
  sl.registerLazySingleton(() => SignOut(repository: sl()));
  sl.registerLazySingleton(() => GetCurrentUser(repository: sl()));
  sl.registerLazySingleton(() => SaveAuthToken(repository: sl()));
  sl.registerLazySingleton(() => GetAuthToken(repository: sl()));
  sl.registerLazySingleton(() => ClearAuthToken(repository: sl()));

//BLoC==================================
  sl.registerFactory(() => AuthBloc(
      signInWithGoogle: sl(),
      signInWithEmailAndPassword: sl(),
      signUpWithEmailAndPassword: sl(),
      verifyPhoneNumber: sl(),
      signInWithPhoneNumber: sl(),
      signOut: sl(),
      getCurrentUser: sl(),
      saveAuthToken: sl(),
      getAuthToken: sl(),
      clearAuthToken: sl(),
      saveUserProfileUsecase: sl()));

//LOCATION================================================

// // Data source=========================================
  sl.registerLazySingleton<LocationDatasource>(() => LocationDataSourceImpl());

// Repository============================================
  sl.registerLazySingleton<LocationRepository>(
      () => LocationRepositoryImpl(sl()));

// Usecase===============================================
  sl.registerLazySingleton(() => GetCurrentLocationCameraPositionUseCase(sl()));
  sl.registerLazySingleton(
      () => GetLocationFromPlaceIdUseCase(sl<LocationRepository>()));

// BLoC==================================================
  sl.registerFactory(() => LocationMapBloc(
        sl(),
        sl(),
      ));

//Payment-STRIPE========================================================

//final dio = GetIt.instance<Dio>();
  sl.registerLazySingleton<Dio>(() => Dio());

  sl.registerLazySingleton(() => PaymentBloc(makePaymentUsecase: sl()));

  sl.registerLazySingleton(() => MakePaymentUsecase(sl()));

  sl.registerLazySingleton<PaymentDataSource>(() => PaymentDataSource());

  sl.registerLazySingleton<PaymentRepository>(() => StripePaymentRepository(
      stripeSecretKey: stripeSecretKey, paymentDataSource: sl()));

//Return Process====================================================

//Repositories---------------------------------------------

  sl.registerLazySingleton<CarReturnRepository>(
      () => CarReturnRepositoryImpl(sl()));
//DataSource---------------------------------------------

  sl.registerLazySingleton<ReturnCarDatasource>(
      () => ReturnCarDataSourceImpl());

//UseCases---------------------------------------------
  sl.registerLazySingleton(() => ReturnCarConfirmUsecase(sl()));
  sl.registerLazySingleton(() => ReturnCarInitialUsecases(sl()));

  sl.registerLazySingleton(() => AddReviewUseCase(sl()));
  sl.registerLazySingleton(() => UploadImageUseCase(sl()));

  sl.registerLazySingleton<ReviewRepository>(() => ReviewRepositoryImpl(sl()));

  sl.registerLazySingleton<ReviewDataSource>(() => ReviewDataSource());

  sl.registerFactory(() => ReviewBloc(
        sl(),
        sl(),
      ));
}

// Lazy singleton means the instance
//will be created only once when it is needed for the first time.
//FirebaseDataSource and LocalStorageDataSource=> dependencies required by AuthRepositoryImpl
