//
//  CarouselViewModel.swift
//  SwiftTips
//
//  Created by Nguyen Duc Huy B on 12/8/20.
//  Copyright © 2020 nguyen.duc.huyb. All rights reserved.
//

import Foundation

struct CarouselViewModel {
    private let _imageUrls: [String]
    
    private lazy var _currentIndex: Int = firstImgIndex
    
    var imgUrls: [String] { _imageUrls }

    var firstImgIndex: Int {
        return imgUrls.count == 1 ? 0 : 2
    }

    var lastImgIndex: Int {
        return imgUrls.count == 1 ? 0 : imgUrls.count - 3
    }

    var leadingEdgeImgIndex: Int {
        return imgUrls.count == 1 ? 0 : 1
    }

    var trailingEdgeImgIndex: Int {
        return imgUrls.count == 1 ? 0 : imgUrls.count - 2
    }

    let autoSlideDuration: TimeInterval = 5

    init(_ banners: [String]) {
        var urls = banners

        // Add buffer imgUrls, for loop effect
        switch urls.count {
        case 2...:
            let (bufferLeftImgUrl, leftImgUrl, rightImgUrl, bufferRightImgUrl) = (urls[urls.count - 2], urls[urls.count - 1], urls[0], urls[1])
            urls = [bufferLeftImgUrl, leftImgUrl] + urls + [rightImgUrl, bufferRightImgUrl]
        default:
            break
        }
        self._imageUrls = urls
    }
    
    mutating func updateCurrentBanner(at index: Int) {
        _currentIndex = index
    }

    mutating func currentSelectedBanner() -> String? {
        let index = _currentIndex
        guard index < _imageUrls.count else { return nil }
        return _imageUrls[index]
    }

    mutating func currentDisplayedIndex() -> Int? {
        guard let banner = currentSelectedBanner(),
              let index = _imageUrls.firstIndex(of: banner) else { return nil }
        return index + 1 == _imageUrls.count ? 0 : index + 1
    }
}
