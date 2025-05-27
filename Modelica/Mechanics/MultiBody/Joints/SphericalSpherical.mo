within Modelica.Mechanics.MultiBody.Joints;
model SphericalSpherical 
  "球-球组合运动副(1个约束，无潜在状态变量)，在中间可以选择放置一个质点"

  import Modelica.Mechanics.MultiBody.Types;
  extends Interfaces.PartialTwoFrames;

  parameter Boolean animation=true "如果要启用动画，则为true";
  parameter Boolean showMass=true 
    "如果要显示质量(提供animation=true和m>0时)则为true";
  parameter Boolean computeRodLength=false 
    "如果在初始化期间应计算rodLength，则为true(参见info)";
  parameter SI.Length rodLength(
    min=Modelica.Constants.eps, 
    fixed=not computeRodLength, start = 1) 
    "frame_a和frame_b原点之间的距离(如果computeRodLength=true，则为猜测值)";
  parameter SI.Mass m(min=0)=0 
    "杆的质量(放置在杆中间的质点)";
  parameter SI.Diameter sphereDiameter=world.defaultJointLength 
    "球副的直径" 
    annotation (Dialog(tab="动画", group="如果animation=true", enable=animation));
  input Types.Color sphereColor=Modelica.Mechanics.MultiBody.Types.Defaults.JointColor 
    "球副的颜色" 
    annotation (Dialog(colorSelector=true, tab="动画", group="如果animation=true", enable=animation));
  parameter SI.Diameter rodDiameter=sphereDiameter/Types.Defaults.JointRodDiameterFraction 
    "连接两个球副的杆的直径" 
    annotation (Dialog(tab="动画", group="如果animation=true", enable=animation));
  input Types.Color rodColor=Modelica.Mechanics.MultiBody.Types.Defaults.RodColor 
    "连接两个球副的杆的颜色" 
    annotation (Dialog(colorSelector=true, tab="动画", group="如果animation=true", enable=animation));
  parameter SI.Diameter massDiameter=sphereDiameter 
    "表示质点的球的直径" 
    annotation (Dialog(tab="动画", group="如果animation=true且showMass=true且m>0", 
          enable=animation and showMass and m > 0));
  input Types.Color massColor=Modelica.Mechanics.MultiBody.Types.Defaults.BodyColor 
    "表示质点的球的颜色" 
    annotation (
      Dialog(colorSelector=true, tab="动画", group= 
          "如果animation=true且showMass=true且m>0", 
          enable=animation and showMass and m > 0));
  input Types.SpecularCoefficient specularCoefficient = world.defaultSpecularCoefficient 
    "环境光的反射(=0：光被完全吸收)" 
    annotation (Dialog(tab="动画", group="如果animation=true", enable=animation));

parameter Boolean kinematicConstraint=true 
    "=false，如果不需要定义约束，因为通过解析方法解决了运动学环路(\"false\"不应该由用户使用，而是由MultiBody.Joints.Assembliesjoints)" 
    annotation (Dialog(tab="高级"));
Real constraintResidue = rRod_0*rRod_0 - rodLength*rodLength 
    "联接件的约束方程，以残差形式表示：可以是长度约束(=默认)，也可以是计算杆的力的方程(用于解析解决环路与Internal.RevoluteWithLengthConstraint/PrismaticWithLengthConstraint结合使用)" 
    annotation (Dialog(tab="高级", enable=not kinematicConstraint));
parameter Boolean checkTotalPower=false 
    "=true，如果要确定流入该组件的总功率(必须为零)" 
    annotation (Dialog(tab="高级"));

SI.Force f_rod 
    "杆的约束力，沿着杆的方向(在frame_a上为正，当从frame_a指向frame_b时)";
SI.Position rRod_0[3] 
    "从frame_a解析到frame_b的位置矢量，以全局坐标系表示";
SI.Position rRod_a[3] 
    "从frame_a解析到frame_b的位置矢量，以frame_a坐标系表示";
Real eRod_a[3](each final unit="1") 
    "从frame_a指向frame_b的单位矢量，以frame_a坐标系表示";
SI.Position r_CM_0[3] 
    "如果m==0，则为虚拟量，或者从全局坐标系到杆中点的位置矢量，以全局坐标系表示";
SI.Velocity v_CM_0[3] "r_CM_0的一阶导数";
SI.Force f_CM_a[3] 
    "如果m==0，则为虚拟量，或者由于质点加速度而作用在杆中点的转动惯量力，以frame_a坐标系表示";
SI.Force f_CM_e[3] 
    "如果m==0，则为虚拟量，或者f_CM_a在eRod_a上的投影，以frame_a坐标系表示";
SI.Force f_b_a1[3] 
    "作用在frame_b上的力，但杆中没有力，以frame_a坐标系表示";
SI.Power totalPower 
    "如果checkTotalPower=true，则流入该元件的总功率(否则为虚拟量)";

protected
  Visualizers.Advanced.Shape shape_rod(
    shapeType="cylinder", 
    color=rodColor, 
    specularCoefficient=specularCoefficient, 
    length=rodLength, 
    width=rodDiameter, 
    height=rodDiameter, 
    lengthDirection=eRod_a, 
    widthDirection={0,1,0}, 
    r=frame_a.r_0, 
    R=frame_a.R) if world.enableAnimation and animation;
  Visualizers.Advanced.Shape shape_a(
    shapeType="sphere", 
    color=sphereColor, 
    specularCoefficient=specularCoefficient, 
    length=sphereDiameter, 
    width=sphereDiameter, 
    height=sphereDiameter, 
    lengthDirection=eRod_a, 
    widthDirection={0,1,0}, 
    r_shape=-eRod_a*(sphereDiameter/2), 
    r=frame_a.r_0, 
    R=frame_a.R) if world.enableAnimation and animation;
  Visualizers.Advanced.Shape shape_b(
    shapeType="sphere", 
    color=sphereColor, 
    specularCoefficient=specularCoefficient, 
    length=sphereDiameter, 
    width=sphereDiameter, 
    height=sphereDiameter, 
    lengthDirection=eRod_a, 
    widthDirection={0,1,0}, 
    r_shape=eRod_a*(rodLength - sphereDiameter/2), 
    r=frame_a.r_0, 
    R=frame_a.R) if world.enableAnimation and animation;
  Visualizers.Advanced.Shape shape_mass(
    shapeType="sphere", 
    color=massColor, 
    specularCoefficient=specularCoefficient, 
    length=massDiameter, 
    width=massDiameter, 
    height=massDiameter, 
    lengthDirection=eRod_a, 
    widthDirection={0,1,0}, 
    r_shape=eRod_a*(rodLength/2 - sphereDiameter/2), 
    r=frame_a.r_0, 
    R=frame_a.R) if world.enableAnimation and animation and showMass and m > 0;
equation
  // 确定两个坐标系之间的相对位置矢量
  if kinematicConstraint then
    rRod_0 = transpose(frame_b.R.T)*(frame_b.R.T*frame_b.r_0) - transpose(
      frame_a.R.T)*(frame_a.R.T*frame_a.r_0);
  else
    rRod_0 = frame_b.r_0 - frame_a.r_0;
  end if;

  // 在 frame_a 坐标系下计算位置矢量和单位矢量
  rRod_a = Frames.resolve2(frame_a.R, rRod_0);
  eRod_a = rRod_a/rodLength;

  // 约束方程
  constraintResidue = 0;

  // 在 frame_a 和 frame_b 处的力矩
  frame_a.t = zeros(3);
  frame_b.t = zeros(3);

  /* 杆件的力和力矩平衡
     - 质心 CM 的运动学
       r_CM_0 = frame_a.r_0 + rRod_0/2;
       v_CM_0 = der(r_CM_0);
       a_CM_a = resolve2(frame_a.R, der(v_CM_0) - world.gravityAcceleration(r_CM_0));
     - 杆件方向和垂直方向的转动惯量和重力力量
       f_CM_a = m*a_CM_a
       f_CM_e = f_CM_a*eRod_a;           // 杆件方向
       f_CM_n = rodLength(f_CM_a - f_CM_e);  // 垂直方向
     - 杆件方向上的力平衡
       f_CM_e = fa_rod_e + fb_rod_e;
     - 杆件垂直方向上的力平衡
       f_CM_n = fa_rod_n + fb_rod_n;
     - 关于 frame_a 的力矩平衡
       0 = (-f_CM_n)*rodLength/2 + fb_rod_n*rodLength
     结果为:
     fb_rod_n = f_CM_n/2;
     fa_rod_n = fb_rod_n;
     fb_rod_e = f_CM_e - fa_rod_e;
     fa_rod_e 是从运动环中计算的未知数
  */

    // 在组合运动副中解析运动学闭环时需要 f_b_a1
  if m > 0 then
    r_CM_0 = frame_a.r_0 + rRod_0/2;
    v_CM_0 = der(r_CM_0);
    f_CM_a = m*Frames.resolve2(frame_a.R, der(v_CM_0) - 
      world.gravityAcceleration(r_CM_0));
    f_CM_e = (f_CM_a*eRod_a)*eRod_a;
    frame_a.f = (f_CM_a - f_CM_e)/2 + f_rod*eRod_a;
    f_b_a1 = (f_CM_a + f_CM_e)/2;
    frame_b.f = Frames.resolveRelative(f_b_a1 - f_rod*eRod_a, frame_a.R, 
      frame_b.R);
  else
    r_CM_0 = zeros(3);
    v_CM_0 = zeros(3);
    f_CM_a = zeros(3);
    f_CM_e = zeros(3);
    f_b_a1 = zeros(3);
    frame_a.f = f_rod*eRod_a;
    frame_b.f = -Frames.resolveRelative(frame_a.f, frame_a.R, frame_b.R);
  end if;

  if checkTotalPower then
    totalPower = frame_a.f*Frames.resolve2(frame_a.R, der(frame_a.r_0)) + 
      frame_b.f*Frames.resolve2(frame_b.R, der(frame_b.r_0)) + (-m)*(der(
      v_CM_0) - world.gravityAcceleration(r_CM_0))*v_CM_0 + frame_a.t* 
      Frames.angularVelocity2(frame_a.R) + frame_b.t*Frames.angularVelocity2(
      frame_b.R);
  else
    totalPower = 0;
  end if;

  annotation (
    Icon(coordinateSystem(
        preserveAspectRatio=true, 
        extent={{-100,-100},{100,100}}), graphics={
        Ellipse(
          extent={{-95,-40},{-15,40}}, 
          fillPattern=FillPattern.Sphere, 
          fillColor={192,192,192}), 
        Ellipse(
          extent={{-84,-30},{-24,30}}, 
          fillColor={255,255,255}, 
          fillPattern=FillPattern.Solid), 
        Ellipse(
          extent={{15,-40},{95,40}}, 
          fillPattern=FillPattern.Sphere, 
          fillColor={192,192,192}), 
        Ellipse(
          extent={{25,-29},{85,30}}, 
          lineColor={128,128,128}, 
          fillColor={255,255,255}, 
          fillPattern=FillPattern.Solid), 
        Text(
          extent={{-150,90},{150,50}}, 
          textString="%name", 
          textColor={0,0,255}), 
        Rectangle(
          extent={{-40,40},{41,-41}}, 
          lineColor={255,255,255}, 
          fillColor={255,255,255}, 
          fillPattern=FillPattern.Solid), 
        Rectangle(
          extent={{-51,6},{48,-4}}, 
          fillPattern=FillPattern.HorizontalCylinder, 
          fillColor={192,192,192}), 
        Ellipse(
          extent={{-68,15},{-39,-13}}, 
          fillPattern=FillPattern.Sphere, 
          fillColor={192,192,192}), 
        Ellipse(
          extent={{39,14},{68,-14}}, 
          fillPattern=FillPattern.Sphere, 
          fillColor={192,192,192}), 
        Text(
          extent={{-150,-60},{150,-90}}, 
          textString="%rodLength")}), 
    Documentation(info="<html>
<p>
在其两端各有一个球副。
连接两个球副的杆件被近似为位于杆件中间的一个质点。
当质量设置为零(默认情况下)，将生成用于无质量刚体。
在以下默认动画图中，两个球副由两个红色球体表示，连接杆件由灰色圆柱体表示，杆件中间的质点由浅蓝色球体表示：</p>

<div>
<img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/Joints/SphericalSpherical.png\"alt=\"model Joints.SphericalSpherical\">
</div>

<p>
此运动副引入<strong>一个约束</strong>，定义了frame_a原点和frame_b原点之间的距离保持恒定(=rodLength)。
强烈建议在可能的情况下在运动环中使用此运动副，因为这样可以大大提高效率，减小非线性代数方程系统的规模。
</p>
<p>
有时在初始化过程中计算连接杆件的rodLength是很有必要的。
为此，参数<strong>computeLength</strong>必须设置为<strong>true</strong>，并且在同一运动环中，需要有一个其他更容易确定的位置变量具有固定属性为<strong>true</strong>。
例如，如果一个运动环由一个转动副、一个平移副和一个球副组成，可以固定转动副角度的起始值和平动副的相对距离，以计算杆件的rodLength。
</p>
<p>
无法在连接两个球副的杆上连接其他组件，如具有质量属性的体或特殊视觉形状对象。
如果需要这样做，可以使用具有此属性的运动副Joints.<strong>UniversalSpherical</strong>。
</p>

</html>"));
end SphericalSpherical;