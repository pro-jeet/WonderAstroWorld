# WonderAstroWorld
WonderAstroWorld Version1.0 Build 1 - Project 
Deployment targets - iOS (17.5), macOS (14.4)

 - WonderAstroWorld is built on MVVM design Pattern
 - SOLID principles followed while developing project.
 - Documentation added for the code.
 - Caching is done for images.
 - WebView to show content other than images
 - Dark Mode Supported


Feature and Functionality as per requirements:

1. AstroListView:
   - Developed AstroListView and AstroListViewModel - for showing "Picture of the day"  for last 7 days.
   - Added Reload button if error comes while fetching data in AstroListView.

2. AstroDetailView
   - Developed AstroDetailView and AstroDetailViewModel to show details of selected Astronomy picture.
   - Added Full Screen Image view to see image on full screen in original size.
   
3. Added Network Layer to call apis whenever required.


4. Error handling added to the project.


5. Testing (Unit and UITesting): (Code coverage of 88%.)
   - UITest added for all Views.
   - UnitTest added for all business logic.
  


Additional Features Added:

1. AstroListView:
    - Added functionality like selecting date from calendar and get data for the last 7 days from the selected date. (On Click of calendar button on Top bar)

2. AstroDetailView:
    - Added function like to see the HD version of the Picture. (To switch between HD and Normal Pic - click of HD/Normal Button on Top Bar)
    - Read More and Read less button added for large description for the Picture.
    - Click on picture to see it in Original size (scrollable) and click again on image to see the previous view again.

3. Image Caching for both HD and Normal Picturs:
    - Developed module for caching images in Cache memory.

4. Misc:
    - Timezone added ad api works in US timezone.
    - ProgressView addded to show loading Screen.
    - Error handling added.
    - Added Support for WebView to show content other than Picture.
  
5. Added plist for storing API_KEY.



