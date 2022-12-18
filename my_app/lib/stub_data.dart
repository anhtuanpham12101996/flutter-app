// Copyright 2020 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'place.dart';

class StubData {
  static const List<Place> places = [
    Place(
        id: '1',
        latLng: LatLng(45.524676, -122.681922),
        name: 'DAIRY QUEEN',
        description:
            'Dairy Queen là thương hiệu kem tươi cao cấp của Mỹ được yêu thích suốt 75 năm trên toàn thế giới.Được làm từ nguyên liệu nhập khẩu cao cấp, kem tươi Dairy Queen dẻo, mịn, không đông tuyết, mang hương vị sữa tươi nguyên chất. Độ dẻo mịn của kem Dairy Queen là bí quyết tạo nên vòng xoắn đặc trưng của kem Dairy Queen..',
        category: PlaceCategory.favorite,
        starRating: 5,
        path: 'assets/dairy-queen.jpg'),
    Place(
        id: '2',
        latLng: LatLng(45.516887, -122.675417),
        name: 'STARBUCKS',
        description:
            'Starbucks đã, đang và sẽ luôn chú trọng vào chất lượng. Starbucks say mê tìm nguồn cung ứng cà phê hạt ngon nhất theo cách có đạo đức, rang chúng một cách cực kỳ cẩn thận và cải thiện cuộc sống của những người trồng cà phê. Starbucks quan tâm sâu sắc đến tất cả các hoạt động này; công việc của Starbucks không bao giờ kết thúc.',
        category: PlaceCategory.favorite,
        starRating: 5,
        path: 'assets/starbuck.jpg'),
    Place(
        id: '3',
        latLng: LatLng(45.528952, -122.698344),
        name: 'KOI THÉ',
        description:
            'Tại mỗi cửa hàng KOI, chúng tôi mong muốn chia sẻ niềm hạnh phúc và tình yêu trà với bạn. Chúng tôi cố gắng hết sức mỗi ngày để làm cho trải nghiệm của bạn trở nên đáng nhớ..',
        category: PlaceCategory.favorite,
        starRating: 5,
        path: 'assets/koi.jpg'),
    Place(
        id: '4',
        latLng: LatLng(45.525253, -122.684423),
        name: 'LOTTERIA',
        description:
            'Xuất hiện tại Việt Nam vào năm 1998 với những sản phẩm nổi bật: Burger, Gà rán, Khoai tây lắc, Kem,… Lotteria luôn không ngừng nỗ lực cải thiện để cung cấp cho quý khách hàng đời sống dinh dưỡng.',
        category: PlaceCategory.favorite,
        starRating: 4,
        path: 'assets/lotteria.jpg'),
    Place(
        id: '5',
        latLng: LatLng(45.513485, -122.657982),
        name: 'iSUSHI',
        description:
            'Được thành lập từ 2015, iSushi đã lan rộng 10 chi nhánh trên toàn quốc tại 3 thành phố lớn: Hà Nội, Hồ Chí Minh, Hải Phòng. iSushi tự hào mang tới khách hàng những trải nghiệm và cảm xúc Nhật thực thụ với Buffet Nhật Bản 100 món ăn tinh hoa với các món Sashimi tươi ngon, hơn 57 loại Sushi cùng nhiều món ăn hấp dẫn khác được thực hiện dưới sự dẫn dắt tài tình của Tổng bếp trưởng Noda Toshiro. Cho dù là mùi vị nguyên bản hay được chế biến cầu kỳ, món ăn tại iSushi không ngừng hấp dẫn khách hàng. Do đó, iSushi trở thành một lựa chọn hảo hạng không thể bỏ qua đối với các tín đồ ẩm thực xứ Phù Tang.',
        category: PlaceCategory.favorite,
        starRating: 4,
        path: 'assets/iSushi.png'),
    Place(
      id: '6',
      latLng: LatLng(45.487137, -122.799940),
      name: 'Buffalo Wild Wings',
      description:
          'Lively sports-bar chain dishing up wings & other American pub grub amid lots of large-screen TVs.',
      category: PlaceCategory.visited,
      starRating: 5,
    ),
    Place(
      id: '7',
      latLng: LatLng(45.416986, -122.743171),
      name: 'Chevys',
      description:
          'Lively, informal Mexican chain with a colorful, family-friendly setting plus tequilas & margaritas.',
      category: PlaceCategory.visited,
      starRating: 4,
    ),
    Place(
      id: '8',
      latLng: LatLng(45.430489, -122.831802),
      name: 'Cinetopia',
      description:
          'Moviegoers can take food from the on-site eatery to their seats, with table service in 21+ theaters.',
      category: PlaceCategory.visited,
      starRating: 4,
    ),
    Place(
      id: '9',
      latLng: LatLng(45.383030, -122.758372),
      name: 'Thai Cuisine',
      description:
          'Informal restaurant offering Thai standards in a modest setting, plus takeout & delivery.',
      category: PlaceCategory.visited,
      starRating: 4,
    ),
    Place(
      id: '10',
      latLng: LatLng(45.493321, -122.669330),
      name: 'The Old Spaghetti Factory',
      description:
          'Family-friendly chain eatery featuring traditional Italian entrees amid turn-of-the-century decor.',
      category: PlaceCategory.visited,
      starRating: 4,
    ),
    Place(
      id: '11',
      latLng: LatLng(45.548606, -122.675286),
      name: 'Mississippi Pizza',
      description:
          'Music, trivia & other all-ages events featured at pizzeria with lounge & vegan & gluten-free pies.',
      category: PlaceCategory.wantToGo,
      starRating: 4,
    ),
    Place(
      id: '12',
      latLng: LatLng(45.420226, -122.740347),
      name: 'Oswego Grill',
      description:
          'Wood-grilled steakhouse favorites served in a casual, romantic restaurant with a popular happy hour.',
      category: PlaceCategory.wantToGo,
      starRating: 4,
    ),
    Place(
      id: '13',
      latLng: LatLng(45.541202, -122.676432),
      name: 'The Widmer Brothers Brewery',
      description:
          'Popular, enduring gastropub serving craft beers, sandwiches & eclectic entrees in a laid-back space.',
      category: PlaceCategory.wantToGo,
      starRating: 4,
    ),
    Place(
      id: '14',
      latLng: LatLng(45.559783, -122.924103),
      name: 'TopGolf',
      description:
          'Sprawling entertainment venue with a high-tech driving range & swanky lounge with drinks & games.',
      category: PlaceCategory.wantToGo,
      starRating: 5,
    ),
    Place(
      id: '15',
      latLng: LatLng(45.485612, -122.784733),
      name: 'Uwajimaya Beaverton',
      description:
          'Huge Asian grocery outpost stocking meats, produce & prepared foods plus gifts & home goods.',
      category: PlaceCategory.wantToGo,
      starRating: 5,
    ),
  ];

  static const reviewStrings = [
    'My favorite place in Portland. The employees are wonderful and so is the food. I go here at least once a month!',
    'Staff was very friendly. Great atmosphere and good music. Would recommend.',
    'Best. Place. In. Town. Period.'
  ];
}
