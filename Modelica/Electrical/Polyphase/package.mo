within Modelica.Electrical;
package Polyphase "多相电气元件库"
  extends Modelica.Icons.Package;
  annotation (Documentation(info="<html>
<p>
版权&copy; 1998-2020，Modelica协会和贡献者
</p>
</html>", revisions="<html>
  <ul>
  <li>v1.0 2004/10/01 Anton Haumer</li>
  <li>v1.1 2006/01/12 Anton Haumer<br>
      添加了Sensors.PowerSensor</li>
  <li>v1.2 2006/07/05 Anton Haumer<br>
      从 Interfaces.Plug的引脚中移除了注释<br>
      修正了电阻/导纳的使用</li>
  <li>v1.3.0 2007/01/23 Anton Haumer<br>
      改进了一些图标</li>
  <li>v1.3.1 2007/08/12 Anton Haumer<br>
      改进了文档</li>
  <li>v1.3.2 2007/08/24 Anton Haumer<br>
      移除了重新声明类型SignalType</li>
  <li>v1.4.0 2009/08/26 Anton Haumer<br>
      添加了条件热端口作为Electrical.Analog<br>
      添加了带弧的开关作为Electrical.Analog</li>
  </ul>
</html>"), Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100}, 
            {100,100}}), graphics={
        Ellipse(
          origin={14,56}, 
          lineColor={95,95,95}, 
          extent={{-84,-126},{56,14}}), 
        Ellipse(
          origin={0,42}, 
          lineColor={95,95,95}, 
          fillColor={95,95,95}, 
          fillPattern=FillPattern.Solid, 
          extent={{-40,-34},{-20,-14}}), 
        Ellipse(
          origin={20,40}, 
          lineColor={95,95,95}, 
          fillColor={95,95,95}, 
          fillPattern=FillPattern.Solid, 
          extent={{0,-34},{20,-14}}), 
        Ellipse(
          origin={10,34}, 
          lineColor={95,95,95}, 
          fillColor={95,95,95}, 
          fillPattern=FillPattern.Solid, 
          extent={{-20,-74},{0,-54}})}));
end Polyphase;