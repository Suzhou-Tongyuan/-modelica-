within Modelica.Magnetic.FundamentalWave.Interfaces;
connector PositiveMagneticPort "基波机的正磁端口"
  extends Magnetic.FundamentalWave.Interfaces.MagneticPort;
  annotation (
    defaultComponentName="port_p", 
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
            100,100}}), graphics={Ellipse(
          extent={{-100,100},{100,-100}}, 
          lineColor={255,128,0}, 
          fillColor={255,128,0}, 
          fillPattern=FillPattern.Solid)}), 
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100}, 
            {100,100}}), graphics={Text(
          extent={{-60,100},{-60,60}}, 
          textColor={255,128,0}, 
          textString="%name"), Ellipse(
          extent={{-50,50},{50,-50}}, 
          lineColor={255,128,0}, 
          fillColor={255,128,0}, 
          fillPattern=FillPattern.Solid)}), 
    Documentation(info="<html>
<p>
正磁性 <a href=\"modelica://Modelica.Magnetic.FundamentalWave.Interfaces.MagneticPort\">port</a>.
</p>

<h4>另见</h4>
<p>
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.Interfaces.MagneticPort\">MagneticPort</a>,
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.Interfaces.NegativeMagneticPort\">NegativeMagneticPort</a>
</p>

</html>"));
end PositiveMagneticPort;