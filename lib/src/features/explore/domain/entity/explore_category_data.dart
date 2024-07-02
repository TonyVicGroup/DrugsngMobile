import 'package:drugs_ng/src/core/contants/app_image.dart';

class ExploreCategoryData {
  final String image;
  final String title;
  final String subtitle;

  ExploreCategoryData({
    required this.image,
    required this.title,
    required this.subtitle,
  });

  static List<ExploreCategoryData> get all => [
        ExploreCategoryData(
          image: AppImage.generalHealth,
          title: "General Health",
          subtitle:
              "Explore a wide range of medications and supplements for overall health, including antimalaria and pain relief.",
        ),
        ExploreCategoryData(
          image: AppImage.heartHealth,
          title: "Heart Health",
          subtitle:
              "Discover medications and treatments for angina, arrhythmia, heart failure, high blood pressure, and more.",
        ),
        ExploreCategoryData(
          image: AppImage.lungHealth,
          title: "Lung Health",
          subtitle:
              "Find effective treatments for asthma, COPD, and other respiratory conditions to ensure healthy lungs.",
        ),
        ExploreCategoryData(
          image: AppImage.digestiveHealth,
          title: "Digestive Health",
          subtitle:
              "Explore solutions for acid reflux, Crohn's disease, and other gastrointestinal issues.",
        ),
        ExploreCategoryData(
          image: AppImage.womenHealth,
          title: "Women Health",
          subtitle:
              "Discover treatments and supplements for birth control, fertility, and overall reproductive health.",
        ),
      ];
}
