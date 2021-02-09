//
//  StringExtension.swift
//  SwiftTips
//
//  Created by Nguyen Duc Huy B on 2/5/21.
//  Copyright © 2021 nguyen.duc.huyb. All rights reserved.
//

import Foundation

extension String {
    func stringByAppendingPathComponent(path: String) -> String {
        let nsSt = self as NSString
        return nsSt.appendingPathComponent(path)
    }
}
