import 'dart:convert';
import 'package:foods_app/features/auth/data/model/get_profile_data_model.dart';
import 'package:foods_app/features/cart/data/model/cart_response_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefsService {
  static const String _tokenKey = 'token';
  static const String _profileKey = 'user_profile';

  Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_tokenKey, token);
  }

  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_tokenKey);
  }

  Future<bool> isLoggedIn() async {
    final token = await getToken();
    return token != null && token.isNotEmpty;
  }

  Future<void> clearToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_tokenKey);
    await prefs.remove(_profileKey);
  }

  Future<void> saveProfile(GetProfileDataModel profile) async {
    final prefs = await SharedPreferences.getInstance();
    String profileJson = jsonEncode(profile.toJson());
    await prefs.setString(_profileKey, profileJson);
  }

  Future<GetProfileDataModel?> getProfile() async {
    final prefs = await SharedPreferences.getInstance();
    String? profileJson = prefs.getString(_profileKey);
    if (profileJson != null && profileJson.isNotEmpty) {
      try {
        return GetProfileDataModel.fromJson(jsonDecode(profileJson));
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  static const String _cartKey = 'user_cart';

  Future<void> saveCart(CartResponseModel cart) async {
    final prefs = await SharedPreferences.getInstance();
    String cartJson = jsonEncode(cart.toJson());
    await prefs.setString(_cartKey, cartJson);
  }

  Future<CartResponseModel?> getCart() async {
    final prefs = await SharedPreferences.getInstance();
    String? cartJson = prefs.getString(_cartKey);
    if (cartJson != null && cartJson.isNotEmpty) {
      try {
        return CartResponseModel.fromJson(jsonDecode(cartJson));
      } catch (e) {
        return null;
      }
    }
    return null;
  }
}
