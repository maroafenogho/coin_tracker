# Coin Tracker

Welcome to coin tracker. A mobile application that helps you keep track of your favourite crypto-currency assets with ease. 

The app currently queries the top 100 coins in the market using the CoinGecko API to retrieve coin data which is displayed in a list.

This app follows the Riverpod architecture.

The app uses the following packages/dependencies:

* <a href="https://pub.dev/packages/flutter_riverpod" target="_blank">Riverpod</a> for state management
* Firebase for Authentication. (Currently removed from this branch)
* <a href="https://pub.dev/packages/http" target="_blank">Http</a> for querying APIs


The homescreen currently looks like the image below:

## Update (January 23 2023):
- The app now has icons for each asset.
- The app also includes an expandable widget which opens up a separate part on the list itm to display more details for the selected coin.
- <a href="https://pub.dev/packages/fl_chart" target="_blank">FL Charts</a> has been added to show price action over a 7-Day, 1-Month, 1-Year and all-time period.

## New Look:
<img src="./cointracker.png">
<img src="./cointracker1.png">
<img src="./chart.png">

# What can you learn from this repo?
1. API integration
2. Riverpod Architecture
3. State management with Riverpod, and more.