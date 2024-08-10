import 'package:flutter/material.dart';
import 'package:rentit/features/home/domain/entity/car_entity.dart';
import 'package:rentit/features/home/presentation/pages/widgets/tapbar.dart';
import 'package:rentit/features/rental/presentation/pages/rental/widgets/booking_button.dart';
import 'package:rentit/utils/appcolors.dart';

class CarDetailPage extends StatelessWidget {
    final CarVehicleEntity car;

  // final String carId;
  // final String carName;
  // final String carType;
  // final String imageUrl;
  // final RangeValues pricePerHour;
  // final String fuelType;
  // final int seats;
  // final double rating;
  // final String transmission;

  const CarDetailPage({
    super.key, required this.car,
    // required this.carId,
    // required this.carName,
    // required this.carType,
    // required this.imageUrl,
    // required this.pricePerHour,
    // required this.fuelType,
    // required this.seats,
    // required this.rating,
    // required this.transmission,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ExternalAppColors.bg,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(icon: const Icon(Icons.share), onPressed: () {}),
          IconButton(icon: const Icon(Icons.favorite_border), onPressed: () {}),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(15)),
                height: 300,
                child: Image.network(car.imageUrls.first, fit: BoxFit.cover),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(car.model,
                      style: const TextStyle(fontSize: 18, color: Colors.grey)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(car.make,
                          style: const TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold)),
                      Row(
                        children: [
                          const Icon(Icons.star, color: Colors.amber),
                          Text(car.rentalPriceRange.toString(),
                              style: const TextStyle(fontSize: 18)),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  TabBarSection(car: car,
                    // carType: carName,
                    // fuelType: fuelType,
                    // seats: seats,
                    // rating: 4.9,
                    // transmission: 'Manual',
                    // imageUrl: imageUrl,
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Price: \$${car.rentalPriceRange.start.toStringAsFixed(2)}/hr',
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold)),
                  BookingButton(carId: car.carId)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget buildTabButton(String text, {bool isSelected = false}) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    decoration: BoxDecoration(
      color: isSelected ? Colors.blue : Colors.transparent,
      borderRadius: BorderRadius.circular(20),
    ),
    child: Text(
      text,
      style: TextStyle(color: isSelected ? Colors.white : Colors.black),
    ),
  );
}
