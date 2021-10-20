import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:bloodpressure_keeper_app/model/blood_pressure_item.dart';
import 'package:bloodpressure_keeper_app/utils/day_util.dart' ;


class BloodPressureLocalDB{
  final String _BLOOD_PRESSURE_DATA = 'BLOOD_PRESSURE_DATA';
  static String _CREATE_TABLE = "CREATE TABLE BLOOD_PRESSURE_DATA( id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, saveData TEXT,rData TEXT, systolic INTEGER, diastole INTEGER, pulse INTEGER, memo TEXT, dayOfTheWeek INTEGER, registeredType INTEGER, temperature TEXT, weatherImg TEXT, weatherTemp TEXT, weatherInfo TEXT )";
  Map<int, String> migrationScripts = {
    1: _CREATE_TABLE,
    2: ' ALTER TABLE BLOOD_PRESSURE_DATA ADD COLUMN sendServerYM INTEGER '
  };
  var _db;
  Future<Database> get database async {
    int nbrMigrationScripts = migrationScripts.length;
    if (_db != null) return _db;
    _db = openDatabase(
      join(await getDatabasesPath(), 'BLOOD_PRESSURE_DATA.db'),
      version: nbrMigrationScripts,
      onCreate: (Database db, int version) async {
        var batch = db.batch();
        await db.execute(migrationScripts[1]!);
        await batch.commit();
      },
      onUpgrade: (db, oldVersion, newVersion) async {
        if(oldVersion != newVersion){
          var batch = db.batch();
          for (int i = oldVersion + 1; i <= newVersion; i++) {
            await db.execute(migrationScripts[i]!);
          }
          await batch.commit();
        }
      },
    );
    return _db;
  }

  //Create(Insert) 메소드 작성하기
  Future<void> insertAssetPortfolio(BloodPressureItem bloodPressureItem) async {
    final db = await database;

    await db.insert(
      _BLOOD_PRESSURE_DATA, //테이블 명
      bloodPressureItem.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace, //기본키 중복시 대체
    );
  }

  //Read 메소드 작성하기  ReadAll
  Future<List<BloodPressureItem>> getAllAssetPortfolio() async {
    final db = await database;

    // 모든 AssetPortfolio를 얻기 위해 테이블에 질의합니다.
    final List<Map<String, dynamic>> maps = await db.query('assetportfolio');

    // List<Map<String, dynamic>를 List<BloodPressureItem>으로 변환합니다.
    return List.generate(maps.length, (i) {
      return BloodPressureItem(
        id:  maps[i]['id'],
        rData:  maps[i]['rData'],
        saveData: maps[i]['saveData'],
        systolic:  maps[i]['systolic'],
        diastole:  maps[i]['diastole'],
        pulse:   maps[i]['pulse'],
        memo:   maps[i]['memo'],
        dayOfTheWeek:  maps[i]['dayOfTheWeek'],
        registeredType:  maps[i]['registeredType'],
        temperature: maps[i]['temperature'],
        weatherImg: maps[i]['weatherImg'],
        weatherTemp: maps[i]['weatherTemp'],
        weatherInfo: maps[i]['weatherInfo'],
        sendServerYM : maps[i]['sendServerYM'],
      );
    });
  }

  //Read 메소드 작성하기 Read(kind 값으로 찾기)
  Future<dynamic> getBloodPressureItem(String rData) async {
    final db = await database;

    final List<Map<String, dynamic>> maps = (await db
        .query(_BLOOD_PRESSURE_DATA, where: 'rData = ?', whereArgs: [rData]));

    return maps.isNotEmpty ? maps.first['rData'] : null;
  }

  //Update 메소드 작성하기
  Future<void> updateAssetPortfolio(BloodPressureItem bloodPressureItem) async {
    final db = await database;

    // 주어진 assetPortfolio를 수정합니다.
    await db.update(
      _BLOOD_PRESSURE_DATA,
      bloodPressureItem.toMap(),
      // assetPortfolio의 kind가 일치하는 지 확인합니다.
      where: "rData = ?",
      whereArgs: [bloodPressureItem.rData],
    );
  }

  //선택날의 싹 갖구오삼
  Future<List<BloodPressureItem>> getSelectDayBPDataList(String selectSunday)async{
    final db = await database ;
    List<BloodPressureItem> returnList  = [];
    StringBuffer qurey = StringBuffer();
    qurey.write(" SELECT id, rData, systolic, diastole, pulse, memo, registeredType, dayOfTheWeek, temperature, weatherImg, weatherTemp, weatherInfo, saveData ");
    qurey.write(" FROM BLOOD_PRESSURE_DATA ");
    qurey.write("WHERE rData  BETWEEN '$selectSunday' AND '$selectSunday' ORDER BY saveData DESC ");
    List<Map<String, dynamic>> maps = (await db.rawQuery(qurey.toString()));
    print("구른다 로컬디비${maps.length}<!!!!!!!!!!!!!!!!!!!!!!!!!!!!!>$maps");
    if(maps.length > 0){
      for(int i = (maps.length-1) ; 0 <= i ; i--){
        returnList.add(BloodPressureItem(
          id: maps[i]['id'],
          rData:  maps[i]['rData'],
          systolic:  (maps[i]['systolic']).toInt(),
          diastole:  (maps[i]['diastole']).toInt(),
          pulse:   (maps[i]['pulse']).toInt(),
          memo: maps[i]['memo'],
          temperature: maps[i]['temperature'],
          weatherImg:   (maps[i]['weatherImg'] == null ?'' : maps[i]['weatherImg']),
          weatherTemp:  (maps[i]['weatherTemp'] == null ?'' : maps[i]['weatherTemp']),
          weatherInfo:  (maps[i]['weatherInfo'] == null ?'' : maps[i]['weatherInfo']),
          saveData:  maps[i]['saveData'],
        ));
      }
    }else{
      returnList.add(BloodPressureItem(
        id: 0,
        systolic:  0,
        diastole:  0,
        pulse:   0,
        memo: ' ',
        rData: '1111-11-11',
        weatherImg: 'images/weather_s.png',
        weatherTemp: '',
        weatherInfo: '',
        saveData:  '2020-11-11 11:11',
      ));
    }
    return returnList ;
  }

  //저장데이터 수정
  Future<void> selectMemoUpset(BloodPressureItem bloodPressureItem)async{
    final db = await database ;
    await db.update(
      _BLOOD_PRESSURE_DATA,
      bloodPressureItem.toMap(),
      where: "id = ?",
      whereArgs: [bloodPressureItem.id],
    );
  }
  //선택날의 평균 데이터
  Future<BloodPressureItem> getSelectDayAvgBPData(String selectSunday)async{
    final db = await database ;
    BloodPressureItem returnList  ;
    StringBuffer qurey = StringBuffer();
    qurey.write(" SELECT rData, ROUND(AVG(systolic),0) AS 'systolic',  ROUND(AVG(diastole),0) AS 'diastole', ROUND(AVG(pulse),0) AS 'pulse' ");
    qurey.write(" FROM BLOOD_PRESSURE_DATA ");
    qurey.write("WHERE rData  BETWEEN '$selectSunday' AND '$selectSunday' GROUP BY  rData  ORDER BY rData DESC ");
    List<Map<String, dynamic>> maps = (await db.rawQuery(qurey.toString()));
    print("로컬디비<!!!!!!!!!!!!!!!!!!!!!!!!!!!!!>$maps");
    if(maps.length > 0){
      returnList =  BloodPressureItem(
        rData:  maps[0]['rData'],
        systolic:  (maps[0]['systolic']).toInt(),
        diastole:  (maps[0]['diastole']).toInt(),
        pulse:   (maps[0]['pulse']).toInt(),
      );
    }else{
      returnList =  BloodPressureItem(
        systolic:  0,
        diastole:  0,
        pulse:   0,
      );
    }
    return returnList ;
  }

  //가장 마지막에 측정한 혈압 데이터 갖고 오기
  Future<BloodPressureItem> getLastBPData()async{
    final db = await database ;
    BloodPressureItem returnList =  BloodPressureItem() ;
    StringBuffer qurey = StringBuffer();
    qurey.write(" SELECT rData, systolic, diastole, pulse, memo, registeredType, dayOfTheWeek ");
    qurey.write(" FROM BLOOD_PRESSURE_DATA  ");
    qurey.write(" ORDER BY rData DESC LIMIT 1 ");
    List<Map<String, dynamic>> maps = (await db.rawQuery(qurey.toString()));
    print("로컬디비<!!!!!!!!!!!!!!!!!!!!!!!!!!!!!>$maps");
    if(maps.length > 0){
      returnList =  BloodPressureItem(
        rData:  maps[0]['rData'],
        systolic:  maps[0]['systolic'],
        diastole:  maps[0]['diastole'],
        pulse:   maps[0]['pulse'],
        // memo:   maps[i]['memo'],
        dayOfTheWeek:  maps[0]['dayOfTheWeek'],
        registeredType:  maps[0]['registeredType'],
      );
    }
    return returnList ;
  }

  //선택한 날짜에 -7
  Future<List<BloodPressureItem>> getSelectDayAgeServenDaysBPDataList(String selectday)async{
    String  strSelectDay = getStringDay(selectday); //+" 00:00:00";
    String  strFirstWeekDay = getWeekDaySearch(selectday,7); //+ "23:59:59";
    final db = await database ;
    StringBuffer qurey = StringBuffer();
    qurey.write("SELECT rData, ROUND(AVG(systolic),0) AS 'systolic', ROUND(AVG(diastole),0) AS 'diastole', ROUND(AVG(pulse),0) AS 'pulse', dayOfTheWeek ");
    qurey.write(" FROM BLOOD_PRESSURE_DATA  ");
    qurey.write(" WHERE rData  BETWEEN '"+ strFirstWeekDay +"' AND '"+ strSelectDay +"' ");
    qurey.write(" GROUP BY  rData ");
    qurey.write(" ORDER BY rData ASC ");
    List<Map<String, dynamic>> maps = (await db.rawQuery(qurey.toString()));
    print("주달력로컬디비<!!!!!!!!!!!!!!!!!!!!!!!!!!!!!>$maps");
    List<BloodPressureItem> returnList = [] ;
    for(int w = 6 ; 0 <= w ; w--){
      bool check = false ;
      localData:for(int i = 0 ; i < maps.length; i++){
        if(getWeekDaySearch(selectday,w) == maps[i]['rData']){
          returnList.add(BloodPressureItem(
            rData:  maps[i]['rData'],
            systolic:  (maps[i]['systolic']).toInt(),
            diastole:  (maps[i]['diastole']).toInt(),
            pulse:   (maps[i]['pulse']).toInt(),
            dayOfTheWeek:  maps[i]['dayOfTheWeek'],
            // memo:   maps[i]['memo'],
            // registeredType:  maps[i]['registeredType'],
          ));
          check = true ;
          break localData ;
        }
      }
      if(!check){
        returnList.add(BloodPressureItem(
          rData: getWeekDaySearch(strSelectDay, w),
          systolic:  0,
          diastole:  0,
          pulse:   0,
          dayOfTheWeek:  getStringDayOfTheWeek(w),
          // memo:   maps[i]['memo'],
          // registeredType:  maps[i]['registeredType'],
        ));
      }
    }
    return returnList ;
    // return List.generate(maps.length, (i) {
    //   return BloodPressureItem(
    //     rData:  maps[i]['rData'],
    //     systolic:  (maps[i]['systolic']).toInt(),
    //     diastole:  (maps[i]['diastole']).toInt(),
    //     pulse:   (maps[i]['pulse']).toInt(),
    //     dayOfTheWeek:  maps[i]['dayOfTheWeek'],
    //     // memo:   maps[i]['memo'],
    //     // registeredType:  maps[i]['registeredType'],
    //   );
    // });
  }
  //선택한 월욜에 요일별 평균값 가지구 오기
  Future<List<BloodPressureItem>> getSelectWeekAvgBPDataList(String selectday)async{
    String  strSelectSunday = getselectWeekSunday(selectday); //+" 00:00:00";
    String  strSelectSaturday = getselectWeekSaturday(selectday); //+ "23:59:59";
    final db = await database ;
    StringBuffer qurey = StringBuffer();
    qurey.write("SELECT rData, ROUND(AVG(systolic),0) AS 'systolic', ROUND(AVG(diastole),0) AS 'diastole', ROUND(AVG(pulse),0) AS 'pulse', dayOfTheWeek ");
    qurey.write(" FROM BLOOD_PRESSURE_DATA  ");
    qurey.write(" WHERE rData  BETWEEN '"+ strSelectSunday +"' AND '"+ strSelectSaturday +"' ");
    qurey.write(" GROUP BY  rData ");
    qurey.write(" ORDER BY rData ASC ");
    List<Map<String, dynamic>> maps = (await db.rawQuery(qurey.toString()));
    print("주달력로컬디비<!!!!!!!!!!!!!!!!!!!!!!!!!!!!!>$maps");
    List<BloodPressureItem> returnList = [] ;
    for(int w = 0 ; w < 7; w++){
      bool check = false ;
      localData:for(int i = 0 ; i < maps.length; i++){
        if(w == getIntDayOfTheWeek( maps[i]['dayOfTheWeek'])){
          returnList.add(BloodPressureItem(
            rData:  maps[i]['rData'],
            systolic:  (maps[i]['systolic']).toInt(),
            diastole:  (maps[i]['diastole']).toInt(),
            pulse:   (maps[i]['pulse']).toInt(),
            dayOfTheWeek:  maps[i]['dayOfTheWeek'],
            // memo:   maps[i]['memo'],
            // registeredType:  maps[i]['registeredType'],
          ));
          check = true ;
          break localData ;
        }
      }
      if(!check){
        returnList.add(BloodPressureItem(
          rData: getWeekDaySearch(strSelectSunday, w),
          systolic:  0,
          diastole:  0,
          pulse:   0,
          dayOfTheWeek:  getStringDayOfTheWeek(w),
          // memo:   maps[i]['memo'],
          // registeredType:  maps[i]['registeredType'],
        ));
      }
    }
    return returnList ;
    // return List.generate(maps.length, (i) {
    //   return BloodPressureItem(
    //     rData:  maps[i]['rData'],
    //     systolic:  (maps[i]['systolic']).toInt(),
    //     diastole:  (maps[i]['diastole']).toInt(),
    //     pulse:   (maps[i]['pulse']).toInt(),
    //     dayOfTheWeek:  maps[i]['dayOfTheWeek'],
    //     // memo:   maps[i]['memo'],
    //     // registeredType:  maps[i]['registeredType'],
    //   );
    // });
  }
  //Delete 메소드 작성하기
  Future<void> deleteBloodPressureItem(String rData) async {
    final db = await database;

    // 데이터베이스에서 BloodPressureItem를 삭제합니다.
    await db.delete(
      _BLOOD_PRESSURE_DATA,
      // 특정 BloodPressureItem를 제거하기 위해 `where` 절을 사용하세요
      where: "rData = ?",
      whereArgs: [rData],
    );
  }
}