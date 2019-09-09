class Item {
  final String id;
  final String title;
  final String description;
  final String itemImage;
  final String userId;

  Item({this.id, this.title, this.description, this.itemImage, this.userId});

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      itemImage: json['itemImage'],
      userId: json['userId'],
    );
  }
}

class Items {
  final int count;
  final List<Item> items;

  Items({this.count, this.items});

  factory Items.fromJson(Map<String, dynamic> json) {
    var list = json['items'] as List;
    List<Item> itemsList = list.map((i) => Item.fromJson(i)).toList();
    return Items(
      count: json['count'],
      items: itemsList,
    );
  }
}
