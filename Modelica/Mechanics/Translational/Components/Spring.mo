within Modelica.Mechanics.Translational.Components;
model Spring "一维线性平动弹簧"
  extends Translational.Interfaces.PartialCompliant;
  parameter SI.TranslationalSpringConstant c(final min=0, start=1) 
    "弹簧刚度系数";
  parameter SI.Distance s_rel0=0 "未拉伸弹簧长度";

equation
  f = c*(s_rel - s_rel0);
  annotation (
    Documentation(info="<html><p>
一个一维线性平动弹簧。该组件可以连接在两个滑动质量块之间，也可以连接在一个滑动质量块和壳体（模型Fixed）之间， 用以描述通过弹簧将滑动质量与壳体耦合的情况。
</p>
</html>"), 
    Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
            100,100}}), graphics={
        Line(points={{-60,-90},{20,-90}}, color={95,127,95}), 
        Polygon(
          points={{50,-90},{20,-80},{20,-100},{50,-90}}, 
          lineColor={95,127,95}, 
          fillColor={95,127,95}, 
          fillPattern=FillPattern.Solid), 
        Text(
          extent={{-150,90},{150,50}}, 
          textString="%name", 
          textColor={0,0,255}), 
        Line(points={{-98,0},{-60,0},{-44,-30},{-16,30},{14,-30},{44,30},{
              60,0},{100,0}}, color={0,127,0}), 
        Text(
          extent={{-150,-45},{150,-75}}, 
          textString="c=%c")}));
end Spring;