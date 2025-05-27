within Modelica.Magnetic.QuasiStatic.FluxTubes.Interfaces;
connector NegativeMagneticPort "负准静态磁口"
  extends Magnetic.QuasiStatic.FundamentalWave.Interfaces.MagneticPort;
  Modelica.Electrical.QuasiStatic.Types.Reference reference "Reference";
  annotation (
    defaultComponentName="port_n", 
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100, 
            -100},{100,100}}), 
            graphics={Text(
              extent={{-100,100},{100,60}}, 
              textColor={255,170,85}, 
              fillColor={0,0,255}, 
              fillPattern=FillPattern.Solid, 
              textString="%name"), Rectangle(
          extent={{-40,40},{40,-40}}, 
          lineColor={255,170,85}, 
          fillColor={255,255,255}, 
          fillPattern=FillPattern.Solid)}), 
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
            100,100}}), 
         graphics={Rectangle(
          extent={{-100,100},{100,-100}}, 
          lineColor={255,170,85}, 
          fillColor={255,255,255}, 
          fillPattern=FillPattern.Solid)}), 
    Documentation(info="<html>
<p>
负磁端口是基于
<a href=\"modelica://Modelica.Magnetic.QuasiStatic.FluxTubes.Interfaces.MagneticPort\">MagneticPort</a>。
此外，参考角度在连接器中指定。的时间导数
参考角是准静态磁势和磁通的实际角频率。
这个符号也是这样设计的，看起来不同于
<a href=\"modelica://Modelica.Magnetic.QuasiStatic.FluxTubes.Interfaces.PositiveMagneticPort\">PositiveMagneticPort</a>.
</p>

<h4>另外</h4>

<p>
<a href=\"modelica://Modelica.Magnetic.QuasiStatic.FluxTubes.Interfaces.MagneticPort\">MagneticPort</a>,
<a href=\"modelica://Modelica.Magnetic.QuasiStatic.FluxTubes.Interfaces.PositiveMagneticPort\">PositiveMagneticPort</a>,
<a href=\"modelica://Modelica.Magnetic.FluxTubes.Interfaces.NegativeMagneticPort\">Magnetic.FluxTubes.Interfaces.NegativeMagneticPort</a>
</p>
</html>"));
end NegativeMagneticPort;