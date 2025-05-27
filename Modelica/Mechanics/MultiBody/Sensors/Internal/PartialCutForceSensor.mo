within Modelica.Mechanics.MultiBody.Sensors.Internal;
partial model PartialCutForceSensor 
  "基类，用于测量两个由组件定义的坐标系之间的局部力和/或力矩"

  extends Modelica.Icons.RoundSensor;
  Modelica.Mechanics.MultiBody.Interfaces.Frame_a frame_a 
    "坐标系a" annotation (Placement(
        transformation(extent={{-116,-16},{-84,16}})));
  Modelica.Mechanics.MultiBody.Interfaces.Frame_b frame_b 
    "坐标系b" annotation (Placement(
        transformation(extent={{84,-16},{116,16}})));
  Modelica.Mechanics.MultiBody.Interfaces.Frame_resolve frame_resolve if 
         resolveInFrame==Modelica.Mechanics.MultiBody.Types.ResolveInFrameA.frame_resolve 
    "输出矢量可以选择在此坐标系中解析(局部力/力矩设置为零)" 
    annotation (Placement(transformation(
        origin={80,-100}, 
        extent={{-16,-16},{16,16}}, 
        rotation=270)));

  parameter Modelica.Mechanics.MultiBody.Types.ResolveInFrameA resolveInFrame= 
    Modelica.Mechanics.MultiBody.Types.ResolveInFrameA.frame_a 
    "解析输出矢量的坐标系(world、frame_a或frame_resolve)";

protected
  outer Modelica.Mechanics.MultiBody.World world;
equation
  assert(cardinality(frame_a) > 0, 
    "局部力/力矩传感器对象的连接器frame_a未连接");
  assert(cardinality(frame_b) > 0, 
    "局部力/力矩传感器对象的连接器frame_b未连接");

  annotation (
    Documentation(info="<html>
<p>
这是一个基类，用于具有两个坐标系和一个输出端口的三维机械组件，以测量两个坐标系之间作用的局部力和/或局部力矩，并将测量的信号作为输出提供，以供使用Modelica.Blocks包中的块进一步处理。
</p>
</html>"), 
       Icon(coordinateSystem(
        preserveAspectRatio=true, 
        extent={{-100,-100},{100,100}}), graphics={
        Line(points={{-70,0},{-101,0}}), 
        Line(points={{70,0},{100,0}}), 
        Text(
          extent={{-132,76},{129,124}}, 
          textString="%name", 
          textColor={0,0,255}), 
        Text(
          extent={{-118,55},{-82,30}}, 
          textColor={128,128,128}, 
          textString="a"), 
        Text(
          extent={{83,55},{119,30}}, 
          textColor={128,128,128}, 
          textString="b"), 
        Text(
          extent={{70,-66},{201,-91}}, 
          textColor={95,95,95}, 
          textString="resolve"), 
        Line(
          points={{80,0},{80,-100}}, 
          color={95,95,95}, 
          pattern=LinePattern.Dot)}));
end PartialCutForceSensor;