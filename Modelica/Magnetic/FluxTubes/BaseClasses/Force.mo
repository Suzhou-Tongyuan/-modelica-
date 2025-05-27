within Modelica.Magnetic.FluxTubes.BaseClasses;
partial model Force "产生磁阻力的磁通管的基本类别;恒磁导率"

  extends Interfaces.TwoPort;

  parameter Boolean useSupport=false 
    "= true，如果支撑法兰开启，否则隐式接地" 
    annotation (Evaluate=true, HideResult=true);

  parameter SI.RelativePermeability mu_r(start=1) 
    "相对磁导率";

  SI.Force F_m "磁阻力";
  SI.Length s=flange.s - s_support 
    "法兰与支架之间的距离";

  SI.Reluctance R_m "磁阻";
  SI.Permeance G_m "磁导率";
  SI.Permeability dGmBydx 
    "磁导率与电枢位置的导数关系";
  parameter Integer dlBydx=1 
    "磁通管变化尺寸相对于电枢位置的导数；设置为 +1 或 -1";

  Modelica.Mechanics.Translational.Interfaces.Flange_b flange 
    "电枢位置上产生的磁阻力" annotation (Placement(
        transformation(extent={{-10,90},{10,110}})));
  Modelica.Mechanics.Translational.Interfaces.Support support(s=s_support, 
      f=-flange.f) if useSupport "支持/安置组件" annotation (
     Placement(transformation(extent={{-10,-110},{10,-90}})));

protected
  SI.Length s_support "支撑法兰的绝对位置";

equation
  V_m = Phi*R_m;
  R_m = 1/G_m;
  F_m = 0.5*V_m^2*dGmBydx;

  if not useSupport then
    s_support = 0;
  end if;
  flange.f = -F_m;

  annotation (Icon(coordinateSystem(
      preserveAspectRatio=false, 
      extent={{-100,-100},{100,100}}), graphics={
      Rectangle(
        extent={{30,30},{70,-30}}, 
        lineColor={255,128,0}, 
        fillColor={255,255,255}, 
        fillPattern=FillPattern.Solid), 
      Line(points={{-70,0},{-90,0}}, color={255,128,0}), 
      Line(points={{70,0},{90,0}}, color={255,128,0}), 
      Text(
        extent={{-150,-80},{150,-40}}, 
        textString="%name", 
        textColor={0,0,255}), 
      Line(points={{-10,-100},{-30,-120}}), 
      Line(points={{-30,-100},{-50,-120}}), 
      Line(points={{-30,-100},{30,-100}}), 
      Line(points={{10,-100},{-10,-120}}), 
      Line(points={{30,-100},{10,-120}}), 
      Rectangle(
        extent={{-70,30},{-30,-30}}, 
        lineColor={255,128,0}, 
        fillColor={255,255,255}, 
        fillPattern=FillPattern.Solid), 
      Rectangle(
        extent={{-10,80},{10,-30}}, 
        fillColor={0,127,0}, 
        fillPattern=FillPattern.Solid)}), Documentation(info="<html>
<p>
请参考<a href=\"modelica://Modelica.Magnetic.FluxTubes.Shapes.Force\">Shapes.Force</a>子包的描述来使用这个部分模型。.
</p>
</html>"));
end Force;