# Forecast


Test for Senior iOS Engineer position.

## Table of Contents

- [Prerequisite](#prerequisite)
- [The App](#theapp)
- [Architecture](#architecture)
- [Testing & Automation](#testing)
- [ScreenShots](#screenshots)
- [Video](#video)

## Prerequisite
This app has been built using Xcode 14. XCode automatically manages signing but if you face problem while running the app, go to the project directory, under `Signing $ Capabilities`, and add your developer team account.

# The App
The app displays the current weather at the user’s location
and a 5-day forecast from [Open Weather API](https://api.openweathermap.org/data/2.5/).

## Additional Features
a. The ability to save different weather locations as favourites.<br>
b. The ability to view a list of favourites.<br>
c. The ability to get extra information about a specific location Using something Google Places API.<br>
d. The ability to see weather information while the application is offline.<br>
e. Allow the user to view saved locations on a map.


## Languages
The project has been written in <b>Swift</b> language and design using <b>UIKit</b> and <b>SwiftUI</b>. It uses URLSession with <b>Combine</b> for network requests.

## Architecture
The project is meticulously crafted adhering to the MVVM (Model-View-ViewModel) architectural pattern,
a cornerstone of modern app development.
MVVM fosters the decoupling of concerns, paving the way for simplified testing and maintenance.

## MVVM implementation
  <b>* Data Initialization:</b> Upon the app's initial launch, the backend API service is summoned to retrieve current weather and the % day forecast data.
    This data is stored locally using the <b>CoreData</b> database.

  <b>* Offline Resilience:</b> 
    In scenarios where internet connectivity is unavailable, the stored data within the local cache becomes the go-to source of information, ensuring that the user experience remains uninterrupted.

  <b>* ViewModel Dynamics:</b> The ViewModel plays a pivotal role in this architectural composition of orchestrating the interaction between the Model (data) and the View (UI). 
    It updates the UI in response to data changes.

Incorporating these technical strategies ensures that the project aligns with contemporary architectural best practices,
fostering modularity, testability, and overall software quality.

## Testing and Testing
All tests are located within the iOS Test package. The execution of these tests is handled using XCTest.
To run tests using <b>fastlane</b> run `fastlane test` command in your CL.
Test automation has also been demonstrated using CircleCI.

## ScreenShots

<img src="https://github.com/Hechio/Forecast/assets/47601553/7aab1d0a-6ca7-4ed3-9f1f-51280f37e109" width="200" style="max-width:100%;">
<img src="https://github.com/Hechio/Forecast/assets/47601553/117dc9e4-b76e-4997-bfc8-d6aa57db7381" width="200" style="max-width:100%;">
<img src="https://github.com/Hechio/Forecast/assets/47601553/afdc35b1-2531-4229-96fc-c44ce09ee2bd" width="200" style="max-width:100%;"> 
<img src="https://github.com/Hechio/Forecast/assets/47601553/cf5cb7c8-8176-4c95-a013-d6062a53e52b" width="200" style="max-width:100%;"> 
<img src="https://github.com/Hechio/Forecast/assets/47601553/b1a38ff6-ac13-45cc-a304-c7bfb7a0dd96" width="200" style="max-width:100%;"> 
<img src="https://github.com/Hechio/Forecast/assets/47601553/374e788a-e4dd-40d6-a592-c60ca8979940" width="200" style="max-width:100%;"> 
<img src="https://github.com/Hechio/Forecast/assets/47601553/85254782-9386-484a-9465-738c9dc6f5cd" width="200" style="max-width:100%;"> 

## Video Recording of the App

https://github.com/Hechio/Forecast/assets/47601553/f13987e3-b61a-49a3-839a-ee27edc479c5



