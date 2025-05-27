within Modelica.Magnetic.FluxTubes.Basic;
model EddyCurrent 
  "用于导电磁通管中涡流的建模"

  extends Interfaces.TwoPort;
  extends Modelica.Electrical.Analog.Interfaces.ConditionalHeatPort(
    final T=273.15);

  parameter Boolean useConductance = false 
    "用电导率代替几何数据和 rho" 
    annotation(Evaluate=true, choices(checkBox=true));
  parameter SI.Conductance G(min=0) = 1/0.098e-6 
    "等效损耗电导 G=A/rho/l" 
    annotation(Dialog(enable=useConductance),Evaluate=true);
  parameter SI.Resistivity rho=0.098e-6 
    "通量管材料的电阻率（默认值：20 摄氏度时为铁）" 
    annotation(Dialog(enable=not useConductance));
  parameter SI.Length l=1 "涡流路径的平均长度" 
    annotation(Dialog(enable=not useConductance));
  parameter SI.Area A=1 "涡流路径横截面积" 
    annotation(Dialog(enable=not useConductance));

  final parameter SI.Resistance R=rho*l/A 
    "涡流路径的电阻" 
    annotation(Dialog(enable=not useConductance));

equation
  LossPower = V_m*der(Phi);
  V_m =(if useConductance then G else 1/R) * der(Phi);
  //涡流导致的磁性网络中的磁电压降
  annotation (Icon(coordinateSystem(
      preserveAspectRatio=false, 
      extent={{-100,-100},{100,100}}), graphics={
      Rectangle(
        extent={{-70,30},{70,-30}}, 
        lineColor={255,128,0}, 
        fillColor={255,255,255}, 
        fillPattern=FillPattern.Solid), 
      Line(points={{-70,0},{-90,0}}, color={255,128,0}), 
      Line(points={{70,0},{90,0}}, color={255,128,0}), 
      Rectangle(
        extent={{-70,30},{70,-30}}, 
        lineColor={255,128,0}, 
        fillColor={255,128,0}, 
        fillPattern=FillPattern.Solid), 
      Text(
        extent={{-150,50},{150,90}}, 
        textString="%name", 
        textColor={0,0,255})}), Documentation(info="<html>
<p>
当磁通量随时间变化时，导电磁通管中会产生涡流。除了磁通管的磁阻造成的电压降之外，这还会导致磁电压降。涡流分量可视为变压器只有一匝的短路次级绕组。其电阻可根据涡流路径的几何形状和电阻率计算得出.
</p>

<p>
将一个固体导电圆柱体或棱镜分割成几个空心圆柱体或单独的嵌套棱镜，并对这些磁通管中的每一个进行建模，并将磁阻元件和涡流元件串联起来，可以模拟整个磁通管中从外部到内部部分的磁场延迟积累。请参考<a href=\"modelica://Modelica.Magnetic.FluxTubes.UsersGuide.Literature\">[Ka08]</a>的插图.
</p>
</html>", revisions="<html>
<h5>Version 3.2.2, 2014-01-15 (Christian&nbsp;Kral)</h5>
<ul>
<li>增加参数<code>useConductance</code>包括可选参数</li>
</ul>
</html>"));
end EddyCurrent;