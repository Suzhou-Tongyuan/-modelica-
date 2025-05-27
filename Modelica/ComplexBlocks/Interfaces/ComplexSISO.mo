within Modelica.ComplexBlocks.Interfaces;
partial block ComplexSISO 
  "单输入单输出连续控制模块"
  extends Modelica.ComplexBlocks.Icons.ComplexBlock;
  ComplexInput u "复数输入信号的连接器" annotation(Placement(
    transformation(extent = {{-140, -20}, {-100, 20}})));
  ComplexOutput y "复数输出信号的连接器" annotation(
    Placement(transformation(extent = {{100, -10}, {120, 10}})));
  parameter Boolean useConjugateInput = false 
    "如果为真，则处理输入的共轭复数";
protected
  Complex uInternal = (if useConjugateInput then Modelica.ComplexMath.conj(u) 
    else u) 
    "如果 useComplexInput = true，则等于 u 或共轭复数输入 u";
  annotation(Documentation(info = "<html>
<p>
该模块具有一个连续复数类型的输入信号和一个连续复数类型的输出信号。
</p>
</html>"));
end ComplexSISO;