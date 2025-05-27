within Modelica.ComplexBlocks.Interfaces;
partial block ComplexSI2SO 
  "2个单输入/1 个单输出连续控制模块"
  extends Modelica.ComplexBlocks.Icons.ComplexBlock;
  ComplexInput u1 "复数输入信号的连接器1" annotation (
      Placement(transformation(extent={{-140,40},{-100,80}})));
  ComplexInput u2 "复数输入信号出连接器2" annotation (
      Placement(transformation(extent={{-140,-80},{-100,-40}})));
  ComplexOutput y "复数输入信号的连接器" annotation (
      Placement(transformation(extent={{100,-10},{120,10}})));
  parameter Boolean useConjugateInput1=false 
    "如果为真，则处理输入1的共轭复数";
  parameter Boolean useConjugateInput2=false 
    "如果为真，则处理输入2的共轭复数";
protected
  Complex u1Internal=(if useConjugateInput1 then Modelica.ComplexMath.conj(
      u1) else u1) 
    "如果 useComplexInput1 = true，则等于 u1 或共轭复数输入 u1";
  Complex u2Internal=(if useConjugateInput2 then Modelica.ComplexMath.conj(
      u2) else u2) 
    "如果 useComplexInput2 = true，则等于 u2 或共轭复数输入 u2";
  annotation (Documentation(info="<html>
<p>
该模块具有两个连续复数类型的输入信号u1和u2，以及一个连续复数类型的输出信号y。
</p>
</html>"));
end ComplexSI2SO;