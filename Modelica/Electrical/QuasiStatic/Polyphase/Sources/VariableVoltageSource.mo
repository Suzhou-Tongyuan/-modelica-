within Modelica.Electrical.QuasiStatic.Polyphase.Sources;
model VariableVoltageSource "可变多相交流电压源"
  extends Interfaces.Source;
  Modelica.Blocks.Interfaces.RealInput f(unit="Hz") annotation (Placement(
        transformation(
        origin={60,120}, 
        extent={{-20,-20},{20,20}}, 
        rotation=270)));
  Modelica.ComplexBlocks.Interfaces.ComplexInput V[m] annotation (Placement(
        transformation(
        origin={-60,120}, 
        extent={{-20,-20},{20,20}}, 
        rotation=270)));
equation
  omega = 2*Modelica.Constants.pi*f;
  v = V;
  annotation (defaultComponentName="voltageSource", 
    Icon(graphics={
        Line(points={{-50,0},{50,0}}, color={85,170,255}), 
        Line(points={{-70,30},{-70,10}}, color={85,170,255}), 
        Line(points={{-80,20},{-60,20}}, color={85,170,255}), 
        Line(points={{60,20},{80,20}}, color={85,170,255})}), 
                                 Documentation(info="<html>

<p>
该模型描述了 <em>m</em> 个可变电压源，具有 <em>m</em> 个复信号输入，通过复有效值电压分量来指定复电压。
此外，电压源的频率由一个实信号输入定义。
使用了 <em>m</em> 个<a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Sources.VariableVoltageSource\">单相VariableVoltageSources</a>。
</p>

<h4>另请参阅</h4>

<p>
<a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Sources.VoltageSource\">SinglePhase.VoltageSource</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.Polyphase.Sources.VoltageSource\">VoltageSource</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.Polyphase.Sources.CurrentSource\">CurrentSource</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.Polyphase.Sources.VariableCurrentSource\">VariableCurrentSource</a>
</p>
</html>"));
end VariableVoltageSource;