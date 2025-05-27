within Modelica.Mechanics.Translational.Components;
model Mass "带有惯性的滑动质量块"
  parameter SI.Mass m(min=0, start=1) "滑动质量块的质量";
  parameter StateSelect stateSelect=StateSelect.default 
    "使用s和v作为状态的优先级" annotation (Dialog(tab="高级"));
  extends Translational.Interfaces.PartialRigid(L=0,s(start=0, stateSelect= 
          stateSelect));
  SI.Velocity v(start=0, stateSelect=stateSelect) 
    "组件的绝对速度";
  SI.Acceleration a(start=0) "组件的绝对加速度";

equation
  v = der(s);
  a = der(v);
  m*a = flange_a.f + flange_b.f;
  annotation (
    Documentation(info="<html><p>
带有惯性，无摩擦和两个刚性连接一维平动接口的滑动质量。
</p>
<p>
滑动质量块具有长度L，位置坐标s位于中间。 符号约定：在一维平动接口flange_a处的正力将滑动质量块向正方向移动。 在一维平动接口flange_a处的负力将滑动质量块向负方向移动。
</p>
</html>"), 
    Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
            100,100}}), graphics={
        Line(points={{-100,0},{100,0}}, color={0,127,0}), 
        Rectangle(
          extent={{-55,-30},{56,30}}, 
          fillPattern=FillPattern.Sphere, 
          fillColor={160,215,160}, 
          lineColor={0,127,0}), 
        Polygon(
          points={{50,-90},{20,-80},{20,-100},{50,-90}}, 
          lineColor={95,127,95}, 
          fillColor={95,127,95}, 
          fillPattern=FillPattern.Solid), 
        Line(points={{-60,-90},{20,-90}}, color={95,127,95}), 
        Text(
          extent={{-150,85},{150,45}}, 
          textString="%name", 
          textColor={0,0,255}, 
          fillColor={110,210,110}, 
          fillPattern=FillPattern.Solid), 
        Text(
          extent={{-150,-45},{150,-75}}, 
          textString="m=%m", 
          fillColor={110,221,110}, 
          fillPattern=FillPattern.Solid, 
          fontSize=0)}));
end Mass;