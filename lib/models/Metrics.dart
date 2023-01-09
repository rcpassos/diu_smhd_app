class Metrics {
  String phSoilMin = "";
  String phSoilMax = "";
  String soilMoistureMin = "";
  String soilMoistureMax = "";
  String uvIndexMin = "";
  String uvIndexMax = "";
  String temperatureMin = "";
  String temperatureMax = "";
  String humidityMin = "";
  String humidityMax = "";
  String lightIntensityMin = "";
  String lightIntensityMax = "";

  Metrics.empty();

  Metrics(
    this.phSoilMin,
    this.phSoilMax,
    this.soilMoistureMin,
    this.soilMoistureMax,
    this.uvIndexMin,
    this.uvIndexMax,
    this.temperatureMin,
    this.temperatureMax,
    this.humidityMin,
    this.humidityMax,
    this.lightIntensityMin,
    this.lightIntensityMax,
  );
}
