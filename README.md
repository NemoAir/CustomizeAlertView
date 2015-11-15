# NemoAlertViewDemo
该Demo是展示《秀动》项目中自定义AlertView控件的使用，自定义类似系统UIAlertView的场景在开发中比较常见，所以将该控件开放出来，如果有需要的同学可以拿去用，或者作为参考。
## NemoAlertBaseView 
该类是AlertView的基类，提供了show|hide方法，具体展示的Alert内容需要子类继承自己定义，也可以自己重载show|hide动画方法。
##NemoFilterUserView
该类是一个自定义的AlertView，用来让用户筛选性别，比如一个UITableView中需要根据筛选条件显示附近用户。同时用POP动画引擎重写了show|hide动画。

##后续
《秀动》项目现在已经比较成熟，其中写了很多控件感觉能重用，后面看自己时间安排会一步步开源出来。现在想到的有，3D广告Banner、日历控件、表情键盘，还有一些图片和复杂列表页优化的心得。
这段时间在开发新版本，完了之后有时间会整理一些代码发出来。
