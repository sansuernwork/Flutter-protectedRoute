import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_newproject/test/bloc/test_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  Future<String?> init() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString('token');
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final testBloc = BlocProvider(create: (context) => TestBloc());

    return MultiBlocProvider(
      providers: [testBloc],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        builder: (context, child) {
          return FutureBuilder(
            future: init(),
            builder: (context, snapshot) {
              if (snapshot.data != null) {
                BlocProvider.of<TestBloc>(context).add(LoginEvent());
              }
              return BlocBuilder<TestBloc, TestState>(
                builder: (context, state) {
                  if (state.isLoggin) {
                    return Scaffold(
                      body: RefreshIndicator(
                          onRefresh: () async {},
                          child: CustomScrollView(
                            slivers: [
                              SliverToBoxAdapter(
                                child: Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Text("Login out"),
                                      TextButton(
                                          onPressed: () async {
                                            BlocProvider.of<TestBloc>(context)
                                                .add(LogoutEvent());
                                          },
                                          child: const Text("test")),
                                      ListView.builder(
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        padding: const EdgeInsets.all(0),
                                        itemCount: 20,
                                        shrinkWrap: true,
                                        itemBuilder: (context, index) {
                                          return Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Container(
                                              color: Colors.red,
                                              height: 100,
                                            ),
                                          );
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          )),
                    );
                  } else {
                    return Scaffold(
                      body: Center(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text("please login"),
                            TextButton(
                                onPressed: () async {
                                  BlocProvider.of<TestBloc>(context)
                                      .add(LoginEvent());
                                },
                                child: const Text("Login"))
                          ],
                        ),
                      ),
                    );
                  }
                },
              );
            },
          );
        },
      ),
    );
  }
}
