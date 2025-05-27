within Modelica.Electrical.PowerConverters.DCAC.Control;
block SVPWM "空间矢量脉冲宽度调制"
  parameter SI.Frequency f "开关频率";
  extends Modelica.Blocks.Interfaces.DiscreteBlock(final samplePeriod=1/f);
  import Modelica.Constants.small;
  import Modelica.Constants.eps;
  import Modelica.Constants.pi;
  import Modelica.Math.atan2;
  constant Integer m=3 "相数";
  parameter Real uMax "空间矢量的最大长度 = 六边形的半对角线";
  constant Boolean fire[6,m]=[true, false,false;
                              true, true, false;
                              false,true, false;
                              false,true, true;
                              false,false,true;
                              true, false,true] "开关模式";
  Modelica.Blocks.Interfaces.RealInput u[2] "参考空间相量" 
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
  Modelica.Blocks.Interfaces.BooleanOutput fire_p[m] "正火信号" 
    annotation (Placement(transformation(extent={{100,50},{120,70}})));
  Modelica.Blocks.Interfaces.BooleanOutput fire_n[m] "负火信号" 
    annotation (Placement(transformation(extent={{100,-70},{120,-50}})));
protected
  discrete Real uRef(start=0, fixed=true) "参考矢量的长度";
  discrete SI.Angle phiRef(start=0, fixed=true) "参考矢量的角度在 (-pi, +pi] 范围内";
  discrete SI.Angle phiPos(start=0, fixed=true) "参考矢量的角度在 [0, 2*pi) 范围内";
  Integer ka(start=0, fixed=true), kb(start=0, fixed=true) "限制扇区的开关模式";
  discrete SI.Angle phiSec(start=0, fixed=true) "扇区内参考矢量的角度范围 [0, pi/m)";
  discrete Real ta(start=0, fixed=true), tb(start=0, fixed=true), t0(start=samplePeriod, fixed=true) "矢量 a, b, 和 0 的相对时间跨度";
  discrete SI.Time T0(start=startTime, fixed=true) "开关周期的开始时间";
algorithm
  when sampleTrigger then
    // 限制相对参考信号
    uRef:=min(sqrt(u[1]^2 + u[2]^2)/(2/3*uMax), cos(pi/6));
    // 确定参考信号的角度在 (-pi, +pi] 范围内
    phiRef:=if noEvent(uRef < small) then 0 else atan2(u[2], u[1]);
    // 将角度转换为 [0, 2*pi) 范围内
    phiPos:=max(phiRef + (if phiRef < -eps then 2*pi else 0), 0);
    // 确定扇区和相邻扇区
    ka:=integer(phiPos/(pi/m));
    kb:=if noEvent(ka >= 5) then 0 else ka + 1;
    // 确定扇区内的角度范围 [0, pi/m)
    phiSec:=phiPos - ka*pi/m;
    // 确定相对时间跨度
    // uRef*cos(phiSec)=tb*cos(pi/m) + ta;
    // uRef*sin(phiSec)=tb*sin(pi/m);
    tb:=min(uRef*sin(phiSec)/sin(pi/m), 1);
    ta:=min(uRef*cos(phiSec) - tb*cos(pi/m), 1);
    t0:=max(1 - ta - tb, 0);
    // 记录开关周期的开始时间
    T0:=time;
  end when;
equation
  // 分配开关模式 t0/4 + ta/2 + tb/2 + t0/2 + tb/2 + t2/2 + t0/4
  if time<startTime then
    fire_p= fill(true, m);
  elseif (time - T0)/samplePeriod < (t0/4) then
    fire_p= fill(false, m);
  elseif (time - T0)/samplePeriod < (t0/4 + ta/2) then
    fire_p= fire[ka + 1, :];
  elseif (time - T0)/samplePeriod < (t0/4 + ta/2 + tb/2) then
    fire_p= fire[kb + 1, :];
  elseif (time - T0)/samplePeriod < (t0/4 + ta/2 + tb/2 + t0/4) then
    fire_p= fill(true, m);
  elseif (time - T0)/samplePeriod < (t0/4 + ta/2 + tb/2 + t0/4 + tb/2) then
    fire_p= fire[kb + 1, :];
  elseif (time - T0)/samplePeriod < (t0/4 + ta/2 + tb/2 + t0/4 + tb/2 + ta/2) then
    fire_p= fire[ka + 1, :];
  else
    fire_p= fill(false, m);
  end if;
  fire_n= not fire_p;
  annotation (defaultComponentName="svPWM", Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Line(points={{-80,30},{-36,30},{-36,50},{-10,50},{-10,30},{10,30},{10,50}, 
              {36,50},{36,30},{80,30}}, color={255,0,0}), 
        Line(points={{-80,-10},{-70,-10},{-70,10},{-36,10},{-36,-10},{36,-10},{36, 
              10},{70,10},{70,-10},{80,-10}}, color={0,0,255}), 
        Line(points={{-80,-50},{-80,-30},{-70,-30},{-70,-50},{-10,-50},{-10,-30}, 
              {10,-30},{10,-50},{70,-50},{70,-30},{80,-30},{80,-50}}, color={0,0, 
              0})}),    Documentation(info="<html>
<p>
对于三相系统，根据以下开关模式，共有8个空间矢量可用：
</p>
<ul>
<li>0 [0,0,0] 长度为0</li>
<li>1 [1,0,0] 000&deg;</li>
<li>2 [1,1,0] 060&deg;</li>
<li>3 [0,1,0] 120&deg;</li>
<li>4 [0,1,1] 180&deg;</li>
<li>5 [0,0,1] 240&deg;</li>
<li>6 [1,0,1] 300&deg;</li>
<li>7 [1,1,1] 长度为0</li>
</ul>
<p>
矢量 1 到 6 构成一个六边形，矢量 0 和 7 的长度为0。
</p>
<p>
首先，限制空间矢量，
并确定输入空间矢量 <u>u</u> 位于六边形中的扇区；
然后计算该空间矢量在该扇区内的角度 0&le;&phi;&lt;60&deg;。
</p>
<p>
通过以下方程确定一个开关周期内的平均值：
</p>
<ul>
<li>实部: <u>u</u>*cos(&phi;) = <u>u</u><sub>b</sub>*t<sub>b</sub>*cos(60&deg;) + <u>u</u><sub>a</sub>*t<sub>a</sub>*1</li>
<li>虚部: <u>u</u>*sin(&phi;) = <u>u</u><sub>b</sub>*t<sub>b</sub>*sin(60&deg;)</li>
<li>t<sub>a</sub> + t<sub>b</sub> + t<sub>0</sub> = 1</li>
</ul>
<p>
为了获得正火信号，开关时间跨度被对称分配：
t<sub>0</sub>/4 + t<sub>a</sub>/2 + t<sub>b</sub>/2 +t<sub>0</sub>/2 + t<sub>b</sub>/2 + t<sub>a</sub>/2 + t<sub>0</sub>/4
</p>
<p>
负火信号的开关模式与正火信号的开关模式相反。
</p>
</html>"));
end SVPWM;