//
//  HjzItemModel.swift
//  SwiftyItemsView
//
//  Created by 黄江桂 on 2018/9/13.
//  Copyright © 2018年 海南美哪里信息技术有限公司. All rights reserved.
//

import UIKit

public struct HjzItemModel: Equatable {
    public var name: String
    public var image: String
    var fontSize: CGFloat = 14
    var spacing: CGFloat = 5
    init() {
        self.name = ""
        self.image = ""
    }
    public init(image: String, name: String) {
        self.image = image
        self.name = name
    }
}
