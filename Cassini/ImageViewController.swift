//
//  ImageViewController.swift
//  Cassini
//
//  Created by Vasanthakumar Annadurai on 24/07/18.
//  Copyright © 2018 Vasanthakumar Annadurai. All rights reserved.
//

import UIKit

class ImageViewController: UIViewController, UIScrollViewDelegate {
    
    // MARK: - Properties.
    var imageUrl: URL? {
        didSet{
            image = nil
            // Fetch image only if this viewController is onScreen.
            if view.window != nil{
                fetchImage()
            }
        }
    }
    var imageView = UIImageView()
    @IBOutlet weak var scrollView: UIScrollView!{
        didSet{
            scrollView.minimumZoomScale = 1/25
            scrollView.maximumZoomScale = 1.0
            scrollView.delegate = self
            scrollView.addSubview(imageView)
        }
    }
    private var image: UIImage?{
        get{
            return imageView.image
        }
        set{
            imageView.image = newValue
            imageView.sizeToFit()
            scrollView.contentSize = imageView.frame.size
        }
    }
    
    // MARK: - UIViewController Methods.
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if imageUrl == nil{
            imageUrl = DemoURLs.standford
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if imageView.image == nil{
            fetchImage()
        }
    }
    
    // MARK: - UIScrollViewDelegate Methods.
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
    
    // MARK: - Private Methods.
    private func fetchImage(){
        if let url = imageUrl{
            let urlContent = try? Data(contentsOf: url)
            if let imageData = urlContent{
                image = UIImage(data: imageData)
            }
        }
    }
    
    
}
