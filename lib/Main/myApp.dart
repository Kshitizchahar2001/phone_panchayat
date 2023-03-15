// ignore_for_file: file_names, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:online_panchayat_flutter/services/userManagement.dart';
import 'package:online_panchayat_flutter/utils/theme.dart';
import 'package:provider/provider.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:easy_localization/easy_localization.dart';
import 'myNavigator.dart';

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    final PlatformRouteInformationProvider routeInformationProvider =
        MyNavigator.getRouterInformation();
    // Services.gqlQueryService =
    //     Provider.of<GQLQueryService>(context, listen: false);
    // Services.gqlMutationService =
    //     Provider.of<GQLMutationService>(context, listen: false);
    // Services.globalDataNotifier =
    //     Provider.of<GlobalDataNotifier>(context, listen: false);

    // Services.locationNotifier =
    //     Provider.of<LocationNotifier>(context, listen: false);

    // return Consumer<ThemeProvider>(
    //   builder: (context, themeProvider, child) {
    //     return MaterialApp(
    //       themeMode: themeProvider.getThemeMode,
    //       theme: themeProvider.light,
    //       darkTheme: themeProvider.dark,
    //       debugShowCheckedModeBanner: false,
    //       localizationsDelegates: context.localizationDelegates,
    //       supportedLocales: context.supportedLocales,
    //       home: DeveloperScreen(),
    //       // home: SharedPrefData(),
    //       // home: GenerateTextNotification(),
    //       // home: MyProfile(),
    //       // home: MyUniLinkApp(),
    //       // home: ScrollTestPage(),
    //       // Scaffold(
    //       //   body: Container(
    //       //     color: Colors.white,
    //       //     child: Center(
    //       //       child: FLutterNativeAdmobWidget(),
    //       //       // child: NativeAds(),
    //       //     ),
    //       //   ),
    //       // PostImage(
    //       //   url:
    //       //       // null,
    //       //       //  'https://i1.ytimg.com/vi/LigsDDRrfwM/hqdefault.jpg',
    //       //       'https://flutter.github.io/assets-for-api-docs/assets/widgets/puffin.jpg',
    //       //   numberOfViews: 23,
    //       //   showPlayIcon: true, //todo
    //       // ),
    //       // ),
    //       // home: SuggestionMessageScreen(),
    //       // home: YoutubeVideoScreen(
    //       //   url: 'https://youtu.be/684BzzsoG80',
    //       // ),
    //       //  NotificationLinkWebView(
    //       //   suppressedUrl: SuppressedUrl(
    //       //     name: 'hi',
    //       //     url:
    //       //         'https://stackoverflow.com/questions/57886661/passing-generic-type-by-functiont-in-flutter',
    //       //     showWebPage: true,
    //       //   ),
    //       // ),
    //       // home: PlaceSuggestionScreen(),
    //       // home: EditProfileForm(),
    //       // PlaceList(
    //       //   // place: District(),
    //       //   place: Tehsil(Identifier(name: "1")),
    //       // )
    //       // GetCoordinatesFromDescription()
    //       // ElectedMemberScreen()
    //       // DesignatedMembersScreen()
    //       // LoadingSplashScreen()
    //       // ChangeNotifierProvider<IndividualProfessionalListScreenData>(
    //       //   create: (_) => IndividualProfessionalListScreenData(
    //       //     profession: 'designer',
    //       //   ),
    //       //   builder: (context, child) => IndividualProfessionalListScreen(),
    //       // )
    //       // FindProfessional()
    //       // Scaffold(
    //       //   body: Registration(),
    //       //   // body: Test(),
    //       // )
    //       // LoadingSplashScreen()
    //       // ReferAndEarnScreen()
    //       // SelectPostTag()
    //       // AddPost()
    //       // SelectPostAudienceScreen()
    //       // MainPage(),
    //     );
    //   },
    // );

    return UserManagement(
      builder: (BuildContext context, isUserValid, isUserRegistered) {
        VxNavigator navigator = MyNavigator.getNavigator(
          isUserValid,
          isUserRegistered,
        );
        return Consumer<ThemeProvider>(
            builder: (context, themeProvider, child) {
          return MaterialApp.router(
            locale: BuildContextEasyLocalizationExtension(context).locale,
            routeInformationProvider: routeInformationProvider,
            debugShowCheckedModeBanner: false,
            localizationsDelegates: context.localizationDelegates,
            supportedLocales: context.supportedLocales,
            title: 'Phone Panchayat',
            themeMode: themeProvider.getThemeMode,
            theme: themeProvider.light,
            darkTheme: themeProvider.dark,
            routeInformationParser: VxInformationParser(),
            routerDelegate: navigator,
          );
        });
      },
    );
  }
}
