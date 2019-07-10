## SwiftUI: 苹果的一次天才尝试

时间回到一个月前的 WWDC 19 现场，当苹果宣布推出 SwiftUI 时，所有观众为其优雅的语法、 强大的实时预览 `preview`特性而欢呼雀跃，在发布之后几天，各路人马推入巨大的热情，研究 SwiftUI DSL 语言设计、Swift5.1 的新特性、 Combine 库的使用方法，产出了很多的文章。熟悉 Swift 语言的会从 Swift 演进的角度对新特性的来由、场景用法等深度解析；熟稔动画的作者，则用 SwiftUI 用极简的代码玩出酷炫的效果；以前玩 reactive-cocoa 类型开发模式的大佬，则对 Combine 库做了深入的探讨。

作者对 Swift 语言是新手、水平有限，这篇文章不会深入的讨论 Swift 语法特性和 Combine 的使用及实现原理。而是分享在这几星期期间，一边学习其他人的文章，一遍使用 SwiftUI 构建网易严选的 iPad 版本 —— YanxuanHD（源码见参考链接）过程中思考和感悟。从最初的惊喜到迷茫、再到困惑直到若有所得，拙作在这里抛砖引玉。

对于分享的方法，我有个小小的执念，我在学习新语言的时候，会觉得国外的一些人写的文章和书籍，很简单易懂、看完也容易记住；而我们国人写书文章很少有这种感觉。我总结了下原因；

> 那些的外国人设计实现的程序语言和框架，他们对程序语言和框架的了解，更丰富和立体。

我们接触的这些语言框架时候已经是个完整体，面对 1K+ 的 API，十几个模块，我们读文档的时候，他们就像是已经组装好的钟表，了解它就像是在拆钟表，直到你拆解完毕，并尝试多次组装他们，你才有知道如何分而治之，先做小模块、后组装成整体，以及各个模块的组装顺序如何协调才是最优的；但是如果是个钟表设计者，他不仅仅知道如何正确组织组装，而且知道为什么要这样做，这样做有什么好处，那样做有什么坏处，如果你知道这些 API 文档和代码里没有的额外信息，你自然会对 API 设计有深入的理解——甚至按照设计思想的理解，对 API 内部实现或者未来的发展有自己的推断，而且大部分是对的。

举个例子，读 `The Swift Programming Language` 第 5 版，你得到是按照基础、字符、控制流、下标、集合这样零散的概念，是个二维的信息，需要靠自己理解来串联，函数、闭包、异常处理他们的联系。如果加上 Swift 里闭包的设计的参考原型，为什么有逃逸闭包和非逃逸闭包的区分等背景知识，曾经有的多种不同方案之间的权衡—— 即语言的演进时间维度，形成立体的集合。多了第三个维度，原来二维的关系之间多了几层关系，对梳理和理解整个语言大有裨益。

所以这里，我尝试从一个全新的角度——以 SwiftUI 设计者的视角来解释 SwiftUI 目前的现状，从原因来解释 SwiftUI 中一些特有的设计和思想。因为 SwiftUI 未开源和本人水平有限，真心希望读者能够指出这份解读存在的谬误。

下面行文里，假设我叫 Taylor Swift 是 SwiftUI 的负责人；
## 1. SwiftUI 设计的动机和目标
SwiftUI 的愿景是降低开发 iOS 门槛，吸引更多开发者、丰富 iOS 的业态。为了达到这个目的，苹果一直在尝试*所见即所得的理念*，从早期 xib 到 stroyboard。这么多年了，这几项技术发展不尽如人意，大部分限于处于教程展示、demo 制作的场景，并没有在生产环境中流行起来，但苹果在一直在动这方面的心思。

随着整个软件开发领域的演进，近年来涌现的 `React`，`Vue`，`Flutter`技术，逐渐证明了一个事实；
> 在 UI 开发领域，描述性语言是最佳方式

我们也注意到这个趋势。苹果对可视化界面编写很早就开始布局，但是当时受传统所见即所得开发模式的影响，如 `Dreamweaver` 把描述界面的语言 html，隐藏在拖拽的界面后面，苹果把“所见即所得用”实现的方式是把 xml 文件隐藏在后面，这种封装在 autolayout 和 size class 多种因素下，变得性能又差，开发效率也低，成为一个鸡肋的功能。

但前端开发方式演进中，Facebook 提供了一个天才的设计—— React.js。其中，jsx 描述语言负责绘制界面，使用 setState 来更新界面 - 数据驱动，这种方式越来越被证明是未来的方向。所以大可去掉 storyboard 这一层封装，直接把描述语言 xml 暴露给开发，去掉 storyboard 这层中间层，反而更直观。在前端开发领域，直接对 html 和 jsx 编程，然后数据双向绑定实现界面刷新和更改，开发人员的转变并没那么难。React、和 Vue  已经完成对前端开发人员基本的开发模式教育，并不是障碍。

当直接暴露 xml 不是好选择，多了个编程语言不说，历史经验证明性能也是瓶颈。
这催生了 SwiftUI 全新的 UI framework 的诞生，在开发 SwiftUI 伊始，SwiftUI 团队就确认了基本的原则。
1. **用原生语言的编写描述性界面**
2. **数据驱动，A Single Source Of Truth**

确定好目标，接下来思考，如何在 Swift 中实现（objc 不在考虑范围）。不同团队对上面两种目标的实现有不同的方式，而SwiftUI 将是充满各种天才的设计，在苹果生态中界面开发的 game changer，我们希望苹果的产品服务给顾客优雅时尚等高品质体验的同时，开发者面对的 SwiftUI 也同样拥有优雅时尚的质感。

面对 Tim  Cook 先生给我的任务，我需要解决的是不是能不能实现目标，而是如何用 apple-style 来实现。
### a. **界面描述语言编写页面**
凡是组织交给我的任务，我的方法论中有两个很基本的原则；
1. 我们擅长什么？也就是我们有哪些经验积累，旧的还能拿过来使用，DRY
2. 别人是怎么做到？他们的优缺点？如何用 apple-style 来实现

第一步，**确定描述语言的语法， DSL**
先抛弃自家已经折腾了很久的 xml 语言，再筛选下竞品；
- **HTML**，界面描述能力最好，和实际节点真·一一对应（::before 除外），但是缺乏编程能力
- **Flutter**，具有很强的编程能力，但使用代码函数调用、入参、形参、代码缩进来模拟界面的层级结构的方式，不够优雅，层次不精确，而且函数调用里的 `,`、`{}`的符号的存在，导致布局代码观感很差，神似型不似，这点很致命。加上不区分 UI 结构和 UI 属性，以及一套代码到处跑的理念和我们苹果承认设备差异性是相左的。
- **JSP、jQote、php**，这些模板技术既有编程语言，又可以输出 UI 模板，但是太灵活，不可控，原始，不利于做封装和优化。
- **JSX、Pug、Vue**，Pug 脱胎自 html，拥有极其简洁的界面描述语法，符合 apple-style；JSX、Vue 的编程能力和界面描述能力平衡的很好，但是他们需要对模板编译然后再用 JS 渲染。

>结论：Pug 式简洁的语法 + 受限的编程能力。最重要，不能引入编译过程。

也就是说他必须是 100 % 的 Swift 源码—— 不需要引入新的布局语言，而是用 Swift 语言自身来实现界面描述语法，这才是真正的挑战。

第二步，**Swift 布局的 DSL**
经过上一步的分解，我们的任务变成了 —— 用现有的 Swift 包一层语法糖。

从 Flutter 里，我们看到一种可能性 —— 函数调用的嵌套，可以模拟界面的层级。但是不足之处：

1. 布局元素夹杂了`mainAxisAlignment `、`decoration `等属性元素
2. 冗余的表示层级的元素`children` 形参。
3. 同时函数调用的痕迹也很明显，充斥大量的 `new`、 `return`、 `()`、 `,` 、 `;` 号等。

其中，1 比较好处理，这是设计理念的区别，而去掉 `children`，以及后面的用来分隔子元素的`,` 就不容易处理了。用 Swift 的已有语法，我们可以写出这样的语法糖；
```swift
func VStack(children: () -> (_ a1, _ a2, _ a3) {
  return (a1, a2, a3)
}
// 调用方式
VStack {(
    Text("a1"),
    Text("a1"),
    Text("a1")
)}
```
上面的子元素组织方式,已经是能够简化的极限。在 Swift 早期被引入的特性在 SwiftUI 里得到发扬光大：用 `Trailing Closures` 省略了函数调用的关键标记`()`, 同时也省略了 `return`、`；`号，还有一早就被抛弃的 `new` 等关键字;
下面我们和 Flutter、 HTML 做个对比。
```java
// Flutter
Stack(
        children: <Widget>[
                 Text("a1"),
                 Text("a2"),
                 Text("a3"),
         ],
)
```
```html
// html
<div>
  <label>a1</label>
  <label>a2</label>
  <label>a3</label>
</div>
```
看起来不赖，比 Flutter 明晰，甚至比 HTML 也简洁，省略了尾标签关闭，也省略了 xml 里标志性的“<>”符号。唯一的问题是表示 tuple 的 `()` 和分隔符 `,`，这两个语法里必须存在内容，可以去掉吗？

现有 Swift 里是不行的，但新 Swift 版本里不一定哦，解决方式想必大家都知道了——`@__ViewBuilder`。我们自己改 Swift 的语法，让省略上述两个符号的源码也是合法的 Swift 代码。【详细原理解读可参阅其它文章】。

第三步，**Swift 布局的 DSL的编程能力**
确定支持有限个控制语法，这个容易，只要配合组件系统，能够实现基本的控制就可以了。
1. 分支语句 `if true {} else {} `
2. 循环语句 `ForEach`
既然 SwiftUI 是合法的 Swift 代码，那么原生的插值语法和参数传递，就可实现对界面的数据插入等特性（界面如何响应操作和数据是下一部分的问题）。

完整的的界面描述代码是这样的
```swift
Stack {
      Text("Avocado Toast")
      Spacer()
      Image("20x20_avocado")
}
```
和 React 的 `render() ` 函数返回 `jsx` 对象， Flutter 的 `build()` 返回`Widget`对象大同小异。
当遇到去给 `Text("Avocado Toast")`设置字体时，三个框架走出了不同的道路。

* 考察 React 的方式：
> 1. 在 render 函数体内部，可以提取子组件方式配合独立的 `css` 对象来配置样式
```react
var detail = this.props.data;
var bgColor = this.props.backgroundColor || '#ff00ff';
//
var soldoutEle = null;
if (disabled) {
    soldoutEle = (<Image source={require('../images/ico-detail-soldout.png')} style={[styles.soldoutImage]}></Image>);
}
return (
    <View style={[styles.wrapper]}>
        <NameAndRate data={detail} backgroundColor={bgColor} disabled={disabled}/>
        {soldoutEle}
    </View>
);
```
是个很不错的方式，把样式和 html 分类，这是 HTML 特有的优势， Swift 可学不来，提取子组件为一个函数调用的主意很不错。

* 考察 Flutter 的方式
> Flutter  不仅可以提取子组件，还可以提取属性，把属性作为一个变量，在 build 函数体 return 之前做运算。但是他的核心是**仿照 html 的 attribute 理念，在构造界面描述树时，所有属性都作为构造函数的可选参数传入**
```flutter
  Column _buildButtonColumn(BuildContext context, IconData icon, String label) {
    Color color = Theme.of(context).primaryColor;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(top: 8.0),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 12.0,
              fontWeight: FontWeight.w400,
              color: color,
            ),
          ),
        )
      ],
    );
  }
```
嗯哼，again，又是一锅炖方式。按照这种方式编写的代码，缺乏扩展、可读性很差，界面复杂时，必将形成调用链地狱。SwiftUI 取其精华去其糟粕，是不是可以有下面的语法？
```swift
// 错误的写法
Stack {
        let myTost = Text("Avocado Toast")
        myTost.font(.large)
        myTost
        myTost
}
```
上面的写法具有很高的编程能力，但会导致语法校验灾难，使用时，恐怕也会被玩出各种奇葩用法，更不符合界面描述语言的结构。

我这么多年的软件开发经验，直觉告诉我，链式语法是解药，远的不说，近的如 `snapkit` 语法糖写法;
```swift
// 仿照 snapkit
Stack {
    Text("Avocado Toast").makeDecoration {  deco in 
        deco.font(.large).color(.red)
        deco.padding(10).background(.blue)        
    }
}
```
哇，看起来不错，我们用 `deco` 这个代理对象，完成对属性的设置。 但是按照 apple-style， 这里出现`deco` 对象有些多余，为何要把它暴露给开发者呢？而且 `{}` 是个 closure，这意味着开发者可以做任何事情。
回想有个上古大神——我的好朋友 `John Resig` 一手绝学 `chain expression` 用的出神入化，天下无敌手，斩落多少 library 于马下。
```javascript
// jQuery 的链式语法
$('div.test')
  .add('p.quote')
  .addClass('blue')
  .slideDown('slow');
```
真是一个天才的作品，拿来为我所用：
```swift
  var body: some View {
        Text("Avocado Toast")
            .padding(10)
            .background(Color.green)
    }
```
此外，如果你需要初始化 View 时省掉有默认值的参数，这样会让 View 看起来更精简，更像 html 标签描述界面，是否能够实现呢？
同样的，在 Swift 5.1 里容许你这样做。

暂时回到本文作者身份。我无法确定 `ViewModifier` 的设计受 `Reactive-Cocoa`多些还是 `jQuery` 多些，目前我们拿到的 SwiftUI，即有链式调用这种过程化的思想，也有底层用 `Combine` 实现的数据响应式-“onReceive”语法。

第四步，**SwiftUI 的组件系统**

有了布局的 DSL 语法，我们还需要内置的 SwiftUI 组件，支撑快速开发能力。这里有两个原则；
1.  提供最朴素的组件集
2. 提供扩展能力

分开来讲，
**1. 内置的组件**
包括基础的 Text、Button组件、容器类 List、VStack、另外提供辅助组件 Group 等。
选定好基础组件，下一步是确认提供的组件的可定制程度？
经过我们集体研究，有以下原则
**A. SwiftUI 自带 Design System**。Design System 遵循的是基本的  [Human Interface Guidelines - Design ](https://developer.apple.com/design/human-interface-guidelines/)
 的条款。 在一定程度上，你必须遵守这些设计原则，这样产出来的 App UI，自动符合 Human Interface Guidelines - Design 的要求，比如，
- List 必须有 seperator
- 元素之间默认拥有符合苹果美感的间距
- 容器元素布局符合 Guidelines
- 无处不在的留白等

有些属性你甚至没有开放接口可以定制，如 Scrollview 你甚至不能设置 isPageEnabled。**定制参数以初始化参数的形式存在，额外行为通过 view modifier 来实现**。我们认为在 apple-style 里，你只需要关心这些参数就够了，如果有已有的样式行为不能满足，你需要通过适配自定义 UIView 到 SwiftUI 的方式实现。

 **B. 更简化的布局系统**
在 React-Native 身上，我们看到了 css 的一个子集完成可以满足日常的布局需要，复杂如 `float`,在 web 领域甚至都没有在用 float 的本意使用, native  里更不需要。而 iOS 上的  Autolayout 用来解决适配问题的方式，多少有些繁琐，可以进一步简化；
- **flex**
- **position 、offset**
- **盒子模型**，既不是 `content-box ` 也不是 `border-box `，和设置 padding 顺序有关、
- 只有 padding 没有 margin 

上面的设计要素是完备的。布局系统简化带来运行效率和开发效率的双提升，对我们 SwiftUI 的运行时实现也是个很大的简化

**2. SwiftUI 的扩展能力**
我们观察了竞品， React-Native 对 TextInput 的封装。
**通过开放 `self.refs` 属性，开发人员可以获取当前实例；**
```javascript
// react-native 的 ref 回调属性
  render() {
    return <TextInput ref={(c) => this._input = c} />;
  }
  componentDidMount() {
    this._input.focus();
  }
```
总体而言，是个不错的主意，但在 SwiftUI 的封装里不容许暴露这种潜在的危险。我们相信社区的力量，如果你的需求是个普遍需求，相信你能在社区中找到其他人奉献的组件。
基于同样的考虑；
> 自定义组件的标签也不容许包含 SwiftUI 组件作为子元素

考虑到还要支持组件的 `preview` ，要求我们实现一切 View 都可以被单独展示，在 SwiftUI 里所有的 View 都是相同的，都可以被 present 和 push。只是在考虑到和  UIKit 协同时，我们单独在 UIViewRepresentable 的基础上封装了 UIViewControllerRepresentable，记住 **万物皆为 View**（对标 Flutter：一切都是 widget）

除了 UI 组件的扩展性，当一个 View 内部因为异步网络数据或者复杂的事件交互变多时，我们参考了 iOS 里比较流行的 MVVM、VIPER 架构，解决传统的 MVC 框架下 ViewController 过于膨胀的问题 —— 引入`Coordinater` 机制。
>UIViewRepresentable 负责单纯的 UI 数据刷新逻辑， Coordinater 加工数据和内部事件更新数据；并且严格限制在 View 实例里，被 @State 标记的变量只在 `var body: some View {}` 只读属性里被改变，强制 View 和 BindableObject 实例的职责分离，首先是加工数据然后是使用数据渲染，不许混杂。

至此，涉及对 UI 静态部分的 SwiftUI 设计基本成型，接下来是如何处理数据流动

### b. A Single Source Of Truth
数据驱动或者数据双向绑定，是近年来在前端开发领域非常流行的模式，只需要遵循简单的一些规约即可完成 UI 和数据源之间同步的事务，极大的简化了数据态维护的工作。

目前传统的 Swift 里缺少主流的解决数据绑定和 UI 更新的框架，Reactive 理念被宣传了这么多年，也依然没有成为主流方式。是时候，由苹果自己推出官方库了，依靠我们强大的品牌影响力和我们拥有世界上最好的程序员团队，一定会把响应式编程理念带给整个 apple 开发社区生态。

考察下竞品，React 里使用 `setState`和`getInitialState` 来支持属性单向流动，而 Vue 里则对
```javascript
 var vm = new Vue({
  data: data
})
```
里的  `data`（有时候是一个返回 data 的 function）结合 `v-model` 实现了双向绑定。
 React 和 Vue 都很好的实现了数据驱动，不过他们因为需要额外的一个变量 `state`或者 `data`来标识可能会被修改数据，而迫不得已没有区分哪些是潜在可变的数据，哪些是不会变化的数据—— 难道要再引入 `staticState`或者 `staticData`不成？

> 而且从本质上讲，`state` 和 `data` 本身都是冗余的部分，它不是数据，只是为了标识数据集合而引入的管理属性。在 SwiftUI 中，我们能不能优化这个呢？

别忘了，我是 Taylor Swift。在 Swift 5.1 里引入了 `@propertyDelegate @dynamicMemberLookup` 概念，引入了 `@State` 来去掉额外的属性，我们希望开发者引用数据属性，而不是从额外的代理锚点去获取数据，经过我们团队的努力，成果效果不错，而且通过区分静态变量和已变变量，减少 diff 的数据结构数据量的同时，也为重构代码带来了方便。
简单的以定义数据为例，和 React、Vue 做对比
```javascript
// React
var Input = React.createClass({
  getInitialState: function() {
    return {value: 'Hello!'};
  },
  render: function () {
    return (
      <div>
        <p>{this.state.value}</p>
      </div>
    );
  }
});
```
对比 Vue  定义一个名为 button-counter 的新组件
```javascript

Vue.component('button-counter', {
  data: function () {
    return {
      count: 0
    }
  },
  template: '<button v-on:click="count++">You clicked me {{ count }} times.</button>'
})
```
而定义了一个不变的变量和已变变量的 Swift 是这样的；
```swift
struct ProfileView : View {
    var avatar: String = "sidebar-avatar"
    @State var userName: String = "严选用户"
    
    var body: some View {
        VStack {
          NetworkImage(userData: NetworkImageData(self.avatar))
                    .frame(width: 60, height: 60)
                    .clipShape(Circle())
                    .padding(.top, 15)
               
           Text(self.userName)
                    .font(.caption)
                    .color(.white)
        }
    }
}
```
在定义数据源代码的简洁性上，SwiftUI 略胜一筹。另外提供了
@State @Binding @EnvironmentObject @ObjectBinding 一系列的 Combine 支持实现双向绑定、单一数据源、类似 redux 里全局 store 等特性。

编写 Combine 库遵循业界对响应式编程的接口定义规范，提供了如 `reduce\flat`等常见 API，在实现层面也一定程度上，支持了 SwiftUI 在布局时，链式调用的语法。Combine 的链式调用和 SwiftUI 组件里的 ViewModifier  虽然形似但内核是不一样的，Combine 本身就是数据流处理的模式；而 SwiftUI 里链式调用只是为了形式上返回单一对象。

### c. SwiftUI 的开发范式
解答了最关键的两个问题，回到日常开发工作，项目业务类型和项目体量形态差异会导致用相同的 API，产出迥异的项目代码结构和分层，有必要给出我们推荐的开发规范。
在这里，我们提出一些小小的建议，让普通的开发者能够快速上手 SwiftUI，使用 SwiftUI 的设计思路来开发 App。

第一，**数据驱动**，这不仅意味着渲染、修改页面需要使用数据驱动，在组织数据在业务流动时，以及用户和业务数据交互时，也需要使用数据驱动的模型来组织代码逻辑

第二，**组件化**，这是定义 SwiftUI 时原则。我们鼓励将界面分解为不同的 SwiftUI 组件，在然后使用 Combine 等手段将其组合在一起。并且每个小组件维护自身的数据源、数据状态，跨组件联动可使用全局的@ State 来联结。
高度内聚组件，不仅方便管理和复用，在开发阶段，可以很方便的 Preview 和 Live-Preview。同样得益于组件的自治，整个界面的某个局部进行数据刷新也非常容易，类似 ajax 技术。

第三，**源码组织结构**。为了保持功能的内聚，每个 View 应该和它需要的其他配套源码再相同的文件夹里，如
![功能模块](https://upload-images.jianshu.io/upload_images/277783-2e0a585a1212ffe4.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/620)
其中， `NewArrivalSection` 是独立功能模块视图，`NewArrivalProductShow` 是子视图，`NewArrivalModel` 是数据模型，`NewArrivalData` 则是负责获取model 数据、处理、更新的管理对象。

以上为 SwiftUI 诞生过程的简述，退出 Taylor Swift 人设。

*关于 Preview 原理*（以下为作者猜测）
> 基于旧时 @IBInspectable 支持的经验，当运行一次之后，不再接收动态代码替换指令，而是在生成的静态界面上，有一个管理类，用 didSet\willSet\keyPath 监听了 Swift 属性，来动态修改界面；
Live-Preview 则使用模拟器运行 App，将模拟器运行的界面实时映射到 Canvas上面，也将 Canvas 的触控事件传会模拟器。

### d. 对 SwiftUI 的评价
SwiftUI 现在还在 beta，作者对 SwiftUI 创造性的使用合法的 Swift 语言创建了一个非常接近 HTML 描述语言的 DSL 惊叹不已，近似于 iPhone 用不怎么出色的硬件创造出比其他 Android 硬件狂魔堆砌的性能和体验都高的多的感叹。和 Flutter 相比，同样是用编程语言实现的界面描述 DSL，SwiftUI 的品质和 Apple 产品给用户的体验一样—— 简洁、优雅，背后又蕴藏玄机。
这后面也依赖苹果对 Swift 的控制，所以在 Swift 语言层面对 SwiftUI 这个 UI 库，进行了极大的支持，寄希望于 SwiftUI 能带动 App 开发方式的演进。

性能问题，beta 阶段可以忽略此问题，目前发现最大问题： cell 复用很糟糕。
![YanxuanHD 首页](https://upload-images.jianshu.io/upload_images/277783-5546eb33948b6de0.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/620)
右侧是由很多带图的 Cell 组成的 list，在没引入图片缓存前，上下滑动时，被隐藏、可见的 cell 会触发新建和销毁，导致图片频繁下载，界面非常卡顿。

但这些都不是大问题，后期在 SwiftUI 迭代和社区最佳实践出现后，会有改观。但是我这里要说的是 SwiftUI 的支持库 Combine，这个响应式库，可能是阻碍 SwiftUI 被广泛应用的障碍。

**1. Combine 所提倡的响应式编程不适合处理 UI、交互逻辑**
目前来看，在 Combine 的支持下，SwiftUI 体现出惊人的简洁和优雅，但是 Combine 的使用方式是**基于数据流**，而 UI 或者交互的流程大部分是**基于树形分支**的，他们天生是不 match
对于 iOS 开发者来说（指我），我需要将需求转化为树形流程图，如果用 Combine，我需要把树形流程逻辑，转化为数据流的逻辑。（私下认为，树形流程并没有 100 能转化为数据流模式的能力）。
Combine 局限于对数据处理领域是比较好的选择。
**2. Combine 对开发人员的要求**
在一个团队里假设对数据流 <-> 树形逻辑 之前转化的能力从低到高分为 3 等（30%：60%： 10 %），像作者这种 30% 的人在看 70% 的人写的数据流的代码时，企图将其还原为真实的用户交互的树形流程，因为能力有限我丢失了一些逻辑（在 debug 或者 CodeReview 时都会发生丢失的情况），所以 bug 产生了。另外数据流的可玩性太高了，导致我在写 YanxuanHD 时，每次我对 Dataflow in SwiftUI 理解多一层的时候，我都会代码大改，从子组件可能要改到最顶级父组件。
总之，Combine 这种响应式不适合在前端使用，也不适合团队协作。
>  Combine 的引入，为了 UI 的可视化，牺牲了代码逻辑的可视化，现代版的 goto 语句。

总的来说，SwiftUI 的初次亮相十足惊艳，各种 tutorial、 introduce 、 Example 的文章代码也继续验证 SwiftUI 的强大。就像在 T 型台上光彩照人，穿着 SwiftUI 这身 blink blink 华服的模特，是否能够下了台之后，追的了公交、拎的了菜篮子，还未可知。 SwiftUI 终究还是要回到实际各式各样的业务场景中，免不了弄脏裙子、卸下手帕，最后变得和 T 台上的人判若两人。

但总是开了个好头，就像小马过河一样，不去尝试，怎知 iOS 里 SwiftUI 是否会流行。希望能够走出 storyboard 的老路，不要只停留在 demo 原型制作的阶段。对此我表示谨慎的乐观。

### 参考
1. [SwiftUI Tutorials | Apple Developer Documentation](https://developer.apple.com/tutorials/swiftui)
1. [The Swift 5.1 features that power SwiftUI’s API](https://www.swiftbysundell.com/posts/the-swift-51-features-that-power-swiftuis-api?rq=DSL)
1.  [About-SwiftUI](https://github.com/Juanpe/About-SwiftUI)
1. [**YanxuanHD**](https://github.com/hite/YanxuanHD/blob/master/README.md)
1. [SwiftUI 的一些初步探索 (二)](https://xiaozhuanlan.com/topic/5346879201)
1. [系列文章深度解读|SwiftUI 背后那些事儿 ](https://mp.weixin.qq.com/s/ciiauLB__o-cXXfKn7lL1Q)
1. [从 SwiftUI 谈声明式 UI 与类型系统](https://zhuanlan.zhihu.com/p/68275232)
1. [Building DSLs in Swift](https://www.swiftbysundell.com/posts/building-dsls-in-swift?rq=DSL)
1. [Fucking SwiftUI - SwiftUI Cheat Sheet](https://fuckingswiftui.com/)
1. [SwiftUI 和 Swift 5.1 新特性(2) 属性代理Property Delegates](https://mp.weixin.qq.com/s/Y1RXhZmcYNRwtjFOOfC5gg)
1. [SwiftUI 数据流](https://xiaozhuanlan.com/topic/0528764139)
1. [SwiftUI 自定义视图](https://xiaozhuanlan.com/topic/9586134027)
1. [React.js](http://www.ruanyifeng.com/blog/2015/03/react.html)
1. [Vue.js](https://cn.vuejs.org)
