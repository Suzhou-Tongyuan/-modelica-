within Modelica.Magnetic.QuasiStatic.FundamentalWave.BasicMachines.Components;
model PermanentMagnet 
  "无固有磁阻的永磁模型，用磁势差表示"
  extends FundamentalWave.Losses.PermanentMagnetLosses;
  extends Magnetic.QuasiStatic.FundamentalWave.Interfaces.TwoPortElementary;
  parameter SI.ComplexMagneticPotentialDifference V_m= 
      Complex(re=1, im=0) 
    "相对于转子固定参照系的复磁势差";
  SI.MagneticPotentialDifference abs_V_m= 
      Modelica.ComplexMath.abs(V_m) 
    "复合磁势差的大小";
  SI.Angle arg_V_m=Modelica.ComplexMath.arg(V_m) 
    "相对于参照系的复磁势差论证";

  SI.Angle gamma "V_m 固定参照系的角度";
  SI.ComplexMagneticFlux Phi "复合磁通量";
  SI.MagneticPotentialDifference abs_Phi= 
      Modelica.ComplexMath.abs(Phi) 
    "复合磁通量的大小";
  SI.Angle arg_Phi=Modelica.ComplexMath.arg(Phi) 
    "复合磁通论证";
  SI.ComplexMagneticPotentialDifference V_mGamma=V_m* 
      Modelica.ComplexMath.fromPolar(1, -gamma) 
    "相对于参照系的磁动势差";
equation
  // 相对于转子固定参考点的磁动力
  port_p.V_m - port_n.V_m = V_mGamma;
  // 相对于转子固定基准流入正端口的流量
  port_p.Phi = Phi;
  // 当地通量平衡
  port_p.Phi + port_n.Phi = Complex(0, 0);
  // 参考角速度和角度
  gamma = port_p.reference.gamma;
  // Connections.root(port_p.reference);
  annotation (defaultComponentName="magnet", 
    Documentation(info="<html>
<p>永磁体模型与磁性，机械和热连接器，包括损耗。永磁模型是恒磁位差的来源。PM损耗计算公式为
<a href=\"modelica://Modelica.Magnetic.QuasiStatic.FundamentalWave.Losses.PermanentMagnetLosses\">PermanentMagnetLosses</a>.
</p>
</html>"), 
     Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100}, 
            {100,100}}), graphics={Line(
          points={{-100,0},{100,0}}, 
          color={255,170,85}), Ellipse(extent={{-50,50},{50,-50}}, 
            lineColor={255,170,85})}));
end PermanentMagnet;