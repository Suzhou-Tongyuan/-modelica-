within Modelica.Mechanics.MultiBody.Frames.Internal;
function maxWithoutEvent_dd 
  "函数maxWithoutEvent_d(..)的一阶导数"
  extends Modelica.Icons.Function;

  input Real u1;
  input Real u2;
  input Real u1_d;
  input Real u2_d;
  input Real u1_dd;
  input Real u2_dd;
  output Real y_dd;
algorithm
  y_dd := if u1 > u2 then u1_dd else u2_dd;
  annotation(
    Inline = true, Documentation(info = "<html>
<p>
这是函数
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.Internal.maxWithoutEvent_d\">maxWithoutEvent_d</a>
的导数，即函数
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.Internal.maxWithoutEvent\">maxWithoutEvent</a>
的二阶导数。
</p>
</html>"));
end maxWithoutEvent_dd;