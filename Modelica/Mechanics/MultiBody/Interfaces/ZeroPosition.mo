within Modelica.Mechanics.MultiBody.Interfaces;
model ZeroPosition 
  "将frame_resolve的绝对位置矢量设置为零矢量，并将方向对象设置为无旋转"
  extends Modelica.Blocks.Icons.Block;
  Interfaces.Frame_resolve frame_resolve annotation(Placement(transformation(extent = {{-116, -16}, {-84, 16}})));
equation
  Connections.root(frame_resolve.R);
  frame_resolve.R = Modelica.Mechanics.MultiBody.Frames.nullRotation();
  frame_resolve.r_0 = zeros(3);
  annotation(Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, 
    -100}, {100, 100}}), graphics = {Text(
    extent = {{-74, 24}, {80, -20}}, 
    textString = "r = 0")}), Documentation(info = "<html>
<p>
由一个在全局坐标系中固定的坐标系(frame_resolve)组成，其位置和方向与全局坐标系相同，
即从全局坐标系原点到frame_resolve的位置矢量是零矢量，并且这两个坐标系之间的相对方向是单位矩阵。
</p>
<p>
该组件不提供可视化。
</p>
</html>"));
end ZeroPosition;