within Modelica.Mechanics.Translational.Components;
model RollingResistance "车轮的阻力"
  extends Modelica.Mechanics.Translational.Interfaces.PartialForce;
  import Modelica.Constants.pi;
  parameter SI.Force fWeight(start=0) "由重力引起的车轮载荷";
  parameter Boolean useCrInput=false "启用Cr的信号输入";
  parameter Real CrConstant=0.01 "常数滚动阻力系数" 
    annotation(Dialog(enable=not useCrInput));
  parameter Boolean useInclinationInput=false "启用倾斜角的信号输入";
  parameter Real inclinationConstant=0 "常数倾斜角 = tan(angle)" 
    annotation(Dialog(enable=not useInclinationInput));
  parameter Modelica.Blocks.Types.Regularization reg=Modelica.Blocks.Types.Regularization.Exp 
    "正则化类型" annotation(Evaluate=true);
  parameter SI.Velocity v0(final min=Modelica.Constants.eps)=0.1 
    "小于v0的正则化速度";
  SI.Velocity v 
    "相对于支撑组件的一维平动接口的速度 (= der(s))";
  SI.Force f_nominal "没有正则化的名义滚动阻力";
  Blocks.Interfaces.RealInput inclination = inclination_internal if useInclinationInput 
    "倾斜角=tan(angle)" 
    annotation (Placement(transformation(extent={{-20,-20},{20,20}}, 
        origin={-120,60})));
  Blocks.Interfaces.RealInput cr = Cr_internal if useCrInput 
    "滚动阻力系数" 
    annotation (Placement(transformation(extent={{-20,-20},{20,20}}, 
        origin={-120,-60})));
protected
  Real Cr_internal "滚动阻力系数";
  Real inclination_internal "倾斜角";
equation
  if not useCrInput then
    Cr_internal = CrConstant;
  end if;
  if not useInclinationInput then
    inclination_internal = inclinationConstant;
  end if;
  v = der(s);
  f_nominal = -Cr_internal*fWeight*cos(atan(inclination_internal));
  if reg==Modelica.Blocks.Types.Regularization.Exp then
    f = -f_nominal*(2/(1 + Modelica.Math.exp(-v/(0.01*v0)))-1);
  elseif reg==Modelica.Blocks.Types.Regularization.Sine then
    f = -f_nominal*smooth(1, (if abs(v)>=v0 then sign(v) else Modelica.Math.sin(pi/2*v/v0)));
  elseif reg==Modelica.Blocks.Types.Regularization.Linear then
    f = -f_nominal*(if abs(v)>=v0 then sign(v) else (v/v0));
  else//if reg==Modelica.Blocks.Types.Regularization.CoSine
    f = -f_nominal*(if abs(v)>=v0 then sign(v) else sign(v)*(1 - Modelica.Math.cos(pi/2*v/v0)));
  end if;
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,100}}), 
      graphics={
        Ellipse(extent={{-60,60},{60,-60}}, 
          lineColor={0,127,0}, 
          fillColor={160,215,160}, 
          fillPattern=FillPattern.Sphere), 
        Ellipse(extent={{-40,40},{40,-40}}, 
          lineColor={0,127,0}, 
          fillColor={255,255,255}, 
          fillPattern=FillPattern.Solid), 
        Text(
          extent={{-100,70},{-60,50}}, 
          textColor={64,64,64}, 
          textString="inc."), 
        Text(
          extent={{-110,-50},{-70,-70}}, 
          textColor={64,64,64}, 
          textString="cr"), 
        Rectangle(
          extent={{-2,40},{2,-40}}, 
          lineColor={0,127,0}, 
          fillColor={160,215,160}, 
          fillPattern=FillPattern.Solid), 
        Rectangle(
          extent={{-2,40},{2,-40}}, 
          lineColor={0,127,0}, 
          fillColor={160,215,160}, 
          fillPattern=FillPattern.Solid, 
          rotation=90), 
        Rectangle(
          extent={{-2,40},{2,-40}}, 
          lineColor={0,127,0}, 
          fillColor={160,215,160}, 
          fillPattern=FillPattern.Solid, 
          rotation=135), 
        Rectangle(
          extent={{-2,40},{2,-40}}, 
          lineColor={0,127,0}, 
          fillColor={160,215,160}, 
          fillPattern=FillPattern.Solid, 
          rotation=45), 
        Ellipse(extent={{-10,10},{10,-10}}, 
          lineColor={0,127,0}, 
          fillColor={160,215,160}, 
          fillPattern=FillPattern.Solid)}), 
    Documentation(info="<html>
<p>
简化的车轮阻力模型，依赖于垂直车轮载荷（由重力引起，即仅静态载荷）、倾斜角和滚动阻力系数：
</p>
<blockquote>
<pre>
flange.f = Cr * fWeight * cos(alpha)
</pre>
</blockquote>

<p>
滚动阻力系数&nbsp;<var>C<sub>r</sub></var>可以是常数（由参数 <code>CrConstant</code> 给出），
也可以由输入 <code>cr</code> 规定。
</p>
<p>
倾斜角可以是常数（参数 <code>inclinationConstant</code>），
也可以由输入 <code>inclination</code> 规定。
这对应于车辆行驶距离内的路面上升量，
通常表示为百分比，等于 tan(<var>&alpha;</var>)。
例如，对于在100米距离内上升了10米的道路，坡度为10%，因此倾斜角为0.1。
正的倾斜角意味着车辆上坡行驶，负的倾斜角意味着车辆下坡行驶，假设车辆速度为正。
</p>

<h4>注意</h4>
<p>
滚动阻力在这里与速度无关，但随速度方向变化。
为了避免在零速度附近出现数值问题，滚动阻力在 <code>[-v0,&nbsp;v0]</code> 范围内进行了相应的正则化。
因此，在车辆静止时不考虑静摩擦。
</p>
</html>"));
end RollingResistance;