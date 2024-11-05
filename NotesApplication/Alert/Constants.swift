//
//  Constants.swift
//  NotesApplication
//
//  Created by Ana on 11/5/24.
//

import UIKit

enum AlertConstants {
    enum Layout {
        static let containerCornerRadius: CGFloat = 12
        static let buttonCornerRadius: CGFloat = 8
        static let containerWidth: CGFloat = 330
        static let containerHeight: CGFloat = 235
        static let buttonHeight: CGFloat = 40
        static let stackSpacing: CGFloat = 8
        
        enum Padding {
            static let standard: CGFloat = 16
            static let top: CGFloat = 20
            static let imageSize: CGFloat = 36
        }
    }
    
    enum Text {
        static let title = "Are you sure you want to delete note?"
        static let cancelButton = "Cancel"
        static let deleteButton = "Delete"
    }
    
    enum Image {
        static let infoImage = "Information"
    }
    
    enum Style {
        static let titleFontSize: CGFloat = 20
        static let backgroundAlpha: CGFloat = 0.5
    }
}
