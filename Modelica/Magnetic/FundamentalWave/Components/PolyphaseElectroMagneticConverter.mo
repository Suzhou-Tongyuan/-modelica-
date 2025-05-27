within Modelica.Magnetic.FundamentalWave.Components;
model PolyphaseElectroMagneticConverter 
  "多相电磁转换器"

  import Modelica.Constants.pi;

  // 全局插头和端口变量
  SI.Voltage v[m]=plug_p.pin.v - plug_n.pin.v "电压";
  SI.Current i[m]=plug_p.pin.i "电流";
  SI.ComplexMagneticPotentialDifference V_m=port_p.V_m - 
      port_n.V_m "磁电势差";
  SI.MagneticPotentialDifference abs_V_m= 
      Modelica.ComplexMath.abs(V_m) 
    "复合磁势差的大小";
  SI.Angle arg_V_m=Modelica.ComplexMath.arg(V_m) 
    "复磁势差论证";

  SI.ComplexMagneticFlux Phi=port_p.Phi "磁通量";
  SI.MagneticPotentialDifference abs_Phi= 
      Modelica.ComplexMath.abs(Phi) "复合磁通量的大小";
  SI.Angle arg_Phi=Modelica.ComplexMath.arg(Phi) 
    "复合磁通论证";

  Modelica.Electrical.Polyphase.Interfaces.PositivePlug plug_p(final m=m) 
    "正极插头" annotation (Placement(transformation(
        origin={-100,100}, 
        extent={{-10,-10},{10,10}}, 
        rotation=180)));
  Modelica.Electrical.Polyphase.Interfaces.NegativePlug plug_n(final m=m) 
    "负极插头" annotation (Placement(transformation(
        origin={-100,-100}, 
        extent={{-10,-10},{10,10}}, 
        rotation=180)));
  Magnetic.FundamentalWave.Interfaces.PositiveMagneticPort port_p 
    "正复磁端口" 
    annotation (Placement(transformation(extent={{90,90},{110,110}})));
  Magnetic.FundamentalWave.Interfaces.NegativeMagneticPort port_n 
    "负复合磁端口" 
    annotation (Placement(transformation(extent={{90,-110},{110,-90}})));
  parameter Integer m=3 "相位数量" annotation(Evaluate=true);
  parameter Real effectiveTurns[m] "有效转数";
  parameter SI.Angle orientation[m] 
    "由此产生的基波场相位的方向";
  Magnetic.FundamentalWave.Components.SinglePhaseElectroMagneticConverter singlePhaseElectroMagneticConverter[m](final
      effectiveTurns=effectiveTurns, final orientation=orientation) 
    annotation (Placement(transformation(extent={{-8,-10},{12,10}})));
equation
  connect(plug_p.pin, singlePhaseElectroMagneticConverter.pin_p) 
    annotation (Line(
      points={{-100,100},{-8,100},{-8,10}}, color={0,0,255}));
  connect(singlePhaseElectroMagneticConverter.pin_n, plug_n.pin) 
    annotation (Line(
      points={{-8,-10},{-8,-100},{-100,-100}}, color={0,0,255}));
  connect(singlePhaseElectroMagneticConverter[1].port_p, port_p) 
    annotation (Line(
      points={{12,10},{12,100},{100,100}}, color={255,128,0}));
  for k in 2:m loop
    connect(singlePhaseElectroMagneticConverter[k - 1].port_n, 
      singlePhaseElectroMagneticConverter[k].port_p);
  end for;
  connect(singlePhaseElectroMagneticConverter[m].port_n, port_n) 
    annotation (Line(
      points={{12,-10},{12,-100},{100,-100}}, color={255,128,0}));
  annotation (defaultComponentName="converter", 
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
            100,100}}), graphics={           Line(points={{100,-100},{94,-100},{84,-98},{76,-94},{64,-86},{50,-72},{42,-58},{36,-40},{30,-18},{30,0},{30,18},{34,36},{46,66},{62,84},{78,96},{90,100},{100,100}}, 
          color={255,128,0}),Line(points={{-20,60},{-20,100},{-100,100}}, 
          color={0,0,255}),Line(points={{-20,-60},{-20,-100},{-100,-100}}, 
          color={0,0,255}), 
        Line(
          points={{-15,-7},{-9,43},{5,73},{25,73},{41,43},{45,-7}}, 
          color={0,0,255}, 
          smooth=Smooth.Bezier, 
          origin={-13,45}, 
          rotation=270), 
        Line(
          points={{-15,-7},{-9,43},{5,73},{25,73},{41,43},{45,-7}}, 
          color={0,0,255}, 
          smooth=Smooth.Bezier, 
          origin={-13,-15}, 
          rotation=270), 
          Text(
              extent={{-150,120},{150,160}}, 
              textColor={0,0,255}, 
              textString="%name")}), 
    Documentation(info="<html>
<p>
<img src=\"modelica://Modelica/Resources/Images/Magnetic/FundamentalWave/k.png\">的每个相位<img src=\"modelica://Modelica/Resources/Images/Magnetic/FundamentalWave/m.png\">绕组具有有效匝数，<img src=\"modelica://Modelica/Resources/Images/Magnetic/FundamentalWave/effectiveTurns_k.png\">和各自的翅膀角度<img src=\"modelica://Modelica/Resources/Images/Magnetic/FundamentalWave/orientation_k.png\">和相电流<img src=\"modelica://Modelica/Resources/Images/Magnetic/FundamentalWave/i_k.png\">.
</p>

<p>
多相绕组的总复磁势差由以下公式确定:
</p>

<p>
&nbsp;&nbsp;<img src=\"modelica://Modelica/Resources/Images/Magnetic/FundamentalWave/Components/polyphaseconverter_vm.png\">
</p>

<p>
在这一方程式中，绕组磁动力对总复合磁势差的贡献与绕组各自的方向一致.
</p>

<p>
<img src=\"modelica://Modelica/Resources/Images/Magnetic/FundamentalWave/v_k.png\">每个绕组的感应电压取决于绕组方向与复磁通角度之间的余弦。此外，感应电压的大小与各自的匝数成正比。这种关系可以用以下公式来模拟</p>

<p>
&nbsp;&nbsp;<img src=\"modelica://Modelica/Resources/Images/Magnetic/FundamentalWave/Components/polyphaseconverter_phi.png\">
</p>

<p>对于 <img src=\"modelica://Modelica/Resources/Images/Magnetic/FundamentalWave/k_in_1_m.png\"> 如下图所示:</p>

<table border=\"0\" cellspacing=\"0\" cellpadding=\"2\">
  <caption align=\"bottom\"><strong>Fig:</strong> 绕组方向和复合磁通的位置</caption>
  <tr>
    <td>
      <img src=\"modelica://Modelica/Resources/Images/Magnetic/FundamentalWave/Components/coupling.png\">
    </td>
  </tr>
</table>

<h4>另见</h4>
<p>
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.Components.SinglePhaseElectroMagneticConverter\">SinglePhaseElectroMagneticConverter</a>
</p>
</html>"));
end PolyphaseElectroMagneticConverter;