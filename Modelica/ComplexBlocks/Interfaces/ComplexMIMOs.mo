within Modelica.ComplexBlocks.Interfaces;
partial block ComplexMIMOs 
  "具有相同数量输入和输出的多输入多输出连续控制模块"
  extends Modelica.ComplexBlocks.Icons.ComplexBlock;
  parameter Integer n=1 "输入数量 (= 输出数量)";
  ComplexInput u[n] "复合输入信号的连接器" annotation (
      Placement(transformation(extent={{-140,-20},{-100,20}})));
  ComplexOutput y[n] "复合输出信号的连接器" annotation (
      Placement(transformation(extent={{100,-10},{120,10}})));

  parameter Boolean useConjugateInput[n]=fill(false, n) 
    "如果为真，则处理输入的共轭复数";
protected
  Complex uInternal[n]={if useConjugateInput[k] then 
      Modelica.ComplexMath.conj(u[k]) else u[k] for k in 1:n} 
    "如果 useComplexInput = true，则等于 u 或 u 的共轭复数输入";

  annotation (Documentation(info="<html>
<p>
该模块具有一个连续复数类型的输入信号向量和一个连续复数类型的输出信号向量，且输入向量和输出向量的信号大小相同。
</p>
</html>"));
end ComplexMIMOs;