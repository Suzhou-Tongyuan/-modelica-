within Modelica.Electrical.QuasiStatic.SinglePhase.Sources;
model VariableVoltageSource "可变交流电压"
  extends Interfaces.Source;
  Modelica.Blocks.Interfaces.RealInput f(unit="Hz") annotation (Placement(
        transformation(
        origin={60,120}, 
        extent={{-20,-20},{20,20}}, 
        rotation=270)));
  Modelica.ComplexBlocks.Interfaces.ComplexInput V annotation (Placement(
        transformation(
        origin={-60,120}, 
        extent={{-20,-20},{20,20}}, 
        rotation=270)));
equation
  omega = 2*Modelica.Constants.pi*f;
  v = V;
  annotation (defaultComponentName="voltageSource", 
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100, 
            -100},{100,100}}), graphics={
        Line(points={{-50,0},{50,0}}, color={85,170,255}), 
        Line(points={{-70,30},{-70,10}}, color={85,170,255}), 
        Line(points={{-80,20},{-60,20}}, color={85,170,255}), 
        Line(points={{60,20},{80,20}}, color={85,170,255})}), 
                                         Documentation(info="<html>

<p>
这是一个带有复信号输入的电压源，通过复有效值电压分量来指定复电压。
此外，电压源的频率由实信号输入定义。
</p>

<h4>另请参阅</h4>

<p>
<a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Sources.VoltageSource\">VoltageSource</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Sources.CurrentSource\">CurrentSource</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Sources.VariableCurrentSource\">VariableCurrentSource</a>
</p>
</html>"));
end VariableVoltageSource;