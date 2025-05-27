within Modelica.Clocked.ClockSignals.Clocks;
block PeriodicRealClock 
  "生成周期由实数定义的周期时钟信号"
  parameter SI.Time period 
    "时钟周期（定义为实数）" annotation(Evaluate=true);
  extends Clocked.ClockSignals.Interfaces.PartialPeriodicClock;
equation
  if useSolver then
     y = Clock(Clock(period), solverMethod=solverMethod);
  else
     y = Clock(period);
  end if;

  annotation (
     defaultComponentName="periodicClock1", 
    Icon(coordinateSystem(preserveAspectRatio=true,  extent={{-100,-100},{100,100}}, initialScale=0.06), 
                    graphics={
        Rectangle(
          extent={{20,58},{40,46}}, 
          fillPattern=FillPattern.Solid, 
          rotation=45, 
          origin={-50,-120}, 
          lineColor={95,95,95}, 
          fillColor={95,95,95}), 
        Rectangle(
          extent={{20,58},{40,46}}, 
          fillPattern=FillPattern.Solid, 
          rotation=90, 
          origin={52,60}, 
          pattern=LinePattern.None, 
          fillColor={95,95,95}), 
        Text(
          extent={{-150,-110},{150,-150}}, 
          textColor={0,0,0}, 
          textString="%period"), 
        Text(
          visible=useSolver, 
          extent={{-150,-160},{150,-200}}, 
          textColor={0,0,0}, 
          textString="%solverMethod")}), 
    Documentation(info="<html><p style=\"text-align: start;\">该组件生成一个周期性时钟，在仿真开始时开始计时。<strong>周期</strong>通过一个<strong>实数</strong>定义，单位为秒。如果时钟之间是相对同步的，则只能使用 PeriodicRealClock 定义其中一个时钟。
</p>
<p style=\"text-align: start;\">有关时钟的介绍，请参阅<a href=\"modelica://Modelica.Clocked.UsersGuide.Clocks\" target=\"\">UsersGuide.Clocks</a>&nbsp;。如果需要精确的基于整数的时间同步，并且定义绝对周期，请使用 &nbsp;<a href=\"modelica://Modelica.Clocked.ClockSignals.Clocks.PeriodicExactClock\" target=\"\">PeriodicExactClock</a>&nbsp; 块生成周期性时钟信号。
</p>
<p style=\"text-align: start;\">如果时钟与连续时间分区相关联，则必须定义一个<strong>积分器</strong>，用于将分区从上一个时钟滴答整合到当前时钟滴答。这通过设置参数 <strong>useSolver</strong> = <strong>true</strong> &nbsp;并将积分方法定义为字符串形式的参数<strong> solver</strong> 来实现。两个参数都位于<strong>高级</strong>选项卡中。有关示例，请参阅 <a href=\"modelica://Modelica.Clocked.Examples.Systems.ControlledMixingUnit\" target=\"\">Examples.Systems.ControlledMixingUnit</a>&nbsp;。
</p>
</html>"));
end PeriodicRealClock;