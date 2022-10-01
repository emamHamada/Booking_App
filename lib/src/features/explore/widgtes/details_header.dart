import 'package:booking_app/src/app/core/components/buttons/main_button.dart';
import 'package:booking_app/src/app/core/utils/colors_manager.dart';
import 'package:booking_app/src/app/core/utils/mediaquery_managment.dart';
import 'package:booking_app/src/app/core/utils/text_styles_manager.dart';
import 'package:booking_app/src/features/explore_hotels/data/models/hotel_data.dart';
import 'package:flutter/material.dart';

class DetailsHeader extends StatelessWidget {
  final HotelData hotelData;
  const DetailsHeader({Key? key, required this.hotelData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  hotelData.name!,
                  style: TextStyle(
                      fontSize: 22,
                      color: Colors.black,
                      fontWeight: FontWeightManager.bold),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
                SizedBox(height: 10,),
                Container(
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          hotelData.address!.split(",")[1],
                          style: TextStyle(fontSize: 15, color: Colors.grey.shade600),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),

                    ],
                  ),
                ),
                SizedBox(height: 5,),
                Row(
                  children: [
                    Icon(
                      Icons.location_on,
                      color: ColorManager.primaryColor,
                      size: 20,
                    ),
                    Text(
                      "5.0km to city",
                      style: TextStyle(fontSize: 15, color: Colors.grey.shade600),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        Column(
          children: [
            Text(
              "\$" + hotelData.price!,
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            Text(
              "/per night",
              style: TextStyle(fontSize: 15, color: Colors.grey),
            )
          ],
        )
      ],
    );
  }
}