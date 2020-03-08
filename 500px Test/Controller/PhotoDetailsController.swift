//
//  PhotoDetailsController.swift
//  500px Test
//
//  Created by Viswa Kodela on 2020-03-07.
//  Copyright © 2020 Viswa Kodela. All rights reserved.
//

import UIKit

class PhotoDetailsController: UIViewController {
    
    // MARK:- Properties
    private let photo: Photo
    
    // MARK:- Layout Objects
    let photoImageView: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    
    let activitySpinner: UIActivityIndicatorView = {
        let ai = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.large)
        ai.translatesAutoresizingMaskIntoConstraints = false
        ai.startAnimating()
        ai.hidesWhenStopped = true
        return ai
    }()
    
    var scrollView: UIScrollView!
    
    
    // MARK:- Init
    init(photo: Photo) {
        self.photo = photo
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureLayout()
        addScrollView()
        fetchImageData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    // MARK:- Helper Methods
    private func addScrollView() {
        scrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height))
        scrollView.minimumZoomScale = 1
        scrollView.maximumZoomScale = 3
        scrollView.bounces = false
        scrollView.delegate = self
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        view.addSubview(scrollView)
        
        scrollView.addSubview(photoImageView)
        photoImageView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        photoImageView.centerYAnchor.constraint(equalTo: scrollView.centerYAnchor).isActive = true
        photoImageView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        photoImageView.heightAnchor.constraint(equalToConstant: scrollView.frame.height).isActive = true
    }
    
    private func configureLayout() {
        view.backgroundColor = .systemBackground
        view.addSubview(activitySpinner)
        activitySpinner.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        activitySpinner.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    private func fetchImageData() {
        MainViewController.popularPhotosApi.request(.getPhoto(withID: photo.id)) { (data, resp, err) in
            guard let data = data else {return}
            do {
                let photo = try JSONDecoder().decode(PhotoDetail.self, from: data)
                DispatchQueue.main.async {
                    if let imageString = photo.photo.imageUrls.first, let url = URL(string: imageString) {
                        self.activitySpinner.stopAnimating()
                        self.photoImageView.sd_setImage(with: url)
                    }
                }
            } catch {
                print("Error decpding Image data with error \(error.localizedDescription)")
            }
        }
    }
    
    deinit {
        print("Details controller de-initialized")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension PhotoDetailsController: UIScrollViewDelegate {
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return photoImageView
    }
}
