within Modelica.Magnetic.FluxTubes.Basic;
model ElectroMagneticConverter "理想的电磁能量转换"

  FluxTubes.Interfaces.PositiveMagneticPort port_p "正磁端口" 
    annotation (Placement(transformation(extent={{90,90},{110,110}}), iconTransformation(extent={{90,90},{110,110}})));
  FluxTubes.Interfaces.NegativeMagneticPort port_n "负磁端口" 
    annotation (Placement(transformation(extent={{110,-110},{90,-90}}), iconTransformation(extent={{110,-110},{90,-90}})));
  Modelica.Electrical.Analog.Interfaces.PositivePin p "正电引脚" 
    annotation (Placement(transformation(extent={{-90,90},{-110,110}}), iconTransformation(extent={{-90,90},{-110,110}})));
  Modelica.Electrical.Analog.Interfaces.NegativePin n "负电引脚" 
    annotation (Placement(transformation(extent={{-110,-110},{-90,-90}}), iconTransformation(extent={{-110,-110},{-90,-90}})));
  SI.Voltage v "电压";
  SI.Current i(start=0, stateSelect=StateSelect.prefer) "电流";
  SI.MagneticPotentialDifference V_m "磁位差";
  SI.MagneticFlux Phi "磁通量耦合成磁路";

  parameter Real N=1 "转数";

  // 仅供参考:
  SI.MagneticFlux Psi "磁链";
  SI.Inductance L_stat "静态电感abs(Psi/i)";

protected
  Real eps=100*Modelica.Constants.eps;
equation
  v = p.v - n.v;
  0 = p.i + n.i;
  i = p.i;

  V_m = port_p.V_m - port_n.V_m;
  0 = port_p.Phi + port_n.Phi;
  Phi = port_p.Phi;

  // 转换器方程
  V_m = i*N "安培定律";
  N*der(Phi) = -v "法拉第定律";

  // 仅供参考
  Psi = N*Phi;
  // 使用abs()表示阳性结果;由于Modelica符号约定流入连接器
  L_stat = noEvent(if abs(i) > eps then abs(Psi/i) else abs(Psi/eps));

  annotation (
    defaultComponentName="converter", 
    Diagram(coordinateSystem(
        preserveAspectRatio=false, 
        extent={{-100,-100},{100,100}}), graphics={Polygon(
              points={{-136,103},{-126,100},{-136,97},{-136,103}}, 
              lineColor={160,160,164}, 
              fillColor={160,160,164}, 
              fillPattern=FillPattern.Solid),Line(points={{-152,100},{-127,100}}, 
                color={160,160,164}),Polygon(
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
              textString="i"),Line(points={{126,100},{151,100}}, color={160,160,164}), 
          Polygon(
          points={{136,103},{126,100},{136,97},{136,103}}, 
          lineColor={160,160,164}, 
          fillColor={160,160,164}, 
          fillPattern=FillPattern.Solid)}), 
    Icon(coordinateSystem(
      preserveAspectRatio=false, 
      extent={{-100,-100},{100,100}}), graphics={
      Text(
        extent={{-150,150},{150,110}}, 
        textColor={0,0,255}, 
        textString="%name"), 
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
电磁能量转换分别由<em>安培</em>定律和<em>法拉第</em>定律给出:
</p>

<blockquote><pre>
V<sub>m</sub> = N * i
N * d&Phi;/dt = -v
</pre></blockquote>

<div>
<img src=\"modelica://Modelica/Resources/Images/Magnetic/FluxTubes/Basic/converter_signs.png\" alt=\"converter signs\">
</div>

<p>
V<sub>m</sub>是由于通过线圈的电流i(安培定律)而施加到磁路上的磁电位差。
在电流i之间存在一个左赋值(把你的手放在线圈周围，手指指向电流的方向)。
磁位差V<sub>m</sub>(拇指).<br>
<strong>注释:</strong> 在通过线圈i(指)的电流和磁动势mmf之间存在一个右赋值。
mmf与V<sub>m</sub>方向相反，在Modelica中不使用.
</p>

<p>
对于整个磁路，在参考方向上以正确符号计数的所有磁位差之和等于零:sum(V<sub>m</sub>) = 0。<br>
磁通量&Phi;与磁电位差V<sub>m</sub>按等效欧姆定律:V<sub>m</sub> = R<sub>m</sub> * & φ有关;<br>
<strong>注释:</strong> 磁阻R<sub>m</sub>取决于几何形状和材料性质。对于铁磁材料，由于饱和，R<sub>m</sub>不是恒定的.
</p>

<p>
因此符号(实际方向)&;(通过变换器的磁通量)取决于磁路的相关支路。<br>
v是线圈中感应电压，这是由磁通量&Phi的导数引起的;(法拉第定律).<br>
<strong>注释:</strong> 感应电压v的负号是由于<em>Lenz</em>定律.
</p>

<p>
<strong>注释:</strong> 图像显示一个逆时针绕的线圈(正数学方向)。
如果必须对顺时针绕制的线圈进行建模，则参数N(匝数)可以设置为负值.
</p>

<p>
磁链&Psi;和静态电感L_stat = |&Psi;/i|仅供参考。注意，L_stat被设置为|&Psi;/eps| if |i| &lt;每股收益
(= 100 * Modelica.Constants.eps).
</p>
</html>"));
end ElectroMagneticConverter;