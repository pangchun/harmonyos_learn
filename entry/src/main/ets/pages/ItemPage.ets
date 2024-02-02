import { Header } from '../components/CommonComponents'

class Item {
  name: string
  image: ResourceStr
  price: number
  discount: number

  constructor(name: string, image: ResourceStr, price: number, discount: number = 0) {
    this.name = name
    this.image = image
    this.price = price
    this.discount = discount
  }
}


@Entry
@Component
struct ItemPage {
  // 商品数组
  private items: Array<Item> = [
    new Item('华为mate60', $r('app.media.icon'), 6999, 500),
    new Item('小米ultra', $r('app.media.icon'), 7999),
    new Item('iphone12', $r('app.media.icon'), 8999),
    new Item('华为P90', $r('app.media.icon'), 9999),
    new Item('华为P1000', $r('app.media.icon'), 99999),
    new Item('华为P1000', $r('app.media.icon'), 99999),
    new Item('华为P1000', $r('app.media.icon'), 99999),
    new Item('华为P1000', $r('app.media.icon'), 99999),
  ]

  build() {
    Column({ space: 8 }) {
      Header({ title: '商品列表' })
        .margin({ bottom: 20 })
      List({ space: 8 }) {
        // for循环
        ForEach(
          this.items,
          (item: Item) => {
            ListItem() {
              ItemCard(item)
            }
          }
        )
      }
      .width('100%')
      .height('100%')
      .layoutWeight(1)
    }
    .fillScreen()
  }
}

// 商品卡片
@Builder
function ItemCard(item: Item) {
  Row({ space: 10 }) {
    Image(item.image)
      .width(80)
      .interpolation(ImageInterpolation.High)
    Column({ space: 4 }) {
      if (item.discount) {
        Text(item.name)
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
        Text('原价: ￥' + item.price)
          .fontSize(18)
          .fontColor('#ff000000')
          .decoration({ type: TextDecorationType.LineThrough })
        Text('折扣价: ￥' + (item.price - item.discount))
          .priceText()
        Text('补贴: ￥' + item.discount)
          .priceText()
      } else {
        Text(item.name)
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
        Text('￥' + item.price)
          .priceText()
      }
    }
    .alignItems(HorizontalAlign.Start)
  }
  .width('100%')
  .backgroundColor('#FFF')
  .borderRadius(20)
  .height(120)
  .padding(10)
  .justifyContent(FlexAlign.Start)
}

// 全局公共样式
@Styles
function fillScreen() {
  .width('100%')
  .height('100%')
  .backgroundColor('#cccccc')
  .padding(20)
}

@Extend(Text)
function priceText() {
  .fontSize(18)
  .fontColor('#F36')
}
