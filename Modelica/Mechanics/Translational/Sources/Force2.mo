within Modelica.Mechanics.Translational.Sources;
model Force2 "作为扭矩作用在两个一维平动接口上的输入信号"
  extends Translational.Interfaces.PartialTwoFlanges;
  Modelica.Blocks.Interfaces.RealInput f(unit="N") 
    "驱动力作为输入信号" annotation (Placement(transformation(
        extent={{-20,-20},{20,20}}, 
        rotation=270, 
        origin={0,60}), iconTransformation(
        extent={{-20,-20},{20,20}}, 
        rotation=270, 
        origin={0,40})));

equation
  flange_a.f = f;
  flange_b.f = -f;
  annotation (defaultComponentName="force", 
    Documentation(info="<html>
<p>
输入信号 \"f\" 单位为 [N]，表示作用在两个一维平动接口上的 <em>外部力</em>（正号），
即，连接到这些一维平动接口的组件受到力 f 的驱动。
</p>
<p>
输入信号 s 可以来自 Modelica.Blocks.Source 块库中的信号生成器块之一。
</p>

</html>"), 
       Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100}, 
            {100,100}}), graphics={Text(
              extent={{-150,-40},{150,-80}}, 
              textString="%name", 
              textColor={0,0,255}),Polygon(
          points={{90,0},{60,-30},{60,-10},{10,-10},{10,10},{60,10},{60,30},{90,0}}, 
          lineColor={0,127,0}, 
          fillColor={160,215,160}, 
          fillPattern=FillPattern.Solid),    Polygon(
          points={{-90,0},{-60,30},{-60,10},{-10,10},{-10,-10},{-60,-10},{-60,-30},{-90,0}}, 
          lineColor={0,127,0}, 
          fillColor={160,215,160}, 
          fillPattern=FillPattern.Solid)}));
end Force2;