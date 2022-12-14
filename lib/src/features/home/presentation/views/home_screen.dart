import 'package:booking_app/src/app/core/utils/colors_manager.dart';
import 'package:booking_app/src/app/core/utils/mediaquery_managment.dart';
import 'package:booking_app/src/features/home/data/models/nav_bar_data.dart';

import 'package:ezanimation/ezanimation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../home_cubit/home_cubit.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MediaQueryManager().init(context);
    return BlocProvider(
      create: (context) => HomeCubit(),
      child: BlocBuilder<HomeCubit, HomeState>(
        buildWhen: (previous, current) => current is ScreenChangedState,
        builder: (context, state) {
          EzAnimation margin =
              EzAnimation(60.0, 0.0, const Duration(seconds: 1));
          margin.start();
          return Scaffold(
            body: AnimatedBuilder(
                animation: margin,
                builder: (context, child) => Opacity(
                      opacity: (100.0 - margin.value) / 100,
                      child: Container(
                        margin: EdgeInsets.only(top: margin.value),
                        child: HomeCubit.get(context)
                            .screens[HomeCubit.get(context).index],
                      ),
                    )),
            bottomNavigationBar: BottomNavigationBar(
              selectedItemColor: ColorManager.primaryColor,
                onTap: (i) {
                  HomeCubit.get(context).changeIndex(i);
                },
                items: navbarItems,
                currentIndex: HomeCubit.get(context).index),
          );
        },
      ),
    );
  }
}
