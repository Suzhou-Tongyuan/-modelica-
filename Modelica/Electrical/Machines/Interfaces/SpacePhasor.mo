within Modelica.Electrical.Machines.Interfaces;
connector SpacePhasor "空间矢量的连接器"
  SI.Voltage v_[2] "1=实部, 2=虚部";
  flow SI.Current i_[2] "1=实部, 2=虚部";
  annotation (
    Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100}, 
            {100,100}}), graphics={Polygon(
          points={{0,100},{-100,0},{0,-100},{100,0},{0,100}}, 
          lineColor={0,0,255}, 
          fillColor={0,0,255}, 
          fillPattern=FillPattern.Solid), Text(
          extent={{-150,-90},{150,-150}}, 
          textColor={0,0,255}, 
          textString="%name")}), 
    Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
            100,100}}), graphics={Polygon(
          points={{0,100},{-100,0},{0,-100},{100,0},{0,100}}, 
          lineColor={0,0,255}, 
          fillColor={0,0,255}, 
          fillPattern=FillPattern.Solid)}), 
    Documentation(info="<html>
空间相量的连接器:
<ul>
<li>电压 v_[2] ... 电压空间相量的实部和虚部</li>
<li>电流 i_[2] ... 电流空间相量的实部和虚部</li>
</ul>
</html>"));
end SpacePhasor;