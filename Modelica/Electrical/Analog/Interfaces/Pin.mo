within Modelica.Electrical.Analog.Interfaces;
connector Pin "一个电气组件的引脚"
  SI.ElectricPotential v "引脚处的电势" annotation (
    unassignedMessage="无法唯一计算电势。可能的原因包括：
- 缺少地接对象(Modelica.Electrical.Analog.Basic.Ground)以定义电路的零电势，或
- 电气组件的连接器未连接。");
  flow SI.Current i "流入引脚的电流" annotation (
    unassignedMessage="无法唯一计算电流。可能的原因包括：
- 缺少地接对象(Modelica.Electrical.Analog.Basic.Ground)以定义电路的零电势，或
- 电气组件的连接器未连接。");
  annotation (defaultComponentName="pin", 
    Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,100}}), graphics={Rectangle(
    extent={{-100,100},{100,-100}}, 
    lineColor={0,0,255}, 
    fillColor={0,0,255}, 
    fillPattern=FillPattern.Solid)}), 
    Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,100}}), graphics={Rectangle(
    extent={{-40,40},{40,-40}}, 
    lineColor={0,0,255}, 
    fillColor={0,0,255}, 
    fillPattern=FillPattern.Solid), Text(
    extent={{-160,110},{40,50}}, 
    textColor={0,0,255}, 
    textString="%name")}), 
    Documentation(revisions="<html>
<ul>
<li><em> 1998   </em>
       由Christoph Clauss<br>初版创建<br>
       </li>
</ul>
</html>", 
    info="<html>
<p>引脚是基本的电气连接器。它包括引脚与地节点之间的电压。地节点是任何接地设备(Modelica.Electrical.Basic.Ground)的节点。此外，引脚还包括电流，如果电流从引脚<strong>流入设备</strong>，则认为该电流为<strong>正值</strong>。</p>
</html>"));
end Pin;