within Modelica.Electrical.Analog.Ideal;
model IdealGTOThyristor "理想GTO晶闸管"
  extends Modelica.Electrical.Analog.Interfaces.IdealSemiconductor;
  Modelica.Blocks.Interfaces.BooleanInput fire annotation (Placement(
        transformation(
        origin={100,120}, 
        extent={{-20,-20},{20,20}}, 
        rotation=270), iconTransformation(
        extent={{-20,-20},{20,20}}, 
        rotation=270, 
        origin={100,120})));
equation
  off = s < 0 or not fire;
  annotation (defaultComponentName="gto", 
    Documentation(info="<html><p>
这是一个理想GTO晶闸管，详见<a href=\"modelica://Modelica.Electrical.Analog.Interfaces.IdealSemiconductor\" target=\"\">IdealSemiconductor</a>&nbsp;<br>当电压大于Vknee且fire=true，晶闸管导通，反之则不导通。<br>
</p>
</html>",revisions="<html>
<ul>
<li><em>2016年2月7日</em>
       Anton Haumer<br>从部分IdealSemiconductor扩展而来<br>
       </li>
<li><em>2009年3月11日</em>
       Christoph Clauss<br>添加了条件热口<br>
       </li>
<li><em>2004年5月7日</em>
       Christoph Clauss 和 Anton Haumer<br>添加了Vknee<br>
       </li>
<li><em>几年前</em>
       Christoph Clauss<br>实现<br>
       </li>
</ul>
</html>"), 
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100, 
            100}}), graphics={
        Line(points={{48,52},{64,36}}, color={0,0,255}), 
        Line(
          visible=useHeatPort, 
          points={{0,-100},{0,-20}}, 
          color={127,0,0}, 
          pattern=LinePattern.Dot), 
        Polygon(
          points={{42,45},{42,38},{49,38},{42,45}}, 
          lineColor={0,0,255}, 
          fillPattern=FillPattern.Solid, 
          fillColor={0,0,255}), 
        Polygon(
          points={{46,33},{53,33},{53,26},{46,33}}, 
          lineColor={0,0,255}, 
          fillPattern=FillPattern.Solid, 
          fillColor={0,0,255}), 
        Line(points={{30,10},{60,40}}, color={0,0,255}), 
        Line(points={{30,26},{52,48}}, color={0,0,255}), 
        Line(
          points={{100,100},{100,88},{62,50}}, 
          color={255,0,255}, 
          pattern=LinePattern.Dash), 
        Line(
          points={{58,44}}, 
          color={255,0,255}, 
          pattern=LinePattern.Dash), 
        Line(points={{62,50},{56,44}}, color={0,0,255})}), 
    Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
            100,100}}), graphics={
                                 Line(
            points={{20,10},{70,40}}, 
            thickness=0.5)}));
end IdealGTOThyristor;