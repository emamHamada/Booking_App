import 'package:booking_app/src/app/config/routes/routes.dart';
import 'package:booking_app/src/features/explore_hotels/cubit/explore_states.dart';
import 'package:booking_app/src/features/home/presentation/home_cubit/home_cubit.dart';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../app/core/components/buttons/main_button.dart';
import '../../../../../app/core/utils/colors_manager.dart';
import '../../../../explore_hotels/cubit/explore_cubit.dart';
import '../../widgets/explore_widgets/destination_item.dart';
import '../../widgets/explore_widgets/feature_item.dart';

// ignore: must_be_immutable
class HomeExplore extends StatelessWidget {
  // var Images = {
  //   "paris": "assets/images/paris.jpg",
  //   "spain": "assets/images/spain.jpg",
  //   "egypt": "assets/images/egypt.jpg",
  //   "vernazza": "assets/images/download.jpg",
  //   "london": "assets/images/hotel.jpg",
  //   "venice": "assets/images/hotel.jpg",
  //   "diamond head": "assets/images/hotel.jpg",
  // };
  List<String> itemList = [];
  Widget build(BuildContext context) {
    var exploreCubit = HomeCubit.get(context);
    exploreCubit.getAllHotels();
    return Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.transparent,
          centerTitle: true,
          title: Container(
            margin: const EdgeInsets.symmetric(horizontal: 10),
            height: 40,
            decoration: BoxDecoration(
              boxShadow: <BoxShadow>[
                BoxShadow(
                    color: Colors.grey.withOpacity(0.6),
                    offset: const Offset(1.1, 1.1),
                    blurRadius: 5.0),
              ],
            ),
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(context, Routes.search);
              },
              child: CupertinoTextField(
                enabled: false,
                // controller: _filter,
                keyboardType: TextInputType.text,
                placeholder: 'Search',
                placeholderStyle: const TextStyle(
                  color: Color(0xffC4C6CC),
                  fontSize: 14.0,
                  fontFamily: 'Brutal',
                ),
                prefix: const Padding(
                  padding: EdgeInsets.fromLTRB(5.0, 5.0, 0.0, 5.0),
                  child: Icon(
                    Icons.search,
                    size: 18,
                    color: Colors.black,
                  ),
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        body: NestedScrollView(
          // physics:
          floatHeaderSlivers: true,
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              // SliverAppBar(
              //   backgroundColor: Colors.transparent,
              //   floating: true,
              //   pinned: true,
              //   title: Container(
              //     margin: EdgeInsets.symmetric(horizontal: 10),
              //     height: 40,
              //     decoration: BoxDecoration(
              //       boxShadow: <BoxShadow>[
              //         BoxShadow(
              //             color: Colors.grey.withOpacity(0.6),
              //             offset: const Offset(1.1, 1.1),
              //             blurRadius: 5.0),
              //       ],
              //     ),
              //     child: CupertinoTextField(
              //       controller: _filter,
              //       keyboardType: TextInputType.text,
              //       placeholder: 'Search',
              //       placeholderStyle: TextStyle(
              //         color: Color(0xffC4C6CC),
              //         fontSize: 14.0,
              //         fontFamily: 'Brutal',
              //       ),
              //       prefix: Padding(
              //         padding: const EdgeInsets.fromLTRB(5.0, 5.0, 0.0, 5.0),
              //         child: Icon(
              //           Icons.search,
              //           size: 18,
              //           color: Colors.black,
              //         ),
              //       ),
              //       decoration: BoxDecoration(
              //         borderRadius: BorderRadius.circular(8.0),
              //         color: Colors.white,
              //       ),
              //     ),
              //   ),
              // ),
              SliverAppBar(
                expandedHeight: 300.0,
                pinned: true,
                elevation: 0,
                stretch: true,
                // floating: true,
                // snap: true,
                flexibleSpace: FlexibleSpaceBar(
                  // stretchModes: [StretchMode.fadeTitle],
                  // collapseMode: CollapseMode.none,
                  expandedTitleScale: 1,
                  // collapseMode: CollapseMode.none,
                  centerTitle: true,
                  title: Stack(
                    children: [
                      CarouselSlider(
                        options: CarouselOptions(
                          height: 450,
                          autoPlay: true,
                          viewportFraction: 1,
                          pageSnapping: false,
                        ),
                        items: List.generate(
                          5,
                          (index) => Image.asset(
                            "assets/images/hotel.jpg",
                            fit: BoxFit.cover,
                            width: double.infinity,
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 15,
                        left: 30,
                        child: SizedBox(
                          width: 100,
                          child: MainButton(
                              onPressed: () {
                                Navigator.pushNamed(
                                    context, Routes.exploreHotels);
                              },
                              txt: "View Hotel",
                              isExpanded: false),
                        ),
                      )
                      // Container(
                      //   height: 500,
                      //   width: size.width,
                      //   child: Image.asset(
                      //     "assets/images/hotel.jpg",
                      //     fit: BoxFit.cover,
                      //   ),
                      // ),
                    ],
                  ),
                ),
              )
            ];
          },
          body: ListView(padding: EdgeInsets.zero, children: [
            // populer destination title
            // populer destination cards
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 0, 15, 10),
              child: Row(
                children: const [
                  Text(
                    "populer Destination",
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      color: ColorMangerH.textColor,
                      fontWeight: FontWeight.w500,
                      fontSize: 24,
                    ),
                  ),
                ],
              ),
            ),

            BlocConsumer<ExploreCubit, ExploreStates>(
              listener: (context, state) {},
              builder: (context, state) {
                return Container(
                  child: ConditionalBuilder(
                    condition: exploreCubit.allHotelsData != null,
                    builder: (context) => CarouselSlider(
                      options: CarouselOptions(
                        autoPlay: true,
                        // enlargeCenterPage: true,
                        disableCenter: true,
                        viewportFraction: .8,
                      ),
                      items: List.generate(
                        exploreCubit.allHotelsData!.data!.length,
                        (index) => const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: DestinationItem(),
                        ),
                      ),
                    ),
                    fallback: (context) => const Expanded(
                      child: Center(
                        child: CircularProgressIndicator(
                            color: ColorManager.primaryColor, strokeWidth: 3),
                      ),
                    ),
                  ),
                );
              },
            ),
            // best deals
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 0, 15, 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Best Deals",
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      color: ColorMangerH.textColor,
                      fontWeight: FontWeight.w500,
                      fontSize: 24,
                    ),
                  ),
                  TextButton.icon(
                    onPressed: () {},
                    label: const Text(
                      "view all",
                      style: TextStyle(color: ColorManager.primaryColor),
                    ),
                    icon: const Icon(
                      Icons.arrow_circle_right_rounded,
                      color: ColorManager.primaryColor,
                    ),
                  )
                ],
              ),
            ),
            BlocConsumer<HomeCubit, HomeState>(
              listener: (context, state) {},
              builder: (context, state) {
                return ConditionalBuilder(
                    condition: exploreCubit.allHotelsData != null,
                    builder: (context) => Column(
                          children: List.generate(
                            exploreCubit.allHotelsData!.data!.length,
                            (index) => Padding(
                              padding: const EdgeInsets.only(right: 8),
                              child: FeatureItem(
                                hotelData:
                                    exploreCubit.allHotelsData!.data![index],
                              ),
                            ),
                          ),
                        ),
                    fallback: (context) => const Expanded(
                          child: Center(
                            child: CircularProgressIndicator(
                                color: ColorManager.primaryColor,
                                strokeWidth: 3),
                          ),
                        ));
              },
            ),
          ]),
        ));
  }
}