within Modelica.Mechanics.MultiBody.Joints.Internal;
model RollingConstraintVerticalWheel 
"始终垂直于x-y平面的滚轮滚动约束"
 import Modelica.Mechanics.MultiBody.Frames;

   Modelica.Mechanics.MultiBody.Interfaces.Frame_a frame_a 
   "固定在滚轮中心点的坐标系。
x轴：向上，y轴：沿着滚轮轴" 
     annotation (Placement(transformation(extent={{-16,4},{16,36}}), 
         iconTransformation(extent={{-16,4},{16,36}})));

   parameter SI.Radius radius "Wheelradius";

   parameter Boolean lateralSlidingConstraint = true 
   "=true，如果考虑侧向滑动约束，=false，如果侧向力=0(需要避免过度约束，如果两个理想的滚动滚轮连接在一个轴上)" 
                                                                                                       annotation(choices(checkBox=true),Evaluate=true);

   // 接触力
SI.Force f_wheel_0[3] 
"作用在滚轮上的接触力，在全局坐标系中分解";
SI.Force f_lat "作用在滚轮上的侧向接触力";
SI.Force f_long 
"作用在滚轮上的纵向接触力";
protected
Real e_axis_0[3] 
"沿着滚轮轴的单位矢量，在全局坐标系中分解";
SI.Position rContact_0[3] 
"从滚轮中心到接触点的距离矢量，在全局坐标系中分解";

// 接触点的坐标系
Real e_n_0[3] 
"在接触点处，道路法线方向的单位矢量，在全局坐标系中分解";
Real e_lat_0[3] 
"在接触点处，滚轮侧向方向的单位矢量，在全局坐标系中分解";
Real e_long_0[3] 
"在接触点处，滚轮纵向方向的单位矢量，在全局坐标系中分解";

// 滑动速度
SI.Velocity v_0[3] "滚轮中心的速度，在全局坐标系中分解";
SI.AngularVelocity w_0[3] 
"滚轮的角速度，在全局坐标系中分解";

SI.Velocity vContact_0[3] 
"滚轮接触点的速度，在全局坐标系中分解";

// 实用矢量
Real aux[3];
equation
    // 接触点处的坐标系(e_long_0，e_lat_0，e_n_0)
    e_n_0    = {0,0,1};
    e_axis_0 = Frames.resolve1(frame_a.R, {0,1,0});
    aux      = cross(e_n_0, e_axis_0);
    e_long_0 = aux / Modelica.Math.Vectors.length(aux);
    e_lat_0  = cross(e_long_0, e_n_0);

    // 滑动速度
    rContact_0 = {0,0,-radius};
    v_0 = der(frame_a.r_0);
    w_0 = Frames.angularVelocity1(frame_a.R);
    vContact_0 = v_0 + cross(w_0, rContact_0);

    // 速度水平面上的两个非完整约束方程(理想滚动，无打滑)
    0 = vContact_0*e_long_0;
    if lateralSlidingConstraint then
       0 = vContact_0*e_lat_0;
       f_wheel_0 = f_lat*e_lat_0 + f_long*e_long_0;
    else
       0 = f_lat;
       f_wheel_0 = f_long*e_long_0;
    end if;

    // 滚轮中心处的力和力矩平衡
    zeros(3) = frame_a.f + Frames.resolve2(frame_a.R, f_wheel_0);
    zeros(3) = frame_a.t + Frames.resolve2(frame_a.R, cross(rContact_0, f_wheel_0));
   annotation (Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100, 
             -100},{100,100}}), graphics={
         Rectangle(
           extent={{-100,-60},{100,-80}}, 
           fillColor={175,175,175}, 
           fillPattern=FillPattern.Solid), 
         Text(
           extent={{-148,-86},{152,-126}}, 
           textColor={0,0,255}, 
           textString="%name"), 
         Line(
           points={{0,-60},{0,4}}, 
           pattern=LinePattern.Dot), 
         Line(
           visible=lateralSlidingConstraint, 
           points={{-98,-30},{-16,-30}}), 
         Polygon(
           visible=lateralSlidingConstraint, 
           points={{-40,-16},{-40,-42},{-6,-30},{-40,-16}}, 
           fillColor={255,255,255}, 

           fillPattern=FillPattern.Solid)}), Documentation(info="<html>
<p>
用于滚轮在全局坐标系的x-y平面上滚动的连接旨在用于理想化的轮对。
为了实现这个目标，滚轮始终保持竖直，并且在滚轮/地面接触的纵向方向不允许滑动。
</p>
<p>
相反，滚轮可以选择在横向方向滑动，这对于轮对来说是合理的，其中只有一个滚轮应该在横向上受到约束。
</p>
<p>
坐标系frame_a被放置在滚轮旋转轴与滚轮中平面的交点处，并随滚轮自身一起旋转。
应该连接到该坐标系上的是一个收集质量和转动惯量的滚轮主体。
</p>

<h4>注意</h4>
<p>
为了正常工作，世界的重力加速度矢量g必须指向负z轴，即</p>
<blockquote><pre>
<span style=\"font-family:'Courier New',courier; color:#0000ff;\">inner</span><span style=\"font-family:'Courier New',courier; color:#ff0000;\">Modelica.Mechanics.MultiBody.World</span>world(n={0,0,-1});
</pre></blockquote>

</html>"));
end RollingConstraintVerticalWheel;