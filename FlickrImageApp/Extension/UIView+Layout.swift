//
//  UIView+Layout.swift
//  FlickrImageApp
//
//  Created by sonam taya on 2/3/22.
//

import UIKit

extension UIView {
    
    func bindEdgesToSuperview() {
        constraints(top: superview?.topAnchor, leading: superview?.leadingAnchor, bottom: superview?.bottomAnchor, trailing: superview?.trailingAnchor)
    }
    
    func constraints(top: NSLayoutYAxisAnchor?, leading: NSLayoutXAxisAnchor?, bottom: NSLayoutYAxisAnchor?, trailing: NSLayoutXAxisAnchor?, padding: UIEdgeInsets = .zero, size: CGSize = .zero) {
        translatesAutoresizingMaskIntoConstraints = false
        
        if let top = top { topAnchor.constraint(equalTo: top, constant: padding.top).isActive = true }
        if let leading = leading { leadingAnchor.constraint(equalTo: leading, constant: padding.left).isActive = true }
        if let bottom = bottom { bottomAnchor.constraint(equalTo: bottom, constant: -padding.bottom).isActive = true }
        if let trailing = trailing { trailingAnchor.constraint(equalTo: trailing, constant: -padding.right).isActive = true }
        
        if size.width != 0 { widthAnchor.constraint(equalToConstant: size.width).isActive = true }
        if size.height != 0 { heightAnchor.constraint(equalToConstant: size.height).isActive = true }
    }
    
    func makeCenter(in view: UIView, xAnchor: Bool = true, yAnchor: Bool = true) {
        translatesAutoresizingMaskIntoConstraints = false
        if xAnchor { centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true }
        if yAnchor { centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true }
    }

}
