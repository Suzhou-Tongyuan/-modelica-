within Modelica.ComplexBlocks.Interfaces;
partial block ComplexMI2MO 
  "2个多个输入/多个输出连续控制模块"
  extends Modelica.ComplexBlocks.Icons.ComplexBlock;
  parameter Integer n = 1 "输入和输出向量的维度";
  ComplexInput u1[n] "复合输入信号的连接器1" annotation(
    Placement(transformation(extent = {{-140, 40}, {-100, 80}})));
  ComplexInput u2[n] "复合输入信号的连接器2" annotation(
    Placement(transformation(extent = {{-140, -80}, {-100, -40}})));
  ComplexOutput y[n] "复合输出信号的连接器" annotation(
    Placement(transformation(extent = {{100, -10}, {120, 10}})));

  parameter Boolean useConjugateInput1[n] = fill(false, n) 
    "如果为真，则处理输入1的共轭复数";
  parameter Boolean useConjugateInput2[n] = fill(false, n) 
    "如果为真，则处理输入2的共轭复数";
protected
  Complex u1Internal[n] = {if useConjugateInput1[k] then 
    Modelica.ComplexMath.conj(u1[k]) else u1[k] for k in 1:n} 
    "如果 useComplexInput = true，则等于 u1 或 u1 的共轭复数输入";
  Complex u2Internal[n] = {if useConjugateInput2[k] then 
    Modelica.ComplexMath.conj(u2[k]) else u2[k] for k in 1:n} 
    "如果 useComplexInput = true，则等于 u1 或 u1 的共轭复数输入";

  annotation(Documentation(info = "<html>
<p>
该模块具有两个连续复数类型的输入向量u1和u2，以及一个连续复数类型的输出向量y。
所有向量的元素数量相同。
</p>
</html>"));
end ComplexMI2MO;