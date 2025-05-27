within Modelica.Mechanics.MultiBody.Types;
type Axis = Modelica.Icons.TypeReal[3](each final unit="1") 
  "带有选择的轴矢量" annotation (
  preferredView="text", 
  Evaluate=true, 
  choices(
    choice={1,0,0} "{1,0,0}\"x 轴\"", 
    choice={0,1,0} "{0,1,0}\"y 轴\"", 
    choice={0,0,1} "{0,0,1}\"z 轴\"", 
    choice={-1,0,0} "{-1,0,0}\"负 x 轴\"", 
    choice={0,-1,0} "{0,-1,0}\"负 y 轴\"", 
    choice={0,0,-1} "{0,0,-1}\"负 z 轴\""), 
  Documentation(info="<html>
<p>
轴矢量的类型定义，带有下拉菜单，提供了沿坐标系坐标轴的最常用轴矢量。
例如，请参见模型中的参数“n”<a href=\"modelica://Modelica.Mechanics.MultiBody.Joints.Revolute\">Joints.Revolute</a>。
</p>
</html>"));