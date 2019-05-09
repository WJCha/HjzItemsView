//
//  HjzItemIndexView.swift
//  SwiftyItemsView
//
//  Created by apple on 2018/11/1.
//  Copyright © 2018 黄江桂. All rights reserved.
//

import UIKit

final class HjzItemIndexView: UIView {

    var currentPageColor = UIColor.orange
    
    var pageNum: Int = 0 {
        willSet {
            subviews.forEach { $0.removeFromSuperview() }
            let width = 20
            let spacing = 3
            (0..<newValue).forEach { (index) in
                let view = UIView(frame: CGRect(x: index * (width + spacing), y: 0, width: width, height: 3))
                view.backgroundColor = index == 0 ? currentPageColor : UIColor(white: 0, alpha: 0.3)
                addSubview(view)
            }
            if let superview = superview, let maxX = subviews.last?.frame.maxX {
                frame = CGRect(x: (superview.frame.width - maxX) / 2, y: superview.frame.height - 11, width: maxX, height: 3)
            }
        }
    }
    
    func scroll(index: Int) {
        for (i, view) in subviews.enumerated() where index <= pageNum {
            view.backgroundColor = i == index ? currentPageColor : UIColor(white: 0, alpha: 0.3)
        }
    }
}
