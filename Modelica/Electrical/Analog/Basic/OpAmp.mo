within Modelica.Electrical.Analog.Basic;
model OpAmp "有限制条件的非理想运算放大器模型"
  parameter Real Slope(start=10000) 
    "零输入增益";
  Modelica.Electrical.Analog.Interfaces.PositivePin in_p 
    "输入端口的正极引脚" annotation (Placement(transformation(
          extent={{-110,-70},{-90,-50}}), iconTransformation(extent={{-110,-70},{-90,-50}})));
  Modelica.Electrical.Analog.Interfaces.NegativePin in_n 
    "输入端口的负极引脚" annotation (Placement(transformation(
          extent={{-90,50},{-110,70}}), iconTransformation(extent={{-90,50},{-110,70}})));
  Modelica.Electrical.Analog.Interfaces.PositivePin out "输出引脚" 
    annotation (Placement(transformation(extent={{110,-10},{90,10}}), iconTransformation(extent={{110,-10},{90,10}})));
  Modelica.Electrical.Analog.Interfaces.PositivePin VMax 
    "正向输出电压限制" annotation (Placement(transformation(
          extent={{-10,90},{10,110}}), iconTransformation(extent={{-10,90},{10,110}})));
  Modelica.Electrical.Analog.Interfaces.NegativePin VMin 
    "负向输出电压限制" annotation (Placement(transformation(
          extent={{-10,-110},{10,-90}}), iconTransformation(extent={{-10,-110},{10,-90}})));
  SI.Voltage vin "输入电压";
protected
  Real f "辅助变量";
  Real absSlope;
equation
  in_p.i = 0;
  in_n.i = 0;
  VMax.i = 0;
  VMin.i = 0;
  vin = in_p.v - in_n.v;
  f = 2/(VMax.v - VMin.v);
  absSlope = if (Slope < 0) then -Slope else Slope;
  out.v = (VMax.v + VMin.v)/2 + absSlope*vin/(1 + absSlope*smooth(0, (if (f* 
    vin < 0) then -f*vin else f*vin)));
  annotation (
    Documentation(info="<html>
<p>运算放大器(OpAmp)是一个简单的非理想模型，具有平滑的输出特性曲线out.v=f(vin)，其中“vin=in_p.v-in_n.v”。该特性受到VMax.v和VMin.v的限制。在vin=0处的斜率是参数Slope，它必须为正。(因此，在计算中采用了Slope的绝对值)</p>
</html>", 
        revisions="<html>
<ul>
<li><em> 2000   </em>
       Christoph Clauss<br>创建<br>
       </li>
</ul>

</html>"), 
    Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100, 
            100}}), graphics={
        Polygon(
          points={{70,0},{-70,80},{-70,-80},{70,0}}, 
          fillColor={255,255,255}, 
          fillPattern=FillPattern.Solid, 
          lineColor={0,0,255}), 
        Line(points={{-45,-10},{-20,-10},{-14,-9},{-11,-7},{-9,7},{-6,9},{0, 
              10},{20,10}}, color={0,0,255}), 
        Line(points={{0,40},{0,100}}, color={0,0,255}), 
        Line(points={{0,-40},{0,-100}}, color={0,0,255}), 
        Line(points={{-100,60},{-70,60}}, color={0,0,255}), 
        Line(points={{-100,-60},{-70,-60}}, color={0,0,255}), 
        Line(points={{70,0},{100,0}}, color={0,0,255}), 
        Line(points={{-58,50},{-38,50}}, color={0,0,255}), 
        Line(points={{-49,-40},{-49,-61}}, color={0,0,255}), 
        Line(points={{-60,-51},{-38,-51}}, color={0,0,255}), 
        Text(
          extent={{-150,150},{150,110}}, 
          textString="%name", 
          textColor={0,0,255})}));
end OpAmp;