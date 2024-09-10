//
//  PrewarmingExtBundle.swift
//  PrewarmingExt
//
//  Created by Jonatan Nielavitzky on 09/09/2024.
//

import WidgetKit
import SwiftUI

@main
struct PrewarmingExtBundle: WidgetBundle {
    var body: some Widget {
        PrewarmingExt()
        PrewarmingExtLiveActivity()
    }
}
