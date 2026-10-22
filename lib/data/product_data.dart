import 'package:elunaa/model/product_model.dart';

List<Product> productList = [
  Product(
    id: '1',
    name: 'vitamin c',
    description: 'Hydracting a face,clear pores',
    category: 'Skincare',
    price: 700,
    image: 'assets/images/serr c.png',

    rating: 4.5,
    offer: "20% OFF",
  ),
  Product(
    id: '2',
    name: 'Cleanser',
    description: 'its used for refreshing a face',
    category: 'skincare',
    price: 699,
    image: 'assets/images/cleanserr.png',

    rating: 4.5,
    offer: "20% OFF",
  ),
  Product(
    id: '3',
    name: 'Hair serum',
    description: 'Redues the hairfall',
    category: 'Haircare',
    price: 2500,
    image: 'assets/images/hair serum.png',

    rating: 4.5,
    offer: "20% OFF",
  ),
  Product(
    id: '4',
    name: 'Foundation',
    description: 'Base makeup tool',
    category: 'Makeup',
    price: 4500,
    image: 'assets/images/founder.png',

    rating: 4.5,
    offer: "20% OFF",
  ),
  Product(
    id: '5',
    name: 'Hairmask',
    description: 'Long lasting perfume ',
    category: 'Haircare',
    price: 3500,
    image: 'assets/images/haircare.png',

    rating: 4.5,
    offer: "20% OFF",
  ),
  Product(
    id: '6',
    name: 'Body Spray',
    description: 'Long lasting perfume ',
    category: 'Fragrance',
    price: 3500,
    image: 'assets/images/perfum.png',

    rating: 4.5,
    offer: "20% OFF",
  ),
  Product(
    id: '7',
    name: 'Lipstick',
    description: 'Base makeup tool ',
    category: 'Makeup',
    price: 3500,
    image: 'assets/images/lipstick.png',

    rating: 4.5,
    offer: "20% OFF",
  ),
  Product(
    id: '8',
    name: 'lib balm',
    description: 'Long lasting perfume ',
    category: 'Skincare',
    price: 3500,
    image: 'assets/images/lipbalm.png',

    rating: 4.5,
    offer: "20% OFF",
  ),
];

List<Product> wishlistItems = [];
List<Product> cartItems = [];