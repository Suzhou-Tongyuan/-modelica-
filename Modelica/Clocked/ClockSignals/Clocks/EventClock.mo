within Modelica.Clocked.ClockSignals.Clocks;
block EventClock 
  "当布尔输入从假变为真时产生时钟信号"
  extends Clocked.ClockSignals.Interfaces.PartialClock;
  Modelica.Blocks.Interfaces.BooleanInput u 
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
equation
  if useSolver then
     y = Clock(Clock(u), solverMethod=solverMethod);
  else
     y = Clock(u);
  end if;

  annotation (
    Icon(coordinateSystem(preserveAspectRatio=true,  extent={{-100,-100},{100,100}}, initialScale=0.06), 
                    graphics={
        Text(
          visible=useSolver, 
          extent={{-150,-110},{150,-150}}, 
          textColor={0,0,0}, 
          textString="%solverMethod")}), 
    Documentation(info="<html><p>
这个组件生成一个时钟信号， 由连续时间的布尔输入信号 u 触发： 每当布尔输入信号 <strong>u</strong> 从 <strong>false</strong> 变为 <strong>true</strong> 时， 输出的时钟信号 <strong>y</strong> 就会滴答计时。
</p>
<p>
有关时钟的介绍请参阅 <a href=\"modelica://Modelica.Clocked.UsersGuide.Clocks\" target=\"\">UsersGuide.Clocks</a>&nbsp;.
</p>
<p>
如果时钟与时钟连续时间分区相关联， 则必须定义一个 <strong>积分器</strong>， 用于从上一个时钟刻度到当前时钟刻度对分区进行积分。 具体方法是设置参数 <strong>useSolver</strong> = <strong>true</strong>， 并使用参数 <strong>solver</strong> 将积分方法定义为字符串。 这两个参数都在 “<strong>高级</strong>“选项卡中。示例请参见 <a href=\"modelica://Modelica.Clocked.Examples.Systems.ControlledMixingUnit\" target=\"\">Examples.Systems.ControlledMixingUnit</a>&nbsp;.
</p>
</html>"));
end EventClock;