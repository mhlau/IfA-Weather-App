# IfA Weather App (for staff)

## Downloading, Opening, and Running IfA Weather on the iOS Simulator

In https://github.com/mhlau/IfA-Weather-App, click **Download ZIP**. This should download a .zip file that, when unzipped, contains a folder called ```IfA-Weather-App-master```. In ```IfA-Weather-App-master```, open ```IfA Weather App.xcodeproj```. This should open Xcode 5 and the project. 

To run the app on the iOS Simulator, an application packaged with Xcode 5, click the play button at the top left-hand corner of the Xcode window. Make sure that the destination (the second drop-down list at the top left-hand corner) is set to either **iPhone Retina (3.5-inch)** or **iPhone Retina (4-inch)**. Note that the command ```⌘R``` will also run the app with the selected destination.

Once the iOS Simulator is no longer needed, use **iOS Simulator > Quit iOS Simulator** or ```⌘Q``` to quit the simulator. Quitting the iOS Simulator will not close Xcode.

## Class Relationships (Main_iPhone.storyboard)

The app contains 4 primary views: 

1. ```ViewController``` -- the views containing **current weather data**,
2. ```SecondViewController``` -- the views containing **images**,
3. ```ThirdViewController``` -- the views containing **graphs**,
4. ```SidebarViewController``` --  the view containing the **sidebar**.

The ```Main_iPhone.storyboard``` file contains the above 4 views, and 2 others: the **Reveal View Controller**, of the class ```SWRevealController``` (an external package), and a **Navigation Controller**, used to represent the current view being displayed. These other two views need not be altered.

![](https://github.com/mhlau/IfA-Weather-App/blob/master/readme_images/Main_iPhone.storyboard.jpg)

The **Sidebar View Controller** is linked to the three ```UIViewController``` classes, **View Controller**, **Second View Controller**, and **Third View Controller**, with arrows labeled with "{}" brackets. These arrows represent "segues," which associate each cell in the sidebar to a specific action. A uniquely-named segue is given to every sidebar cell that does something when selected.

# Sidebar (SidebarViewController.m / .h)

The app opens to the Haleakala Current Weather page by default. From there, selecting a cell in the sidebar will cause a new ```UIViewController``` to be displayed, with instructions for the ```UIViewController``` class based on the segue.

For example, take this code contained in the ```(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender``` method in ```SidebarViewController.m```:

```objective-c
// Haleakala 48 Hour Trends cell is selected:
if ([destVC isKindOfClass:[ThirdViewController class]] && [segue.identifier isEqualToString:@"H48GraphSegue"])
{
    [(ThirdViewController *)destVC set48Hours:true];
}
```

This is the code associated with the segue arrow going from the "Haleakala 48-Hour Trends" cell in **Sidebar View Controller** to the **Third View Controller** in ```Main_iPhone.storyboard```. When the user taps on the "48-Hour Trends" cell in the sidebar under "Haleakala," the current view controller changes from class ```ViewController``` to class ```ThirdViewController```, and sets ```_is48Hours``` in ```ThirdViewController.m``` to ```true```, causing the Haleakala 48-Hour data to be displayed.





