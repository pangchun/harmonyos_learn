@Entry
@Component
struct Index {
  @State message: string = 'Hello World'
  @State count: number = 0
  @State imgWidth: number = 250;

  build() {
    Column() {

      Row() {
        // 本地图片文件
        Image($r('app.media.app_icon'))
          .width(this.imgWidth)
          .interpolation(ImageInterpolation.High)
      }
      .width('100%')
      .height(400)
      .justifyContent(FlexAlign.Center)

      Row() {
        // 文本组件
        Text($r("app.string.width_label"))
          .fontWeight(FontWeight.Bold)

        // 文本输入框
        TextInput({ placeholder: '请输入图片宽度', text: this.imgWidth.toFixed(0) })
          .width(150)
          .backgroundColor('#fff')
          .type(InputType.Number)
          .onChange((value) => {
            this.imgWidth = parseInt(value);
          })
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
      .padding({ left: 14, right: 14 })

      Divider().width('91%')

      Row() {
        // 缩小按钮
        Button('缩小')
          .width(80)
          .fontSize(20)
          .onClick(event => {
            if (this.imgWidth >= 10) {
              this.imgWidth -= 10;
            }
          })

        // 放大按钮
        Button('放大')
          .width(80)
          .fontSize(20)
          .onClick(event => {
            if (this.imgWidth <= 300) {
              this.imgWidth += 10;
            }
          })
      }
      .width('100%')
      .margin({top: 30, bottom: 30})
      .justifyContent(FlexAlign.SpaceEvenly)


      // 滑动条
      Slider({
        min: 100,
        max: 300,
        value: this.imgWidth,
        step: 10
      })
        .width('95%')
        .blockColor('#36d')
        .trackColor('red')
        .trackThickness(4)
        .showTips(true)
        .onChange((value) => {
          this.imgWidth = value
        })
    }
    .width('100%')
    .height('100%')
  }
}