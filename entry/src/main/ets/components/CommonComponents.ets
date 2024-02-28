import router from '@ohos.router'
@Component
export struct Header {
  private title: ResourceStr

  @State params: any = router.getParams()

  build() {
    Row() {
      Image($r('app.media.return_icon'))
        .width(30)
        .onClick(() => {
          router.back()
        })
      if (this.params?.id) {
        Text(this.params.id + '.' + this.title)
          .fontSize(30)
          .fontWeight(FontWeight.Bold)
      }
      Blank()
      Image($r('app.media.refresh_icon'))
        .width(30)
    }
    .width('100%')
    .height(30)
  }
}