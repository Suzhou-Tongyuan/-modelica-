within Modelica.Electrical.QuasiStatic.Polyphase.Sources;
model ReferenceCurrentSource 
  "带有参考角度输入的可变多相交流电流源"
  extends Interfaces.ReferenceSource;
  import Modelica.Constants.pi;
  Modelica.Blocks.Interfaces.RealInput gamma 
    "电流源的参考角度" annotation (Placement(
        transformation(
        origin={40,100}, 
        extent={{-20,-20},{20,20}}, 
        rotation=270), iconTransformation(
        extent={{-20,-20},{20,20}}, 
        rotation=270, 
        origin={60,120})));
  Modelica.ComplexBlocks.Interfaces.ComplexInput I[m] annotation (Placement(
        transformation(
        origin={-40,100}, 
        extent={{-20,-20},{20,20}}, 
        rotation=270), iconTransformation(
        extent={{-20,-20},{20,20}}, 
        rotation=270, 
        origin={-60,120})));
equation
  plug_p.reference.gamma = gamma;
  i = I;
  annotation (
    defaultComponentName="currentSource", 
    Icon(graphics={Line(points={{0,-50},{0,50}}, color={85,170,255}), 
          Polygon(
          points={{90,0},{60,10},{60,-10},{90,0}}, 
          lineColor={85,170,255}, 
          fillColor={85,170,255}, 
          fillPattern=FillPattern.Solid)}), 
    Documentation(info="<html>

<p>
该模型描述了 <em>m</em> 个可变电流源，具有 <em>m</em> 个复信号输入，
通过复有效值电压分量指定复电流。
此外，电流源的频率由实信号输入定义。
使用了 <em>m</em> 个<a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Sources.VariableCurrentSource\">单相VariableCurrentSources</a>。
</p>

<h4>另请参阅</h4>

<p>
<a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Sources.VoltageSource\">SinglePhase.VoltageSource</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.Polyphase.Sources.VoltageSource\">VoltageSource</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.Polyphase.Sources.VariableVoltageSource\">VariableVoltageSource</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.Polyphase.Sources.CurrentSource\">CurrentSource</a>.
</p>
</html>"));
end ReferenceCurrentSource;