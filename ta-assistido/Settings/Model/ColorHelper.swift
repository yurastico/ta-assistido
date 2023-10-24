//
//  ColorHelper.swift
//  ta-assistido
//
//  Created by Yuri Cunha on 23/10/23.
//

import Foundation
import SwiftUI

enum ColorHelper {
    static func colorFor(index: Int) -> Color {
        switch index {
        case 0:
            return Color.blue
        case 1:
            return Color.orange
        case 2:
            return Color.purple
        default:
            return Color.blue
        }
    }
}
