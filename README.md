# weather_app

Weather app, as the name impies, allows you to check the weather in your location.

## How to run this app

In order to run this application on your Android or iOS device or simulator. You need to either run or build the application with an API Key provided by Open Weather. 

Get you Open Weather API key by visiting the following link:

- [Open Weather API](https://openweathermap.org/price)

After getting the key, you may either build the app or run the app by entering flutter build or flutter run on your terminal, with the following argument: "--dart-define", "WEATHER_API=[YOUR_API_KEY]". 

## Functionalities

Once you open the app the weather data for the current time in your location will be fetched, as well as data for the next five days. 

You can pull to refresh on the homescreen to fetch new weather data. If you have fetched data before, and you fetch data without an Internet connection, the previously loaded data will be displayed.

You can also change the theme by tapping on the action button on the AppBar (top right). By default, the device's system theme is used. 

The app is available in both English, Italian and Spanish depending on the user's locale. 

## For the future

Using a different Weather API, a more accurate weather forecast could be shown to the user. The current implementation is a workaround, given the fact that OpenWeather requires users to have a paid Account in order to use the Daily Forecast option. 

Dynamic backgrounds depending on the current weather may also be an interesting concept to consider in the near future.

## Others

MVU architecture used. As well as repository-service pattern. State Management is handled with Riverpod.