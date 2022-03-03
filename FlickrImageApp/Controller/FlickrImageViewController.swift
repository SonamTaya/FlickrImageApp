//
//  FlickrImageViewController.swift
//  FlickrImageApp
//
//  Created by sonam taya on 2/3/22.
//

import UIKit

class FlickrImageViewController: UIViewController {
    
    //MARK:- Variables
    let flickrView = FlickrView()
    private var viewModel: FlickrViewModel?
    
    lazy var collectionView: UICollectionView = {
        var collection = UICollectionView()
        return collection
    }()
    
    let activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .medium)
        indicator.startAnimating()
        return indicator
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        viewModel = FlickrViewModel(delegate: self)
    }
    
    // MARK: - Setup
    func setupView(){
        navigationController?.navigationBar.topItem?.title = "Flickr Images"
        self.view.backgroundColor = .systemBackground
        flickrView.frame = view.frame
        view.addSubview(flickrView)
        self.flickrView.searchBar.delegate = self
        setupCollectioniew()
    }
    
    func setupCollectioniew() {
        // CollectionView Flow Layout
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        layout.itemSize = CGSize(width: (self.flickrView.frame.width-40)/3, height: (self.flickrView.frame.width-40)/3)
        layout.scrollDirection = .vertical
        collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        self.flickrView.collectionHolderView.addSubview(collectionView)

        collectionView.constraints(top: flickrView.collectionHolderView.topAnchor, leading: flickrView.collectionHolderView.leadingAnchor, bottom: flickrView.collectionHolderView.bottomAnchor, trailing: flickrView.collectionHolderView.trailingAnchor)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "FlickrImageCollectionCell", bundle: .main), forCellWithReuseIdentifier: "flickrImageCollectionCell")
    }
}

// MARK: - EXTENSION CollectionViewDelegates & CollectionViewDataSource

extension FlickrImageViewController: UICollectionViewDelegate, UICollectionViewDataSource  {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.viewModel?.data?.photos?.photo?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "flickrImageCollectionCell", for: indexPath) as! FlickrImageCollectionCell
        cell.photoData = self.viewModel?.data?.photos?.photo?[indexPath.row]        
        return cell
    }
}

// MARK: - EXTENSION ViewModelDelegates

extension FlickrImageViewController : ViewModelDelegate {
    func fetchDidSucceed() {
        collectionView.reloadData()     
        self.flickrView.searchBar.isUserInteractionEnabled = true
        self.activityIndicator.removeFromSuperview()
    }
    
    func fetchDidFail(with title: String, description: String) {
        showAlert(withTitle:title, withMessage: description)
        self.viewModel?.data = nil
        collectionView.reloadData()
        self.flickrView.searchBar.isUserInteractionEnabled = true
        self.activityIndicator.removeFromSuperview()
    }
}

// MARK: - EXTENSION SearchBarDelegates

extension FlickrImageViewController: UISearchBarDelegate {
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(true, animated: true)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        searchBar.resignFirstResponder()
        searchBar.setShowsCancelButton(false, animated: true)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(false, animated: true)
        searchBar.resignFirstResponder()
        if let text = searchBar.text, text != "" {
            self.flickrView.searchBar.isUserInteractionEnabled = false
            self.view.addSubview(activityIndicator)
            activityIndicator.frame = self.view.frame
            let urlString = baseUrlString.appending(text)
            viewModel?.fetchData(with: urlString)
        }
    }
    
}

