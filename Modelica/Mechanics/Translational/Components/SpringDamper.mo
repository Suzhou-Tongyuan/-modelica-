within Modelica.Mechanics.Translational.Components;
model SpringDamper "平行连接的一维线性平动弹簧和阻尼器"
  extends Translational.Interfaces.PartialCompliantWithRelativeStates;
  parameter SI.TranslationalSpringConstant c(final min=0, start=1) 
    "弹簧刚度系数";
  parameter SI.TranslationalDampingConstant d(final min=0, start=1) 
    "阻尼系数";
  parameter SI.Position s_rel0=0 "未拉伸弹簧长度";
  extends Modelica.Thermal.HeatTransfer.Interfaces.PartialElementaryConditionalHeatPortWithoutT;
protected
  SI.Force f_c "弹簧力";
  SI.Force f_d "阻尼力";
equation
  f_c = c*(s_rel - s_rel0);
  f_d = d*v_rel;
  f = f_c + f_d;
  lossPower = f_d*v_rel;
  annotation (
    Documentation(info="<html><p>
平行连接的弹簧和阻尼器元件。 该组件可以连接在两个滑动质量块之间，以描述弹性和阻尼，也可以连接在滑动质量块和壳体（模型Fixed）之间， 以描述通过弹簧/阻尼器将滑动质量块与壳体耦合的情况。
</p>
</html>"), 
    Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
            100,100}}), graphics={
        Line(points={{-80,40},{-60,40},{-45,10},{-15,70},{15,10},{45,70},{
              60,40},{80,40}}, color={0,127,0}), 
        Line(points={{-80,40},{-80,-70},{80,-70},{80,40}}, color={0,127,0}), 
        Line(points={{-90,0},{-80,0}}, color={0,127,0}), 
        Line(points={{80,0},{90,0}}, color={0,127,0}), 
        Polygon(
          points={{53,-20},{23,-10},{23,-30},{53,-20}}, 
          lineColor={95,127,95}, 
          fillColor={95,127,95}, 
          fillPattern=FillPattern.Solid), 
        Line(points={{-57,-20},{23,-20}}, color={95,127,95}), 
        Text(
          extent={{-150,120},{150,80}}, 
          textString="%name", 
          textColor={0,0,255}), 
        Text(
          extent={{-150,-135},{150,-165}}, 
          textString="d=%d"), 
        Text(
          extent={{-150,-100},{150,-130}}, 
          textString="c=%c"), 
        Line(
          visible=useHeatPort, 
          points={{-100,-100},{-100,-80},{-5,-80}}, 
          color={191,0,0}, 
          pattern=LinePattern.Dot), 
        Rectangle(
          extent={{-50,-50},{40,-90}}, 
          fillColor={192,192,192}, 
          fillPattern=FillPattern.Solid, 
          lineColor={0,127,0}), Line(points={{70,-90},{-50,-90},{-50,-50},{70,-50}}, color={0,127,0})}));
end SpringDamper;