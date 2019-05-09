# HjzItemsView

`UICollectionView` 的水平分页布局控件。

## 安装

### Carthage

```shell
github "hjzCy/HjzItemsView"
```

## 使用

```swift
let itemsView = HjzItemsView(frame: CGRect(x: 0, y: 100, width: view.frame.width, height: view.frame.width / 2))
// 行数
itemsView.flowLayout.row = 2
// 列数
itemsView.flowLayout.column = 5
// 图片和文字间隔
itemsView.spacing = 5
// 文字字号
itemsView.fontSize = 14
// 当前分页的指示器颜色
itemsView.currentPageColor = .purple
// 点击回调
itemsView.tapClosure = { (index, model) in
    print("index: \(model)")
}
// 数据是 [HjzItemModel] 数组.
// image: 图片名称
// name: 标题
// 由于这里的图片名和标题是一样的，所以采用快速写法。
itemsView.data = ["惠整形", "定项目", "找医院", "选医生", "查价格",
                  "挑材料", "看体验", "秀口碑", "大咖评", "定制",
                  "新闻", "会议"].map {
                    HjzItemModel(image: $0, name: $0)
}
```

