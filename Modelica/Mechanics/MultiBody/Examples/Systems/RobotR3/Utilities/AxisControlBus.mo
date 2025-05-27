within Modelica.Mechanics.MultiBody.Examples.Systems.RobotR3.Utilities;
expandable connector AxisControlBus "单个机器人轴的数据总线"
  extends Modelica.Icons.SignalSubBus;

  Boolean motion_ref "= true, 如果参考运动不是静止状态" annotation(HideResult = false);
  SI.Angle angle_ref "轴的一维接口的参考角度" annotation(HideResult = false);
  SI.Angle angle "轴的一维接口的角度" annotation(HideResult = false);
  SI.AngularVelocity speed_ref "轴的一维接口的参考速度" annotation(HideResult = false);
  SI.AngularVelocity speed "轴的一维接口的的速度" annotation(HideResult = false);
  SI.AngularAcceleration acceleration_ref 
    "轴的一维接口的的参考加速度" annotation(HideResult = false);
  SI.AngularAcceleration acceleration "轴的一维接口的的加速度" annotation(HideResult = false);
  SI.Current current_ref "电机的参考电流" annotation(HideResult = false);
  SI.Current current "电机的电流" annotation(HideResult = false);
  SI.Angle motorAngle "电机一维接口的角度" annotation(HideResult = false);
  SI.AngularVelocity motorSpeed "电机一维接口的速度" annotation(HideResult = false);

  annotation(defaultComponentPrefixes = "protected", 
    Documentation(info = "<html>
<p>
信号总线用于<strong>一个</strong>轴的所有信号通信。这是一个可扩展的连接器，具有一组\"默认\"信号。
请注意，该总线上的信号输入/输出因果关系是由与该总线的连接确定的。
</p>

</html>"));
end AxisControlBus;