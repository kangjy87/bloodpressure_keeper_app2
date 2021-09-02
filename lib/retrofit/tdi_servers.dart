import 'package:dio/dio.dart';
import 'package:bloodpressure_keeper_app/retrofit/blood_pressure_server.dart';

class TdiServers {
  final Function(BloodPressureServer bps) bloodPressureServer ;
  TdiServers({
    required this.bloodPressureServer,
  }){
    BloodPressureServer ccg = getTdiServerSetting();
    Future.microtask((){
      bloodPressureServer.call(ccg);
    });
  }

  BloodPressureServer getTdiServerSetting(){
    Dio dio = Dio();
    dio.options.contentType = Headers.jsonContentType ;
    dio.interceptors.add(InterceptorsWrapper());
    BloodPressureServer ccg = BloodPressureServer(dio);
    return ccg ;
  }
}
