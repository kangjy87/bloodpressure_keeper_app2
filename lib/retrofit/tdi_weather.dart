import 'package:dio/dio.dart';
import 'package:bloodpressure_keeper_app/retrofit/weather_server.dart';

class TdiWeather {
  final Function(WeatherServer ws) weatherServer ;
  TdiWeather({
    required this.weatherServer,
  }){
    WeatherServer ccg = getTdiServerSetting();
    Future.microtask((){
      weatherServer.call(ccg);
    });
  }
  WeatherServer getTdiServerSetting(){
    Dio dio = Dio();
    dio.options.contentType = Headers.jsonContentType ;
    dio.options.headers["x-tdi-client-secret"] = "n709wqyNorFhgEEMrPci15gETkvU4aWEF74cJTwkKadp5cXOT01uJMm3TOmp5x1kUw7q2hBG2rqEkt2yd6mG68Dy6msJz4Jes9wPpViGu4QhCgLpJh5FEqXr7iQ9N";
    dio.interceptors.add(InterceptorsWrapper());
    WeatherServer ccg = WeatherServer(dio);
    return ccg ;
  }
}
