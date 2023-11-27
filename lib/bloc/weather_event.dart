part of 'weather_bloc.dart';

sealed class WeatherEvent extends Equatable {
  const WeatherEvent();

  @override
  List<Object> get props => [];
}

class fetchWeather extends WeatherEvent{
 final Position position;

 const fetchWeather(this.position);
}