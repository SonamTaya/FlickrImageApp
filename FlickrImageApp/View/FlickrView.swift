//
//  FlickrView.swift
//  FlickrImageApp
//
//  Created by sonam taya on 2/3/22.
//

import UIKit

struct Orientation {
    // indicate current device is in the LandScape orientation
    static var isLandscape: Bool {
        get {
            return UIDevice.current.orientation.isValidInterfaceOrientation
                ? UIDevice.current.orientation.isLandscape
                : (UIApplication.shared.windows.first?.windowScene?.interfaceOrientation.isLandscape)!
        }
    }
    // indicate current device is in the Portrait orientation
    static var isPortrait: Bool {
        get {
            return UIDevice.current.orientation.isValidInterfaceOrientation
                ? UIDevice.current.orientation.isPortrait
                : (UIApplication.shared.windows.first?.windowScene?.interfaceOrientation.isPortrait)!
        }
    }
}

class FlickrView: UIView {
    
    let viewBackground: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.searchBarStyle = UISearchBar.Style.default
            searchBar.placeholder = " Search..."
            searchBar.sizeToFit()
            searchBar.isTranslucent = false
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        return searchBar
    }()
      
     var collectionHolderView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
 
    // MARK: - Setup
    private func setupView() {
        addSubview(viewBackground)
        viewBackground.addSubview(searchBar)
        viewBackground.addSubview(collectionHolderView)

        NSLayoutConstraint.activate([
            viewBackground.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor),
            viewBackground.leftAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leftAnchor),
            viewBackground.rightAnchor.constraint(equalTo: self.safeAreaLayoutGuide.rightAnchor),
            viewBackground.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),

            searchBar.topAnchor.constraint(equalTo: viewBackground.topAnchor, constant: 10),
            searchBar.leftAnchor.constraint(equalTo: viewBackground.leftAnchor, constant: 10),
            searchBar.rightAnchor.constraint(equalTo: viewBackground.rightAnchor, constant: -10),
            searchBar.heightAnchor.constraint(equalToConstant: 50),
          
            collectionHolderView.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 10),
            collectionHolderView.bottomAnchor.constraint(equalTo: viewBackground.bottomAnchor, constant: -10),
            collectionHolderView.leftAnchor.constraint(equalTo: viewBackground.leftAnchor),
            collectionHolderView.rightAnchor.constraint(equalTo: viewBackground.rightAnchor),
           
        ])
        
    }
    
}
