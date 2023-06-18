import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hr_app/routes/app_route.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'cubit/Fire_auth/fire_auth_cubit.dart';
import 'firebase_options.dart';

final navigatorKey = GlobalKey<NavigatorState>();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({
    super.key,
  });

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    FireAuthRepo().checkSignin();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => FireAuthRepo(),
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => FireAuthRepo(),
          ),
        ],
        child: MaterialApp.router(
          debugShowCheckedModeBanner: false,
          theme: ThemeData.from(
            colorScheme: const ColorScheme.light(),
          ).copyWith(
            pageTransitionsTheme: const PageTransitionsTheme(
              builders: <TargetPlatform, PageTransitionsBuilder>{
                TargetPlatform.android: ZoomPageTransitionsBuilder(),
              },
            ),
          ),
          routerDelegate: AppRouter().router.routerDelegate,
          routeInformationParser: AppRouter().router.routeInformationParser,
          routeInformationProvider: AppRouter().router.routeInformationProvider,
        ),
      ),
    );
  }
}

// class MyHomePage extends StatefulWidget {
//   const MyHomePage({super.key, required this.title});

//   final String title;

//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   setUserId(String? userId) async {
//     final SharedPreferences prefs = await SharedPreferences.getInstance();
//     //   // Try reading data from the 'action' key. If it doesn't exist, returns null.
//     prefs.setString('userId', userId!);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: StreamBuilder<User?>(
//         //Validating the user email & password
//         stream: FirebaseAuth.instance.authStateChanges(),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Center(child: CircularProgressIndicator());
//           } else if (snapshot.hasError) {
//             return const Center(child: Text("Something went wrong!"));
//           } else if (snapshot.hasData) {
//             if (kDebugMode) {
//               print("Directing to Homepage");
//               print("User id is ${snapshot.data!.uid}");
//             }
//             return const HomePage();
//           } else {
//             double width = MediaQuery.of(context).size.width;
//             if (kDebugMode) {
//               print("Re-directing to AuthPage");
//               print("the width is $width");
//             }
//             return CheckAuth(
//               firstTime: true,
//             );
//           }
//         },
//       ),
//     );
//   }
// }

