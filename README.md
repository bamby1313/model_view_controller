# model_view_controller_app
A modern Model View Controller architecture with App organizer.
![](https://github.com/bamby1313/model_view_controller/blob/main/DependencyAnalysis.JPG)

## Instructions
Please check the dev branch which is probably more recent than the master one.

This is the **Model-View-Controller-App** ("MVC-A") architecture interface to build a robust App with **App Designer**.
It is a modern approach with an interface to help end user building his/her application, making it more robust.
Also, there is another class, App, which will add the components.  

### Interface package +mvc  
* The interface package is **mvc**, containing the 4 abstract classes(*aModel*, *aView*, *aCallbacks* and *aApp*) and 1 class (Components):  
  - **aModel**: all the intrinsic calculations of the apps - independent from all other classes, easily scalable for other apps. 
  - **aView**: visual component in the app, with callbacks attached. Updated by the controller. Fully independent.
  - **aController**: callbacks from the user's actions. Controls the view & the model.
  - **aApp**: main object instancing all the other - control the architecture (components) of the app and deployable to web app.


### Web app:  
* The instantiated app is deployable as a web app  

## Relevant Products
* MATLAB
* App Designer
* Web App Server
