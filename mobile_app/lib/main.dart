import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'services/services.dart';
import 'providers/providers.dart';
import 'screens/screens.dart';

void main() {
  runApp(const BookingApp());
}

class BookingApp extends StatelessWidget {
  const BookingApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Initialize services
    final apiService = ApiService();
    final authService = AuthService(apiService);
    final flightService = FlightService(apiService);
    final passengerService = PassengerService(apiService);
    final bookingService = BookingService(apiService);

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => AuthProvider(authService),
        ),
        ChangeNotifierProvider(
          create: (_) => FlightProvider(flightService),
        ),
        ChangeNotifierProvider(
          create: (_) => PassengerProvider(passengerService),
        ),
        ChangeNotifierProvider(
          create: (_) => BookingProvider(bookingService),
        ),
      ],
      child: MaterialApp(
        title: 'Flight Booking',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color(0xFF1565C0),
          ),
          useMaterial3: true,
          appBarTheme: const AppBarTheme(
            centerTitle: true,
          ),
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => const SplashScreen(),
          '/login': (context) => const LoginScreen(),
          '/register': (context) => const RegisterScreen(),
          '/home': (context) => const HomeScreen(),
          '/flights': (context) => const FlightsScreen(),
          '/flight-details': (context) => const FlightDetailsScreen(),
          '/booking-confirm': (context) => const BookingConfirmScreen(),
          '/booking-success': (context) => const BookingSuccessScreen(),
          '/bookings': (context) => const BookingsScreen(),
          '/passenger-registration': (context) =>
              const PassengerRegistrationScreen(),
        },
      ),
    );
  }
}
