within Modelica.Electrical.Analog.Ideal;
model CloserWithArc "带简单电弧效应的理想闭合开关模型"
  extends Modelica.Electrical.Analog.Interfaces.IdealSwitchWithArc;
  Modelica.Blocks.Interfaces.BooleanInput control 
    "true=>p--n连接，false=>开关打开" annotation (Placement(
        transformation(
        origin={0,110}, 
        extent={{-10,-10},{10,10}}, 
        rotation=270)));
equation
  off = not control;
  annotation (defaultComponentName="switch", 
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100, 
            100}}), graphics={
        Line(points={{40,40},{32,14},{48,22},{40,0}}, color={255,0,0})}), 
    Documentation(info="<html>
<p>
这个模型是基于以下模型搭建：<a href=\"modelica://Modelica.Electrical.Analog.Ideal.IdealClosingSwitch\">IdealClosingSwitch</a>
</p>
<p>
如果对电弧效应存在疑惑，请查看：<a href=\"modelica://Modelica.Electrical.Analog.Interfaces.IdealSwitchWithArc\">IdealSwitchWithArc</a>
</p>
</html>", 
        revisions="<html>
<ul>
<li><em>2016年2月7日</em>
       Anton Haumer<br>从部分IdealSwitch扩展而来<br>
       </li>
<li><em>2009年3月11日</em>
       Christoph Clauss<br>最初实现<br>
       </li>

</html>"));
end CloserWithArc;