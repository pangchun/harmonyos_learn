import router from '@ohos.router'

class RouteInfo {
  url: string
  name: string

  constructor(url: string, name: string) {
    this.url = url
    this.name = name
  }
}

@Entry
@Component
struct Index {
  @State title: string = '页面列表'
  routes: RouteInfo[] = [
    new RouteInfo('pages/ImagePage', '图片案例'),
    new RouteInfo('pages/PropPage', '任务统计案例'),
    new RouteInfo('pages/ItemPage', '商品列表案例'),
    new RouteInfo('pages/StatePage', 'State装饰器案例'),
  ]

  build() {
    Column() {
      Text(this.title)
        .fontSize(50)
        .fontWeight(FontWeight.Bold)
        .margin({ top: 20, bottom: 10 })

      List({ space: 10 }) {
        ForEach(this.routes, (item: RouteInfo, index: number) => {
          ListItem() {
            Row() {
              Text((index + 1).toString() + '.')
                .fontSize(20)
                .fontColor(Color.White)
              Text(item.name)
                .fontSize(20)
                .fontColor(Color.White)
            }
            .card()
            .justifyContent(FlexAlign.SpaceBetween)
            .onClick(() => {
              router.pushUrl(
                {
                  url: item.url,
                  params: { id: index + 1 }
                },
                router.RouterMode.Single,
                err => {
                  console.log(`路由失败,errCode: ${err.code} errMsg: ${err.message}`)
                }
              )
            })
          }
        })
      }
      .width('100%')
      .height('100%')
      .layoutWeight(1) // 剩余的高度都给我
      .alignListItem(ListItemAlign.Center)
    }
    .width('100%')
  }
}

@Styles function card() {
  .width('95%')
  .padding(20)
  .backgroundColor('#38f')
  .borderRadius(20)
  .shadow({ radius: 6, color: '#1F000000', offsetX: 2, offsetY: 4 })
}