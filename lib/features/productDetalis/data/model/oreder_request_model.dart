class OrderRequest {
  final List<OrderItem> items;

  OrderRequest({required this.items});

  factory OrderRequest.fromJson(Map<String, dynamic> json) {
    return OrderRequest(
      items: (json['items'] as List).map((e) => OrderItem.fromJson(e)).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'items': items.map((e) => e.toJson()).toList(),
    };
  }
}

class OrderItem {
  final int productId;
  final int quantity;
  final double? spicy;
  final List<int> toppings;
  final List<int> sideOptions;

  OrderItem({
    required this.productId,
    required this.quantity,
    this.spicy,
    required this.toppings,
    required this.sideOptions,
  });

  factory OrderItem.fromJson(Map<String, dynamic> json) {
    return OrderItem(
      productId: json['product_id'],
      quantity: json['quantity'],
      spicy: json['spicy']?.toDouble(),
      toppings: List<int>.from(json['toppings']),
      sideOptions: List<int>.from(json['side_options']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'product_id': productId,
      'quantity': quantity,
      if (spicy != null) 'spicy': spicy,
      'toppings': toppings,
      'side_options': sideOptions,
    };
  }
}
