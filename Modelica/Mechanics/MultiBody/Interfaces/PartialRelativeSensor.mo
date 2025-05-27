within Modelica.Mechanics.MultiBody.Interfaces;
partial model PartialRelativeSensor 
  "用于测量两个坐标系之间相对变量的基础模型"
  extends Modelica.Icons.RoundSensor;
  parameter Integer n_out = 1 "输出信号数量";
  Interfaces.Frame_a frame_a "坐标系a" annotation (Placement(transformation(extent={{-116,-16},{-84,16}})));
  Interfaces.Frame_b frame_b "坐标系b" annotation (Placement(transformation(extent={{84,-16},{116,16}})));

  Modelica.Blocks.Interfaces.RealOutput y[n_out] 
    "作为信号向量的测量数据" 
    annotation (Placement(transformation(
        origin={0,-110}, 
        extent={{10,-10},{-10,10}}, 
        rotation=90)));
protected
  outer Modelica.Mechanics.MultiBody.World world;

equation
  assert(cardinality(frame_a) > 0, 
    "相对传感器对象的连接器frame_a未被连接");
  assert(cardinality(frame_b) > 0, 
    "相对传感器对象的连接器frame_b未被连接");

  annotation (
    Documentation(info="<html>
<p>
这是一个具有两个坐标系和一个输出端口的三维力学组件的基类，
用于测量两个坐标系之间的相对量或坐标系中的局部力/力矩，
并将测量信号作为输出以便与Modelica.Blocks包中的模块进一步处理。
</p>
</html>"), 
         Icon(coordinateSystem(
        preserveAspectRatio=true, 
        extent={{-100,-100},{100,100}}), graphics={
        Line(points={{-70,0},{-101,0}}), 
        Line(points={{70,0},{100,0}}), 
        Line(points={{0,-100},{0,-70}}, color={0,0,127}), 
        Text(
          extent={{-132,76},{129,124}}, 
          textString="%name", 
          textColor={0,0,255}), 
        Text(
          extent={{-118,52},{-82,27}}, 
          textColor={128,128,128}, 
          textString="a"), 
        Text(
          extent={{85,53},{121,28}}, 
          textColor={128,128,128}, 
          textString="b")}));
end PartialRelativeSensor;