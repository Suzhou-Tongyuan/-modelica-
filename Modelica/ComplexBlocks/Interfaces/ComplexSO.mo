within Modelica.ComplexBlocks.Interfaces;
partial block ComplexSO "单输出连续控制模块"
  extends Modelica.ComplexBlocks.Icons.ComplexBlock;
  ComplexOutput y "复数输出信号连接器" annotation (
      Placement(transformation(extent={{100,-10},{120,10}})));
  annotation (Documentation(info="<html>
<p>
该模块具有一个连续的复数输出信号。
</p>
</html>"));
end ComplexSO;