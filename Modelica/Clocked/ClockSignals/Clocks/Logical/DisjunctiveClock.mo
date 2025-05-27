within Modelica.Clocked.ClockSignals.Clocks.Logical;
block DisjunctiveClock 
  "逻辑时钟在任何输入时钟信号跳变时触发"
  extends PartialLogicalClock(
    redeclare Modelica.Blocks.MathBoolean.Or combinator);

  annotation (
    Icon(graphics={
      Text(
        extent = {{-60,60},{60,-60}}, 
        textColor = {217,67,180}, 
        textStyle = {TextStyle.Bold}, 
        textString = "∨")}), 
    Documentation(info="<html>
对于一个简单的例子，请参见
<a href=\"modelica://Modelica.Clocked.Examples.Elementary.ClockSignals.LogicalSample\">logical sampling example</a>.
</html>"));
end DisjunctiveClock;