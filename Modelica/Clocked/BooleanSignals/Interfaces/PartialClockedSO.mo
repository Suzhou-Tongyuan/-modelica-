within Modelica.Clocked.BooleanSignals.Interfaces;
partial block PartialClockedSO 
  "时钟单输出布尔信号模块"
  extends Clocked.ClockSignals.Interfaces.ClockedBlockIcon;

  Modelica.Blocks.Interfaces.BooleanOutput y 
    "时钟、实数输出信号连接器" 
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));
  annotation();

end PartialClockedSO;