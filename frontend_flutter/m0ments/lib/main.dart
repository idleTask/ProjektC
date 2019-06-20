import 'package:flutter/material.dart';
import 'package:m0ments/src/blocs/m0mentCard_bloc.dart';
import 'package:m0ments/src/pages/homePage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:m0ments/src/blocs/cardList_bloc.dart';

void main() => runApp(M0mentsApp());

class M0mentsApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProviderTree(
      blocProviders: [
        BlocProvider<CardListBloc>(bloc: CardListBloc()),
        BlocProvider<M0mentCardBloc>(bloc: M0mentCardBloc()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Colorspace',
        home: HomePage(),
      ),
    );
  }
}
