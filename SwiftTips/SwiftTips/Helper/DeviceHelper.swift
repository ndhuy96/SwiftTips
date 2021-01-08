//
//  DeviceHelper.swift
//  SwiftTips
//
//  Created by Nguyen Duc Huy B on 12/8/20.
//  Copyright © 2020 nguyen.duc.huyb. All rights reserved.
//

import UIKit

struct DeviceHelper {
    static let isTablet = UIDevice.current.userInterfaceIdiom == .pad
    
    static var currentDeviceRatio: CGFloat = {
        let portraitWidth = min(UIScreen.main.bounds.width, UIScreen.main.bounds.height)
        let baseWidth: CGFloat = isTablet ? 768 : 375
        return portraitWidth / baseWidth
    }()
}
