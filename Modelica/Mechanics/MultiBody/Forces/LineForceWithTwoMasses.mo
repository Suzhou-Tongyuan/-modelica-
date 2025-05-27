within Modelica.Mechanics.MultiBody.Forces;
model LineForceWithTwoMasses 
  "连接线上具有2个可选点质量的通用线性力组件"

  import Modelica.Mechanics.MultiBody.Types;

  extends Interfaces.LineForceBase;
  Modelica.Mechanics.Translational.Interfaces.Flange_a flange_b 
    "一维平动接口(平动库中flange_a和flange_b之间的连接力)" 
    annotation (Placement(transformation(
        origin={60,110}, 
        extent={{-10,-10},{10,10}}, 
        rotation=90)));
  Modelica.Mechanics.Translational.Interfaces.Flange_b flange_a 
    "一维平动接口(平动库中flange_a和flange_b之间的连接力)" 
    annotation (Placement(transformation(
        origin={-60,110}, 
        extent={{-10,-10},{10,10}}, 
        rotation=90)));
  parameter Boolean animate=true "= true，如果要启用动画";
  parameter Boolean animateMasses=true 
    "= true，如果要可视化质点，前提是animate = true且m_a、m_b > 0";
  parameter SI.Mass m_a(min=0)=0 
    "连接线上质点a的质量，位于frame_a的原点和frame_b的原点之间";
  parameter SI.Mass m_b(min=0)=0 
    "连接线上质点b的质量，位于frame_a的原点和frame_b的原点之间";
  parameter SI.Position L_a=0 
    "质点a与frame_a的距离(指向frame_b的方向为正)";
  parameter SI.Position L_b=L_a 
    "质点b与frame_b的距离(指向frame_a的方向为正)";
  input Types.SpecularCoefficient specularCoefficient = world.defaultSpecularCoefficient 
    "环境光的反射(= 0：光完全被吸收)" 
    annotation (Dialog(tab="动画", enable=animate));
  input SI.Diameter cylinderDiameter_a=world.defaultForceWidth 
    "frame_a 处圆柱的直径" 
    annotation (Dialog(tab="动画", group="如果 animate = true，则为 frame_a 处的圆柱", enable=animate));
  parameter SI.Length cylinderLength_a=2*L_a "frame_a 处圆柱的长度" 
    annotation (Dialog(tab="动画", group="如果 animate = true，则为 frame_a 处的圆柱", enable=animate));
  input Types.Color color_a={155,155,155} "frame_a 处圆柱的颜色" 
    annotation (Dialog(colorSelector=true, tab="动画", group="如果 animate = true，则为 frame_a 处的圆柱", enable=animate));
  input Real diameterFraction=0.8 
    "frame_b 处圆柱的直径相对于 frame_a 处圆柱直径的比例" 
    annotation (Dialog(tab="动画", group="如果 animate = true，则为 frame_b 处的圆柱", enable=animate));
  parameter SI.Length cylinderLength_b=2*L_b "frame_b 处圆柱的长度" 
    annotation (Dialog(tab="动画", group="如果 animate = true，则为 frame_b 处的圆柱", enable=animate));
  input Types.Color color_b={100,100,100} "frame_b 处圆柱的颜色" 
    annotation (Dialog(colorSelector=true, tab="动画", group="如果 animate = true，则为 frame_b 处的圆柱", enable=animate));
  input Real massDiameterFaction=1.7 
    "质点球的直径相对于 cylinderDiameter_a 的比例" 
    annotation (Dialog(tab="动画", group="如果 animate = true 和 animateMasses = true，则为质点球", enable=animate and animateMasses));
  input Types.Color massColor=Modelica.Mechanics.MultiBody.Types.Defaults.BodyColor 
    "质点的颜色" 
    annotation (Dialog(colorSelector=true, tab="动画", group="如果 animate = true 和 animateMasses = true，则为质点球", enable=animate and animateMasses));

protected
  SI.Force fa "flange_a 上的力";
  SI.Force fb "flange_b 上的力";
  SI.Position r_CM1_0[3](each stateSelect=StateSelect.avoid) 
    "从全局坐标系到质点 1 的位置矢量，解析在全局坐标系中";
  SI.Position r_CM2_0[3](each stateSelect=StateSelect.avoid) 
    "从全局坐标系到质点 2 的位置矢量，解析在全局坐标系中";
  SI.Velocity v_CM1_0[3](each stateSelect=StateSelect.avoid) 
    "der(r_CM_1_0) - 质点 1 的速度";
  SI.Velocity v_CM2_0[3](each stateSelect=StateSelect.avoid) 
    "der(r_CM_2_0) - 质点 2 的速度";
  SI.Acceleration ag_CM1_0[3] "der(v_CM1_0) - gravityAcceleration(r_CM1_0)";
  SI.Acceleration ag_CM2_0[3] "der(v_CM2_0) - gravityAcceleration(r_CM2_0)";
  SI.Force aux1_0[3] "辅助力 1";
  SI.Force aux2_0[3] "辅助力 2";

  input SI.Length cylinderDiameter_b=cylinderDiameter_a*diameterFraction;
  input SI.Length massDiameter=cylinderDiameter_a*massDiameterFaction;
  parameter Boolean animateMasses2=world.enableAnimation and animate and animateMasses and m_a > 0 and m_b > 0;
  Visualizers.Advanced.Shape cylinder_a(
    shapeType="cylinder", 
    color=color_a, 
    specularCoefficient=specularCoefficient, 
    length=cylinderLength_a, 
    width=cylinderDiameter_a, 
    height=cylinderDiameter_a, 
    lengthDirection=e_rel_0, 
    widthDirection={0,1,0}, 
    r=frame_a.r_0) if world.enableAnimation and animate;

  Visualizers.Advanced.Shape cylinder_b(
    shapeType="cylinder", 
    color=color_b, 
    specularCoefficient=specularCoefficient, 
    length=cylinderLength_b, 
    width=cylinderDiameter_b, 
    height=cylinderDiameter_b, 
    lengthDirection=-e_rel_0, 
    widthDirection={0,1,0}, 
    r=frame_b.r_0) if world.enableAnimation and animate;

  Visualizers.Advanced.Shape sphere_a(
    shapeType="sphere", 
    color=massColor, 
    specularCoefficient=specularCoefficient, 
    length=massDiameter, 
    width=massDiameter, 
    height=massDiameter, 
    lengthDirection=e_rel_0, 
    widthDirection={0,1,0}, 
    r_shape=e_rel_0*(L_a - massDiameter/2), 
    r=frame_a.r_0) if animateMasses2;

  Visualizers.Advanced.Shape sphere_b(
    shapeType="sphere", 
    color=massColor, 
    specularCoefficient=specularCoefficient, 
    length=massDiameter, 
    width=massDiameter, 
    height=massDiameter, 
    lengthDirection=-e_rel_0, 
    widthDirection={0,1,0}, 
    r_shape=-e_rel_0*(L_b - massDiameter/2), 
    r=frame_b.r_0) if animateMasses2;

equation
  flange_a.s = 0;
  flange_b.s = length;

  // 确定平移一维接口力
  if cardinality(flange_a) > 0 and cardinality(flange_b) > 0 then
    fa = flange_a.f;
    fb = flange_b.f;
  elseif cardinality(flange_a) > 0 and cardinality(flange_b) == 0 then
    fa = flange_a.f;
    fb = -fa;
  elseif cardinality(flange_a) == 0 and cardinality(flange_b) > 0 then
    fa = -fb;
    fb = flange_b.f;
  else
    fa = 0;
    fb = 0;
  end if;

  /* Force and torque balance of the two point masses
     - Kinematics for center of masses CM1, CM2 of point masses including gravity
       (L = length, va = der(frame_a.r_0), vb = der(frame_b.r_0))
       r_CM1_0 = frame_a.r_0 + e_rel_0*L_a;
       r_CM2_0 = frame_b.r_0 - e_rel_0*L_b;
       v_CM1_0 = der(r_CM1_0);
       v_CM2_0 = der(r_CM2_0);
       ag_CM1_0 = der(v_CM1_0) - world.gravityAcceleration(r_CM1_0);
       ag_CM2_0 = der(v_CM2_0) - world.gravityAcceleration(r_CM2_0);
       der(e_rel_0) = der(r_rel_0/sqrt(r_rel_0*r_rel_0))
                    = 1/L*(I - e_rel_0*e_rel_0')*der(r_rel_0)
                    = 1/L*(I - e_rel_0*e_rel_0')*(vb - va)
       v_CM1_0 = va + L_a/L*(I - e_rel_0*e_rel_0')*(vb - va)
       v_CM2_0 = vb - L_b/L*(I - e_rel_0*e_rel_0')*(vb - va)
     - Power balance for the connection line
       (f1=force on frame_a side, f2=force on frame_b side)
       0 = f1*va - m_a*ag_CM1*v_CM1 + f2*vb - m_b*ag_CM2*v_CM2
         = f1*va - m_a*ag_CM1*(va + L_a/L*(I - e_rel*e_rel')*(vb - va)) +
           f2*vb - m_b*ag_CM2*(vb - L_b/L*(I - e_rel*e_rel')*(vb - va))
         = (f1 - m_a*ag_CM1*(I - L_a/L*(I - e_rel*e_rel'))
               - m_b*ag_CM2*(L_b/L*(I - e_rel*e_rel')))*va +
           (f2 - m_b*ag_CM2*(I - L_b/L*(I - e_rel_0*e_rel_0'))
               - m_a*ag_CM1*(L_a/L*(I - e_rel*e_rel')))*vb
         = va*(f1 - m_a*ag_CM1 +
               (m_a*ag_CM1*L_a/L - m_b*ag_CM2*L_b/L)*(I - e_rel*e_rel')) +
           vb*(f2 - m_b*ag_CM2 +
               (m_b*ag_CM2*L_b/L - m_a*ag_CM1*L_a/L)*(I - e_rel*e_rel'))
       since va and vb are completely independent from other
       the parenthesis must vanish:
         f1 := m_a*ag_CM1 - (m_a*ag_CM1*L_a/L - m_b*ag_CM2*L_b/L)*(I - e_rel*e_rel')
         f2 := m_b*ag_CM2 + (m_a*ag_CM1*L_a/L - m_b*ag_CM2*L_b/L)*(I - e_rel*e_rel')
       or
         aux1 := ag_CM1*(m_a*L_a/L) - ag_CM2*(m_b*L_b/L);
         aux2 := aux1 - (aux1'*e_rel)*e_rel
         f1 := m_a*ag_CM1 - aux2
         f2 := m_b*ag_CM2 + aux2
     - Force balance on frame_a and frame_b finally results in
         0 = frame_a.f + e_rel_a*fa - f1_a
         0 = frame_b.f + e_rel_b*fb - f2_b
       and therefore
         frame_a.f = -e_rel_a*fa + m_a*ag_CM1 - aux2
         frame_b.f = -e_rel_b*fb + m_b*ag_CM2 + aux2
  */
  /* 两个点质量的力和力矩平衡

包括重力的点质量质心 CM1、CM2 的运动学 
(L = 长度, va = der(frame_a.r_0), vb = der(frame_b.r_0)) 
r_CM1_0 = frame_a.r_0 + e_rel_0L_a; 
r_CM2_0 = frame_b.r_0 - e_rel_0L_b; 
v_CM1_0 = der(r_CM1_0); 
v_CM2_0 = der(r_CM2_0); 
ag_CM1_0 = der(v_CM1_0) - world.gravityAcceleration(r_CM1_0); 
ag_CM2_0 = der(v_CM2_0) - world.gravityAcceleration(r_CM2_0); 
der(e_rel_0) = der(r_rel_0/sqrt(r_rel_0r_rel_0)) = 1/L(I - e_rel_0e_rel_0')der(r_rel_0) = 1/L(I - e_rel_0e_rel_0')(vb - va) v_CM1_0 = va + L_a/L(I - e_rel_0e_rel_0')(vb - va) v_CM2_0 = vb - L_b/L*(I - e_rel_0e_rel_0')(vb - va)
连接线的功率平衡 (f1=frame_a 侧的力, f2=frame_b 侧的力) 
0 = f1va - m_aag_CM1v_CM1 + f2vb - m_bag_CM2v_CM2 = f1va - m_aag_CM1*(va + L_a/L*(I - e_rele_rel')(vb - va)) + f2vb - m_bag_CM2*(vb - L_b/L*(I - e_rele_rel')(vb - va)) = (f1 - m_aag_CM1(I - L_a/L*(I - e_rele_rel')) - m_bag_CM2*(L_b/L*(I - e_rele_rel')))va + (f2 - m_bag_CM2(I - L_b/L*(I - e_rel_0e_rel_0')) - m_aag_CM1*(L_a/L*(I - e_rele_rel')))vb 
= va(f1 - m_aag_CM1 + (m_aag_CM1L_a/L - m_bag_CM2L_b/L)(I - e_rele_rel')) + vb*(f2 - m_bag_CM2 + (m_bag_CM2L_b/L - m_aag_CM1L_a/L)(I - e_rele_rel')) 
由于 va 和 vb 完全独立于其他变量 括号必须消失： 
f1 := m_aag_CM1 - (m_aag_CM1L_a/L - m_bag_CM2L_b/L)(I - e_rele_rel') 
f2 := m_bag_CM2 + (m_aag_CM1L_a/L - m_bag_CM2L_b/L)(I - e_rele_rel') 
或 aux1 := ag_CM1(m_aL_a/L) - ag_CM2(m_b*L_b/L); 
aux2 := aux1 - (aux1'e_rel)e_rel 
f1 := m_aag_CM1 - aux2 
f2 := m_bag_CM2 + aux2
最终，frame_a 和 frame_b 上的力平衡导致
0 = frame_a.f + e_rel_afa - f1_a 0 
= frame_b.f + e_rel_bfb - f2_b 因此 frame_a.f 
= -e_rel_afa + m_aag_CM1 - aux2 frame_b.f 
= -e_rel_bfb + m_bag_CM2 + aux2 */
  if m_a > 0 or m_b > 0 then
    r_CM1_0 = frame_a.r_0 + e_rel_0*L_a;
    r_CM2_0 = frame_b.r_0 - e_rel_0*L_b;
    v_CM1_0 = der(r_CM1_0);
    v_CM2_0 = der(r_CM2_0);
    ag_CM1_0 = der(v_CM1_0) - world.gravityAcceleration(r_CM1_0);
    ag_CM2_0 = der(v_CM2_0) - world.gravityAcceleration(r_CM2_0);
    aux1_0 = ag_CM1_0*(m_a*L_a/length) - ag_CM2_0*(m_b*L_b/length);
    aux2_0 = aux1_0 - (aux1_0*e_rel_0)*e_rel_0;
    frame_a.f = Frames.resolve2(frame_a.R, m_a*ag_CM1_0 - aux2_0 - e_rel_0*fa);
    frame_b.f = Frames.resolve2(frame_b.R, m_b*ag_CM2_0 + aux2_0 - e_rel_0*fb);
  else
    r_CM1_0 = zeros(3);
    r_CM2_0 = zeros(3);
    v_CM1_0 = zeros(3);
    v_CM2_0 = zeros(3);
    ag_CM1_0 = zeros(3);
    ag_CM2_0 = zeros(3);
    aux1_0 = zeros(3);
    aux2_0 = zeros(3);
    frame_a.f = -Frames.resolve2(frame_a.R, e_rel_0*fa);
    frame_b.f = -Frames.resolve2(frame_b.R, e_rel_0*fb);
  end if;

  annotation (
    Icon(coordinateSystem(
        preserveAspectRatio=true, 
        extent={{-100,-100},{100,100}}), graphics={
        Ellipse(
          extent={{-100,-40},{-20,40}}, 
          fillPattern=FillPattern.Sphere, 
          fillColor={192,192,192}), 
        Ellipse(
          extent={{-90,-30},{-30,30}}, 
          fillColor={255,255,255}, 
          fillPattern=FillPattern.Solid), 
        Ellipse(
          extent={{20,-40},{100,40}}, 
          fillPattern=FillPattern.Sphere, 
          fillColor={192,192,192}), 
        Ellipse(
          extent={{31,-29},{91,30}}, 
          lineColor={128,128,128}, 
          fillColor={255,255,255}, 
          fillPattern=FillPattern.Solid), 
        Text(
          extent={{-150,-55},{150,-95}}, 
          textString="%name", 
          textColor={0,0,255}), 
        Rectangle(
          extent={{-52,40},{48,-40}}, 
          lineColor={255,255,255}, 
          fillColor={255,255,255}, 
          fillPattern=FillPattern.Solid), 
        Ellipse(
          extent={{-74,15},{-45,-13}}, 
          fillPattern=FillPattern.Sphere, 
          fillColor={192,192,192}), 
        Ellipse(
          extent={{45,14},{74,-14}}, 
          fillPattern=FillPattern.Sphere, 
          fillColor={192,192,192}), 
        Line(points={{-60,0},{-60,23},{-30,23},{-30,70},{-60,70},{-60,101}}), 
        Line(points={{60,0},{60,20},{30,20},{30,70},{60,70},{60,100}}), 
        Line(
          points={{-23,0},{25,0}}, 
          pattern=LinePattern.Dot), 
        Ellipse(
          extent={{23,8},{39,-8}}, 
          fillPattern=FillPattern.Solid), 
        Ellipse(
          extent={{-39,8},{-23,-8}}, 
          fillPattern=FillPattern.Solid), 
        Line(points={{-60,0},{-29,0}}), 
        Line(points={{29,0},{60,0}}), 
        Ellipse(visible=fixedRotationAtFrame_a, extent={{-70,30},{-130,-30}}, lineColor={255,0,0}), 
        Text(visible=fixedRotationAtFrame_a, 
          extent={{-62,50},{-140,30}}, 
          textColor={255,0,0}, 
          textString="R=0"), 
        Ellipse(visible=fixedRotationAtFrame_b, extent={{70,30},{130,-30}}, lineColor={255,0,0}), 
        Text(visible=fixedRotationAtFrame_b, 
          extent={{62,50},{140,30}}, 
          textColor={255,0,0}, 
          textString="R=0")}), 
    Diagram(coordinateSystem(
        preserveAspectRatio=true, 
        extent={{-100,-100},{100,100}}), graphics={
        Line(points={{-60,80},{46,80}}, color={0,0,255}), 
        Polygon(
          points={{60,80},{45,86},{45,74},{60,80}}, 
          lineColor={0,0,255}, 
          fillColor={0,0,255}, 
          fillPattern=FillPattern.Solid), 
        Text(
          extent={{-42,91},{30,79}}, 
          textString="length", 
          textColor={0,0,255}), 
        Ellipse(
          extent={{-100,-40},{-20,40}}, 
          fillPattern=FillPattern.Sphere, 
          fillColor={192,192,192}), 
        Ellipse(
          extent={{-90,-30},{-30,30}}, 
          fillColor={255,255,255}, 
          fillPattern=FillPattern.Solid), 
        Ellipse(
          extent={{20,-40},{100,40}}, 
          fillPattern=FillPattern.Sphere, 
          fillColor={192,192,192}), 
        Ellipse(
          extent={{31,-29},{91,30}}, 
          lineColor={128,128,128}, 
          fillColor={255,255,255}, 
          fillPattern=FillPattern.Solid), 
        Rectangle(
          extent={{-49,39},{51,-41}}, 
          lineColor={255,255,255}, 
          fillColor={255,255,255}, 
          fillPattern=FillPattern.Solid), 
        Ellipse(
          extent={{-74,15},{-45,-13}}, 
          fillPattern=FillPattern.Sphere, 
          fillColor={192,192,192}), 
        Ellipse(
          extent={{45,15},{74,-13}}, 
          fillPattern=FillPattern.Sphere, 
          fillColor={192,192,192}), 
        Line(points={{-60,0},{-60,24},{-40,24},{-40,60},{-60,60},{-60,110}}), 
        Line(points={{60,1},{60,21},{40,21},{40,60},{60,60},{60,110}}), 
        Line(
          points={{-60,0},{60,0}}, 
          pattern=LinePattern.Dot), 
        Ellipse(
          extent={{20,8},{36,-8}}, 
          fillPattern=FillPattern.Solid), 
        Line(points={{-18,-18},{11,-18}}, color={0,0,255}), 
        Polygon(points={{23,-18},{11,-15},{11,-21},{23,-18}}, lineColor={0,0, 
              255}), 
        Line(points={{-60,16},{-37,16}}, color={0,0,255}), 
        Line(points={{-25,0},{-25,20}}, color={0,0,255}), 
        Text(
          extent={{-38,-20},{33,-35}}, 
          textString="e_rel_0"), 
        Polygon(points={{-25,16},{-37,19},{-37,13},{-25,16}}, lineColor={0,0, 
              255}), 
        Text(
          extent={{-39,31},{-22,21}}, 
          textString="L_a"), 
        Ellipse(
          extent={{-33,7},{-17,-9}}, 
          fillPattern=FillPattern.Solid), 
        Line(points={{29,3},{29,22}}, color={0,0,255}), 
        Line(points={{29,16},{60,16}}, color={0,0,255}), 
        Polygon(points={{29,16},{41,19},{41,13},{29,16}}, lineColor={0,0,255}), 
        Text(
          extent={{15,36},{32,26}}, 
          textString="L_b"), 
        Line(
          points={{37,18},{30,27}}, 
          pattern=LinePattern.Dot, 
          color={0,0,255})}), 
    Documentation(info="<html>
<p>此组件用于在frame_a原点和frame_b原点之间施加一个<strong>线性力</strong>，
通过连接Modelica中的<strong>一维平移</strong>机械库(Modelica.Mechanics.Translational)的组件在两个一维接口连接器<strong>flange_a</strong>和<strong>flange_b</strong>之间来实现。
可选地，frame_a原点和frame_b原点的连线上有<strong>两个点质量</strong>。
这些点质量近似于<strong>力元件</strong>的<strong>质量</strong>。两个点质量的位置分别由它们相对于frame_a的固定距离L_a和相对于frame_b的固定距离L_b定义。
</p>
<p>在示例<a href=\"modelica://Modelica.Mechanics.MultiBody.Examples.Elementary.LineForceWithTwoMasses\">MultiBody.Examples.Elementary.LineForceWithTwoMasses</a>
中展示了此线性力元件的使用，并与使用<a href=\"modelica://Modelica.Mechanics.MultiBody.Joints.Assemblies.JointUPS\">MultiBody.Joints.Assemblies.JointUPS</a>组件的替代示例实现进行了比较。
此示例的组成图在下图中显示。</p>

<div>
<img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/Forces/LineForceWithTwoMassesDiagram.png\">
</div>

<p>在下一张图中显示了时间为0时的动画视图。
前方左侧的系统是带有LineForceWithTwoMasses组件的动画，而后方右侧的系统是带有JointUPS组件的动画。两种实现都产生相同的结果。
然而，使用LineForceWithTwoMasses组件的实现更简单。
</p>
<div>

<div>
<img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/Examples/Elementary/LineForceWithTwoMasses2.png\">
</div>

<p>在一维平动库中，有这样一个隐含的假设，即仅具有一个一维接口连接器的组件的力对该组件的轴承产生相反的作用力。
这个假设也用于LineForceWithTwoMasses组件：如果只连接到一个一维接口连接器，则该一维接口连接器中的力也将隐式地对另一个一维接口连接器产生相反方向的作用力。
</p>
</html>"));
end LineForceWithTwoMasses;