# Coin Tracker

Welcome to coin tracker. A mobile application that helps you keep track of your favourite crypto-currency assets with ease. 


With coin tracker, you would be able to get hourly notifications on the current price of your assets, helping you decide when to buy, sell or hodl.

# Features

At the currrent app stage, users would be able to get the current prices of bitcoin and Ethereum at the tap of a button. 
The current prices obtained are then stored in a map along with the time of retrieval. The map is immediately parsed into the local database provided before displaying the updated list in the homescreen. 
## Update:
The app allows users get the current prices of Ethereum and Bitcoin, checks them against the previous prices stored on the app's local database, and then determines if the price of the asset went up or down within the time period. After checking, the database is updated with the current price of the asset, its old price and increased/decreased keyword.


The app uses the following packages/dependencies:

* <a href="https://pub.dev/packages/get" target="_blank">Getx</a> for state management
* Firebase for Authentication.
* <a href="https://pub.dev/packages/hive" target="_blank">Hive</a> for offline database
* <a href="https://pub.dev/packages/http" target="_blank">Http</a> for querying APIs
* <a href="https://pub.dev/packages/flutter_local_notifications"> Local notifications</a> for sending notifications as set.

The app is implemented using the MVVM and Repository design patterns.



The homescreen currently looks like the image below:

<img src="./cointracker.png">