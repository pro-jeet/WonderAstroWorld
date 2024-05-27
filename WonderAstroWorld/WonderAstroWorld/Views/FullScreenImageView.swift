//
//  FullScreenImageView.swift
//  WonderAstroWorld
//
//  Created by JSharma on 27/05/24.
//

import SwiftUI

struct FullScreenImageView: View {
    let uiImage: UIImage
    var body: some View {
        ScrollView {
            Image(uiImage: uiImage)
        }
    }
}
