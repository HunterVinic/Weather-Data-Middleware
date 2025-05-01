import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore _firestore;

  FirestoreService() : _firestore = FirebaseFirestore.instance;

  Future<void> addWeatherData(Map<String, dynamic> weatherData) async {
    try {
      await _firestore.collection('weather_data')
          .doc(DateTime.now().toUtc().toString())
          .set({
        'weatherData': weatherData,
        'createdAt': FieldValue.serverTimestamp(),
      });
      print('✅ Data successfully written to Firestore');
    } catch (e) {
      print('❌ Firestore error: $e');
      rethrow;
    }
  }
}