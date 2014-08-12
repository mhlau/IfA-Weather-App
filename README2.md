# IfA Weather App (for staff)

## Downloading, Opening, and Running IfA Weather on the iOS Simulator

In https://github.com/mhlau/IfA-Weather-App, click **Download ZIP**. This should download a .zip file that, when unzipped, contains a folder called ```IfA-Weather-App-master```. In ```IfA-Weather-App-master```, open ```IfA Weather App.xcodeproj```. This should open Xcode 5 and the project. 

To run the app on the iOS Simulator, an application packaged with Xcode 5, click the play button at the top left-hand corner of the Xcode window. Make sure that the active scheme is set to either **iPhone Retina (3.5-inch)** or **iPhone Retina (4-inch)**. Note that the command ```⌘R``` will also run the app with the selected destination.

Once the iOS Simulator is no longer needed, use **iOS Simulator > Quit iOS Simulator** or ```⌘Q``` to quit the simulator. Quitting the iOS Simulator will not close Xcode.

## Running IfA Weather on a Provisioned Device

#### Provisioning a Device for Development, via Xcode

1. Connect the device to the Mac.
2. Open Xcode. Go to **Window > Organizer** (```⌘⇧2```).
3. Click "Use for Development".
4. In the team dialog that appears, select the checkbox next to your account name, and click Choose.
5. If a Certificate Not Found dialog appears, click Request.

#### Running IfA Weather on the Device

1. At the top-right of Xcode, make sure the active scheme is set to the name of the iOS device.
2. Click the run button at the top-right of Xcode. The app should be added to the device and run. The app may not load and run on the first build, so try again if it fails.

## External Libraries and Packages

IfA Weather uses the following libraries and packages:
- **CorePlot** (https://github.com/core-plot/core-plot) as its graphing framework,
- **SDWebImage** (https://github.com/rs/SDWebImage) and UIActivityIndicator-for-SDWebImage (https://github.com/JJSaccolo/UIActivityIndicator-for-SDWebImage) for asynchronous image downloads, 
- **SWRevealViewController** (https://github.com/John-Lluch/SWRevealViewController) and modified code from AppCoda (http://www.appcoda.com/ios-programming-sidebar-navigation-menu/) for its side-drawer navigation.

The PHP side uses **GifCreator** (https://github.com/Sybio/GifCreator) to turn series of MKWC satellite images into .gif files.


## Class Relationships (```Main_iPhone.storyboard```)

The app contains 4 primary views: 

1. ```ViewController``` -- the views containing **current weather data**,
2. ```SecondViewController``` -- the views containing **images**,
3. ```ThirdViewController``` -- the views containing **graphs**,
4. ```SidebarViewController``` --  the view containing the **sidebar**.

The ```Main_iPhone.storyboard``` file contains the above 4 views, and 2 others: the **Reveal View Controller**, of the class ```SWRevealController``` (an external package), and a **Navigation Controller**, used to represent the current view being displayed. These other two views need not be altered.

![](https://github.com/mhlau/IfA-Weather-App/blob/master/readme_images/Main_iPhone.storyboard.jpg)

The **Sidebar View Controller** is linked to the three ```UIViewController``` classes, **View Controller**, **Second View Controller**, and **Third View Controller**, with arrows labeled with "{}" brackets. These arrows represent "segues," which associate each cell in the sidebar to a specific action. A uniquely-named segue is given to every sidebar cell that does something when selected. The segue identifier can be viewed by selecting the segue arrow, then opening the Attributes Inspector in the Utilities sidebar (right-hand sidebar).

## Sidebar (```SidebarViewController.m``` / ```.h```)

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

## ```ViewController.m``` / ```.h```

The ```ViewController``` class contains a ```UITableView``` to display the current weather conditions of Haleakala and the multiple stations of Mauna Kea. Each ```UITableViewCell``` in the table view is initialized from the .xib files and classes in the **DataCells** group (e.g. ```TemperatureCell.xib``` / ```.h``` / ```.m```). 

The Mauna Kea current weather view has fewer data fields than the Haleakala one, so the ```cellForRowAtIndexPath``` method uses conditionals to only instantiate desired cells.

#### Overview of Major Methods

- ```- (void)viewDidLoad```
    + Initializes background image.
    + Initializes table view.
    + Initializes ```DataParser``` and associated data structures.
    + Calls ```downloadItems``` on ```DataParser```, using URL depending on location.
    + Initializes timer that ticks every second, re-downloading data on tick.
    + Initializes sidebar.
    + Initializes picker view and arrays of URLs and Mauna Kea locations.
- ```- (void)itemsDownloaded:(NSDictionary *)itemDict```
    + Receives dictionary parameter, rounds all decimal values to 2 places, and inserts (key, value) pairs into new dictionary instance variable.
- ```-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component```
    + Called when row is selected in picker view. Hides picker view, changes MK weather station dictionary, and reloads the table view so data refreshes.
- ```- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath```
    + Initializes different types of UITableViewCell subclasses (```DateCell```, ```TemperatureCell```, etc.) by table row - order is hardcoded.
    + Sets UITableViewCell labels with data from dictionary.
- ```- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath```
    + Contains default height values and expanded height values for table view cells (hardcoded). 
- ```(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath```
    + Uses ```selectedIndex``` instance variable to change height of selected / unselected cells.
    + Uses ```toggle``` property to reveal / hide picker view.

## ```SecondViewController.m``` / ```.h```

The ```SecondViewController``` class contains a ```UITableView``` to display images of live web-cams, satellite weather, etc. Each ```UITableViewCell``` in the table view is initialized from the .xib file and class in the **ImageCell** group (```ImageCell.xib``` / ```.h``` / ```.m```). 

#### Overview of Major Methods

- ```- (void)viewDidLoad```
    + Initializes table view.
    + Initializes location and URL arrays based on boolean instance variable (e.g. ```_isMaunaKea```, ```_isWaterVapor```, etc.).
    + Sets up sidebar.
- ```-(void)setMaunaKea: (BOOL)isMaunaKea``` 
    + allows ```_isMaunaKea``` to be accessed outside of class in ```SidebarViewController.m``` (**applies to similar methods**).
- asdf

## Launch Image

The launch image (splash screen that is displayed before the app opens) must follow strict guidelines set by Apple (https://developer.apple.com/library/ios/documentation/userexperience/conceptual/mobilehig/LaunchImages.html). 

To change the launch image:

1. Create and add the new launch image files to the project with **File > Add Files to "IfA Weather App"**. 
2. Open the project in Xcode and click on **IfA Weather App** in the Navigator (left-hand toolbar),
3. Go to **General > Launch Images** and click the small arrow next to the drop-down menu,
4. Drag and drop the appropriate launch image from the file selector at the bottom right-hand corner (in Utilities sidebar). 2x is for iPhone 4S and below, and R4 is for iPhone 5 and above. 

