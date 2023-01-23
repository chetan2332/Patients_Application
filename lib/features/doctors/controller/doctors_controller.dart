import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:patient/features/doctors/repository/doctors_repository.dart';
import 'package:patient/models/doctor.dart';

final doctorsControllerProvider = Provider((ref) {
  final doctorsRepository = ref.watch(doctorsRepositoryProvider);
  return DoctorsController(doctorsRepository);
});

class DoctorsController {
  final DoctorsRepository doctorsRepository;
  DoctorsController(this.doctorsRepository);

  Stream<List<Doctor>> getDoctorsList() {
    return doctorsRepository.getDoctorsList();
  }

  Future<List<Doctor>> getRegisteredDoctorsList() {
    return doctorsRepository.getRegisteredDoctorsList();
  }
}
