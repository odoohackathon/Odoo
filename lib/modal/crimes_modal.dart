class CrimesModal {
  String? pid;
  String? itemName;
  String? filter;
  String? code;
  String? description;
  String? price;
  String? minimumQuantity;
  String? otherDetails;
  List? imageUrls;
  List? wishlistedUsers;
  String? isOutOfStock;

  CrimesModal(
      {this.pid,
        this.itemName,
        this.filter,
        this.code,
        this.description,
        this.price,
        this.minimumQuantity,
        this.otherDetails,
        this.imageUrls,
        this.wishlistedUsers,
        this.isOutOfStock});

  CrimesModal.fromJson(Map<String, dynamic> json) {
    pid = json['pid'];
    itemName = json['itemName'];
    filter = json['filter'];
    code = json['code'];
    description = json['description'];
    price = json['price'];
    minimumQuantity = json['minimumQuantity'];
    otherDetails = json['otherDetails'];
    imageUrls = json['imageUrls'].split(',');
    wishlistedUsers = json['wishlistedUsers'] != null ? json['wishlistedUsers'].split(',') : json['wishlistedUsers'] ;// put the text inside a widget.toList();
    isOutOfStock = json['isOutOfStock'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['pid'] = this.pid;
    data['itemName'] = this.itemName;
    data['filter'] = this.filter;
    data['code'] = this.code;
    data['description'] = this.description;
    data['price'] = this.price;
    data['minimumQuantity'] = this.minimumQuantity;
    data['otherDetails'] = this.otherDetails;
    data['imageUrls'] = this.imageUrls;
    data['wishlistedUsers'] = this.wishlistedUsers;
    data['isOutOfStock'] = this.isOutOfStock;
    return data;
  }
}
