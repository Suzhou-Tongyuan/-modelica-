within Modelica;
package Thermal "用于模拟热传导和简单热流体管道流动的热系统组件库"
  extends Modelica.Icons.Package;
  import Modelica.Units.SI;

  annotation (
   Icon(coordinateSystem(extent={{-100.0,-100.0},{100.0,100.0}}), graphics={
    Line(
    origin={-47.5,11.6667}, 
    points={{-2.5,-91.6667},{17.5,-71.6667},{-22.5,-51.6667},{17.5,-31.6667},{-22.5,-11.667},{17.5,8.3333},{-2.5,28.3333},{-2.5,48.3333}}, 
      smooth=Smooth.Bezier), 
    Polygon(
    origin={-50.0,68.333}, 
    pattern=LinePattern.None, 
    fillPattern=FillPattern.Solid, 
      points={{0.0,21.667},{-10.0,-8.333},{10.0,-8.333}}), 
    Line(
    origin={2.5,11.6667}, 
    points={{-2.5,-91.6667},{17.5,-71.6667},{-22.5,-51.6667},{17.5,-31.6667},{-22.5,-11.667},{17.5,8.3333},{-2.5,28.3333},{-2.5,48.3333}}, 
      smooth=Smooth.Bezier), 
    Polygon(
    origin={0.0,68.333}, 
    pattern=LinePattern.None, 
    fillPattern=FillPattern.Solid, 
      points={{0.0,21.667},{-10.0,-8.333},{10.0,-8.333}}), 
    Line(
    origin={52.5,11.6667}, 
    points={{-2.5,-91.6667},{17.5,-71.6667},{-22.5,-51.6667},{17.5,-31.6667},{-22.5,-11.667},{17.5,8.3333},{-2.5,28.3333},{-2.5,48.3333}}, 
      smooth=Smooth.Bezier), 
    Polygon(
    origin={50.0,68.333}, 
    pattern=LinePattern.None, 
    fillPattern=FillPattern.Solid, 
      points={{0.0,21.667},{-10.0,-8.333},{10.0,-8.333}})}), 
    Documentation(info="<html><p>
这个包包含用于模拟热传递和热流体的库。
</p>
</html>"));
end Thermal;