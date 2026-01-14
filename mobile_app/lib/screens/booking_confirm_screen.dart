import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../providers/flight_provider.dart';
import '../providers/booking_provider.dart';
import '../providers/passenger_provider.dart';

class BookingConfirmScreen extends StatefulWidget {
  const BookingConfirmScreen({super.key});

  @override
  State<BookingConfirmScreen> createState() => _BookingConfirmScreenState();
}

class _BookingConfirmScreenState extends State<BookingConfirmScreen> {
  final _descriptionController = TextEditingController();

  @override
  void dispose() {
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _confirmBooking() async {
    final flightProvider = context.read<FlightProvider>();
    final bookingProvider = context.read<BookingProvider>();
    final passengerProvider = context.read<PassengerProvider>();

    final flight = flightProvider.selectedFlight;
    final passenger = passengerProvider.currentPassenger;

    if (flight == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('No flight selected'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    if (passenger == null) {
      // Navigate to passenger registration
      final result = await Navigator.pushNamed(context, '/passenger-registration');
      if (result != true) return;
    }

    final currentPassenger = passengerProvider.currentPassenger;
    if (currentPassenger == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please complete passenger registration'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    final success = await bookingProvider.createBooking(
      passengerId: currentPassenger.id,
      flightId: flight.id,
      description: _descriptionController.text.isNotEmpty
          ? _descriptionController.text
          : 'Flight booking',
    );

    if (!mounted) return;

    if (success) {
      Navigator.pushReplacementNamed(context, '/booking-success');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(bookingProvider.error ?? 'Booking failed'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('EEEE, MMM dd, yyyy');
    final timeFormat = DateFormat('HH:mm');

    return Scaffold(
      appBar: AppBar(
        title: const Text('Confirm Booking'),
        backgroundColor: const Color(0xFF1565C0),
        foregroundColor: Colors.white,
      ),
      body: Consumer2<FlightProvider, PassengerProvider>(
        builder: (context, flightProvider, passengerProvider, child) {
          final flight = flightProvider.selectedFlight;
          final seat = flightProvider.selectedSeat;
          final passenger = passengerProvider.currentPassenger;

          if (flight == null) {
            return const Center(child: Text('No flight selected'));
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  'Booking Summary',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 24),
                _buildSectionCard(
                  title: 'Flight Details',
                  icon: Icons.flight,
                  children: [
                    _buildDetailRow('Flight', flight.flightNumber),
                    _buildDetailRow('Date', dateFormat.format(flight.flightDate)),
                    _buildDetailRow(
                      'Departure',
                      '${timeFormat.format(flight.departureDate)} - ${flight.departureAirportName ?? "N/A"}',
                    ),
                    _buildDetailRow(
                      'Arrival',
                      '${timeFormat.format(flight.arriveDate)} - ${flight.arriveAirportName ?? "N/A"}',
                    ),
                    _buildDetailRow('Duration', flight.formattedDuration),
                  ],
                ),
                const SizedBox(height: 16),
                if (seat != null)
                  _buildSectionCard(
                    title: 'Seat Details',
                    icon: Icons.event_seat,
                    children: [
                      _buildDetailRow('Seat Number', seat.seatNumber),
                      _buildDetailRow('Class', seat.classText),
                      _buildDetailRow('Type', seat.typeText),
                    ],
                  ),
                const SizedBox(height: 16),
                _buildSectionCard(
                  title: 'Passenger',
                  icon: Icons.person,
                  children: passenger != null
                      ? [
                          _buildDetailRow('Name', passenger.name),
                          _buildDetailRow('Passport', passenger.passportNumber),
                          _buildDetailRow('Type', passenger.passengerTypeText),
                        ]
                      : [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: TextButton.icon(
                              onPressed: () {
                                Navigator.pushNamed(
                                    context, '/passenger-registration');
                              },
                              icon: const Icon(Icons.add),
                              label: const Text('Complete Registration'),
                            ),
                          ),
                        ],
                ),
                const SizedBox(height: 16),
                _buildSectionCard(
                  title: 'Notes (Optional)',
                  icon: Icons.note,
                  children: [
                    TextField(
                      controller: _descriptionController,
                      maxLines: 3,
                      decoration: InputDecoration(
                        hintText: 'Add any special requests or notes...',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Total Amount',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        '\$${flight.price.toStringAsFixed(0)}',
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1565C0),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                Consumer<BookingProvider>(
                  builder: (context, bookingProvider, child) {
                    return ElevatedButton(
                      onPressed:
                          bookingProvider.isLoading ? null : _confirmBooking,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF1565C0),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: bookingProvider.isLoading
                          ? const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                valueColor:
                                    AlwaysStoppedAnimation<Color>(Colors.white),
                              ),
                            )
                          : const Text(
                              'Confirm Booking',
                              style: TextStyle(fontSize: 16),
                            ),
                    );
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildSectionCard({
    required String title,
    required IconData icon,
    required List<Widget> children,
  }) {
    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: const Color(0xFF1565C0), size: 20),
                const SizedBox(width: 8),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            ...children,
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(color: Colors.grey[600]),
          ),
          Text(
            value,
            style: const TextStyle(fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}
