within Modelica.Mechanics.MultiBody.Parts;
model Rotor1D 
    "一维转动惯量附在三维物体上(如果world.driveTrainMechanics3D = true，则考虑三维动态效应)"

  parameter Boolean animation=true 
    "=true，如果启用动画(显示转子为圆柱体)";
  parameter SI.Inertia J(min=0,start=1) 
    "绕其旋转轴的转子转动惯量";
  parameter Modelica.Mechanics.MultiBody.Types.Axis n={1,0,0} 
    "在frame_a中解析的旋转轴" 
      annotation (Evaluate=true);
  parameter SI.Position r_center[3]=zeros(3) 
    "从frame_a原点到圆柱体中心的位置矢量" 
    annotation (Dialog(
      tab="动画", 
      group="如果animation=true", 
      enable=animation));
  parameter SI.Distance cylinderLength=2*world.defaultJointLength 
    "代表转子的圆柱体的长度" 
    annotation (Dialog(
      tab="动画", 
      group="如果animation=true", 
      enable=animation));
  parameter SI.Distance cylinderDiameter=2*world.defaultJointWidth 
    "代表转子的圆柱体的直径" 
    annotation (Dialog(
      tab="动画", 
      group="如果animation=true", 
      enable=animation));
  input Modelica.Mechanics.MultiBody.Types.Color cylinderColor=Modelica.Mechanics.MultiBody.Types.Defaults.RodColor 
    "代表转子的圆柱体的颜色" 
    annotation (Dialog(
      colorSelector=true, 
      tab="动画", 
      group="如果animation=true", 
      enable=animation));
  input Modelica.Mechanics.MultiBody.Types.SpecularCoefficient 
    specularCoefficient=world.defaultSpecularCoefficient 
    "环境光的反射(=0：光完全被吸收)" 
    annotation (Dialog(
      tab="动画", 
      group="如果animation=true", 
      enable=animation));
  parameter StateSelect stateSelect=StateSelect.default 
    "使用转子角度(phi)和转子速度(w)作为状态的优先级" 
    annotation (Dialog(tab="高级"));
  parameter Boolean exact=true 
    "=true，如果进行精确计算；false，如果忽略轴承对转子加速度的影响以避免代数回路" 
    annotation (Evaluate=true, Dialog(tab="高级"));

 SI.Angle phi(start=0, stateSelect=stateSelect) 
    "转子相对于frame_a的旋转角度(=flange_a.phi=flange_b.phi)";
SI.AngularVelocity w(start=0, stateSelect=stateSelect) 
    "转子相对于frame_a的角速度";
SI.AngularAcceleration a(start=0) 
    "转子相对于frame_a的角加速度";

Modelica.Mechanics.Rotational.Interfaces.Flange_a flange_a 
    "(左)驱动一维接口(一维接口轴指向局部平面内)" 
    annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
Modelica.Mechanics.Rotational.Interfaces.Flange_b flange_b 
    "(右)被动一维接口(一维接口轴指向局部平面外)" 
    annotation (Placement(transformation(extent={{90,-10},{110,10}})));
Modelica.Mechanics.MultiBody.Interfaces.Frame_a frame_a if world.driveTrainMechanics3D 
    "转子壳体固定的参考坐标系(如果world.driveTrainMechanics3D=false，则移除连接器)" 
    annotation (Placement(transformation(
        origin={0,-100}, 
        extent={{-20,-20},{20,20}}, 
        rotation=90)));

encapsulated model RotorWith3DEffects 
    "一维转动惯量附在三维物体上(如果world.driveTrainMechanics3D = true，则考虑三维动态效应)"

    import Modelica;
    import Modelica.Units.SI;
    import Modelica.Mechanics.MultiBody.Frames;
    import Modelica.Mechanics.MultiBody.Types;

    parameter Boolean animation=true 
        "=true，如果启用动画(显示转子为圆柱体)";
    parameter SI.Inertia J(min=0) = 1 
        "绕其旋转轴的转子转动惯量";
    parameter Types.Axis n={1,0,0} 
        "在frame_a中解析的旋转轴";
    parameter SI.Position r_center[3]=zeros(3) 
        "从frame_a原点到圆柱体中心的位置矢量" 
        annotation (Dialog(
            tab="动画", 
            group="如果animation=true", 
            enable=animation));
    parameter SI.Distance cylinderLength=2*world.defaultJointLength 
        "代表转子的圆柱体的长度" 
        annotation (Dialog(
            tab="动画", 
            group="如果animation=true", 
            enable=animation));
    parameter SI.Distance cylinderDiameter=2*world.defaultJointWidth 
        "代表转子的圆柱体的直径" 
        annotation (Dialog(
            tab="动画", 
            group="如果animation=true", 
            enable=animation));
    input Types.Color cylinderColor=Modelica.Mechanics.MultiBody.Types.Defaults.RodColor 
        "代表转子的圆柱体的颜色" 
        annotation (Dialog(
            colorSelector=true, 
            tab="动画", 
            group="如果animation=true", 
            enable=animation));
    input Types.SpecularCoefficient specularCoefficient=world.defaultSpecularCoefficient 
        "环境光的反射(=0：光完全被吸收)" 
        annotation (Dialog(
            tab="动画", 
            group="如果animation=true", 
            enable=animation));
    parameter StateSelect stateSelect=StateSelect.default 
        "使用转子角度(phi)和转子速度(w)作为状态的优先级" 
        annotation (Dialog(tab="高级"));
    parameter Boolean exact=true 
        "=true，如果进行精确计算；false，如果忽略轴承对转子加速度的影响以避免代数回路" 
        annotation (Evaluate=true, Dialog(tab="高级"));

    SI.AngularVelocity w_a[3] 
      "frame_a中解析的角速度";

SI.Angle phi(start=0, final stateSelect=stateSelect) 
      "转子相对于frame_a的旋转角度(=flange_a.phi=flange_b.phi)" 
      annotation (Dialog(showStartAttribute=true));

SI.AngularVelocity w(start=0, stateSelect=stateSelect) 
      "转子相对于frame_a的角速度" 
      annotation (Dialog(showStartAttribute=true));
SI.AngularAcceleration a(start=0) 
      "转子相对于frame_a的角加速度" 
      annotation (Dialog(showStartAttribute=true));

Modelica.Mechanics.Rotational.Interfaces.Flange_a flange_a 
      "(左)驱动一维接口(一维接口轴指向局部平面内)" 
      annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
Modelica.Mechanics.Rotational.Interfaces.Flange_b flange_b 
      "(右)被动一维接口(一维接口轴指向局部平面外)" 
      annotation (Placement(transformation(extent={{90,-10},{110,10}})));
Modelica.Mechanics.MultiBody.Interfaces.Frame_a frame_a 
      "固定转子壳体的参考坐标系" 
      annotation (Placement(
          transformation(
          origin={0,-100}, 
          extent={{-20,-20},{20,20}}, 
          rotation=90)));

  protected
    outer Modelica.Mechanics.MultiBody.World world;
    parameter Real e[3](each final unit="1")= 
      Modelica.Math.Vectors.normalizeWithAssert(n) 
      "转子轴方向的单位矢量，解析在frame_a中";
    parameter SI.Inertia nJ[3]=J*e;
    Modelica.Mechanics.MultiBody.Visualizers.Advanced.Shape cylinder(
      shapeType="cylinder", 
      color=cylinderColor, 
      specularCoefficient=specularCoefficient, 
      length=cylinderLength, 
      width=cylinderDiameter, 
      height=cylinderDiameter, 
      lengthDirection=n, 
      widthDirection={0,1,0}, 
      extra=1, 
      r_shape=r_center - e*(cylinderLength/2), 
      r=frame_a.r_0, 
      R=Frames.absoluteRotation(frame_a.R, Frames.planarRotation(
              e, 
              phi, 
              0))) if world.enableAnimation and animation;

  equation
    phi = flange_a.phi;
    phi = flange_b.phi;
    w = der(phi);
    a = der(w);

   w_a = Modelica.Mechanics.MultiBody.Frames.angularVelocity2(frame_a.R);
if exact then
  J*a = flange_a.tau + flange_b.tau - nJ*der(w_a);
else
  J*a = flange_a.tau + flange_b.tau;
end if;

/* 反作用力矩：
    t = n*(J*a - flange_a.tau - flange_b.tau) + cross(w_a, nJ*w)

  由于
    J*a = flange_a.tau + flange_b.tau - nJ*der(w_a);

  反作用力矩可以简化为
    t = n*(- nJ*der(w_a)) + cross(w_a, nJ*w)

*/

frame_a.f = zeros(3);
frame_a.t = cross(w_a, nJ*w) - e*(nJ*der(w_a));
annotation (Documentation(info="<html>
<p>
该组件用于模拟一维转动惯量体(称为<em>转子</em>)对其三维载体体的陀螺力矩。
如果载体体的角速度矢量与转子轴的矢量不平行，则会出现陀螺力矩。
转子的旋转轴由参数<code>n</code>定义，该参数必须以<code>frame_a</code>的本地坐标系给出。
该组件的默认动画如下图所示。
</p>

<div>
<img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/Parts/Rotor1D.png\"alt=\"model Parts.Rotor1D\">
</div>

<p>
该组件是<a href=\"modelica://Modelica.Mechanics.Rotational.Components.Inertia\">Modelica.Mechanics.Rotational.Components.Inertia</a>的替代品，用于在一维旋转机械系统应与三维载体体连接的情况下。
</p>
<p>
布尔参数<code>exact</code>是基于性能原因引入的。
如果将<code>exact</code>设置为<strong>false</strong>，则会忽略载体体运动对转子角速度的影响。
如果一维旋转机械系统的加速度远远快于基体(例如，车辆动力传动系统的情况)，则这种影响通常是可以忽略的。
其主要优点在于消除了代数回路，因为此时只有从动力传动系统到基体的加速度级别的作用，而没有相反的作用。
</p>
<p>
<strong>参考文献</strong><br><span style=\"font-variant:small-caps\">Schweiger</span>,Christian;<span style=\"font-variant:small-caps\">Otter</span>,Martin:<a href=\"https://www.modelica.org/events/Conference2003/papers/h06_Schweiger_powertrains_v5.pdf\">模拟一维动力传动系统的三维机械效应</a>。
在：<em>第三届国际Modelica会议论文集</em>。
林雪平：Modelica协会和林雪平大学，2003年11月3-4日，第149-158页</p>
</html>"), 

         Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100, 
              100}}), graphics={
          Rectangle(
            extent={{-100,10},{100,-10}}, 
            lineColor={64,64,64}, 
            fillPattern=FillPattern.HorizontalCylinder, 
            fillColor={192,192,192}), 
          Line(points={{-80,-25},{-60,-25}}), 
          Line(points={{60,-25},{80,-25}}), 
          Line(points={{-70,-25},{-70,-70}}), 
          Line(points={{70,-25},{70,-70}}), 
          Line(points={{-80,25},{-60,25}}), 
          Line(points={{60,25},{80,25}}), 
          Line(points={{-70,45},{-70,25}}), 
          Line(points={{70,45},{70,25}}), 
          Line(points={{-70,-70},{70,-70}}), 
          Rectangle(
            extent={{-50,50},{50,-50}}, 
            lineColor={64,64,64}, 
            fillPattern=FillPattern.HorizontalCylinder, 
            fillColor={255,255,255}, 
            radius=10), 
          Rectangle(
            extent={{-50,50},{50,-50}}, 
            lineColor={64,64,64}, 
            radius=10), 
          Text(
            extent={{-148,112},{152,72}}, 
            textString="%name=%J", 
            textColor={0,0,255}), 
          Line(points={{0,-70},{0,-100}})}));
  end RotorWith3DEffects;

protected
  outer Modelica.Mechanics.MultiBody.World world;
  parameter Real e[3](each final unit="1")= 
    Modelica.Math.Vectors.normalizeWithAssert(n) 
    "Unitvectorindirectionofrotoraxis,resolvedinframe_a";
  Modelica.Mechanics.MultiBody.Visualizers.Advanced.Shape cylinder(
    shapeType="cylinder", 
    color=cylinderColor, 
    specularCoefficient=specularCoefficient, 
    length=cylinderLength, 
    width=cylinderDiameter, 
    height=cylinderDiameter, 
    lengthDirection=n, 
    widthDirection={0,1,0}, 
    extra=1, 
    r_shape=r_center - e*(cylinderLength/2), 
    r=zeros(3), 
    R=Modelica.Mechanics.MultiBody.Frames.planarRotation(
          e, 
          phi, 
          0)) if world.enableAnimation and animation and not world.driveTrainMechanics3D;

  Modelica.Mechanics.Rotational.Components.Inertia inertia(J=J, stateSelect= 
        StateSelect.never) if not world.driveTrainMechanics3D annotation (
      Placement(transformation(extent={{-20,-20},{20,20}})));
  RotorWith3DEffects rotorWith3DEffects(
    animation=animation, 
    J=J, 
    n=n, 
    r_center=r_center, 
    cylinderLength=cylinderLength, 
    cylinderDiameter=cylinderDiameter, 
    cylinderColor=cylinderColor, 
    specularCoefficient=specularCoefficient, 
    exact=exact, 
    stateSelect=StateSelect.never) if world.driveTrainMechanics3D annotation (
     Placement(transformation(extent={{-20,-80},{20,-40}})));
equation
  phi = flange_a.phi;
  w = der(phi);
  a = der(w);

  connect(inertia.flange_a, flange_a) annotation (Line(
      points={{-20,0},{-100,0}}));
  connect(inertia.flange_b, flange_b) annotation (Line(
      points={{20,0},{100,0}}));
  connect(rotorWith3DEffects.flange_b, flange_b) annotation (Line(
      points={{20,-60},{60,-60},{60,0},{100,0}}));
  connect(rotorWith3DEffects.flange_a, flange_a) annotation (Line(
      points={{-20,-60},{-60,-60},{-60,0},{-100,0}}));
  connect(rotorWith3DEffects.frame_a, frame_a) annotation (Line(
      points={{0,-80},{0,-100}}, 
      color={95,95,95}, 
      thickness=0.5));
  annotation (Documentation(info="<html>
<p>
该组件用于模拟一维转动惯量体(称为<em>转子</em>)对其三维载体体的陀螺力矩。
如果载体体的角速度矢量与转子轴的矢量不平行，则会出现陀螺力矩。
转子的旋转轴由参数<code>n</code>定义，该参数必须以<code>frame_a</code>的本地坐标系给出。
该组件的默认动画如下图所示。
</p>
<div>
<img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/Parts/Rotor1D.png\"alt=\"model Parts.Rotor1D\">
</div>
<p>
该组件是<a href=\"modelica://Modelica.Mechanics.Rotational.Components.Inertia\">Modelica.Mechanics.Rotational.Components.Inertia</a>的替代品，用于在一维旋转机械系统应与三维载体体连接的情况下。
</p>
<p>
布尔参数<code>exact</code>是基于性能原因引入的。
如果将<code>exact</code>设置为<strong>false</strong>，则会忽略载体体运动对转子角速度的影响。
如果一维旋转机械系统的加速度远远快于基体(例如，车辆动力传动系统的情况)，则这种影响通常是可以忽略的。
其主要优点在于消除了代数回路，因为此时只有从动力传动系统到基体的加速度级别的作用，而没有相反的作用。
</p>
<p>
<strong>参考文献</strong><br><span style=\"font-variant:small-caps\">Schweiger</span>,Christian;<span style=\"font-variant:small-caps\">Otter</span>,Martin:<a href=\"https://www.modelica.org/events/Conference2003/papers/h06_Schweiger_powertrains_v5.pdf\">Modelling 3D Mechanical Effects of 1-dim. Powertrains</a>。
在：<em>第三届国际Modelica会议论文集</em>。
林雪平：Modelica协会和林雪平大学，2003年11月3-4日，第149-158页</p>

</html>"), 
         Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100}, 
            {100,100}}), graphics={
        Rectangle(
          extent={{-100,10},{100,-10}}, 
          lineColor={64,64,64}, 
          fillPattern=FillPattern.HorizontalCylinder, 
          fillColor={192,192,192}), 
        Line(points={{-80,-25},{-60,-25}}), 
        Line(points={{60,-25},{80,-25}}), 
        Line(points={{-70,-25},{-70,-70}}), 
        Line(points={{70,-25},{70,-70}}), 
        Line(points={{-80,25},{-60,25}}), 
        Line(points={{60,25},{80,25}}), 
        Line(points={{-70,45},{-70,25}}), 
        Line(points={{70,45},{70,25}}), 
        Line(points={{-70,-70},{70,-70}}), 
        Rectangle(
          extent={{-50,50},{50,-50}}, 
          lineColor={64,64,64}, 
          fillPattern=FillPattern.HorizontalCylinder, 
          fillColor={255,255,255}, 
          radius=10), 
        Rectangle(
          extent={{-50,50},{50,-50}}, 
          lineColor={64,64,64}, 
          radius=10), 
        Text(
          extent={{-150,125},{150,85}}, 
          textColor={0,0,255}, 
          textString="%name"), 
        Line(points={{0,-70},{0,-100}}), 
        Text(
          extent={{-150,80},{150,50}}, 
          textString="%J")}));
end Rotor1D;