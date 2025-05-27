within Modelica.Electrical.Analog.Ideal;
model IdealThyristor "理想晶闸管"
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
  off = s < 0 or pre(off) and not fire;
  annotation (defaultComponentName="thyristor", 
    Documentation(info="<html>
<p>这是一个理想晶闸管，详见<a href=\"modelica://Modelica.Electrical.Analog.Interfaces.IdealSemiconductor\">IdealSemiconductor</a><br>
如果voltage&gt;Vknee且fire=true时，晶闸管导通。<br>
反之，晶闸管截止。</p>
</html>", 
        revisions="<html>
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
    Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100, 
            100}}), graphics={
        Line(
          visible=useHeatPort, 
          points={{0,-100},{0,-20}}, 
          color={127,0,0}, 
          pattern=LinePattern.Dot), 
        Line(points={{30,20},{60,50}}, color={0,0,255}), 
        Line(
          points={{100,100},{100,90},{60,50}}, 
          color={255,0,255}, 
          pattern=LinePattern.Dash)}), 
    Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
            100,100}}), graphics={
                                 Line(
            points={{20,10},{70,40}}, 
            thickness=0.5)}));
end IdealThyristor;