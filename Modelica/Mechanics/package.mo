within Modelica;
package Mechanics "一维和三维机械组件库(多体、转动、平动)"
  extends Modelica.Icons.Package;
  import Modelica.Units.SI;
  annotation(
  Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100.0,-100.0},{100.0,100.0}}), graphics={
      Rectangle(
        origin={8.6,63.3333}, 
        lineColor={64,64,64}, 
        fillColor={192,192,192}, 
        fillPattern=FillPattern.HorizontalCylinder, 
        extent={{-4.6,-93.3333},{41.4,-53.3333}}), 
      Ellipse(
        origin={9.0,46.0}, 
        extent={{-90.0,-60.0},{-80.0,-50.0}}), 
      Line(
        origin={9.0,46.0}, 
        points={{-85.0,-55.0},{-60.0,-21.0}}, 
        thickness=0.5), 
      Ellipse(
        origin={9.0,46.0}, 
        extent={{-65.0,-26.0},{-55.0,-16.0}}), 
      Line(
        origin={9.0,46.0}, 
        points={{-60.0,-21.0},{9.0,-55.0}}, 
        thickness=0.5), 
      Ellipse(
        origin={9.0,46.0}, 
        fillPattern=FillPattern.Solid, 
        extent={{4.0,-60.0},{14.0,-50.0}}), 
      Line(
        origin={9.0,46.0}, 
        points={{-10.0,-26.0},{72.0,-26.0},{72.0,-86.0},{-10.0,-86.0}})}), 
  Documentation(info="<html>
<p>
这个包包含了用于模拟一维转动、一维平动和三维的<strong>机械系统</strong>运动的组件。
</p>
<p>
注意，Modelica.Mechanics库中所有的<strong>耗散性</strong>组件都有一个可选择的<strong>heatPort</strong>连接器，
用于将耗散能量以热的形式传输。通过参数\"useHeatPort\"启用该连接器。
如果启用了heatPort连接器，则必须连接它；如果未启用，则不能连接。无论heatPort是否启用，
耗散功率都可以从变量\"<strong>lossPower</strong>\"中获取(如果热量从heatPort流出，则该值为正)。
</p>
</html>"));
end Mechanics;