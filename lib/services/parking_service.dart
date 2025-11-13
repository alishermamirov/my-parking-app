import 'package:firebase_database/firebase_database.dart';
import 'package:my_parking_app/models/booking_model.dart';

import '../models/parking_model.dart';

class ParkingService {
  final FirebaseDatabase database = FirebaseDatabase.instance;

  //parkings
  Future<List<ParkingModel>> getParkings() async {
    final snapshot = await database.ref('parkings').get();

    if (snapshot.exists && snapshot.value != null) {
      final Map<dynamic, dynamic> rawData =
          snapshot.value as Map<dynamic, dynamic>;

      final List<ParkingModel> parkings = rawData.entries.map((entry) {
        final key = entry.key.toString();
        final value = Map<String, dynamic>.from(entry.value);
        // print(value);
        return ParkingModel.fromJson(value).copyWith(id: key);
      }).toList();
      return parkings;
    } else {
      return [];
    }
  }

  //slots
  // Future getParkingAreas(final String parkingId) async {
  //    final query = database.ref("parkingAreas/${parkingId}");
  // }

  //bookings

  Future bookSlot(BookingModel data) async {
    final slotRef = database.ref(
      "parkingAreas/${data.parkingId}/slots/${data.index}",
    );

    await slotRef.update({"isOccupied": false});
    await saveBooking(data);
  }

  Future saveBooking(BookingModel booking) async {
    final bookingRef = database.ref('bookings/${booking.userId}').push();
    await bookingRef.set(booking.toJson());
  }

  Future<List<BookingModel>> getBooking(String userId) async {
    final snapshot = await database.ref('bookings/${userId}').get();

    // final snapshot = await bookingRef.get();
    if (snapshot.exists && snapshot.value != null) {
      final Map<dynamic, dynamic> rawData =
          snapshot.value as Map<dynamic, dynamic>;

      final bookings = rawData.entries.map<BookingModel>((entry) {
        final key = entry.key.toString();
        final value = Map<String, dynamic>.from(entry.value);
        return BookingModel.fromJson(value).copyWith(id: key);
      }).toList();

      return bookings;
    } else {
      return [];
    }
  }
  // Future<List<BookingModel>> getBooking(String userId) async {
  //   final bookingRef = database.ref('bookings/${userId}');

  //   final snapshot = await bookingRef.get();
  //   if (snapshot.exists && snapshot.value != null) {
  //     final Map<dynamic, dynamic> rawData =
  //         snapshot.value as Map<dynamic, dynamic>;

  //     final List bookings = rawData.entries.map((entry) {
  //       final key = entry.key.toString();
  //       final value = Map<String, dynamic>.from(entry.value);
  //       return BookingModel.fromJson(value).copyWith(id: key);
  //     }).toList();
  //     return bookings as List<BookingModel>;
  //   } else {
  //     return [];
  //   }
  //   // final snapshot = await bookingRef.get();

  //   // if (snapshot.exists && snapshot.value != null) {
  //   //   final data = Map<String, dynamic>.from(snapshot.value as Map);
  //   //   return BookingModel.fromJson(data).copyWith(id: bookingId);
  //   // } else {
  //   //   throw Exception("Booking not found");
  //   // }
  // }

  // Future<List<BookingModel>> getBooking(String userId) async {
  //   try {
  //     final bookingRef = database.ref('bookings/$userId');
  //     final snapshot = await bookingRef.get();

  //     if (!snapshot.exists || snapshot.value == null) {
  //       return [];
  //     }

  //     final value = snapshot.value;

  //     if (value is Map) {
  //       final Map<dynamic, dynamic> rawData = value;

  //       final List<BookingModel> bookings = rawData.entries.map((entry) {
  //         final key = entry.key.toString();
  //         final data = Map<String, dynamic>.from(entry.value as Map);
  //         return BookingModel.fromJson(data).copyWith(id: key);
  //       }).toList();

  //       return bookings;
  //     } else {
  //       debugPrint("❌ Booking ma'lumot tipi noto‘g‘ri: ${value.runtimeType}");
  //       return [];
  //     }
  //   } catch (e) {
  //     debugPrint("🔥 Firebase getBooking xato: $e");
  //     return [];
  //   }
  // }

  Future removeBooking(String userId, String bookingId) async {
    print(bookingId);
    print('bookings/${userId}/${bookingId}');
    final bookingRef = database.ref('bookings/${userId}/${bookingId}');
    await bookingRef.remove();
  }

  Future cancelSlot(BookingModel data) async {
    print("parkingAreas/${data.parkingId}/slots/${data.index}");
    final slotRef = database.ref(
      "parkingAreas/${data.parkingId}/slots/${data.index}",
    );

    await slotRef.update({"isOccupied": true});
    await removeBooking(data.userId, data.id);
  }
}
