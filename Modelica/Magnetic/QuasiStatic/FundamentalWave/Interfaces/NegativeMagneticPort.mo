within Modelica.Magnetic.QuasiStatic.FundamentalWave.Interfaces;
connector NegativeMagneticPort "基波机的负准静磁端口"
  extends FundamentalWave.Interfaces.MagneticPort;
  Modelica.Electrical.QuasiStatic.Types.Reference reference "参考";
  annotation (
    defaultComponentName="port_n", 
    Diagram(graphics={Text(
          extent={{-100,100},{100,60}}, 
          textColor={255,170,85}, 
          textString="%name"), Ellipse(
          extent={{-40,40},{40,-40}}, 
          lineColor={255,170,85}, 
          fillColor={255,255,255}, 
          fillPattern=FillPattern.Solid)}), 
    Icon(graphics={Ellipse(
          extent={{-100,100},{100,-100}}, 
          lineColor={255,170,85}, 
          fillColor={255,255,255}, 
          fillPattern=FillPattern.Solid)}), 
    Documentation(info="<html>

<p>
负引脚基于<a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Interfaces.Pin\">Pin</a>。
此外，参考角度在连接器中指定。参考角的时间导数是准静态电压和电流的实际角速度。该符号也被设计成看起来与<a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Interfaces. PositivePin\">positive pin</a>.
</p>

<h4>另见</h4>

<p>
<a href=\"modelica://Modelica.Magnetic.QuasiStatic.FundamentalWave.Interfaces.MagneticPort\">MagneticPort</a>,
<a href=\"modelica://Modelica.Magnetic.QuasiStatic.FundamentalWave.Interfaces.PositiveMagneticPort\">PositiveMagneticPort</a>
</p>
</html>"));
end NegativeMagneticPort;