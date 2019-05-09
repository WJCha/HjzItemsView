//
//  HjzItemCell.swift
//  SwiftyItemsView
//
//  Created by 黄江桂 on 2018/7/21.
//  Copyright © 2018年 黄江桂. All rights reserved.
//

import UIKit

final class HjzItemCell: UICollectionViewCell {
    /// 容器视图，包含图片和文字
    lazy var containerView: UIView = {
        let view = UIView(frame: .zero)
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(itemClick)))
        return view
    }()
    /// 图片
    private let pic = UIImageView(frame: .zero)
    /// 标题
    private let titleLabel = UILabel(frame: .zero)
    /// 点击闭包
    var tapClosure: ((_ index: Int, _ model: HjzItemModel) -> Void)?
    
    // MARK: - 生命周期
    override init(frame: CGRect) {
        super.init(frame: frame)
        titleLabel.textAlignment = .center
        containerView.addSubview(pic)
        containerView.addSubview(titleLabel)
        contentView.addSubview(containerView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // MARK: - 赋值模型
    var model = HjzItemModel() {
        didSet {
            pic.image = UIImage(named: model.image)
            titleLabel.text = model.name
            titleLabel.font = .systemFont(ofSize: model.fontSize)
        }
    }
    
    // MARK: - 项目点击
    @objc private func itemClick() {
        tapClosure?(tag, model)
    }
    
    // MARK: - 布局子视图
    override func layoutSubviews() {
        super.layoutSubviews()
        let spacing = model.spacing
        let fontSize = model.fontSize
        let imageSize = pic.image?.size ?? .zero
        let picOrigin = CGPoint(x: (frame.width - imageSize.width) / 2,
                                y: (frame.height - imageSize.height - spacing - fontSize - 3) / 2)
        let titleSize = CGSize(width: titleLabel.sizeThatFits(.zero).width, height: fontSize + 3)
        let titleOrigin = CGPoint(x: (frame.width - titleSize.width) / 2, y: pic.frame.maxY + spacing)
        
        containerView.frame = CGRect(x: min(picOrigin.x, titleOrigin.x),
                                     y: picOrigin.y,
                                     width: max(imageSize.width, titleSize.width),
                                     height: imageSize.height + spacing + fontSize + 3)
        pic.frame = CGRect(x: (containerView.frame.width - imageSize.width) / 2, y: 0, width: imageSize.width, height: imageSize.height)
        titleLabel.frame = CGRect(x: 0, y: pic.frame.maxY + spacing, width: containerView.frame.width, height: titleSize.height)
    }
}
