class WeatherUtil{
  static String getWeatherStr(int skyType, int ptyType, int lgt){
    if( skyType == 1 ){
      // 맑음
      return ( lgt > 0 ) ? "맑은날 번개" : "맑음";
    }else if( skyType == 3 ) {
      // 구름
      return (lgt > 0) ? "구름낀날 번개" : "구름";
    }else if( skyType == 4 ) {
      // 흐림
      if( ptyType == 1 ){
        // 비
        return (lgt > 0) ? "비 내리는 날 번개" : "비";
      }else if( ptyType == 2 ){
        // 비/눈
        return (lgt > 0) ? "비/눈 내리는 날 번개" : "비/눈";
      }else if( ptyType == 3 ){
        // 눈
        return (lgt > 0) ? "눈 내리는 날 번개" : "눈";
      }else if( ptyType == 4 ){
        // 소나기
        return (lgt > 0) ? "소나기 내리는 날 번개" : "소나기";
      }else{
        // 알수없음
        return ( lgt > 0 ) ? "맑은날 번개" : "맑음";
      }
    }else{
      // 기타
      // 0 : 없음, 1 : 비, 2 : 비/눈, 3 : 눈, 4 : 소나기
      if( ptyType == 1 ){
        // 비
        return (lgt > 0) ? "비 내리는 날 번개" : "비";
      }else if( ptyType == 2 ){
        // 비/눈
        return (lgt > 0) ? "비/눈 내리는 날 번개" : "비/눈";
      }else if( ptyType == 3 ){
        // 눈
        return (lgt > 0) ? "눈 내리는 날 번개" : "눈";
      }else if( ptyType == 4 ){
        // 소나기
        return (lgt > 0) ? "소나기 내리는 날 번개" : "소나기";
      }else{
        // 알수없음
        return "맑음";
      }
    }
  }

  static String getWeatherImage(int skyType, int ptyType, int lgt){
    if( skyType == 1 ){
      // 맑음
      return ( lgt > 0 ) ? "images/weather_s.png" : "images/weather_s.png";
    }else if( skyType == 3 ) {
      // 구름
      return (lgt > 0) ? "images/weather_sc.png" : "images/weather_sc.png";
    }else if( skyType == 4 ) {
      // 흐림
      if( ptyType == 1 ){
        // 비
        return (lgt > 0) ? "images/weather_r.png" : "images/weather_r.png";
      }else if( ptyType == 2 ){
        // 비/눈
        return (lgt > 0) ? "images/weather_sn.png" : "images/weather_sn.png";
      }else if( ptyType == 3 ){
        // 눈
        return (lgt > 0) ? "images/weather_sn.png" : "images/weather_sn.png";
      }else if( ptyType == 4 ){
        // 소나기
        return (lgt > 0) ? "images/weather_r.png" : "images/weather_r.png";
      }else{
        // 알수없음
        return ( lgt > 0 ) ? "images/weather_s.png" : "images/weather_s.png";
      }
    }else{
      // 기타
      // 0 : 없음, 1 : 비, 2 : 비/눈, 3 : 눈, 4 : 소나기
      if( ptyType == 1 ){
        // 비
        return (lgt > 0) ? "images/weather_r.png" : "images/weather_r.png";
      }else if( ptyType == 2 ){
        // 비/눈
        return (lgt > 0) ? "images/weather_sn.png" : "images/weather_sn.png";
      }else if( ptyType == 3 ){
        // 눈
        return (lgt > 0) ? "images/weather_sn.png" : "images/weather_sn.png";
      }else if( ptyType == 4 ){
        // 소나기
        return (lgt > 0) ? "images/weather_r.png" : "images/weather_r.png";
      }else{
        // 알수없음
        return "images/weather_s.png";
      }
    }
  }

  static String getWeatherImage2(int skyType, int ptyType, int lgt){
    if( skyType == 1 ){
      // 맑음
      return ( lgt > 0 ) ? "images/weather_s.png" : "images/weather_s.png";
    }else if( skyType == 3 ) {
      // 구름
      return (lgt > 0) ? "images/weather_cloud.png" : "images/weather_cloud.png";
    }else if( skyType == 4 ) {
      // 흐림
      if( ptyType == 1 ){
        // 비
        return (lgt > 0) ? "images/weather_r.png" : "images/weather_r.png";
      }else if( ptyType == 2 ){
        // 비/눈
        return (lgt > 0) ? "images/weather_sn.png" : "images/weather_sn.png";
      }else if( ptyType == 3 ){
        // 눈
        return (lgt > 0) ? "images/weather_sn.png" : "images/weather_sn.png";
      }else if( ptyType == 4 ){
        // 소나기
        return (lgt > 0) ? "images/weather_r.png" : "images/weather_r.png";
      }else{
        // 알수없음
        return ( lgt > 0 ) ? "images/weather_s.png" : "images/weather_s.png";
      }
    }else{
      // 기타
      // 0 : 없음, 1 : 비, 2 : 비/눈, 3 : 눈, 4 : 소나기
      if( ptyType == 1 ){
        // 비
        return (lgt > 0) ? "images/weather_r.png" : "images/weather_r.png";
      }else if( ptyType == 2 ){
        // 비/눈
        return (lgt > 0) ? "images/weather_sn.png" : "images/weather_sn.png";
      }else if( ptyType == 3 ){
        // 눈
        return (lgt > 0) ? "images/weather_sn.png" : "images/weather_sn.png";
      }else if( ptyType == 4 ){
        // 소나기
        return (lgt > 0) ? "images/weather_r.png" : "images/weather_r.png";
      }else{
        // 알수없음
        return "images/m_sb_weather_fine.png";
      }
    }
  }

  static String getWeatherImageFromWeatherStr(String weatherStr){
    if( weatherStr == '구름' || weatherStr == '흐림' || weatherStr == '구름많음' ) {
      // 구름
      return "images/weather_r.png";
    }else if( weatherStr == '구름많고 비' ) {
      return "images/weather_sn.png";
    }else if( weatherStr == '구름많고 눈' ) {
      return "images/weather_sn.png";
    }else if( weatherStr == '구름많고 비/눈' ) {
      return "images/weather_r.png";
    }else if( weatherStr == '구름많고 소나기' ) {
      return "images/weather_s.png";
    }
    else{
      return "images/weather_s.png";
    }
  }
}