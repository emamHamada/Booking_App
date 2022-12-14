import 'package:booking_app/src/app/core/components/text_form_fields/app_textform_field.dart';
import 'package:booking_app/src/app/core/core.dart';
import 'package:booking_app/src/app/core/utils/mediaquery_managment.dart';
import 'package:booking_app/src/features/booking/cubit/booking_cubit.dart';
import 'package:booking_app/src/features/explore_hotels/cubit/explore_cubit.dart';
import 'package:booking_app/src/features/explore_hotels/cubit/explore_states.dart';
import 'package:booking_app/src/features/explore_hotels/presentation/components/hotel_item_map.dart';
import 'package:booking_app/src/features/explore_hotels/presentation/screens/hotels_result_screen.dart';
import 'package:booking_app/src/features/explore_hotels/presentation/screens/map_screen.dart';
import 'package:booking_app/src/features/home/presentation/widgets/explore_widgets/feature_item.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../../../app/config/routes/routes.dart';
import '../components/dialog_widget.dart';

class ExploreScreen extends StatelessWidget {
  ExploreScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MediaQueryManager().init(context);
    var exploreCubit = ExploreCubit.get(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Explore",
          style: Theme.of(context).textTheme.headline5!.copyWith(
                fontWeight: FontWeight.w500,
              ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            splashRadius: 20,
            onPressed: () {},
            icon: const Icon(
              Icons.favorite_border,
            ),
          ),
          BlocConsumer<ExploreCubit, ExploreStates>(
            listener: (context, state) {},
            builder: (context, state) {
              return IconButton(
                splashRadius: 20,
                onPressed: () {
                  exploreCubit.changeScreen();
                },
                icon: exploreCubit.isMapScreen
                    ? const Icon(
                        Icons.filter_list,
                      )
                    : const Icon(
                        Icons.map_outlined,
                      ),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: AppTextFormField(
                        controller: exploreCubit.searchController,
                        hintText: 'Search',
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    FloatingActionButton(
                      onPressed: () {
                        Navigator.pushNamed(context, Routes.search);
                      },
                      elevation: 3,
                      backgroundColor: mainAppColor,
                      child: const Icon(
                        Icons.search,
                        size: 35,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          exploreCubit.pickDateRange(context);
                        },
                        child: BlocConsumer<ExploreCubit, ExploreStates>(
                          listener: (context, state) {},
                          builder: (context, state) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "Choose date",
                                  style: TextStyle(color: Colors.grey),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                exploreCubit.dateRange != null
                                    ? Text(
                                        "${DateFormat.MMMd().format(exploreCubit.dateRange!.start)} - ${DateFormat.MMMd().format(exploreCubit.dateRange!.end)}")
                                    : Text(
                                        "${DateFormat.MMMd().format(DateTime.now())} - ${DateFormat.MMMd().format(DateTime.now().add(const Duration(days: 1)))}"),
                              ],
                            );
                          },
                        ),
                      ),
                    ),
                    Container(
                      height: 40,
                      width: 1,
                      color: Colors.grey,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (_) {
                              return const NumberOfRoomDialog();
                            },
                          );
                        },
                        child: BlocConsumer<ExploreCubit, ExploreStates>(
                          listener: (context, state) {},
                          builder: (context, state) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "Number of Room",
                                  style: TextStyle(color: Colors.grey),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text(
                                    "${exploreCubit.numberOfRooms} Room ${exploreCubit.numberOfPeople} People"),
                              ],
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const Divider(
            height: 30,
            thickness: 1,
          ),
          BlocConsumer<ExploreCubit, ExploreStates>(
            listener: (context, state) {},
            builder: (context, state) {
              return Expanded(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              exploreCubit.allHotelsData != null
                                  ? "All Hotels (${exploreCubit.allHotelsData!.data!.length})"
                                  : "Please wait...",
                            ),
                          ),
                          const Text("Filter"),
                          const SizedBox(
                            width: 5,
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.of(context).pushNamed(Routes.filter);
                            },
                            child: const Icon(
                              Icons.filter_list,
                            ),
                          ),
                        ],
                      ),
                    ),
                    /////////////////////
                    Expanded(
                      child: exploreCubit.isMapScreen
                          ? Stack(
                              children: [
                                // !!!!!!!!!!!!!!!!!!!!!!!  uncomment this in need only
                                MapScreen(
                                  allHotelsData: exploreCubit.allHotelsData!,
                                ),
                                //TODO : implement Horizontal List View
                                ConditionalBuilder(
                                  condition: exploreCubit.allHotelsData != null,
                                  builder: (context) => Positioned(
                                    bottom: 0,
                                    child: Container(
                                      width: MediaQueryManager.screenWidth,
                                      height: 150,
                                      child: ListView.separated(
                                        physics: const BouncingScrollPhysics(),
                                        itemCount: exploreCubit
                                            .allHotelsData!.data!.length,
                                        scrollDirection: Axis.horizontal,
                                        itemBuilder: (context, index) =>
                                            HotelItemInMap(
                                          hotelData: exploreCubit
                                              .allHotelsData!.data![index],
                                        ),
                                        separatorBuilder: (context, index) =>
                                            const SizedBox(
                                          width: 20,
                                        ),
                                      ),
                                    ),
                                  ),
                                  fallback: (context) =>
                                      const CircularProgressIndicator(),
                                ),
                              ],
                            )
                          : const HotelsResultScreen(),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
