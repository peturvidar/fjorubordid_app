//API endpoints
class ApiConstants {
  static String baseUrl = 'https://794e-31-209-140-152.eu.ngrok.io'; //Ngrok endpoint for base url, needs replacement for every new session to connect with REST API
  static String foodEndpoint = '/api/food';
  static String drinkEndpoint = '/api/drink';
  static String orderItemEndpoint = '/api/orderItem';
  static String deleteOrderItemsById = '/api/orderItem/deleteOrderItemsById';
  static String orderItemFoodEndpoint = '/api/orderItem/addFoodItemToOrder';
  static String orderItemDrinkEndpoint = '/api/orderItem/addDrinkItemToOrder';
  static String orderItemGetOrderItemByUserId =
      "/api/orderItem/getOrderItemByUserId";
  static String increaseQuantityOrderItemFoodEndpoint =
      '/api/orderItem/increaseQuantityOrderItemFood';
  static String decreaseQuantityOrderItemEndpoint =
      '/api/orderItem/decreaseQuantityOrderItem';
  static String increaseQuantityOrderItemDrinkEndpoint =
      '/api/orderItem/increaseQuantityOrderItemDrink';
  static String loginEndPoint = '/api/account/login';
  static String signUpEndPoint = '/api/account/register';
  static String imageEndpoint = '/images/';
}
