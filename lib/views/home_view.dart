// ignore_for_file: prefer_const_constructors

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:helloweather/bloc/weather_bloc.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {


  Widget getWeatherIcon(int code){
    switch (code) {
      case >=200 && <300:
        return Lottie.asset(
          'assets/thunderstorm.json'
        );
      case >=300 && < 500:
        return Lottie.asset('assets/clouds.json');
      case >= 500 && < 600:
        return Lottie.asset('assets/sun rain.json');
      case >= 600 && < 700:
        return Lottie.asset('assets/snow.json');
      case >= 700 && < 800:
        return Lottie.asset('assets/mist.json');
      case ==801:
        return Lottie.asset('assets/suncloud.json');
      default:
      return Lottie.asset(
        'assets/sun.json'
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.grey.shade800,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        systemOverlayStyle:
            const SystemUiOverlayStyle(statusBarBrightness: Brightness.dark),
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(40, 1.2 * kToolbarHeight, 40, 20),
        child: BlocBuilder<WeatherBloc, WeatherState>(
          builder: (context, state) {
            if (state is WeatherSuccess) {
              return SizedBox(
                height: MediaQuery.of(context).size.height,
                child: Stack(
                  children: [
                    Align(
                      alignment: AlignmentDirectional(3, -0.3),
                      child: Container(
                        height: 300,
                        width: 300,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.lightBlueAccent.shade400),
                      ),
                    ),
                    Align(
                      alignment: AlignmentDirectional(-3, -0.3),
                      child: Container(
                        height: 300,
                        width: 300,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.lightBlueAccent.shade400),
                      ),
                    ),
                    Align(
                      alignment: AlignmentDirectional(0, -1.2),
                      child: Container(
                        height: 300,
                        width: 600,
                        decoration: BoxDecoration(
                            color: Color.fromARGB(255, 64, 169, 255)),
                      ),
                    ),
                    BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 100.0, sigmaY: 100.0),
                      child: Container(
                        decoration: BoxDecoration(color: Colors.transparent),
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      child: Column(
                        children: [
                          //Area name...
                          Padding(
                            padding: EdgeInsets.only(top: 8.0),
                            child: Text(
                              '${state.weather.areaName}',
                              style: GoogleFonts.rowdies(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w300),
                            ),
                          ),

                          SizedBox(height: 8),

                          //welcome...
                          Text(
                            'Welcome',
                            style: GoogleFonts.rowdies(
                                color: Colors.white,
                                fontSize: 30,
                                fontWeight: FontWeight.bold),
                          ),

                          //Weather image...
                          getWeatherIcon(state.weather.weatherConditionCode!),

                          //Current temperature...
                          Text('${state.weather.temperature!.celsius!.round()} °C',
                              style: GoogleFonts.rowdies(
                                  color: Colors.white,
                                  fontSize: 55,
                                  fontWeight: FontWeight.w600)),

                          //Weather type...
                          Text(
                            '${state.weather.weatherMain!.toUpperCase()}',
                            style: GoogleFonts.rowdies(
                                color: Colors.white,
                                fontSize: 25,
                                fontWeight: FontWeight.w500),
                          ),

                          SizedBox(
                            height: 5,
                          ),

                          Center(
                            child: Text(
                              DateFormat('EEEE dd ').add_jm().format(state.weather.date!),
                              style: GoogleFonts.rowdies(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w300),
                            ),
                          ),

                          const SizedBox(
                            height: 30,
                          ),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Lottie.asset(
                                    'assets/sun.json',
                                    height: 50,
                                    width: 50,
                                  ),
                                  const SizedBox(
                                    width: 1,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Sunrise',
                                        style: GoogleFonts.rowdies(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w300),
                                      ),
                                      const SizedBox(
                                        height: 3,
                                      ),
                                      Text(
                                        DateFormat().add_jm().format(state.weather.sunrise!),
                                        style: GoogleFonts.rowdies(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w300),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                              Row(
                                children: [
                                  Lottie.asset(
                                    'assets/moon.json',
                                    height: 50,
                                    width: 50,
                                  ),
                                  const SizedBox(
                                    width: 1,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Sunset',
                                        style: GoogleFonts.rowdies(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w300),
                                      ),
                                      const SizedBox(
                                        height: 3,
                                      ),
                                      Text(
                                        DateFormat().add_jm().format(state.weather.sunset!),
                                        style: GoogleFonts.rowdies(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w300),
                                      ),
                                    ],
                                  )
                                ],
                              )
                            ],
                          ),

                          Padding(
                            padding: EdgeInsets.symmetric(
                              vertical: 5.0,
                            ),
                            child: Divider(
                              color: Colors.grey.shade700,
                            ),
                          ),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Lottie.asset(
                                    'assets/wind.json',
                                    height: 50,
                                    width: 50,
                                  ),
                                  const SizedBox(
                                    width: 1,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'vent',
                                        style: GoogleFonts.rowdies(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w300),
                                      ),
                                      const SizedBox(
                                        height: 3,
                                      ),
                                      Text(
                                        '${state.weather.windSpeed!} km/h',
                                        style: GoogleFonts.rowdies(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w300),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                              Row(
                                children: [
                                  Lottie.asset(
                                    'assets/humidity.json',
                                    height: 50,
                                    width: 50,
                                  ),
                                  const SizedBox(
                                    width: 1,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'humidité',
                                        style: GoogleFonts.rowdies(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w300),
                                      ),
                                      const SizedBox(
                                        height: 3,
                                      ),
                                      Text(
                                        '${state.weather.humidity!.round()}%',
                                        style: GoogleFonts.rowdies(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w300),
                                      ),
                                    ],
                                  )
                                ],
                              )
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
              );
            } else {
              return Center(child: Text('There is something went wrong !'));
            }
          },
        ),
      ),
    );
  }
}
