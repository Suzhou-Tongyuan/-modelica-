within Modelica.Clocked.IntegerSignals.Interfaces;
partial block PartialClockedSO 
  "带时钟单输出整数信号的模块"
  extends Clocked.ClockSignals.Interfaces.ClockedBlockIcon;

  Modelica.Blocks.Interfaces.IntegerOutput y 
    "时钟、实数输出信号连接器" 
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));
  annotation();

end PartialClockedSO;