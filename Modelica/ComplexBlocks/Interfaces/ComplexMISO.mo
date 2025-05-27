within Modelica.ComplexBlocks.Interfaces;
partial block ComplexMISO 
  "多输入单输出连续控制模块"
  extends Modelica.ComplexBlocks.Icons.ComplexBlock;
  parameter Integer nin=1 "输入数量";
  ComplexInput u[nin] "复数输入信号的连接器" annotation (
      Placement(transformation(extent={{-140,-20},{-100,20}})));
  ComplexOutput y "复数输出信号的连接器" annotation (
      Placement(transformation(extent={{100,-10},{120,10}})));

  parameter Boolean useConjugateInput[nin]=fill(false, nin) 
    "如果为真，则处理输入的共轭复数";
protected
  Complex uInternal[nin]={if useConjugateInput[k] then 
      Modelica.ComplexMath.conj(u[k]) else u[k] for k in 1:nin} 
    "如果 useComplexInput = true，则等于 u 或 u 的共轭复数输入";

  annotation (Documentation(info="<html>
<p>
该模块具有一个连续复数类型输入信号的向量，以及一个连续复数类型的输出信号。
</p>
</html>"));
end ComplexMISO;