# weather_app

Weather app allows you to check the weather in London (and soon in other places). 

## How to run this app

In order to run this application on your Android or iOS device or simulator. You need to either run or build the application with an API Key provided by Open Weather. 

Get you Open Weather API key by visiting the following link:

- [Open Weather API](https://openweathermap.org/price)

After getting the key, you may either build the app or run the app by entering flutter build or flutter run on your terminal, with the following argument: "--dart-define", "WEATHER_API=[YOUR_API_KEY]". 

## Functionalities

Once you open the app the weather data for the current time in London will be fetched, as well as data for the next five days. 

You can pull to refresh on the homescreen to fetch new weather data. If you have fetched data before, and you fetch data without an Internet connection, the previously loaded data will be displayed.

You can also change the theme by tapping on the action button on the AppBar (top right). By default, the device's system theme is used. 

The app is available in both English and Spanish depending on the user's locale. 

## Pending

I apologize for not having completed the test, but my time for completing it was limited due to the fact that I'm currently abroad.

Here's a list of things that are still pending due to time limitations:
- Unit tests for the functions used to fetch the data remotely and fetch it and save it locally.
- Widget tests for the main Weather (Home) View.
- A proper implementation of Platform Views on Android and iOS (Webviews are currently being used as an alternative).
- UML Diagrams of the app's flow.

## For the future

With even more time, it would make sense to allow the user to search any location to get the weather of that location, and to use the devices location services to determine where the user is located and fetch the data from their location automatically. 

Using a different Weather API, a more accurate weather forecast could be shown to the user. The current implementation is a workaround, given the fact that OpenWeather requires users to have a paid Account in order to use the Daily Forecast option. 

Dynamic backgrounds depending on the current weather may also be an interesting concept to consider in the near future. 

## Others

MVU architecture used. As well as repository-service pattern. State Management is handled with Riverpod.

