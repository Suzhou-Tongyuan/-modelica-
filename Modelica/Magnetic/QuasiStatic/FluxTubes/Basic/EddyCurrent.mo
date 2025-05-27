within Modelica.Magnetic.QuasiStatic.FluxTubes.Basic;
model EddyCurrent 
"用于导电磁通管中涡流的建模"

  constant Complex j=Complex(0, 1);
  extends Interfaces.TwoPort;

  parameter Boolean useConductance = false 
  "用电导率代替几何数据和 rho" 
    annotation(Evaluate=true, HideResult=true, choices(checkBox=true));
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

  extends 
    Modelica.Thermal.HeatTransfer.Interfaces.PartialElementaryConditionalHeatPort(
      final T=273.15);

equation
  lossPower = (pi/2)*Modelica.ComplexMath.imag(omega*V_m* 
    Modelica.ComplexMath.conj(Phi));
  // 损耗功率的替代计算方法
  // lossPower = -(pi/2)*Modelica.ComplexMath.real(j*omega*V_m*Modelica.ComplexMath.conj(Phi));
  if G > 0 then
    (pi/2)*V_m = j*omega*Phi * (if useConductance then G else 1/R);
  else
    V_m = Complex(0, 0);
  end if;

  annotation (Icon(coordinateSystem(
      preserveAspectRatio=false, 
      extent={{-100,-100},{100,100}}), graphics={
      Line(points={{-70,0},{-90,0}}, color={255,170,85}), 
      Line(points={{70,0},{90,0}}, color={255,170,85}), 
      Rectangle(
          extent={{-70,30},{70,-30}}, 
          lineColor={255,170,85}, 
          fillColor={255,170,85}, 
          fillPattern=FillPattern.Solid), 
      Text(
        extent={{-150,50},{150,90}}, 
        textString="%name", 
        textColor={0,0,255})}), Documentation(info="<html>
<p>
当磁通量随时间变化时，导电磁通管中会产生涡流。除了磁通管的磁阻造成的电压降之外，这还会导致磁电压降。涡流分量可视为变压器中只有一匝的短路次级绕组。其电阻由涡流路径的几何形状和电阻率决定。或者，也可以使用总电导参数.
</p>

<p>
将一个固体导电圆柱体或棱镜分割成几个空心圆柱体或单独的嵌套棱镜，并对这些磁通管中的每一个进行建模，并将磁阻元件和涡流元件串联起来，可以模拟整个磁通管中从外部到内部部分的磁场延迟积累。请参考<a href=\"modelica://Modelica.Magnetic.FluxTubes.UsersGuide. Literature\">[Ka08]</a>的插图.
</p>
</html>", revisions="<html>
</html>"));
end EddyCurrent;