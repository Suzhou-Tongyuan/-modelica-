within Modelica.Mechanics.Translational.Interfaces;
partial model PartialRigid 
  "两个一维平动接口的刚性连接"
  SI.Position s 
    "组件中心的绝对位置 (s = flange_a.s + L/2 = flange_b.s - L/2)";
  parameter SI.Length L(start=0) 
    "组件的长度，从左一维平动接口到右一维平动接口 (= flange_b.s - flange_a.s)";
  extends Translational.Interfaces.PartialTwoFlanges;
equation
  flange_a.s = s - L/2;
  flange_b.s = s + L/2;
  annotation (Documentation(info="<html>
<p>
这是一个具有两个<em>刚性</em>连接一维平动接口的 1-dim. 传动组件。
左右一维平动接口之间的固定距离由参数\"L\"定义。
左右一维平动接口上的力可以不同。
例如，它可用于建立滑动质量。
</p>
</html>"));
end PartialRigid;