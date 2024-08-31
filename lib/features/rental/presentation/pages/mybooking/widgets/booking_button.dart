import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rentit/features/payments/presentation/bloc/stripe/stripe_bloc.dart';
import 'package:rentit/features/payments/presentation/bloc/stripe/stripe_event.dart';
import 'package:rentit/features/payments/presentation/bloc/stripe/stripe_state.dart';
import 'package:rentit/features/payments/presentation/pages/review_summary/review_summary_card.dart';
import 'package:rentit/features/rental/presentation/bloc/rental_bloc/rental_bloc.dart';
import 'package:rentit/features/rental/presentation/bloc/rental_bloc/rental_event.dart';
import 'package:rentit/utils/primary_text.dart';

class ActionButtons extends StatelessWidget {
  final String rentalPrice;
  const ActionButtons({super.key, required this.rentalPrice});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PaymentBloc, PaymentState>(
      listener: (context, state) {
        if (state is PaymentSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Payment successful!')),
          );
          final user = FirebaseAuth.instance.currentUser!.uid;
          context
              .read<RentalRequestBloc>()
              .add(FetchUserRentalRequestsWithCarDetailsEvent(user));

          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => const ReviewSummaryScreen(),
            ),
          );
        } else if (state is PaymentFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        }
      },
      builder: (context, state) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(backgroundColor: Colors.grey),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
                onPressed: state is PaymentLoading
                    ? null
                    : () {
                        context.read<PaymentBloc>().add(MakePaymentEvent(
                            amount: double.parse(rentalPrice).toInt(),
                            currency: 'usd'));
                      },
                style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                child: const PrimaryText(
                  text: 'Pay to proceed',
                  size: 14,
                )),
          ],
        );
      },
    );
  }
}
