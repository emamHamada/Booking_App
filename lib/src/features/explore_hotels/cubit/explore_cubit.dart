import 'package:booking_app/src/app/core/core.dart';
import 'package:booking_app/src/app/core/helpers/api_helpert.dart';
import 'package:booking_app/src/app/injector.dart';
import 'package:booking_app/src/features/explore_hotels/cubit/explore_states.dart';
import 'package:booking_app/src/features/explore_hotels/data/models/hotels_data_model.dart';
import 'package:booking_app/src/features/filter/data/models/facilities_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ExploreCubit extends Cubit<ExploreStates> {
  ExploreCubit() : super(InitExploreState());

  static ExploreCubit get(context) => BlocProvider.of(context);

  bool isMapScreen = false;
  TextEditingController searchController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  List<int?> facilities = []; //contains the id of each facility

  void changeScreen() {
    isMapScreen = !isMapScreen;
    emit(ExploreScreenChangedState());
  }

  AllHotelsData? allHotelsData;
  AllHotelsData? searchHotelsData;
  AllFacilitiesData? allFacilitiesData;

  Future<void> getAllHotels({String? token}) async {
    try {
      DioHelper apiHelper = sl<DioHelper>();
      var value = await apiHelper.get(
        endPoint: '/hotels/',
        token: token,
      );
      // showToastMessage(message: "${value.data['message']}");
      allHotelsData = AllHotelsData.fromJson(value);
      debugPrint("-----------------------------------------------");
      debugPrint(allHotelsData!.data!.length.toString());
      debugPrint("-----------------------------------------------");

      emit(SuccessGetHotelsDataState());
    } on DioError catch (e) {
      if (e.response == null) {
        // showToastMessage(message: "Check you connection", toastColor: Colors.red);
      } else {
        debugPrint(e.response!.data);
        // showToastMessage(message: "${e.response!.data['message']}", toastColor: Colors.red);
      }
      emit(FailedGetHotelsDataState());
    }
  }
  Future<void> getAllFacilities({String? token}) async {
    try {
      DioHelper apiHelper = sl<DioHelper>();
      var value = await apiHelper.get(
        endPoint: '/facilities',
        token: token,
      );
      // showToastMessage(message: "${value.data['message']}");
      allFacilitiesData = AllFacilitiesData.fromJson(value);
      debugPrint("------------------facilities-----------------------------");
      debugPrint(allFacilitiesData!.data.length.toString());
      debugPrint("------------------facilities-----------------------------");

    } on DioError catch (e) {
      if (e.response == null) {
        // showToastMessage(message: "Check you connection", toastColor: Colors.red);
      } else {
        debugPrint(e.response!.data);
        // showToastMessage(message: "${e.response!.data['message']}", toastColor: Colors.red);
      }
    }
  }

  Future<void> searchForHotels({
    String? token,
  }) async {
    emit(LoadingSearchState());
    Map<String, dynamic> searchMap;
    if (facilities.isNotEmpty) {
      searchMap = {
        'name': searchController.text,
        'address': addressController.text,
        'max_price': selectedPriceRange.end,
        'min_price': selectedPriceRange.start,
        'facilities[0]': facilities,
      };
    } else {
      searchMap = {
        'name': searchController.text,
        'address': addressController.text,
        'max_price': selectedPriceRange.end,
        'min_price': selectedPriceRange.start,
      };
    }
    try {
      DioHelper apiHelper = sl<DioHelper>();
      var value = await apiHelper.get(
        endPoint: '/search-hotels',
        token: token,
        query: searchMap,
      );
      // showToastMessage(message: "${value.data['message']}");
      searchHotelsData = AllHotelsData.fromJson(value);
      debugPrint("-----------------------------------------------");
      debugPrint(searchHotelsData!.data!.length.toString());
      debugPrint("-----------------------------------------------");

      emit(SuccessSearchState());
    } on DioError catch (e) {
      if (e.response == null) {
        // showToastMessage(message: "Check you connection", toastColor: Colors.red);
      } else {
        debugPrint(e.response!.data);
      
        // showToastMessage(message: "${e.response!.data['message']}", toastColor: Colors.red);
      }
      emit(FailedSearchState());
    }
  }

  DateTimeRange? dateRange;

  Future pickDateRange(BuildContext context) async {
    final initialDateRange = DateTimeRange(
      start: DateTime.now(),
      end: DateTime.now().add(const Duration(days: 1)),
    );
    dateRange = await showDateRangePicker(
      context: context,
      firstDate: DateTime.now(),
      lastDate: DateTime(DateTime.now().year + 5),
      initialDateRange: dateRange ?? initialDateRange,
      builder: (context, child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: mainAppColor,
            colorScheme: ColorScheme.light(primary: mainAppColor),
            buttonTheme:
                const ButtonThemeData(textTheme: ButtonTextTheme.primary),
          ),
          child: Column(
            children: [
              Expanded(
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 150, horizontal: 30),
                    child: Container(
                      clipBehavior: Clip.hardEdge,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: child,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
    emit(DateRangePickedState());
  }

  //filter data
  var selectedPriceRange = const RangeValues(0, 500);
  double currentDistanceValue = 5;

  //Number of rooms widget data
  int numberOfRooms = 1;
  int numberOfPeople = 1;

  void changeNumberOfRoomsWidget() {
    emit(NumberOfRoomsChangedState());
  }
}
