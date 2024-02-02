@Component
export struct Header {
  private title: ResourceStr

  build() {
    Row() {
      Image($r('app.media.return_icon'))
        .width(30)
      Text(this.title)
        .fontSize(30)
        .fontWeight(FontWeight.Bold)
      Blank()
      Image($r('app.media.refresh_icon'))
        .width(30)
    }
    .width('100%')
    .height(30)
  }
}