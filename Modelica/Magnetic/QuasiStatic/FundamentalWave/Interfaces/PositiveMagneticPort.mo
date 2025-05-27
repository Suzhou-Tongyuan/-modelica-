within Modelica.Magnetic.QuasiStatic.FundamentalWave.Interfaces;
connector PositiveMagneticPort "基波机的正准静态磁口"
  extends FundamentalWave.Interfaces.MagneticPort;
  Modelica.Electrical.QuasiStatic.Types.Reference reference "参考";
  annotation (
    defaultComponentName="port_p", 
    Diagram(graphics={Text(
          extent={{-100,100},{100,60}}, 
          textColor={255,170,85}, 
          textString="%name"), Ellipse(
          extent={{-40,40},{40,-40}}, 
          lineColor={255,170,85}, 
          fillColor={255,170,85}, 
          fillPattern=FillPattern.Solid)}), 
    Icon(graphics={Ellipse(
          extent={{-100,100},{100,-100}}, 
          lineColor={255,170,85}, 
          fillColor={255,170,85}, 
          fillPattern=FillPattern.Solid)}), 
    Documentation(info="<html>

<p>
正端的端口是基于
<a href=\"modelica://Modelica.Magnetic.QuasiStatic.FundamentalWave.Interfaces.MagneticPort\">MagneticPort</a>。
此外，参考角度在连接器中指定。参考角的时间导数是准静态电压和电流的实际角速度。这个符号也是这样设计的，看起来不同于
<a href=\"modelica://Modelica.Magnetic.QuasiStatic.FundamentalWave.Interfaces.NegativeMagneticPort\">NegativeMagneticPort</a>.
</p>

<h4>另见</h4>

<p>
<a href=\"modelica://Modelica.Magnetic.QuasiStatic.FundamentalWave.Interfaces.MagneticPort\">MagneticPort</a>,
<a href=\"modelica://Modelica.Magnetic.QuasiStatic.FundamentalWave.Interfaces.NegativeMagneticPort\">NegativeMagneticPort</a>
</p>
</html>"));
end PositiveMagneticPort;