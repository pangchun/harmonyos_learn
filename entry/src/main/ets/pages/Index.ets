import App from '@system.app'
@Entry
@Component
struct Index {
  @State message: string = 'Hello World'

  @State count: number = 0

  build() {
    Row() {
      Column() {
        Text(this.message)
          .fontSize(50)
          .fontWeight(FontWeight.Bold)
          .onClick((e) => {
            this.count++
          })

        Text(this.count.toString())
          .fontSize(50)
          .fontWeight(FontWeight.Bold)
          .fontColor("#36d")

        // 网络图片
        Image('https://images.pexels.com/photos/19119694/pexels-photo-19119694.jpeg?auto=compress&cs=tinysrgb&w=600&lazy=load')
          .width(250)

        // 本地文件
        Image($r('app.media.app_icon'))
          .width(250)
          .interpolation(ImageInterpolation.High)
      }
      .width('100%')
    }
    .height('100%')
  }
}