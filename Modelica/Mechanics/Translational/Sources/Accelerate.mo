within Modelica.Mechanics.Translational.Sources;
model Accelerate 
  "根据加速度信号强制移动一维平动接口"
  extends 
    Modelica.Mechanics.Translational.Interfaces.PartialElementaryOneFlangeAndSupport2(
    s(start=0, 
      fixed=true, 
      stateSelect=StateSelect.prefer));
  SI.Velocity v(
    start=0, 
    fixed=true, 
    stateSelect=StateSelect.prefer) "一维平动接口的绝对速度";
  SI.Acceleration a "一维平动接口的绝对加速度";

  Modelica.Blocks.Interfaces.RealInput a_ref(unit="m/s2") 
    "一维平动接口的绝对加速度作为输入信号" annotation (Placement(
        transformation(extent={{-140,-20},{-100,20}})));

equation
  v = der(s);
  a = der(v);
  a = a_ref;

  annotation (
    Documentation(info="<html>
<p>
输入信号 <strong>a</strong>，单位为 [m/s2]，以预定义的 <em>加速度</em> 移动 1D 平移一维平动接口连接器，
即，一维平动接口被强制相对于支撑连接器以此加速度移动。一维平动接口的速度和位置也是预定义的，并由加速度的积分确定。
</p>
<p>
加速度 \"a(t)\" 可以来自 Modelica.Blocks.Source 块库中的信号生成器块之一。
</p>

</html>"), 
    Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,100}}), 
      graphics={
        Line(points={{-30,-32},{30,-32}}, color={0,127,0}), 
        Line(points={{0,-32},{0,-100}}, color={0,127,0}), 
        Rectangle(
          extent={{-100,20},{100,-20}}, 
          lineColor={0,127,0}, 
          fillColor={160,215,160}, 
          fillPattern=FillPattern.Solid), 
        Line(points={{-29,32},{30,32}}, color={0,127,0}), 
        Line(points={{0,52},{0,32}}, color={0,127,0}), 
        Text(extent={{150,60},{-150,100}}, 
          textString="%name", 
          textColor={0,0,255}), 
        Text(extent={{-140,-60},{-40,-30}}, 
          textColor={128,128,128}, 
          horizontalAlignment=TextAlignment.Right, 
          textString="a_ref")}));
end Accelerate;