class Person {
  name: string
  age: number
  friend: Person

  constructor(name: string, age: number, friend?: Person) {
    this.name = name
    this.age = age
    this.friend = friend
  }
}

@Entry
@Component
struct StatePage {
  @State name: string = 'jack'
  @State age: number = 20
  @State alan: Person = new Person('Alan', 18, new Person('David', 23))
  @State friends: Person[] = [
    new Person('lusi', 25),
    new Person('sari', 24)
  ]

  build() {
    Column() {
      // 演示属性修改导致的视图更新
      Text(`${this.name} : ${this.age}`)
        .fontColor(Color.Green)
        .fontSize(50)
        .fontWeight(FontWeight.Bold)
        .onClick(e => {
          this.age++
        })

      // 演示对象属性修改导致的视图更新
      Text(`${this.alan.name} : ${this.alan.age}`)
        .fontColor(Color.Green)
        .fontSize(50)
        .fontWeight(FontWeight.Bold)
        .onClick(e => {
          this.alan.age++
        })

      // 演示对象嵌套对象的属性修改无法出发视图更新
      Text(`${this.alan.friend.name} : ${this.alan.friend.age}`)
        .fontColor(Color.Green)
        .fontSize(50)
        .fontWeight(FontWeight.Bold)
        .onClick(e => {
          // 这里friend.age的值已经变了，但是不会触发视图更新
          this.alan.friend.age++
        })

      // 演示数组对象修改触发视图更新
      ForEach(this.friends, (item, index) => {
        Text(`${item.name} : ${item.age}`)
          .fontColor(Color.Red)
          .fontSize(50)
          .fontWeight(FontWeight.Bold)
          .onClick(e => {
            this.friends.push(new Person("路西",1))
          })
      })

      // 演示数组对象属性修改无法触发视图更新
      ForEach(this.friends, (item, index) => {
        Text(`${item.name} : ${item.age}`)
          .fontColor(Color.Red)
          .fontSize(50)
          .fontWeight(FontWeight.Bold)
          .onClick(e => {
            item.age++
          })
      })

    }
    .width('100%')
    .height('100%')
    .justifyContent(FlexAlign.Center)
  }
}