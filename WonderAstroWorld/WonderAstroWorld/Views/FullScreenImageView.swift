//
//  FullScreenImageView.swift
//  WonderAstroWorld
//
//  Created by JSharma on 27/05/24.
//

import SwiftUI

/**
 A SwiftUI view representing a full-screen image.

 This view displays a single image in full-screen mode, allowing users to scroll and view the image.

 ## Properties:
 - `uiImage`: An instance of `UIImage` representing the image to be displayed.

 ## View Body:
 - A `ScrollView` containing the image.

 This view utilizes SwiftUI's `ScrollView` and `Image` components to display the provided image in full-screen mode, allowing users to scroll and view the image.

*/

struct FullScreenImageView: View {
    
    // Properties
    let uiImage: UIImage
    
    // View body
    var body: some View {
        ScrollView {
            Image(uiImage: uiImage)
        }
    }
}
