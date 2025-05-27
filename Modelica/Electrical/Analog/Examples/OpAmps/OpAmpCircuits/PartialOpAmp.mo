within Modelica.Electrical.Analog.Examples.OpAmps.OpAmpCircuits;
partial model PartialOpAmp 
  "运算放大器部分电路"
  extends Modelica.Electrical.Analog.Interfaces.FourPin;
  parameter SI.Voltage Vps=+15 "正极输入";
  parameter SI.Voltage Vns=-15 "负极输入";
  parameter Real V0=15000.0 "空载放大";
  Ideal.IdealizedOpAmpLimited opAmp(
    V0=V0, 
    final useSupply=false, 
    final Vps=Vps, 
    final Vns=Vns, 
    out(i(start=0, fixed=false))) 
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Text(
          extent={{-150,150},{150,110}}, 
          textString="%name", 
          textColor={0,0,255}), Polygon(
          points={{-60,70},{70,0},{-60,-72},{-60,70}}, 
          lineColor={0,0,255}, 
          fillColor={255,255,255}, 
          fillPattern=FillPattern.Solid)}),    Documentation(info="<html>
<p>基于<a href=\"modelica://Modelica.Electrical.Analog.Ideal.IdealizedOpAmpLimited\">IdealizedOpAmpLimited</a>的运算放大器电路部分模型。
通过不同的电路可以实现不同的功能。
</p>
</html>"));
end PartialOpAmp;