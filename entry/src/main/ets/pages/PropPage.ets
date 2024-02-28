@Observed
class Task {
  // id，static类共享，不断变化
  static id: number = 1;
  // 任务名称
  name: string = `任务${Task.id++}`
  // 完成状态
  finished: boolean = false
}

// 统一的卡片样式
@Styles function card() {
  .width('95%')
  .padding(20)
  .backgroundColor(Color.White)
  .borderRadius(15)
  .shadow({ radius: 6, color: '#1F000000', offsetX: 2, offsetY: 4 })
}

// 任务完成样式
@Extend(Text) function finishedTask() {
  .decoration({ type: TextDecorationType.LineThrough })
  .fontColor('#ff7e807e')
}

@Entry
@Component
struct PropPage {
  // 总任务数量
  @State totalTask: number = 0
  // 已完成任务数量
  @State finishTask: number = 0
  // 任务数组
  @State tasks: Task[] = []

  build() {
    Column({ space: 10 }) {
      // 1、任务进度卡片
      TaskStatistics({ totalTask: this.totalTask, finishTask: this.finishTask })
      // 2、任务列表
      TaskList({ totalTask: $totalTask, finishTask: $finishTask })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F1F2F3')
  }
}

@Component
struct TaskStatistics {
  // 总任务数量
  @Prop totalTask: number
  // 已完成任务数量
  @Prop finishTask: number

  build() {
    Row() {
      Text('任务进度：')
        .fontSize(30)
        .fontWeight(FontWeight.Bold)
      Stack() {
        Progress({
          value: this.finishTask,
          total: this.totalTask,
          type: ProgressType.Ring
        })
          .width(100)
        Row() {
          Text(this.finishTask.toString())
            .fontSize(24)
            .fontColor('#36d')
          Text(' / ' + this.totalTask.toString())
            .fontSize(24)
        }
      }
    }
    .card()
    .margin({ top: 20, bottom: 10 })
    .justifyContent(FlexAlign.SpaceEvenly)
  }
}

@Component
struct TaskList {
  // 总任务数量
  @Link totalTask: number
  // 已完成任务数量
  @Link finishTask: number
  // 任务数组
  @State tasks: Task[] = []

  handleTaskChange() {
    // 1、更新任务总数量
    this.totalTask = this.tasks.length
    // 2、更新已完成任务数量
    this.finishTask = this.tasks.filter(item => item.finished).length
  }

  build() {
    Column() {
      // 2、新增任务按钮
      Button('新增任务')
        .width(200)
        .onClick(() => {
          // 1、新增任务数据
          this.tasks.push(new Task())
          console.log(this.tasks.length.toString())
          // 2、更新任务总数量
          this.handleTaskChange()
        })
        .margin({ bottom: 20 })

      // 3、任务列表
      List({ space: 10 }) {
        ForEach(this.tasks, (item: Task, index) => {
          ListItem() {
            TaskItem({ item: item, onTaskChange: this.handleTaskChange.bind(this) })
          }
          .swipeAction({ end: this.DeleteBtn(index) })
        })
      }
      .width('100%')
      .layoutWeight(1) // 剩余的高度都给我
      .alignListItem(ListItemAlign.Center)
    }
  }

  @Builder DeleteBtn(index: number) {
    Button() {
      Image($r('app.media.del_icon'))
        .fillColor(Color.White)
        .width(20)
    }
    .width(40)
    .height(40)
    .type(ButtonType.Circle)
    .backgroundColor(Color.Red)
    .margin(5)
    .onClick(() => {
      this.tasks.splice(index, 1)
      // 更新任务总数量、更新已完成任务数量
      this.handleTaskChange()
    })
  }
}

@Component
struct TaskItem {
  @ObjectLink item: Task
  onTaskChange: () => void

  build() {
    Row() {
      if (this.item.finished) {
        Text(this.item.name)
          .fontSize(20)
          .finishedTask()
      } else {
        Text(this.item.name)
          .fontSize(20)
      }
      Checkbox()
        .select(this.item.finished)
        .onChange((value) => {
          // 1、更新当前任务状态
          this.item.finished = value
          // 2、更新已完成任务数量
          this.onTaskChange()
        })
    }
    .card()
    .justifyContent(FlexAlign.SpaceBetween)
  }
}