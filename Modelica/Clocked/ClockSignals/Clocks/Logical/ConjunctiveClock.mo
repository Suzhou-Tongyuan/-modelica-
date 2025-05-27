within Modelica.Clocked.ClockSignals.Clocks.Logical;
block ConjunctiveClock 
  "逻辑时钟在所有输入时钟至少一次跳变时触发，然后重置并开始下一个联结周期"
  extends PartialLogicalClock(
    redeclare Modelica.Blocks.MathBoolean.And combinator);

  annotation (
    Icon(graphics={
      Text(
        extent = {{-60,60},{60,-60}}, 
        textColor = {217,67,180}, 
        textStyle = {TextStyle.Bold}, 
        textString = "∧")}), 
    Documentation(info="<html>
对于一个简单的例子，请参见
<a href=\"modelica://Modelica.Clocked.Examples.Elementary.ClockSignals.LogicalSample\">logical sampling example</a>.
</html>"));
end ConjunctiveClock;