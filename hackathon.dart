dependencies:
  flutter:
    sdk: flutter
  shared_preferences: ^2.1.0
  cupertino_icons: ^1.0.5

//// main.dart
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(NeoShopApp());
}

class NeoShopApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NeoShop — Flutter Demo',
      theme: ThemeData.dark().copyWith(
        primaryColor: Color(0xFF38BDF8),
        scaffoldBackgroundColor: Color(0xFF0B1220),
        cardColor: Color(0xFF111827),
        textTheme: TextTheme(
          bodyText2: TextStyle(color: Color(0xFFE5E7EB)),
        ),
      ),
      home: NeoShopHome(),
    );
  }
}

/* ---------------------------
   Models
----------------------------*/
class Product {
  final int id;
  final String title;
  final int price;
  final double rating;
  final String category;
  final String img; // URL or asset path
  final String desc;

  Product({
    required this.id,
    required this.title,
    required this.price,
    required this.rating,
    required this.category,
    required this.img,
    required this.desc,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'price': price,
        'rating': rating,
        'category': category,
        'img': img,
        'desc': desc,
      };

  factory Product.fromJson(Map<String, dynamic> j) => Product(
        id: j['id'],
        title: j['title'],
        price: j['price'],
        rating: (j['rating'] as num).toDouble(),
        category: j['category'],
        img: j['img'],
        desc: j['desc'],
      );
}

/* ---------------------------
   Mock Catalog (translate from JS)
----------------------------*/
final List<Product> PRODUCTS = [
  Product(
    id: 1,
    title: 'Echo Mini Smart Speaker',
    price: 1999,
    rating: 4.4,
    category: 'Electronics',
    img:
        'https://images.unsplash.com/photo-1585386959984-a415522b2b4b?w=800&q=60', // replace as desired
    desc: 'Compact smart speaker with rich sound.',
  ),
  Product(
    id: 2,
    title: 'Noise Canceling Headphones',
    price: 4999,
    rating: 4.6,
    category: 'Electronics',
    img:
        'https://images.unsplash.com/photo-1519985176271-adb1088fa94c?w=800&q=60',
    desc: 'Over-ear, 30h battery, fast charge.',
  ),
  Product(
    id: 3,
    title: 'Stainless Steel Bottle 1L',
    price: 599,
    rating: 4.2,
    category: 'Home & Kitchen',
    img:
        'https://images.unsplash.com/photo-1504754524776-8f4f37790ca0?w=800&q=60',
    desc: 'Keeps drinks cold 24h, hot 12h.',
  ),
  Product(
    id: 4,
    title: 'Ergonomic Office Chair',
    price: 7999,
    rating: 4.1,
    category: 'Furniture',
    img:
        'https://images.unsplash.com/photo-1582582494700-1a2d6f0fa4d2?w=800&q=60',
    desc: 'Adjustable lumbar, breathable mesh.',
  ),
  Product(
    id: 5,
    title: 'Gaming Mouse RGB',
    price: 1299,
    rating: 4.5,
    category: 'Computers',
    img:
        'https://images.unsplash.com/photo-1612831664636-9c6586b1f4f2?w=800&q=60',
    desc: '7200 DPI, 7 buttons, low-latency.',
  ),
  Product(
    id: 6,
    title: 'Fast Charging Power Bank 20k',
    price: 1699,
    rating: 4.3,
    category: 'Mobiles',
    img:
        'https://images.unsplash.com/photo-1539887541012-7a7f6b8f6b9d?w=800&q=60',
    desc: 'PD 20W, dual USB, slim design.',
  ),
  Product(
    id: 7,
    title: 'Non-stick Frying Pan 28cm',
    price: 899,
    rating: 4.0,
    category: 'Home & Kitchen',
    img:
        'https://images.unsplash.com/photo-1509042239860-f550ce710b93?w=800&q=60',
    desc: 'PFOA-free, induction compatible.',
  ),
  Product(
    id: 8,
    title: 'Cotton Bedsheet Queen',
    price: 1099,
    rating: 3.9,
    category: 'Home & Kitchen',
    img:
        'https://images.unsplash.com/photo-1560448204-e02f11c3d0e2?w=800&q=60',
    desc: '300 TC, soft feel, 2 pillow covers.',
  ),
  Product(
    id: 9,
    title: 'Wireless Keyboard',
    price: 1599,
    rating: 4.1,
    category: 'Computers',
    img:
        'https://images.unsplash.com/photo-1515879218367-8466d910aaa4?w=800&q=60',
    desc: 'Low profile keys, 2.4G receiver.',
  ),
  Product(
    id: 10,
    title: 'Android TV Stick 4K',
    price: 3499,
    rating: 4.4,
    category: 'Electronics',
    img:
        'https://images.unsplash.com/photo-1585079542146-5f1a7b42e5ee?w=800&q=60',
    desc: 'Dolby Vision, Dual-band Wi-Fi.',
  ),
  Product(
    id: 11,
    title: 'Backpack 28L Water Resistant',
    price: 1290,
    rating: 4.2,
    category: 'Bags & Luggage',
    img:
        'https://images.unsplash.com/photo-1520975698516-6b2aa3f6f8b8?w=800&q=60',
    desc: 'Laptop sleeve, 10 pockets, light.',
  ),
  Product(
    id: 12,
    title: 'Running Shoes Men',
    price: 2199,
    rating: 4.0,
    category: 'Fashion',
    img:
        'https://images.unsplash.com/photo-1600180758892-8a1b7d6b3f6f?w=800&q=60',
    desc: 'Cushioned sole, breathable knit.',
  ),
  Product(
    id: 13,
    title: 'Desk LED Lamp',
    price: 799,
    rating: 4.3,
    category: 'Home & Kitchen',
    img:
        'https://images.unsplash.com/photo-1519710164239-da123dc03ef4?w=800&q=60',
    desc: '3 brightness modes, USB-C.',
  ),
  Product(
    id: 14,
    title: 'Portable SSD 1TB',
    price: 5999,
    rating: 4.7,
    category: 'Computers',
    img:
        'https://images.unsplash.com/photo-1545239351-1141bd82e8a6?w=800&q=60',
    desc: 'USB-C 10Gbps, aluminum shell.',
  ),
];

/* ---------------------------
   Cart state with persistence
----------------------------*/
class CartModel extends ChangeNotifier {
  Map<int, int> _items = {}; // productId -> qty
  String? coupon;

  Map<int, int> get items => _items;

  int get totalItems => _items.values.fold(0, (a, b) => a + b);

  int subtotal(List<Product> products) {
    int s = 0;
    _items.forEach((id, qty) {
      final p = products.firstWhere((x) => x.id == id, orElse: () => PRODUCTS[0]);
      s += p.price * qty;
    });
    return s;
  }

  void add(int id, [int qty = 1]) {
    _items[id] = (_items[id] ?? 0) + qty;
    notifyListeners();
    _save();
  }

  void remove(int id) {
    _items.remove(id);
    notifyListeners();
    _save();
  }

  void changeQty(int id, int delta) {
    if (!_items.containsKey(id)) return;
    int next = (_items[id] ?? 0) + delta;
    if (next <= 0) _items.remove(id);
    else _items[id] = next;
    notifyListeners();
    _save();
  }

  void clear() {
    _items = {};
    coupon = null;
    notifyListeners();
    _save();
  }

  void setCoupon(String? code) {
    coupon = code;
    notifyListeners();
    _save();
  }

  int discountAmount(int subtotal) {
    if (coupon == null) return 0;
    if (coupon == 'SAVE10') return (subtotal * 0.10).round();
    if (coupon == 'SHIPFREE') return subtotal > 999 ? 0 : 49;
    return 0;
  }

  // Persistence
  Future<void> _save() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('neoshop_cart', jsonEncode(_items));
    prefs.setString('neoshop_coupon', coupon ?? '');
  }

  Future<void> restore() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString('neoshop_cart');
    final code = prefs.getString('neoshop_coupon') ?? '';
    if (raw != null && raw.isNotEmpty) {
      try {
        final Map parsed = jsonDecode(raw);
        _items = parsed.map<int, int>((k, v) => MapEntry(int.parse(k.toString()), int.parse(v.toString())));
      } catch (_) {
        _items = {};
      }
    }
    coupon = code.isEmpty ? null : code;
    notifyListeners();
  }
}

/* ---------------------------
   Home screen (UI)
----------------------------*/
class NeoShopHome extends StatefulWidget {
  @override
  _NeoShopHomeState createState() => _NeoShopHomeState();
}

class _NeoShopHomeState extends State<NeoShopHome> {
  final CartModel cart = CartModel();

  // Filters & UI state
  String query = '';
  String selectedCat = 'All';
  int rating = 0;
  int? minPrice;
  int? maxPrice;
  String sortBy = 'pop'; // pop, l2h, h2l, new
  List<String> categories = [];

  @override
  void initState() {
    super.initState();
    categories = ['All', ...{for (var p in PRODUCTS) p.category}];
    cart.restore();
  }

  List<Product> applyFilters() {
    List<Product> list = PRODUCTS.where((p) {
      if (selectedCat != 'All' && p.category != selectedCat) return false;
      if (query.isNotEmpty && !p.title.toLowerCase().contains(query.toLowerCase())) return false;
      if (minPrice != null && p.price < minPrice!) return false;
      if (maxPrice != null && p.price > maxPrice!) return false;
      if (p.rating < rating) return false;
      return true;
    }).toList();

    if (sortBy == 'l2h') list.sort((a, b) => a.price.compareTo(b.price));
    if (sortBy == 'h2l') list.sort((a, b) => b.price.compareTo(a.price));
    if (sortBy == 'new') list.sort((a, b) => a.id.compareTo(b.id));
    if (sortBy == 'pop') list.sort((a, b) => b.rating.compareTo(a.rating));
    return list;
  }

  void openQuickView(Product p) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => QuickViewSheet(product: p, onAdd: () {
        cart.add(p.id);
        Navigator.of(context).pop();
        _openCart();
      }, onBuy: () {
        cart.add(p.id);
        Navigator.of(context).pop();
        _goToCheckout();
      }),
    );
  }

  void _openCart() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) => CartSheet(cart: cart),
    );
  }

  void _goToCheckout() {
    Navigator.of(context).push(MaterialPageRoute(builder: (_) => CheckoutPage(cart: cart)));
  }

  void clearFilters() {
    setState(() {
      query = '';
      selectedCat = 'All';
      minPrice = null;
      maxPrice = null;
      rating = 0;
      sortBy = 'pop';
    });
  }

  @override
  Widget build(BuildContext context) {
    final filtered = applyFilters();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF0f172a),
        title: Row(
          children: [
            Container(
              width: 38,
              height: 38,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                gradient: LinearGradient(colors: [Color(0xFF38BDF8), Color(0xFF60A5FA)]),
              ),
              alignment: Alignment.center,
              child: Text('N', style: TextStyle(color: Color(0xFF041019), fontWeight: FontWeight.w900)),
            ),
            SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [Text('NeoShop', style: TextStyle(fontWeight: FontWeight.w900)), Text('Open-source demo', style: TextStyle(color: Colors.grey, fontSize: 12))],
            ),
          ],
        ),
        actions: [
          IconButton(onPressed: _openCart, icon: Stack(
            children: [
              Icon(Icons.shopping_cart),
              Positioned(
                right: 0,
                child: CircleAvatar(
                  radius: 8,
                  backgroundColor: Colors.red,
                  child: ValueListenableBuilder(
                    valueListenable: cart,
                    builder: (context, _, __) {
                      return Text(cart.totalItems.toString(), style: TextStyle(fontSize: 10));
                    },
                  ),
                ),
              )
            ],
          )),
          SizedBox(width: 10),
        ],
      ),
      body: Row(
        children: [
          // Sidebar filters (on big screens)
          if (MediaQuery.of(context).size.width >= 980)
            Container(
              width: 260,
              padding: EdgeInsets.all(14),
              child: Card(
                color: Theme.of(context).cardColor,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Categories', style: TextStyle(color: Colors.lightBlueAccent)),
                        SizedBox(height: 8),
                        ...categories.map((c) => RadioListTile<String>(
                              contentPadding: EdgeInsets.zero,
                              title: Text(c),
                              value: c,
                              groupValue: selectedCat,
                              onChanged: (v) => setState(() => selectedCat = v ?? 'All'),
                            )),
                        SizedBox(height: 8),
                        Text('Price'),
                        Row(
                          children: [
                            Expanded(
                                child: TextField(
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(hintText: 'Min'),
                              onChanged: (v) => setState(() => minPrice = v.isEmpty ? null : int.tryParse(v)),
                            )),
                            SizedBox(width: 8),
                            Expanded(
                                child: TextField(
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(hintText: 'Max'),
                              onChanged: (v) => setState(() => maxPrice = v.isEmpty ? null : int.tryParse(v)),
                            )),
                          ],
                        ),
                        SizedBox(height: 12),
                        Text('Rating'),
                        RadioListTile<int>(title: Text('⭐⭐⭐⭐ & up'), value: 4, groupValue: rating, onChanged: (v) => setState(() => rating = v ?? 0)),
                        RadioListTile<int>(title: Text('⭐⭐⭐ & up'), value: 3, groupValue: rating, onChanged: (v) => setState(() => rating = v ?? 0)),
                        RadioListTile<int>(title: Text('Any'), value: 0, groupValue: rating, onChanged: (v) => setState(() => rating = v ?? 0)),
                        SizedBox(height: 12),
                        ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(backgroundColor: Colors.transparent, side: BorderSide(color: Colors.white12)),
                            onPressed: clearFilters,
                            icon: Icon(Icons.clear),
                            label: Text('Clear'))
                      ],
                    ),
                  ),
                ),
              ),
            ),
          // Main content
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  children: [
                    // Search + sort + featured hero (shows card)
                    Card(
                      color: Theme.of(context).cardColor,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                      child: Padding(
                        padding: const EdgeInsets.all(14.0),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: TextField(
                                    style: TextStyle(color: Colors.white),
                                    decoration: InputDecoration(
                                      filled: true,
                                      fillColor: Color(0xFF0A1222),
                                      hintText: 'Search products, brands and more',
                                      border: OutlineInputBorder(borderRadius: BorderRadius.horizontal(left: Radius.circular(10))),
                                    ),
                                    onSubmitted: (v) => setState(() => query = v),
                                    onChanged: (v) => setState(() => query = v),
                                  ),
                                ),
                                SizedBox(width: 8),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(backgroundColor: Color(0xFF38BDF8)),
                                  onPressed: () => setState(() {}),
                                  child: Text('Search', style: TextStyle(color: Color(0xFF04202E), fontWeight: FontWeight.w800)),
                                ),
                                SizedBox(width: 8),
                                DropdownButton<String>(
                                  value: sortBy,
                                  dropdownColor: Color(0xFF0B162B),
                                  onChanged: (v) => setState(() => sortBy = v ?? 'pop'),
                                  items: [
                                    DropdownMenuItem(value: 'pop', child: Text('Sort: Popularity')),
                                    DropdownMenuItem(value: 'l2h', child: Text('Price: Low to High')),
                                    DropdownMenuItem(value: 'h2l', child: Text('Price: High to Low')),
                                    DropdownMenuItem(value: 'new', child: Text('Newest')),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(height: 12),
                            Row(
                              children: [
                                // small featured visual card (replacing the tilt card)
                                Expanded(
                                  child: Container(
                                    height: 160,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(14),
                                      gradient: LinearGradient(colors: [Color(0xFF0f172a), Color(0xFF0b162b)]),
                                      border: Border.all(color: Colors.white12),
                                    ),
                                    child: Stack(
                                      children: [
                                        Positioned.fill(
                                          child: Image.network(
                                            'https://static.wixstatic.com/media/3d9313_45b151504946477791c3add537ac398a~mv2.png',
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        Positioned(
                                          left: 14,
                                          bottom: 14,
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Container(padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4), decoration: BoxDecoration(color: Colors.amber.withOpacity(0.9), borderRadius: BorderRadius.circular(999)), child: Text('4,478 m', style: TextStyle(color: Colors.brown))),
                                              SizedBox(height: 8),
                                              Text('Matterhorn', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700)),
                                              Text('Zermatt, Switzerland', style: TextStyle(color: Colors.grey)),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(width: 12),
                                Expanded(
                                  flex: 2,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text('Deals of the Day', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
                                      SizedBox(height: 6),
                                      Text('Fresh picks updated frequently', style: TextStyle(color: Colors.grey)),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),

                    SizedBox(height: 12),
                    // Toolbar: showing count + category
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Showing ${filtered.length} items', style: TextStyle(color: Colors.grey)),
                        Text('Category: ${selectedCat}', style: TextStyle(color: Colors.grey)),
                      ],
                    ),
                    SizedBox(height: 12),

                    // Grid
                    LayoutBuilder(builder: (context, constraints) {
                      int crossAxisCount = 2;
                      double w = constraints.maxWidth;
                      if (w > 1100) crossAxisCount = 4;
                      else if (w > 700) crossAxisCount = 3;
                      return GridView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: filtered.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: crossAxisCount,
                          mainAxisSpacing: 12,
                          crossAxisSpacing: 12,
                          childAspectRatio: 0.72,
                        ),
                        itemBuilder: (context, index) {
                          final p = filtered[index];
                          return ProductCard(
                            product: p,
                            onQuickView: () => openQuickView(p),
                            onAdd: () => cart.add(p.id),
                          );
                        },
                      );
                    }),

                    SizedBox(height: 20),

                    // Checkout summary & form (compact)
                    Card(
                      color: Theme.of(context).cardColor,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          children: [
                            Text('Checkout (demo)', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
                            SizedBox(height: 8),
                            Row(
                              children: [
                                Expanded(
                                  child: TextField(decoration: InputDecoration(hintText: 'Full name'), style: TextStyle(color: Colors.white)),
                                ),
                                SizedBox(width: 8),
                                Expanded(
                                  child: TextField(decoration: InputDecoration(hintText: 'Email'), style: TextStyle(color: Colors.white)),
                                ),
                              ],
                            ),
                            SizedBox(height: 8),
                            TextField(maxLines: 3, decoration: InputDecoration(hintText: 'Address'), style: TextStyle(color: Colors.white)),
                            SizedBox(height: 8),
                            Row(children: [
                              Expanded(child: TextField(decoration: InputDecoration(hintText: 'City'))),
                              SizedBox(width: 8),
                              Expanded(child: TextField(decoration: InputDecoration(hintText: 'PIN'))),
                            ]),
                            SizedBox(height: 8),
                            Row(
                              children: [
                                Expanded(child: TextField(decoration: InputDecoration(hintText: 'Coupon (SAVE10 / SHIPFREE)'))),
                                SizedBox(width: 8),
                                ElevatedButton(onPressed: () {
                                  // simple demo: not wired to inputs here
                                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Apply coupon from cart view instead.')));
                                }, child: Text('Apply'))
                              ],
                            )
                          ],
                        ),
                      ),
                    ),

                    SizedBox(height: 40),
                    Center(child: Text('© ${DateTime.now().year} NeoShop • MIT License • Demo only', style: TextStyle(color: Colors.grey))),
                    SizedBox(height: 40),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

/* ---------------------------
   Widgets
----------------------------*/

class ProductCard extends StatelessWidget {
  final Product product;
  final VoidCallback onQuickView;
  final VoidCallback onAdd;

  const ProductCard({required this.product, required this.onQuickView, required this.onAdd});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).cardColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Thumbnail
          Container(
            height: 140,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.vertical(top: Radius.circular(14)),
              color: Colors.black12,
            ),
            clipBehavior: Clip.hardEdge,
            child: product.img.isNotEmpty
                ? Image.network(product.img, fit: BoxFit.cover, errorBuilder: (_, __, ___) => Center(child: Text(product.title)))
                : Center(child: Text(product.title)),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(product.title, style: TextStyle(fontWeight: FontWeight.w700)),
              SizedBox(height: 6),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text('₹${product.price}', style: TextStyle(fontWeight: FontWeight.w900, color: Color(0xFF86EFAC))),
                  SizedBox(height: 4),
                  Text(product.category, style: TextStyle(color: Colors.grey)),
                ]),
                Column(children: [
                  Row(children: [
                    Text('★' * product.rating.round(), style: TextStyle(color: Colors.amber)),
                    SizedBox(width: 4),
                    Text('(${product.rating.toStringAsFixed(1)})', style: TextStyle(color: Colors.grey, fontSize: 12))
                  ])
                ])
              ]),
              SizedBox(height: 8),
              Row(children: [
                Expanded(child: ElevatedButton(onPressed: onAdd, child: Text('Add to Cart'))),
                SizedBox(width: 8),
                OutlinedButton(onPressed: onQuickView, child: Text('Quick View')),
              ])
            ]),
          )
        ],
      ),
    );
  }
}

/* ---------------------------
   Quick View Sheet
----------------------------*/
class QuickViewSheet extends StatelessWidget {
  final Product product;
  final VoidCallback onAdd;
  final VoidCallback onBuy;

  const QuickViewSheet({required this.product, required this.onAdd, required this.onBuy});

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.65,
      maxChildSize: 0.95,
      minChildSize: 0.4,
      builder: (context, sc) {
        return Container(
          decoration: BoxDecoration(color: Color(0xFF0B1625), borderRadius: BorderRadius.vertical(top: Radius.circular(16))),
          child: SingleChildScrollView(
            controller: sc,
            child: Padding(
              padding: const EdgeInsets.all(14.0),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                  Text(product.title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800)),
                  IconButton(onPressed: () => Navigator.of(context).pop(), icon: Icon(Icons.close))
                ]),
                SizedBox(height: 8),
                Container(
                  height: 220,
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
                  child: Image.network(product.img, fit: BoxFit.cover, errorBuilder: (_, __, ___) => Container(color: Colors.grey)),
                ),
                SizedBox(height: 12),
                Text(product.category, style: TextStyle(color: Colors.grey)),
                SizedBox(height: 6),
                Text('₹${product.price}', style: TextStyle(fontWeight: FontWeight.w900, fontSize: 20, color: Color(0xFF86EFAC))),
                SizedBox(height: 6),
                Row(children: [Text('★' * product.rating.round()), SizedBox(width: 6), Text('(${product.rating.toStringAsFixed(1)})', style: TextStyle(color: Colors.grey))]),
                SizedBox(height: 10),
                Text(product.desc, style: TextStyle(color: Colors.grey)),
                SizedBox(height: 16),
                Row(children: [
                  Expanded(child: ElevatedButton(onPressed: onAdd, child: Text('Add to Cart'))),
                  SizedBox(width: 8),
                  OutlinedButton(onPressed: onBuy, child: Text('Buy Now')),
                ]),
              ]),
            ),
          ),
        );
      },
    );
  }
}

/* ---------------------------
   Cart Sheet
----------------------------*/
class CartSheet extends StatefulWidget {
  final CartModel cart;
  CartSheet({required this.cart});

  @override
  _CartSheetState createState() => _CartSheetState();
}

class _CartSheetState extends State<CartSheet> {
  @override
  Widget build(BuildContext context) {
    final cart = widget.cart;
    return DraggableScrollableSheet(
      initialChildSize: 0.7,
      maxChildSize: 0.95,
      minChildSize: 0.3,
      builder: (context, sc) {
        return Container(
          decoration: BoxDecoration(color: Color(0xFF0B1625), borderRadius: BorderRadius.vertical(top: Radius.circular(16))),
          child: SingleChildScrollView(
            controller: sc,
            padding: EdgeInsets.all(12),
            child: Column(
              children: [
                Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                  Text('Your Cart', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                  IconButton(onPressed: () => Navigator.of(context).pop(), icon: Icon(Icons.close)),
                ]),
                ValueListenableBuilder(
                  valueListenable: cart,
                  builder: (context, _, __) {
                    if (cart.items.isEmpty) {
                      return Padding(padding: EdgeInsets.all(24), child: Text('Cart is empty', style: TextStyle(color: Colors.grey)));
                    }
                    final entries = cart.items.entries.toList();
                    int total = cart.subtotal(PRODUCTS);
                    final shipping = total > 0 && total < 999 ? 49 : 0;
                    final disc = cart.discountAmount(total);
                    final grand = total + shipping - disc;
                    return Column(
                      children: [
                        for (var e in entries)
                          _buildCartRow(e.key, e.value, cart),
                        Divider(),
                        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Text('Subtotal', style: TextStyle(color: Colors.grey)), Text('₹$total')]),
                        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Text('Shipping', style: TextStyle(color: Colors.grey)), Text('₹$shipping')]),
                        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Text('Discount', style: TextStyle(color: Colors.grey)), Text('- ₹$disc')]),
                        Divider(),
                        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Text('Total', style: TextStyle(fontWeight: FontWeight.bold)), Text('₹$grand', style: TextStyle(fontWeight: FontWeight.bold))]),
                        SizedBox(height: 8),
                        Row(children: [
                          Expanded(child: ElevatedButton(onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => CheckoutPage(cart: cart))), child: Text('Proceed to Checkout'))),
                          SizedBox(width: 8),
                          OutlinedButton(onPressed: () {
                            // quick clear
                            cart.clear();
                          }, child: Text('Clear'))
                        ]),
                        SizedBox(height: 8),
                        TextField(
                          decoration: InputDecoration(hintText: 'Coupon (SAVE10 / SHIPFREE)'),
                          onSubmitted: (v) {
                            cart.setCoupon(v.trim().toUpperCase());
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Coupon applied')));
                            setState(() {});
                          },
                        )
                      ],
                    );
                  },
                )
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildCartRow(int productId, int qty, CartModel cart) {
    final p = PRODUCTS.firstWhere((x) => x.id == productId);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        children: [
          Container(width: 56, height: 56, decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: Colors.black12), clipBehavior: Clip.hardEdge, child: Image.network(p.img, fit: BoxFit.cover, errorBuilder: (_, __, ___) => Container())),
          SizedBox(width: 8),
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(p.title, style: TextStyle(fontWeight: FontWeight.w700)), Text('₹${p.price}', style: TextStyle(color: Colors.grey))])),
          Row(children: [
            IconButton(onPressed: () => setState(() => cart.changeQty(p.id, -1)), icon: Icon(Icons.remove_circle_outline)),
            Text(qty.toString()),
            IconButton(onPressed: () => setState(() => cart.changeQty(p.id, 1)), icon: Icon(Icons.add_circle_outline)),
            IconButton(onPressed: () => setState(() => cart.remove(p.id)), icon: Icon(Icons.delete_outline)),
          ])
        ],
      ),
    );
  }
}

/* ---------------------------
   Checkout page
----------------------------*/
class CheckoutPage extends StatefulWidget {
  final CartModel cart;
  CheckoutPage({required this.cart});

  @override
  _CheckoutPageState createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  final _name = TextEditingController();
  final _email = TextEditingController();
  final _addr = TextEditingController();
  final _city = TextEditingController();
  final _pin = TextEditingController();

  String status = '';

  @override
  Widget build(BuildContext context) {
    final cart = widget.cart;
    final total = cart.subtotal(PRODUCTS);
    final ship = total > 0 && total < 999 ? 49 : 0;
    final disc = cart.discountAmount(total);
    final grand = total + ship - disc;

    return Scaffold(
      appBar: AppBar(title: Text('Checkout')),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(12),
        child: Column(children: [
          TextField(controller: _name, decoration: InputDecoration(hintText: 'Full Name')),
          SizedBox(height: 8),
          TextField(controller: _email, decoration: InputDecoration(hintText: 'Email')),
          SizedBox(height: 8),
          TextField(controller: _addr, maxLines: 3, decoration: InputDecoration(hintText: 'Address')),
          SizedBox(height: 8),
          Row(children: [
            Expanded(child: TextField(controller: _city, decoration: InputDecoration(hintText: 'City'))),
            SizedBox(width: 8),
            Expanded(child: TextField(controller: _pin, decoration: InputDecoration(hintText: 'PIN'))),
          ]),
          SizedBox(height: 12),
          Card(
            color: Color(0xFF111827),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(children: [
                Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Text('Items', style: TextStyle(color: Colors.grey)), Text('${cart.totalItems}')]),
                Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Text('Subtotal', style: TextStyle(color: Colors.grey)), Text('₹$total')]),
                Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Text('Shipping', style: TextStyle(color: Colors.grey)), Text('₹$ship')]),
                Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Text('Discount', style: TextStyle(color: Colors.grey)), Text('- ₹$disc')]),
                Divider(),
                Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Text('Total'), Text('₹$grand', style: TextStyle(fontWeight: FontWeight.bold))]),
                SizedBox(height: 8),
                ElevatedButton(
                  onPressed: () {
                    if (_name.text.trim().isEmpty || _email.text.trim().isEmpty || _addr.text.trim().isEmpty || cart.totalItems == 0) {
                      setState(() => status = 'Please fill details and add items to cart.');
                      return;
                    }
                    setState(() => status = 'Placing order…');
                    Future.delayed(Duration(milliseconds: 700), () {
                      setState(() => status = 'Order confirmed! (demo) — check your email: ${_email.text.trim()}');
                      cart.clear();
                    });
                  },
                  child: Text('Place Order'),
                ),
                if (status.isNotEmpty) ...[
                  SizedBox(height: 8),
                  Text(status, style: TextStyle(color: status.startsWith('Order') ? Colors.green : Colors.red)),
                ]
              ]),
            ),
          )
        ]),
      ),
    );
  }
}


