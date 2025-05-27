within Modelica.Mechanics.MultiBody.Examples.Systems.RobotR3.Utilities;
expandable connector ControlBus "机器人所有轴的数据总线"
  extends Modelica.Icons.SignalBus;
  Modelica.Mechanics.MultiBody.Examples.Systems.RobotR3.Utilities.AxisControlBus axisControlBus1 "轴1的数据总线";
  Modelica.Mechanics.MultiBody.Examples.Systems.RobotR3.Utilities.AxisControlBus axisControlBus2 "轴2的数据总线";
  Modelica.Mechanics.MultiBody.Examples.Systems.RobotR3.Utilities.AxisControlBus axisControlBus3 "轴3的数据总线";
  Modelica.Mechanics.MultiBody.Examples.Systems.RobotR3.Utilities.AxisControlBus axisControlBus4 "轴4的数据总线";
  Modelica.Mechanics.MultiBody.Examples.Systems.RobotR3.Utilities.AxisControlBus axisControlBus5 "轴5的数据总线";
  Modelica.Mechanics.MultiBody.Examples.Systems.RobotR3.Utilities.AxisControlBus axisControlBus6 "轴6的数据总线";

  annotation(
    Documentation(info = "<html>
<p>
信号总线用于通信机器人的<strong>所有信号</strong>。这是一个可扩展的连接器，具有一组\"默认\"信号。
请注意，该总线上的信号输入/输出因果关系是由与该总线的连接确定的。
</p>
</html>"));
end ControlBus;