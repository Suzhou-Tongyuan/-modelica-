within Modelica.Mechanics.MultiBody.Parts;
model Body 
  "具有质量、转动惯量张量和一个坐标系连接器的刚体(12个潜在状态变量)"

  import Modelica.Mechanics.MultiBody.Types;
  import Modelica.Mechanics.MultiBody.Frames;
  import Modelica.Units.Conversions.to_unit1;

  Modelica.Mechanics.MultiBody.Interfaces.Frame_a frame_a 
    "在刚体上固定的坐标系" annotation (Placement(transformation(
          extent={{-116,-16},{-84,16}})));
  parameter Boolean animation=true 
    "=true，如果要启用动画(显示圆柱体和球体)";
  parameter SI.Position r_CM[3](start={0,0,0}) 
    "从frame_a到质心的矢量，在frame_a中解析";
  parameter SI.Mass m(min=0, start=1) "刚体的质量";
  parameter SI.Inertia I_11(min=0) = 0.001 "转动惯量张量的元素(1,1)" 
    annotation (Dialog(group="转动惯量张量(在质心解析，与frame_a平行)"));
  parameter SI.Inertia I_22(min=0) = 0.001 "转动惯量张量的元素(2,2)" 
    annotation (Dialog(group="转动惯量张量(在质心解析，与frame_a平行)"));
  parameter SI.Inertia I_33(min=0) = 0.001 "转动惯量张量的元素(3,3)" 
    annotation (Dialog(group="转动惯量张量(在质心解析，与frame_a平行)"));
  parameter SI.Inertia I_21(min=-C.inf) = 0 "转动惯量张量的元素(2,1)" 
    annotation (Dialog(group="转动惯量张量(在质心解析，与frame_a平行)"));
  parameter SI.Inertia I_31(min=-C.inf) = 0 "转动惯量张量的元素(3,1)" 
    annotation (Dialog(group="转动惯量张量(在质心解析，与frame_a平行)"));
  parameter SI.Inertia I_32(min=-C.inf) = 0 "转动惯量张量的元素(3,2)" 
    annotation (Dialog(group="转动惯量张量(在质心解析，与frame_a平行)"));

  SI.Position r_0[3](start={0,0,0}, each stateSelect=if enforceStates then 
        StateSelect.always else StateSelect.avoid) 
    "从全局坐标系原点到frame_a原点的位置矢量" 
    annotation (Dialog(tab="初始值",showStartAttribute=true));
  SI.Velocity v_0[3](start={0,0,0}, each stateSelect=if enforceStates then 
        StateSelect.always else StateSelect.avoid) 
    "frame_a的绝对速度，在全局坐标系中解析(=der(r_0))" 
    annotation (Dialog(tab="初始值",showStartAttribute=true));
  SI.Acceleration a_0[3](start={0,0,0}) 
    "frame_a的绝对加速度，在全局坐标系中解析(=der(v_0))" 
    annotation (Dialog(tab="初始值",showStartAttribute=true));

parameter Boolean angles_fixed=false 
    "=true，如果将angles_start用作初始值，则作为初始值，否则作为猜测值" 
    annotation (
    Evaluate=true, 
    choices(checkBox=true), 
    Dialog(tab="初始值"));
  parameter SI.Angle angles_start[3]={0,0,0} 
    "将全局坐标系绕'sequence_start'轴旋转到frame_a的初始角度值" 
    annotation (Dialog(tab="初始值"));
  parameter Types.RotationSequence sequence_start={1,2,3} 
    "将全局坐标系旋转到frame_a的初始时间的旋转序列" 
    annotation (Evaluate=true, Dialog(tab="初始值"));

  parameter Boolean w_0_fixed=false 
    "=true，如果将w_0_start用作初始值，则作为初始值，否则作为猜测值" 
    annotation (
    Evaluate=true, 
    choices(checkBox=true), 
    Dialog(tab="初始值"));
  parameter SI.AngularVelocity w_0_start[3]={0,0,0} 
    "frame_a在全局坐标系中的初始或猜测角速度值" 
    annotation (Dialog(tab="初始值"));

  parameter Boolean z_0_fixed=false 
    "=true，如果将z_0_start用作初始值，则作为初始值，否则作为猜测值" 
    annotation (
    Evaluate=true, 
    choices(checkBox=true), 
    Dialog(tab="初始值"));
  parameter SI.AngularAcceleration z_0_start[3]={0,0,0} 
    "角加速度z_0的初始值=der(w_0)" 
    annotation (Dialog(tab="初始值"));

  parameter SI.Diameter sphereDiameter=world.defaultBodyDiameter 
    "球体直径" annotation (Dialog(
      tab="动画", 
      group="如果animation=true", 
      enable=animation));
  input Types.Color sphereColor=Modelica.Mechanics.MultiBody.Types.Defaults.BodyColor 
    "球体颜色" annotation (Dialog(
      colorSelector=true, 
      tab="动画", 
      group="如果animation=true", 
      enable=animation));
  parameter SI.Diameter cylinderDiameter=sphereDiameter/Types.Defaults.BodyCylinderDiameterFraction 
    "圆柱体直径" annotation (Dialog(
      tab="动画", 
      group="如果animation=true", 
      enable=animation));
  input Types.Color cylinderColor=sphereColor "圆柱体颜色" annotation (
     Dialog(
      colorSelector=true, 
      tab="动画", 
      group="如果animation=true", 
      enable=animation));
  input Types.SpecularCoefficient specularCoefficient=world.defaultSpecularCoefficient 
    "环境光反射(=0：光完全被吸收)" 
    annotation (Dialog(
      tab="动画", 
      group="如果animation=true", 
      enable=animation));
  parameter Boolean enforceStates=false 
    "=true，如果绝对变量作为状态使用(StateSelect.always)" 
    annotation (Evaluate=true, Dialog(tab="高级"));
  parameter Boolean useQuaternions=true 
    "=true，如果使用四元数作为潜在状态变量，否则使用3个角度作为潜在状态变量" 
    annotation (Evaluate=true, Dialog(tab="高级"));
  parameter Types.RotationSequence sequence_angleStates={1,2,3} 
    "将全局坐标系绕使用作为潜在状态变量的3个角度的轴旋转到frame_a的旋转序列" 
    annotation (Evaluate=true, Dialog(tab="高级", enable=not 
          useQuaternions));


 // 转动惯量张量
final parameter SI.Inertia I[3, 3]=[I_11, I_21, I_31; I_21, I_22, I_32;
      I_31, I_32, I_33] "转动惯量张量";

// 初始时间的全局坐标系到frame_a的定向对象
final parameter Frames.Orientation R_start= 
      Modelica.Mechanics.MultiBody.Frames.axesRotations(
        sequence_start, 
        angles_start, 
        zeros(3)) 
    "初始时间时全局坐标系到frame_a的定向对象";

// 在frame_a内解析的frame_a的绝对角速度
SI.AngularVelocity w_a[3](
    start=Frames.resolve2(R_start, w_0_start), 
    fixed=fill(w_0_fixed, 3), 
    each stateSelect=if enforceStates then (if useQuaternions then 
        StateSelect.always else StateSelect.never) else StateSelect.avoid) 
    "frame_a的绝对角速度，在frame_a内解析";

// 在frame_a内解析的frame_a的绝对角加速度
SI.AngularAcceleration z_a[3](start=Frames.resolve2(R_start, z_0_start), 
      fixed=fill(z_0_fixed, 3)) 
    "frame_a的绝对角加速度，在frame_a内解析";

// 全局坐标系中的重力加速度
SI.Acceleration g_0[3] "在全局坐标系中解析的重力加速度";

protected
  outer Modelica.Mechanics.MultiBody.World world;

// 四元数的声明(如果不使用四元数，则为虚拟值)
parameter Frames.Quaternions.Orientation Q_start=Frames.to_Q(R_start) 
    "初始时间时全局坐标系到frame_a的四元数定向对象";
Frames.Quaternions.Orientation Q(start=Q_start, each stateSelect=if 
    enforceStates then (if useQuaternions then StateSelect.prefer else 
    StateSelect.never) else StateSelect.avoid) 
    "全局坐标系到frame_a的四元数定向对象(如果不使用四元数作为状态，则为虚拟值)";

// 3个角度的声明
parameter SI.Angle phi_start[3]=if sequence_start[1] == 
    sequence_angleStates[1] and sequence_start[2] == sequence_angleStates[2] 
     and sequence_start[3] == sequence_angleStates[3] then angles_start 
     else Frames.axesRotationsAngles(R_start, sequence_angleStates) 
    "初始时间的潜在角状态";
SI.Angle phi[3](start=phi_start, each stateSelect=if enforceStates then (
    if useQuaternions then StateSelect.never else StateSelect.always) 
     else StateSelect.avoid) 
    "将全局坐标系旋转到body的frame_a的虚拟或3个角度";
SI.AngularVelocity phi_d[3](each stateSelect=if enforceStates then (if 
    useQuaternions then StateSelect.never else StateSelect.always) else 
    StateSelect.avoid) "=der(phi)";
SI.AngularAcceleration phi_dd[3] "=der(phi_d)";

// 动画声明
Visualizers.Advanced.Shape cylinder(
    shapeType="cylinder", 
    color=cylinderColor, 
    specularCoefficient=specularCoefficient, 
    length=if Modelica.Math.Vectors.length(r_CM) > sphereDiameter/2 then 
        Modelica.Math.Vectors.length(r_CM) - (if cylinderDiameter > 1.1* 
        sphereDiameter then sphereDiameter/2 else 0) else 0, 
    width=cylinderDiameter, 
    height=cylinderDiameter, 
    lengthDirection = to_unit1(r_CM), 
    widthDirection={0,1,0}, 
    r=frame_a.r_0, 
    R=frame_a.R) if world.enableAnimation and animation;
Visualizers.Advanced.Shape sphere(
    shapeType="sphere", 
    color=sphereColor, 
    specularCoefficient=specularCoefficient, 
    length=sphereDiameter, 
    width=sphereDiameter, 
    height=sphereDiameter, 
    lengthDirection={1,0,0}, 
    widthDirection={0,1,0}, 
    r_shape=r_CM - {1,0,0}*sphereDiameter/2, 
    r=frame_a.r_0, 
    R=frame_a.R) if world.enableAnimation and animation and sphereDiameter > 
    0;

initial equation
  if angles_fixed then
    // 初始化位置变量
    if not Connections.isRoot(frame_a.R) then
        // frame_a.R 在其他地方计算
        zeros(3) = Frames.Orientation.equalityConstraint(frame_a.R, R_start);
    elseif useQuaternions then
        // frame_a.R 由四元数 Q 计算
        zeros(3) = Frames.Quaternions.Orientation.equalityConstraint(Q, Q_start);
    else
        // frame_a.R 由三个角度 'phi' 计算
        phi = phi_start;
    end if;
end if;

equation
if enforceStates then
    Connections.root(frame_a.R);
else
    Connections.potentialRoot(frame_a.R);
end if;
r_0 = frame_a.r_0;

if not Connections.isRoot(frame_a.R) then
    // 构件没有状态
    // 虚拟值
    Q = {0,0,0,1};
    phi = zeros(3);
    phi_d = zeros(3);
    phi_dd = zeros(3);
elseif useQuaternions then
    // 使用四元数作为状态(具有动态状态选择)
    frame_a.R = Frames.from_Q(Q, Frames.Quaternions.angularVelocity2(Q, der(Q)));
    {0} = Frames.Quaternions.orientationConstraint(Q);

    // 虚拟值
    phi = zeros(3);
    phi_d = zeros(3);
    phi_dd = zeros(3);
else
    // 使用 Cardan 角作为状态
    phi_d = der(phi);
    phi_dd = der(phi_d);
    frame_a.R = Frames.axesRotations(
        sequence_angleStates, 
        phi, 
        phi_d);

    // 虚拟值
    Q = {0,0,0,1};
end if;

// 在全局坐标系中解析的质心处的重力加速度
g_0 = world.gravityAcceleration(frame_a.r_0 + Frames.resolve1(frame_a.R, 
    r_CM));

// 平动运动学微分方程
v_0 = der(frame_a.r_0);
a_0 = der(v_0);

// 旋转运动学微分方程
w_a = Frames.angularVelocity2(frame_a.R);
z_a = der(w_a);

/* 以质心为参考的牛顿/欧拉方程
        a_CM = a_a + cross(z_a, r_CM) + cross(w_a, cross(w_a, r_CM));
        f_CM = m*(a_CM - g_a);
        t_CM = I*z_a + cross(w_a, I*w_a);
   frame_a.f = f_CM
   frame_a.t = t_CM + cross(r_CM, f_CM);
插入前三个方程到最后两个方程中得到：
*/

  frame_a.f = m*(Frames.resolve2(frame_a.R, a_0 - g_0) + cross(z_a, r_CM) + 
    cross(w_a, cross(w_a, r_CM)));
  frame_a.t = I*z_a + cross(w_a, I*w_a) + cross(r_CM, frame_a.f);
  annotation (Icon(coordinateSystem(
        preserveAspectRatio=true, 
        extent={{-100,-100},{100,100}}), graphics={
        Rectangle(
          extent={{-100,30},{-3,-30}}, 
          lineColor={0,24,48}, 
          fillPattern=FillPattern.HorizontalCylinder, 
          fillColor={0,127,255}, 
          radius=10), 
        Text(
          extent={{150,-100},{-150,-70}}, 
          textString="m=%m"), 
        Text(
          extent={{-150,110},{150,70}}, 
          textString="%name", 
          textColor={0,0,255}), 
        Ellipse(
          extent={{-20,60},{100,-60}}, 
          lineColor={0,24,48}, 
          fillPattern=FillPattern.Sphere, 
          fillColor={0,127,255})}), Documentation(info="<html>
<p>
<strong>刚体</strong>具有质量和转动惯量张量。
所有参数矢量必须在frame_a中解析。
<strong>转动惯量张量</strong>必须相对于与frame_a平行的坐标系定义，原点位于物体的质心。
</p>
<p>
默认情况下，此组件通过位于frame_a和质心之间的<strong>圆柱体</strong>以及以质心为中心的<strong>球体</strong>进行可视化。
如果圆柱体长度小于球体的半径，例如，因为frame_a位于质心，圆柱体不会显示出来。
请注意，可以通过参数animation=<strong>false</strong>关闭动画。
</p>
<div>
<img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/Parts/Body.png\"alt=\"Parts.Body\">
</div>

<p>
<strong>刚体组件的状态</strong></p>

<p>
每个物体都有潜在状态变量。
如果可能，工具将选择运动副的状态而不是物体的状态，因为这通常是最有效的选择。
在这种情况下，物体的frame_a的位置、方向、速度和角速度将由连接到frame_a的组件计算。
但是，如果一个物体在空间中自由运动，则必须使用物体的变量作为状态。
物体的潜在状态变量包括：</p>
<ul>
<li>从全局坐标系的原点到物体frame_a的原点的<strong>位置矢量</strong>frame_a.r_0，解析为全局坐标系和frame_a原点的<strong>绝对速度</strong>v_0，解析为全局坐标系(=der(frame_a.r_0))。
</li>
<li>如果\"高级\"菜单中的参数<strong>useQuaternions</strong>为<strong>true</strong>(这是默认值)，则有<strong>4个四元数</strong>作为潜在状态变量。
此外，物体的绝对角速度矢量的坐标是3个潜在状态变量。
<br>
如果\"高级\"菜单中的参数<strong>useQuaternions</strong>为<strong>false</strong>，则<strong>3个角度</strong>和这些角度的导数是潜在状态变量。
frame_a的方向是通过沿参数矢量\"sequence_angleStates\"(默认值={1,2,3}，即Cardan角序列)定义的轴旋转全局坐标系来计算的，围绕作为潜在状态变量的角度旋转。
例如，默认情况下，围绕angles[1]旋转全局坐标系的x轴，围绕angles[2]旋转新的y轴，围绕angles[3]旋转新的z轴，得到frame_a。
</li>
</ul>

<p>
四元数的微小劣势在于四个四元数之间存在非线性约束方程。
因此，在模拟过程中至少必须解决一个非线性方程。
然而，一个工具可能会分析性地解决这个简单的约束方程。
使用3个角度作为状态的劣势在于存在一个奇异配置，其中会发生除以零的情况。
如果可以事先确定对于一个应用类别，这个奇异配置位于操作区域之外，那么可以通过设置<strong>useQuaternions</strong>=<strong>false</strong>来使用3个角度作为潜在状态变量。
</p>
<p>
在关于三维力学的教科书中，通常使用3个角度和角速度作为状态。
但在这里并非如此，因为3个角度及其导数被用作潜在状态变量(如果useQuaternions=false)。
原因是对于实时模拟，积分器的离散化公式可能会被“内联”并与物体方程一起求解。
通过适当的符号转换，如果使用角度及其导数作为状态，而不是角度和角速度，则性能会大大提高。
</p>
<p>
是否将物体的变量用作状态通常由Modelica翻译器自动选择。
如果在\"高级\"菜单中将参数<strong>enforceStates</strong>设置为<strong>true</strong>，则根据参数\"useQuaternions\"和\"sequence_angleStates\"的设置，强制使用物体变量作为状态。
</p>

</html>"));
end Body;