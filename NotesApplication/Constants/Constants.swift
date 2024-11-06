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


enum NoteTableViewCellConstants {
    static let identifier = "NoteCell"
    static let noteViewCornerRadius: CGFloat = 8.0
    static let noteViewTopPadding: CGFloat = 8.0
    static let noteViewLeadingPadding: CGFloat = 16.0
    static let noteViewWidth: CGFloat = 365.0
    static let noteViewHeight: CGFloat = 110.0
    static let noteViewBottomPadding: CGFloat = -8.0
    
    static let titleLabelTopPadding: CGFloat = 12.0
    static let titleLabelLeadingPadding: CGFloat = 12.0
    static let titleLabelTrailingPadding: CGFloat = -12.0
    static let titleLabelBottomPadding: CGFloat = -12.0
    
    static let deleteButtonTrailingPadding: CGFloat = -20.0
    static let deleteButtonSize: CGFloat = 34.0
}
