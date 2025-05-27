within Modelica.Electrical.QuasiStatic.Polyphase.Sources;
model ReferenceVoltageSource 
  "带有参考角度输入的可变多相交流电压源"
  extends Interfaces.ReferenceSource;
  import Modelica.Constants.pi;
  Modelica.Blocks.Interfaces.RealInput gamma 
    "电压源的参考角度" annotation (Placement(
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
  plug_p.reference.gamma = gamma;
  v = V;
  annotation (
    defaultComponentName="voltageSource", Documentation(info="<html>

<p>
该模型描述了 <em>m</em> 个可变电压源，具有 <em>m</em> 个复信号输入，通过复有效值电压分量来指定复电压。
此外，电压源的频率由一个实信号输入定义。
使用了 <em>m</em> 个<a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Sources.VariableCurrentSource\">单相VariableCurrentSources</a>。
</p>

<h4>另请参阅</h4>

<p>
<a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Sources.VoltageSource\">SinglePhase.VoltageSource</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.Polyphase.Sources.VoltageSource\">VoltageSource</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.Polyphase.Sources.VariableVoltageSource\">VariableVoltageSource</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.Polyphase.Sources.CurrentSource\">CurrentSource</a>.
</p>
</html>"), 
       Icon(graphics={
        Line(points={{-70,30},{-70,10}}, color={85,170,255}), 
        Line(points={{-80,20},{-60,20}}, color={85,170,255}), 
        Line(points={{60,20},{80,20}}, color={85,170,255}), 
        Line(points={{-50,0},{50,0}},  color={85,170,255})}));
end ReferenceVoltageSource;