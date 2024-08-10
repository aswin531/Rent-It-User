import 'package:flutter/material.dart';
import 'package:rentit/features/home/domain/entity/car_entity.dart';
import 'package:rentit/features/home/presentation/pages/cardetailpage.dart';
import 'package:rentit/utils/appcolors.dart';

class CarCard extends StatelessWidget {
  final CarVehicleEntity car;
  //  final String carId;
  // final String imageUrl;
  // final String carType;
  // final String carName;
  // final RangeValues pricePerHour;
  // final String fuelType;
  // final int seats;
  // final double rating;
  // final String? transmission;

  const CarCard({
    super.key,
    required this.car,
    // required this.carId,
    // required this.imageUrl,
    // required this.carType,
    // required this.carName,
    // required this.pricePerHour,
    // required this.fuelType,
    // required this.seats,
    // required this.rating,
    // this.transmission,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CarDetailPage(
                car: car,
                // carId: carId,
                // carName: carName,
                // carType: carType,
                // imageUrl: imageUrl,
                // pricePerHour: pricePerHour,
                // fuelType: fuelType,
                // seats: seats,
                // rating: rating,
                // transmission: transmission ?? "Manual"
              ),
            ));
      },
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Container(
          padding: const EdgeInsets.all(16),
          margin: const EdgeInsets.only(bottom: 16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        color: ExternalAppColors.bg,
                        borderRadius: BorderRadius.circular(16)),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: Image.network(
                          car.imageUrls.first,
                          width: double.infinity,
                          height: 200,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 15,
                    left: 15,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Row(
                        children: [
                          Icon(Icons.star, color: Colors.yellow, size: 16),
                          SizedBox(width: 4),
                          Text(
                            '4.9',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    top: 15,
                    right: 15,
                    child: IconButton(
                      icon: const Icon(Icons.favorite_border,
                          color: Colors.black),
                      onPressed: () {},
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Container(
                  decoration: BoxDecoration(
                      color: const Color.fromRGBO(246, 246, 246, 1),
                      // border: Border.all(color: Colors.blue),
                      borderRadius: BorderRadius.circular(5)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(car.body,
                        style: const TextStyle(color: Colors.blue)),
                  )),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(car.make,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 18)),
                  Text(
                    '\$${car.rentalPriceRange.start.toStringAsFixed(2)}/hr',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                ],
              ),
              Divider(
                color: ExternalAppColors.bg,
                thickness: 1,
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  const SizedBox(width: 20),
                  const Icon(
                    Icons.local_gas_station,
                    size: 16,
                    color: Colors.blue,
                  ),
                  Text(car.engine),
                  const SizedBox(width: 90),
                  const SizedBox(width: 8),
                  const Icon(
                    Icons.person,
                    size: 16,
                    color: Colors.blue,
                  ),
                  Text('${car.seatCapacity} Seats'),
                  const SizedBox(width: 90),
                  const Icon(
                    Icons.adjust_outlined,
                    size: 16,
                    color: Colors.blue,
                  ),
                  const SizedBox(width: 8),
                  const Text('Manual',
                      style:  TextStyle(color: Colors.black)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
