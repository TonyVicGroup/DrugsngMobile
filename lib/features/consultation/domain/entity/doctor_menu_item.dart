import 'package:equatable/equatable.dart';

class DoctorMenuItem extends Equatable {
  final String title;
  final List<String> options;

  const DoctorMenuItem(this.title, this.options);

  static const specialty = DoctorMenuItem(
    "Filter by Specialty",
    [
      "Dermatology",
      "Opthamology",
      "Cardiology",
      "Dental",
      "Neurology",
      "Psychiatry",
      "Oncology",
      "Anaesthesiology",
    ],
  );
  static const location = DoctorMenuItem(
    "Filter By Location",
    [
      "Abia",
      "Adamawa",
      "Akwa Ibom",
      "Anambra",
      "Bauchi",
      "Bayelsa",
      "Benue",
      "Borno",
      "Cross River",
      "Delta",
      "Ebonyi",
      "Edo",
      "Ekiti",
      "Enugu",
      "FCT - Abuja",
      "Gombe",
      "Imo",
      "Jigawa",
      "Kaduna",
      "Kano",
      "Katsina",
      "Kebbi",
      "Kogi",
      "Kwara",
      "Lagos",
      "Nasarawa",
      "Niger",
      "Ogun",
      "Ondo",
      "Osun",
      "Oyo",
      "Plateau",
      "Rivers",
      "Sokoto",
      "Taraba",
      "Yobe",
      "Zamfara"
    ],
  );
  static const rating =
      DoctorMenuItem("Filter By Rating", ["4", "3", "2", "1"]);

  @override
  // TODO: implement props
  List<Object?> get props => [title, options];
}
