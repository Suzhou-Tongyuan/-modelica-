within Modelica.Magnetic.FluxTubes.Basic;
model ElectroMagneticConverterWithLeakageInductance 
  "带漏感的电磁能量转换"

  Magnetic.FluxTubes.Interfaces.PositiveMagneticPort port_p 
    "正磁端口" annotation (Placement(transformation(extent={{90, 
            90},{110,110}}), iconTransformation(extent={{90,90},{110,110}})));
  Magnetic.FluxTubes.Interfaces.NegativeMagneticPort port_n 
    "负磁端口" annotation (Placement(transformation(extent={{110, 
            -110},{90,-90}}), iconTransformation(extent={{110,-110},{90,-90}})));
  Modelica.Electrical.Analog.Interfaces.PositivePin p "正极电针" 
    annotation (Placement(transformation(extent={{-90,90},{-110,110}}), iconTransformation(extent={{-90,90},{-110,110}})));
  Modelica.Electrical.Analog.Interfaces.NegativePin n "负极电气插针" 
    annotation (Placement(transformation(extent={{-110,-108},{-90,-88}}), iconTransformation(extent={{-110,-108},{-90,-88}})));
  SI.Voltage v "电压";
  SI.Current i(start=0, stateSelect=StateSelect.prefer) "电流";
  SI.MagneticPotentialDifference V_m "磁电势差";
  SI.MagneticFlux Phi(stateSelect=StateSelect.never) 
    "耦合到磁路中的总磁通量 (= Phi_ind + Phi_leak)";
  SI.MagneticFlux Phi_ind(stateSelect=StateSelect.never) 
    "转换器的磁通量";
  SI.MagneticFlux Phi_leak(stateSelect=StateSelect.never) 
    "漏感磁通量";
  parameter Real N(start=1, min=Modelica.Constants.eps) "转数";

  parameter SI.Length L=10e-3 "通量方向上的长度" 
    annotation (Dialog(tab="Leakage inductance"));
  parameter SI.Area A=10e-6 "横截面积" 
    annotation (Dialog(tab="Leakage inductance"));
  parameter SI.RelativePermeability mu_rel(min=Modelica.Constants.eps) = 1 
    "泄漏电感的恒定相对磁导率（要求 > 0）" 
    annotation (Dialog(tab="Leakage inductance"));
  final parameter SI.Permeance G_m=Modelica.Constants.mu_0*mu_rel*A/L 
    "漏感的磁导率";

  // 仅供参考
  SI.MagneticFlux Psi "通量连接";
  SI.Inductance L_stat "静电感应强度 abs（Psi/i）";

protected
  constant Real eps=100*Modelica.Constants.eps;
equation
  v = p.v - n.v;
  0 = p.i + n.i;
  i = p.i;

  V_m = port_p.V_m - port_n.V_m;
  0 = port_p.Phi + port_n.Phi;
  Phi = port_p.Phi;

  // 转换器方程
  V_m = i*N "安培定律";
  N*der(Phi_ind) = -v "法拉第定律";

  // 泄漏方程
  Phi_leak = G_m*V_m;
  Phi = Phi_ind + Phi_leak;

  // 仅供参考
  Psi = N*Phi_ind;
  //使用 abs() 得到正结果；这是由于 Modelica 对流入连接器的符号约定所致
  L_stat = noEvent(if abs(i) > eps then abs(Psi/i) else abs(Psi/eps));

  annotation (
    defaultComponentName="converter", 
    Diagram(coordinateSystem(
        preserveAspectRatio=false, 
        extent={{-100,-100},{100,100}}, 
        grid={2,2}), graphics={                    Polygon(
              points={{-136,103},{-126,100},{-136,97},{-136,103}}, 
              lineColor={160,160,164}, 
              fillColor={160,160,164}, 
              fillPattern=FillPattern.Solid),Line(points={{-152,100},{-127,100}}, 
                color={160,160,164}), 
                                Line(points={{-152,-100},{-127,-100}}, color={160,160,164}), 
                         Polygon(
          points={{-142,-97},{-152,-100},{-142,-103},{-142,-97}}, 
          lineColor={160,160,164}, 
          fillColor={160,160,164}, 
          fillPattern=FillPattern.Solid),    Text(
              extent={{-143,-96},{-126,-81}}, 
              textColor={160,160,164}, 
              textString="i"),Text(
              extent={{-152,103},{-135,118}}, 
              textColor={160,160,164}, 
              textString="i"),       Polygon(
              points={{143,-97},{153,-100},{143,-103},{143,-97}}, 
              lineColor={160,160,164}, 
              fillColor={160,160,164}, 
              fillPattern=FillPattern.Solid),Line(points={{127,-100},{152,-100}}, 
          color={160,160,164}),Text(
              extent={{130,-96},{146,-81}}, 
              textColor={160,160,164}, 
              textString="Phi"),Text(
              extent={{130,102},{147,117}}, 
          textString="Phi", 
          textColor={160,160,164}), 
                              Line(points={{126,100},{151,100}}, color={160,160,164}), 
          Polygon(
          points={{136,103},{126,100},{136,97},{136,103}}, 
          lineColor={160,160,164}, 
          fillColor={160,160,164}, 
          fillPattern=FillPattern.Solid)}), 
    Icon(coordinateSystem(
        preserveAspectRatio=false, 
        extent={{-100,-100},{100,100}}, 
        grid={2,2}), graphics={
        Line(points={{-30,100},{-90,100}}, 
                                         color={0,0,255}), 
        Line(points={{-30,-100},{-90,-100}}, 
                                           color={0,0,255}), 
        Ellipse(extent={{-4,-34},{64,34}}, lineColor={255,127,0}), 
        Line(points={{30,-100},{30,0}},  color={255,127,0}), 
        Line(points={{30,0},{30,100}}, color={255,127,0}), 
        Line(points={{30,100},{90,100}},color={255,127,0}), 
        Line(points={{30,-100},{90,-100}}, 
                                         color={255,127,0}), 
        Text(
          extent={{-150,150},{150,110}}, 
          textColor={0,0,255}, 
          textString="%name"), 
        Rectangle(
          extent={{72,28},{88,-24}}, 
          lineColor={255,128,0}, 
          fillPattern=FillPattern.Solid, 
          fillColor={255,255,255}), 
        Line(
          points={{80,28},{80,100}}, 
          color={255,128,0}), 
        Line(
          points={{80,-24},{80,-100}}, 
          color={255,128,0}), 
        Line(
          points={{-15,-7},{-14,-1},{-7,7},{7,7},{14,-1},{15,-7}}, 
          color={0,0,255}, 
          smooth=Smooth.Bezier, 
          origin={-23,45}, 
          rotation=270), 
        Line(
          points={{-15,-7},{-14,-1},{-7,7},{7,7},{14,-1},{15,-7}}, 
          color={0,0,255}, 
          smooth=Smooth.Bezier, 
          origin={-23,15}, 
          rotation=270), 
        Line(
          points={{-15,-7},{-14,-1},{-7,7},{7,7},{14,-1},{15,-7}}, 
          color={0,0,255}, 
          smooth=Smooth.Bezier, 
          origin={-23,-15}, 
          rotation=270), 
        Line(
          points={{-15,-7},{-14,-1},{-7,7},{7,7},{14,-1},{15,-7}}, 
          color={0,0,255}, 
          smooth=Smooth.Bezier, 
          origin={-23,-45}, 
          rotation=270), 
        Line(points={{-30,60},{-30,100}}, color={28,108,200}), 
        Line(points={{-30,-100},{-30,-60}}, color={28,108,200})}), 
    Documentation(info="<html>
<p>
与<a href=\"modelica://Modelica.Magnetic.FluxTubes.Basic.ElectroMagneticConverter\">ElectroMagneticConverter</a>在磁侧附加泄漏路径(漏电感，漏磁通)。这种模式可以提高稳定性，特别是当磁路包含多个电磁变换器时.
</p>
</html>"));
end ElectroMagneticConverterWithLeakageInductance;