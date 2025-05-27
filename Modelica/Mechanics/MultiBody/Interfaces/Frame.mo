within Modelica.Mechanics.MultiBody.Interfaces;
connector Frame 
  "固定于组件的坐标系，同时带有一个局部力和局部力矩(无图标)"

  SI.Position r_0[3] 
    "从全局坐标系原点到连接器局部坐标系原点的位置矢量，在全局坐标系中解析";
  Frames.Orientation R 
    "将全局坐标系旋转到连接器局部坐标系的方向对象";
  flow SI.Force f[3] "在连接器局部坐标系中解析的力" annotation(
    unassignedMessage = "无法每次都唯一地计算所有力。
可能的原因是机构中包含平面环路，或者关节限制了相同的运动。
对于平面环路，每个环路的一个旋转关节使用Joints.RevolutePlanarLoopConstraint，
而不是Joints.Revolute。");
  flow SI.Torque t[3] "在连接器局部坐标系中解析的力矩";
  annotation(Documentation(info = "<html>
<p>
固定在机械部件上的坐标系的基本定义。
在坐标系的原点，作用着局部力和局部力矩。该组件没有图标定义，只能通过继承坐标系连接器来定义不同的图标。
</p>
</html>"));
end Frame;