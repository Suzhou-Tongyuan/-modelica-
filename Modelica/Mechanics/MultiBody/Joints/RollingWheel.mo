within Modelica.Mechanics.MultiBody.Joints;
model RollingWheel 
  "描述理想滚轮(在平面z=0上滚动)的运动副(无质量，无转动惯量)"

  import Modelica.Mechanics.MultiBody.Frames;

  Modelica.Mechanics.MultiBody.Interfaces.Frame_a frame_a 
    "固定在轮毂中心点的参考系。
x轴：向上，y轴：沿着轮轴方向" 
    annotation (Placement(transformation(extent={{-16,-16},{16,16}})));

  parameter SI.Radius radius "滚轮半径";
  parameter StateSelect stateSelect=StateSelect.always 
    "将广义坐标用作状态的优先级" annotation(HideResult=true,Evaluate=true);

  SI.Position x(start=0, stateSelect=stateSelect) "滚轮轴的x坐标";
  SI.Position y(start=0, stateSelect=stateSelect) "滚轮轴的y坐标";
  SI.Position z;

  SI.Angle angles[3](start={0,0,0}, each stateSelect=stateSelect) 
    "将世界参考系旋转到frame_a参考系所需的角度，分别绕z轴、y轴、x轴旋转" 
    annotation(Dialog(group="初始值", showStartAttribute=true));

  SI.AngularVelocity der_angles[3](start={0,0,0}, each stateSelect=stateSelect) 
    "角度的导数" 
    annotation(Dialog(group="初始值", showStartAttribute=true));

  SI.Position r_road_0[3] 
    "从世界参考系到路面接触点的位置矢量，以世界参考系为基准";

  // 接触力
  SI.Force f_wheel_0[3] "作用在滚轮上的接触力，以世界参考系为基准";
  SI.Force f_n "作用在滚轮上的法向接触力";
  SI.Force f_lat "作用在滚轮上的横向接触力";
  SI.Force f_long "作用在滚轮上的纵向接触力";
  SI.Position err "|r_road_0-frame_a.r_0|-radius(必须为零；用于检查)";

protected
  Real e_axis_0[3] "滚轮轴方向的单位矢量，以世界参考系为基准";
  SI.Position delta_0[3](start={0,0,-radius}) "从滚轮中心到接触点的距离矢量";

   // 接触点处的坐标系
  Real e_n_0[3] 
    "路面接触点处的法向单位矢量，以世界参考系为基准";
  Real e_lat_0[3] 
    "滚轮接触点处的横向单位矢量，以世界参考系为基准";
  Real e_long_0[3] 
    "滚轮接触点处的纵向单位矢量，以世界参考系为基准";

  // 路面描述
  SI.Position s "路面参数1";
  SI.Position w "路面参数2";
  Real e_s_0[3] "在(s，w)处的路面方向，以世界参考系为基准(单位矢量)";

  // 滑动速度
  SI.Velocity v_0[3] "滚轮中心的速度，以世界参考系为基准";
  SI.AngularVelocity w_0[3] "滚轮的角速度，以世界参考系为基准";
  SI.Velocity vContact_0[3] "滚轮接触点的速度，以世界参考系为基准";

  // 辅助矢量
  Real aux[3];

equation
  // frame_a.R 从广义坐标计算而来
  Connections.root(frame_a.R);
  frame_a.r_0 = {x,y,z};
  der_angles  = der(angles);
  frame_a.R = Frames.axesRotations({3,2,1}, angles, der_angles);

  // 路面描述
  r_road_0 = {s,w,0};
  e_n_0    = {0,0,1};
  e_s_0    = {1,0,0};

  // 接触点处的坐标系 (e_long_0, e_lat_0, e_n_0)
  e_axis_0  = Frames.resolve1(frame_a.R, {0,1,0});
  aux       = cross(e_n_0, e_axis_0);
  e_long_0 = aux / Modelica.Math.Vectors.length(aux);
  e_lat_0  = cross(e_long_0, e_n_0);

  // 确定滚轮与路面接触的点
  delta_0 = r_road_0 - frame_a.r_0;
  0 = delta_0*e_axis_0;
  0 = delta_0*e_long_0;

  // 一个完整的位置约束方程(不允许进入地面)
  0 = radius - delta_0*cross(e_long_0, e_axis_0);

  // 仅用于测试
  err = Modelica.Math.Vectors.length(delta_0) - radius;

  // 滑动速度
  v_0 = der(frame_a.r_0);
  w_0 = Frames.angularVelocity1(frame_a.R);
  vContact_0 = v_0 + cross(w_0, delta_0);

  // 两个速度级别的非完整约束方程(理想滚动，不滑动)
  0 = vContact_0*e_long_0;
  0 = vContact_0*e_lat_0;

  // 接触力
  f_wheel_0 = f_n*e_n_0 + f_lat*e_lat_0 + f_long*e_long_0;

  // 轮毂中心的力和力矩平衡
  zeros(3) = frame_a.f + Frames.resolve2(frame_a.R, f_wheel_0);
  zeros(3) = frame_a.t + Frames.resolve2(frame_a.R, cross(delta_0, f_wheel_0));

  // 防止奇异性
  assert(abs(e_n_0*e_axis_0) < 0.99, "滚轮几乎与地面重合(这是一个奇异性)");

 annotation (
    Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100, -100},{100,100}}), graphics={
        Rectangle(
          extent={{-100,-80},{100,-100}}, 
          fillColor={175,175,175}, 
          fillPattern=FillPattern.Solid), 
        Text(
          extent={{-150,120},{150,80}}, 
          textColor={0,0,255}, 
          textString="%name"), 
        Ellipse(
          extent={{-80,80},{80,-80}}, 
          fillColor={255,255,255}, 
          fillPattern=FillPattern.Solid)}), 
    Documentation(info="<html>
<p>
一个用于滚轮在全局坐标系的x-y平面上滚动的连接件。
滚动接触被视为理想情况，即滚轮与地面之间没有滑动。
通过在速度级别上定义的两个非完整约束方程，分别定义了滚轮的纵向和横向方向。
还有一个位置级别上的完整约束方程，保证滚轮与地面之间保持永久接触，即滚轮无法离开地面。
</p>
<p>
frame_a坐标系的原点放置在滚轮自身的旋转轴与滚轮中平面的交点上，并随着滚轮本身一起旋转。
frame_a的y轴与滚轮的旋转轴相同，即滚轮围绕frame_a的y轴旋转。
应将质量和转动惯量集中到与此坐标系连接的滚轮主体上。
</p>

<h4>注意</h4>
<p>
为了正常工作，世界的重力加速度矢量g必须指向负z轴，即</p>
<blockquote><pre>
<span style=\"font-family:'Courier New',courier; color:#0000ff;\">inner</span><span style=\"font-family:'Courier New',courier; color:#ff0000;\">Modelica.Mechanics.MultiBody.World</span>world(n={0,0,-1});
</pre></blockquote>
</html>"));

end RollingWheel;