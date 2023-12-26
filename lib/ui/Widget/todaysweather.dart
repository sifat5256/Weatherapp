


import 'package:flutter/material.dart';
import 'package:flutter_weather_bg_null_safety/bg/weather_bg.dart';
import 'package:flutter_weather_bg_null_safety/flutter_weather_bg.dart';
import 'package:intl/intl.dart';
import 'package:weatherapp/model/weather_model.dart';

class TodaysWeather extends StatelessWidget {
  final WeatherModel? weatherModel;
  const TodaysWeather({super.key,this.weatherModel});

  WeatherType getWeathertype(Current?current){
    if (current?.isDay == 1) {
      if (current?.condition?.text == "Sunny") {
        return WeatherType.sunny;
      } else if (current?.condition?.text == "Overcast") {
        return WeatherType.overcast;
      } else if (current?.condition?.text == "Partly cloudy") {
        return WeatherType.cloudy;
      } else if (current?.condition?.text == "Cloudy") {
        return WeatherType.cloudy;
      } else if (current?.condition?.text == "Clear") {
        return WeatherType.sunny;
      } else if (current?.condition?.text == "Mist") {
        return WeatherType.lightSnow;
      } else if (current!.condition!.text!.contains("thunder")) {
        return WeatherType.thunder;
      } else if (current!.condition!.text!.contains("showers")) {
        return WeatherType.middleSnow;
      } else if (current!.condition!.text!.contains("rain")) {
        return WeatherType.heavyRainy;
      }
    } else {
      if (current?.condition?.text == "Sunny") {
        return WeatherType.sunny;
      } else if (current?.condition?.text == "Overcast") {
        return WeatherType.overcast;
      } else if (current?.condition?.text == "Partly cloudy") {
        return WeatherType.cloudyNight;
      } else if (current?.condition?.text == "Cloudy") {
        return WeatherType.cloudyNight;
      } else if (current?.condition?.text == "Clear") {
        return WeatherType.sunnyNight;
      } else if (current?.condition?.text == "Mist") {
        return WeatherType.lightSnow;
      } else if (current!.condition!.text!.contains("thunder")) {
        return WeatherType.thunder;
      } else if (current!.condition!.text!.contains("showers")) {
        return WeatherType.middleSnow;
      } else if (current!.condition!.text!.contains("rain")) {
        return WeatherType.heavyRainy;
      }
    }
    return WeatherType.middleRainy;
  }


  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        WeatherBg(
            weatherType: getWeathertype(weatherModel?.current),
            width: MediaQuery.of(context).size.width, height: 300),
        SizedBox(
          width: double.infinity,
          height: 300,
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white30,
                  borderRadius: BorderRadius.circular(11)
                ),
                child:Column(
                  children: [
                    Text(weatherModel?.location?.name??"",style: TextStyle(
                        fontSize: 30,fontWeight: FontWeight.bold,color: Colors.white
                    ),),
                    Text(DateFormat.yMMMMEEEEd().format(DateTime.parse(weatherModel?.current?.lastUpdated.toString()??"")),
                      style: TextStyle(
                          fontSize: 23,fontWeight: FontWeight.bold,color: Colors.white
                      ),),
                  ],
                ) ,
              ),
              Row(
                children: [
                  SizedBox(width: 10,),
                  Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,color: Colors.white10
                      ),

                      child: Image.network("https:${weatherModel?.current?.condition?.icon??""}",)),
                  Spacer(),
                  Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(weatherModel?.current?.tempC.toString()??"",style: TextStyle(
                              fontSize: 70,fontWeight: FontWeight.bold,color: Colors.red
                          ),),
                          Text("o",style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 25
                          ),)
                        ],
                      ),
                      Text(weatherModel?.current?.condition?.text??"",style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500
                      ),)
                    ],
                  )
                ],
              ),
              SizedBox(height: 30,),
              Container(
                margin: EdgeInsets.all(8),
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white30,
                  borderRadius: BorderRadius.circular(10)
                ),
                child:Column(
                  children: [
                    Row(
                      children: [
                        Text("Feelings Like "
                            "${weatherModel?.current?.feelslikeC?.toString()}",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 20),),
                        Spacer(),
                        Text("Wind Kph "
                            "${weatherModel?.current?.windKph?.toString()}",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 20),),

                      ],
                    ),
                    SizedBox(height: 20,),
                    Row(
                      children: [
                        Text("Humidity "
                            "${weatherModel?.current?.humidity ?.toString()}%",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 20),),
                        Spacer(),
                        Text("Visibility "
                            "${weatherModel?.current?.visKm?.toString()} km",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 20),),

                      ],
                    ),
                  ],
                ) ,
              ),




            ],
          ),
        ),
      ],
    );
  }
}
