within Modelica.Mechanics.Translational.Sources;
model Force 
  "作为输入信号的驱动传动元件上的外部力"
  extends Modelica.Mechanics.Translational.Interfaces.PartialElementaryOneFlangeAndSupport2;
  Modelica.Blocks.Interfaces.RealInput f(unit="N") 
    "驱动力作为输入信号" annotation (Placement(transformation(
          extent={{-140,-20},{-100,20}})));

equation
  flange.f = -f;

  annotation (
    Documentation(info="<html>
<p>
输入信号 \"f\" 单位为 [N]，表示作用在一维平动接口上的 <em>外部力</em>（正号），即，连接到一维平动接口的组件受到力 f 的驱动。
</p>
<p>
输入信号 f 可以来自 Modelica.Blocks.Source 块库中的信号生成器块之一。
</p>
</html>"), 
    Icon(
      coordinateSystem(
        preserveAspectRatio=true, 
        extent={{-100,-100},{100,100}}), 
      graphics={
        Line(points={{0,-60},{0,-101}}, color={0,127,0}), 
        Polygon(
          points={{-100,10},{20,10},{20,41},{90,0},{20,-41},{20,-10},{-100,-10},{-100,10}}, 
          lineColor={0,127,0}, 
          fillColor={160,215,160}, 
          fillPattern=FillPattern.Solid), 
        Text(
          extent={{-150,-32},{-80,-62}}, 
          textString="f"), 
        Text(
          extent={{-150,90},{150,50}}, 
          textString="%name", 
          textColor={0,0,255}), 
        Polygon(
          points={{50,-54},{-30,-54},{-30,-46},{-60,-60},{-30,-74},{-30,-66},{50,-66},{50,-54}}, 
          lineColor={0,127,0}, 
          fillColor={160,215,160}, 
          fillPattern=FillPattern.Solid)}));
end Force;