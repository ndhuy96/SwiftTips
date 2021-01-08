//
//  CarouselViewController.swift
//  SwiftTips
//
//  Created by Nguyen Duc Huy B on 12/8/20.
//  Copyright © 2020 nguyen.duc.huyb. All rights reserved.
//

import UIKit

class CarouselViewController: UIViewController {

    // Views
    var scrollView: UIScrollView!
    
    // UI values
    private var viewWidth: CGFloat { self.view.frame.width }
    private var viewHeight: CGFloat { self.view.frame.height }
    private var margin: CGFloat = 8
    private var imgWidth: CGFloat { floor(308 * DeviceHelper.currentDeviceRatio) }
    private var imgPadding: CGFloat = 4

    private var timer: Timer?

    private var viewModel: CarouselViewModel!
    
    private var banners: [String] = []
        
    override func viewDidLoad() {
        super.viewDidLoad()
        initializeBanners()
        self.view.backgroundColor = UIColor.white
        setupViews()
        setupViewModel()
    }
    
    private func initializeBanners() {
        for i in 1...6 {
            banners.append("image_food_\(i)")
        }
    }
    
    func start() {
        guard
            let viewModel = viewModel,
            timer == nil
            else { return }
        timer = Timer.scheduledTimer(
            timeInterval: viewModel.autoSlideDuration,
            target: self,
            selector: #selector(autoSlideNextBanner(_:)),
            userInfo: nil,
            repeats: true
        )
    }

    func stop() {
        timer?.invalidate()
        timer = nil
        guard let viewModel = viewModel else { return }
        let pageWidth = scrollView.frame.width
        scrollView.setContentOffset(
            CGPoint(x: CGFloat(viewModel.firstImgIndex) * pageWidth, y: 0),
            animated: false
        )
    }
}
extension CarouselViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard let viewModel = self.viewModel else { return }
        if viewModel.imgUrls.count > 2 {
            let pageWidth = scrollView.frame.width
            let leadingEdge = CGFloat(viewModel.leadingEdgeImgIndex) * pageWidth
            let trailingEdge = CGFloat(viewModel.trailingEdgeImgIndex) * pageWidth

            let offsetX = scrollView.contentOffset.x

            if offsetX < leadingEdge {
                scrollView.setContentOffset(CGPoint(x: CGFloat(viewModel.lastImgIndex) * pageWidth + offsetX, y: 0),
                                            animated: false)
            }

            if offsetX == trailingEdge {
                scrollView.setContentOffset(CGPoint(x: CGFloat(viewModel.firstImgIndex) * pageWidth, y: 0),
                                            animated: false)
            }

            let currentIndex = offsetX / pageWidth
            self.viewModel?.updateCurrentBanner(at: Int(currentIndex))
        }
    }
}

private extension CarouselViewController {

    func setupViews() {
        let startX = (viewWidth - imgWidth - 2 * margin) / 2 + imgPadding
        scrollView = UIScrollView(
            frame: CGRect(x: startX, y: 0, width: imgWidth + margin, height: viewHeight)
        )
        scrollView.delegate = self
        scrollView.isPagingEnabled = true
        scrollView.clipsToBounds = false
        view.addSubview(scrollView)
    }

    func setupViewModel() {
        viewModel = CarouselViewModel(banners)
        addImageViews(with: viewModel)
        start()
    }

    func addImageViews(with viewModel: CarouselViewModel) {
        scrollView.subviews.forEach({ $0.removeFromSuperview() })
        viewModel.imgUrls.enumerated().forEach({ (index, url) in
            let imgView: UIImageView = .init(
                frame: CGRect(x: imgPadding + CGFloat(index) * (imgWidth + margin), y: 0, width: imgWidth, height: viewHeight)
            )
            imgView.isUserInteractionEnabled = true
            imgView.contentMode = .scaleAspectFit
            let gesture = UITapGestureRecognizer(target: self, action: #selector(bannerDidTap))
            imgView.addGestureRecognizer(gesture)
            imgView.image = UIImage(named: url)
            scrollView.addSubview(imgView)
        })
        scrollView.contentSize = CGSize(width: CGFloat(viewModel.imgUrls.count) * (imgWidth + margin), height: viewHeight)
        scrollView.contentOffset = CGPoint(x: CGFloat(viewModel.firstImgIndex) * scrollView.frame.width, y: 0)
    }

    @objc func bannerDidTap(_ sender: UITapGestureRecognizer?) {
        guard let actionUrlString = viewModel?.currentSelectedBanner(),
              let index = viewModel?.currentDisplayedIndex() else { return }
        print("index: \(index) - url: \(actionUrlString)")
    }

    @objc func autoSlideNextBanner(_ timer: Timer) {
        guard scrollView.contentOffset.x.truncatingRemainder(dividingBy: scrollView.bounds.width) == .zero else {
            return
        }
        let nextBannerX = scrollView.contentOffset.x + scrollView.frame.width
        let offset = CGPoint(x: nextBannerX, y: scrollView.contentOffset.y)
        scrollView.setContentOffset(offset, animated: true)
        if let index = viewModel?.currentDisplayedIndex() {
            print("Index: \(index)")
        }
    }
}
