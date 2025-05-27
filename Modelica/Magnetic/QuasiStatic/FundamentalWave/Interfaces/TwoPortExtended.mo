within Modelica.Magnetic.QuasiStatic.FundamentalWave.Interfaces;
partial model TwoPortExtended "部分二端口的图形化编程与附加变量"
  extends Magnetic.QuasiStatic.FundamentalWave.Interfaces.TwoPortElementary;

  SI.ComplexMagneticPotentialDifference V_m = port_p.V_m - port_n.V_m 
    "复磁位差";
  SI.MagneticPotentialDifference abs_V_m = Modelica.ComplexMath.abs(V_m) 
    "复磁位差的大小";
  SI.Angle arg_V_m = Modelica.ComplexMath.arg(V_m) 
    "复磁位差的论证";
  SI.ComplexMagneticFlux Phi = port_p.Phi 
    "复磁通量";
  SI.MagneticFlux abs_Phi = Modelica.ComplexMath.abs(Phi) 
    "复磁通量的大小";
  SI.Angle arg_Phi = Modelica.ComplexMath.arg(Phi) 
    "复磁通量的参数";

  annotation (
    Documentation(info="<html>
<p>
部分双端口模型由一个正磁端口和一个负磁端口组成。两个端口的参考角度设置为相等，并通过<code>Connections.branch</code>连接.
</p>
<p>
此接口模型包含一组扩展的(输出)变量
<a href=\"modelica://Modelica.Magnetic.QuasiStatic.FundamentalWave.Interfaces.TwoPortElementary\">TwoPortElementary</a>.
</p>
</html>"));
end TwoPortExtended;