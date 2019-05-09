//
//  HjzItemsView.swift
//  SwiftyItemsView
//
//  Created by 黄江桂 on 2018/7/11.
//  Copyright © 2018年 黄江桂. All rights reserved.
//

import UIKit

public class HjzItemsView: UIView {
    /// 集合视图
    private lazy var collecView: UICollectionView = {
        let collecView = UICollectionView(frame: .zero, collectionViewLayout: HjzItemLayout())
        collecView.bounces = false
        collecView.dataSource = self
        collecView.delegate = self
        collecView.isPagingEnabled = true
        collecView.backgroundColor = .clear
        collecView.showsHorizontalScrollIndicator = false
        collecView.register(HjzItemCell.self, forCellWithReuseIdentifier: "Cell")
        return collecView
    }()
    
    /// 指示器视图
    private let indexView = HjzItemIndexView(frame: .zero)
    
    /// 数据源
    public var data = [HjzItemModel]() {
        didSet {
            if oldValue != data {
                collecView.reloadData()
                indexView.isHidden = data.isEmpty
            }
        }
    }
    
    /// 集合视图的布局
    @objc dynamic public var flowLayout: HjzItemLayout {
        return collecView.collectionViewLayout as! HjzItemLayout
    }
    /// 字号
    @objc dynamic public var fontSize: CGFloat = 14
    /// 图片与文字的间隔
    @objc dynamic public var spacing: CGFloat = 5
    /// 当前指引颜色
    @objc dynamic public var currentPageColor = UIColor.orange {
        didSet { indexView.currentPageColor =  currentPageColor }
    }
    
    /// 点击闭包
    public var tapClosure: ((_ index: Int, _ model: HjzItemModel) -> Void)?
    
    // MARK: - 生命周期
    override public func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }

    override public init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override public func layoutSubviews() {
        super.layoutSubviews()
        collecView.frame = bounds
        indexView.pageNum = Int(flowLayout.collectionViewContentSize.width / frame.width)
    }
}

// MARK: - 初始化子视图
private extension HjzItemsView {
    func setupUI() {
        backgroundColor = .white
        addSubview(collecView)
        addSubview(indexView)
    }
}

// MARK: - UICollectionViewDataSource / UICollectionViewDelegate
extension HjzItemsView: UICollectionViewDataSource, UICollectionViewDelegate {
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! HjzItemCell
        cell.tag = indexPath.row
        var model = data[indexPath.item]
        model.spacing = spacing
        model.fontSize = fontSize
        cell.tapClosure = tapClosure
        cell.model = model
        return cell
    }
    
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let num = (collecView.contentOffset.x / frame.width) + 0.5
        indexView.scroll(index: Int(num))
    }
}
