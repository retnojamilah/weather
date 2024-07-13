import 'package:flutter/material.dart';
import 'data_service.dart';
import 'weather.dart'; // mengimport data dari class weather

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MainPage(),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  TextEditingController controller = TextEditingController();
  DataService dataService = DataService();
  Weather? weather;
  bool isFetch = false; //apabila data benar maka

  @override
  Widget build(BuildContext context) {
    // mengatur ukuran layar
    final size = MediaQuery.of(context).size;
    final orientation = MediaQuery.of(context).orientation;

    return Scaffold(
      appBar: AppBar(
        title: Text('WEATHER RETNO'), // nama program yang dibuat
        centerTitle: true,
      ),
      body: Container(
        width: size.width,
        height: size.height,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("images/sea.jpg"),
            fit: BoxFit.cover, // untuk mengatur image memenuhi container
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (isFetch && weather != null)
                Column(
                  children: [
                    Image.network(
                        'https://openweathermap.org/img/wn/${weather!.icon}@2x.png'), // gambar dari weather icon
                    Text(
                      '${weather!.temp}°',
                      style:
                          Theme.of(context).textTheme.headlineLarge?.copyWith(
                                color: Colors
                                    .white, // mengatur warna derajat temperatur
                              ),
                    ),
                    Text(
                      weather!.description,
                      style: Theme.of(context)
                          .textTheme
                          .headlineMedium
                          ?.copyWith(
                            color:
                                Colors.white, //mengatur warna deskripsi weather
                          ),
                    ),
                  ],
                ),
              Container(
                width: orientation == Orientation.portrait
                    ? size.width * 0.7
                    : size.width *
                        0.5, // untuk mengatur responsive,,tapi gambar belum responsive cek lagi
                padding: EdgeInsets.symmetric(vertical: 20),
                child: TextField(
                  controller: controller,
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    labelText: 'Ketik Negara atau Kota Yang dicari:',
                    labelStyle: TextStyle(
                      fontWeight:
                          FontWeight.bold, // membold tulisan dicontainer
                      fontSize: 19, // ukuran tulisan
                      color: Colors.black, // mengatur warna label
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  weather = await dataService.fetchData(controller.text);
                  setState(() {
                    isFetch = true;
                  });
                },
                style: ElevatedButton.styleFrom(
                  //membuat button search dan mengatur warnaa
                  backgroundColor: const Color.fromARGB(255, 151, 188, 218),
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(
                      horizontal: 20, vertical: 12), // Padding
                  textStyle: TextStyle(
                    fontSize: 12, // Text size
                  ),
                ),
                child: Text('Search'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
