within Modelica.ComplexBlocks.Interfaces;
partial block ComplexMO "多路输出连续控制模块"
  extends Modelica.ComplexBlocks.Icons.ComplexBlock;
  parameter Integer nout(min=1) = 1 "输出数量";
  ComplexOutput y[nout] "复数输出信号连接器" annotation (
      Placement(transformation(extent={{100,-10},{120,10}})));
  annotation (Documentation(info="<html>
<p>
该模块具有多个连续复数类型的输出信号向量。
</p>
</html>"));
end ComplexMO;