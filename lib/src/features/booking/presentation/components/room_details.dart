import 'package:booking_app/src/app/core/helpers/cash_helper.dart';
import 'package:booking_app/src/features/booking/cubit/booking_cubit.dart';
import 'package:flutter/material.dart';

import '../../../../app/core/components/buttons/main_button.dart';
import '../../../../app/core/utils/assets_manager.dart';

class RoomDetails extends StatelessWidget {
  final String roomType;
  final int pricePerNight;
  final int? hotelId;
  final String image;
  const RoomDetails({Key? key, required this.roomType, required this.pricePerNight, required this.hotelId, required this.image}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(
          image,
          height: 250,
          width: double.infinity,
          fit: BoxFit.cover,
          // height: 50,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  Expanded(
                    child: Text(
                      roomType,
                      style: Theme.of(context)
                          .textTheme
                          .headline5!
                          .copyWith(fontWeight: FontWeight.bold),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Container(
                      width: 110,
                      height: 40,
                      child: MainButton(
                        txt: 'Book now',
                        onPressed: () {
                          BookingCubit.get(context).createBooking(token: CashHelper.getData('token'), hotelId: hotelId);
                          BookingCubit.get(context).getAllBookingsTypes(token: CashHelper.getData('token'),);
                          Navigator.pop(context);

                        },
                      ))

                ],
              ),
              const SizedBox(height: 10,),
              Row(
                children: [
                  Text(
                    "\$$pricePerNight",
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge!
                        .copyWith(fontWeight: FontWeight.bold),
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    "/per night",
                    style: Theme.of(context).textTheme.bodyMedium,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      'sleeps 2 people + 2 children',
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(color: Colors.grey),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  InkWell(
                    onTap: () {},
                    child: Row(
                      children: [
                        Text(
                          "More details",
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        const Icon(Icons.keyboard_arrow_down),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
