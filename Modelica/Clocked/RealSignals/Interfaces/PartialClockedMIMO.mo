within Modelica.Clocked.RealSignals.Interfaces;
partial block PartialClockedMIMO 
  "具有多个时钟输入和多个时钟输出实数信号的模块"
  extends Clocked.ClockSignals.Interfaces.ClockedBlockIcon;

  parameter Integer nin=1 "Number of inputs";
  parameter Integer nout=1 "Number of outputs";

  Modelica.Blocks.Interfaces.RealInput u[nin] 
    "时钟实数输入信号连接器" 
                               annotation (Placement(transformation(extent= 
          {{-140,-20},{-100,20}})));
  Modelica.Blocks.Interfaces.RealOutput y[nout] 
    "时钟实数输出信号连接器" 
                                annotation (Placement(transformation(extent= 
         {{100,-10},{120,10}})));
  annotation();

end PartialClockedMIMO;