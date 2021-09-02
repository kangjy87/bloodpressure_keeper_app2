class Images {
  static const IMG_PATH = "assets/images/";
  static const img_placeholder = IMG_PATH + "placeholder.png";

  static const img_ic_band = IMG_PATH + "band.png";
  static const img_ic_fbook = IMG_PATH + "fbook.png";
  static const img_ic_google = IMG_PATH + "google.png";
  static const img_ic_insta = IMG_PATH + "insta.png";
  static const img_ic_kstory = IMG_PATH + "kstory.png";
  static const img_ic_nband = IMG_PATH + "nband.png";
  static const img_ic_nblog = IMG_PATH + "nblog.png";
  static const img_ic_tstory = IMG_PATH + "tstory.png";
  static const img_ic_tweeter = IMG_PATH + "tweeter.png";
  static const img_ic_youtube = IMG_PATH + "youtube.png";


  /** 아래는 깨진 이미지들 때문에 사용한 임시 이미지들... 삭제예정 */
  static List<ImageDto> SampleImages = [

    ImageDto(
        url: "https://images-na.ssl-images-amazon.com/images/S/pv-target-images/c24f81b95634562bfa6380091887e738f7bdb211af8761e73afaf463a0015d15._RI_V_TTW_.jpg",
        width: 1200,
        height: 1600
    ),
    ImageDto(
        url: "https://fever.imgix.net/plan/photo/7bba64dc-5552-11e9-b555-064931504376.jpg?w=550&h=550&auto=format&fm=jpg",
        width: 550,
        height: 550
    ),
    ImageDto(
        url: "http://tkfile.yes24.com/upload2/PerfBlog/202104/20210401/20210401-38766.jpg",
        width: 430,
        height: 602
    ),
    ImageDto(
        url: "https://cdnticket.melon.co.kr/resource/image/upload/marketing/2021/07/202107050922497f93ecca-30dd-44f3-a207-31f95f830958.jpg",
        width: 420,
        height: 594
    ),
    ImageDto(
        url: "https://d28erbnojfkip4.cloudfront.net/content/uploads/2021/05/TLK-TWIO-3000x1418-NoButton-scaled.jpg",
        width: 2560,
        height: 1263
    ),
    ImageDto(
        url: "https://theprommusical.com/wp-content/uploads/2020/12/PROM-mobile-website-image-Coming-Soon.jpg",
        width: 640,
        height: 1045
    ),
    ImageDto(
        url: "https://file.themusical.co.kr/fileStorage/ThemusicalAdmin/Play/Image/201702011101001N8L2KP311I07112.jpg",
        width: 419,
        height: 600
    )

  ];


  static int rotateNum = 0;
  static ImageDto getSampleImagesForFeed () {
    rotateNum = (rotateNum < SampleImages.length - 1) ? rotateNum + 1 : 0;
    return SampleImages[rotateNum];
  }

}


class ImageDto {

  String? url;
  int? width;
  int? height;

  ImageDto ({
    this.url,
    this.width,
    this.height
  });

}

class Constants {
  static const String API_BASE_URL = "https://dev.api.curator9.com";
  static const String CDN_URL = "https://chuncheon.blob.core.windows.net/chuncheon/";
}