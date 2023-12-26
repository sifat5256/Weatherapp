

import 'package:flutter/material.dart';
import 'package:weatherapp/model/weather_model.dart';
import 'package:weatherapp/service/api_service.dart';
import 'package:weatherapp/ui/Widget/fururelistItem.dart';
import 'package:weatherapp/ui/Widget/hourlyweather.dart';
import 'package:weatherapp/ui/Widget/todaysweather.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  ApiService apiService=ApiService();
  final _texfieldcontrolar = TextEditingController();
  String searchText="auto:ip";

  _showTextInputDialog(BuildContext context) async{
    return showDialog(context: context, builder: (context){
      return  AlertDialog(
        title: Text("Search Location"),
        content: TextField(
          controller: _texfieldcontrolar,
          decoration: InputDecoration(
            hintText:"search city,zip",

          ),


        ),
        actions: [
          ElevatedButton(onPressed: (){

            if(_texfieldcontrolar.text.isEmpty){
              return;
            }

            Navigator.pop(context,_texfieldcontrolar.text);
          }, child: Text("Ok")),
          ElevatedButton(onPressed: (){
            Navigator.pop(context);
          }, child: Text("Cancel"))

        ],
      );
    });


  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text("Flutter weather app"),
        centerTitle: true,
        elevation: 0,
        actions: [
          IconButton(onPressed: ()async{
            _texfieldcontrolar.clear();
            String text = await _showTextInputDialog(context);
            setState(() {
              searchText=text;
            });


          }, icon: Icon(Icons.search)),
          IconButton(onPressed: (){
            searchText="auto:ip";
            setState(() {

            });
          }, icon: Icon(Icons.my_location)),
        ],
      ),
      body: SafeArea(

        child: FutureBuilder(builder: (context,snapshot){
          if(snapshot.hasData){
            WeatherModel? weatherModel=snapshot.data;
            return SizedBox(
              width: double.infinity,
              child: Column(
                children: [
                  TodaysWeather(
                    weatherModel: weatherModel,
                  ),
                 const SizedBox(height: 10,),
                  const  Text("Weather by Hour",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold,color: Colors.white),),
                  const SizedBox(height: 10,),
                   SizedBox(
                    height: 150,
                    child:ListView.builder(itemBuilder: (context,index){
                      Hour? hour= weatherModel?.forecast?.forecastday?[0].hour?[index];
                      return HourlyWeather(
                        hour : hour,

                      );

                    },
                      itemCount:weatherModel?.forecast?.forecastday?[0].hour?.length,
                      scrollDirection: Axis.horizontal,) ,
                  ),
                  const SizedBox(height: 10,),
                  const Text("Next 7 Days Weather",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold,color: Colors.white),),
                  const SizedBox(height: 10,),
                  Expanded(
                    child: ListView.builder(itemBuilder: (context,index){
                      Forecastday? forecastday=weatherModel?.forecast?.forecastday?[index];
                      return FtureListItem(
                        forecastday: forecastday,
                      );
                    },
                      itemCount:weatherModel?.forecast?.forecastday?.length ,),
                  )


                ],
              ),
            );



          }
          if(snapshot.hasError){
            return Center(
              child: Text("Error Has Occered"),
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );




        }, future: apiService.getWeatherData(searchText),),
      ),

    );
  }
}
