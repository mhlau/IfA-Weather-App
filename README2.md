# IfA Weather App (for staff)

## Downloading, Opening, and Running IfA Weather on the iOS Simulator

In https://github.com/mhlau/IfA-Weather-App, click **Download ZIP**. This should download a .zip file that, when unzipped, contains a folder called ```IfA-Weather-App-master```. In ```IfA-Weather-App-master```, open ```IfA Weather App.xcodeproj```. This should open Xcode 5 and the project. 

To run the app on the iOS Simulator, an application packaged with Xcode 5, click the play button at the top left-hand corner of the Xcode window. Make sure that the destination (the second drop-down list at the top left-hand corner) is set to either **iPhone Retina (3.5-inch)** or **iPhone Retina (4-inch)**. Note that the command ```⌘R``` will also run the app with the selected destination.

Once the iOS Simulator is no longer needed, use **iOS Simulator > Quit iOS Simulator** or ```⌘Q``` to quit the simulator. Quitting the iOS Simulator will not close Xcode.

## Class Relationships (Main_iPhone.storyboard)

The app contains 3 primary views: 
1. ```ViewController``` -- the views containing current weather data,
2. ```SecondViewController``` -- the views containing images,
3. ```ThirdViewController``` -- the views containing graphs.