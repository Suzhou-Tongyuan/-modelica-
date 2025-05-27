within Modelica.Mechanics.Rotational.Sources;
model Speed 
  "根据参考角速度信号强制一维转动接口转动"
  extends 
    Modelica.Mechanics.Rotational.Interfaces.PartialElementaryOneFlangeAndSupport2;
  parameter Boolean exact=false 
    "exact为true时精确处理输入信号，为false时对输入信号进行滤波" 
    annotation (Evaluate=true);
  parameter SI.Frequency f_crit=50 
    "如果exact为false，则为用于滤波输入信号的滤波器的临界频率" 
    annotation (Dialog(enable=not exact));
  SI.Angle phi(
    start=0, 
    fixed=true, 
    stateSelect=StateSelect.prefer) 
    "一维转动接口相对于支撑组件的旋转角度";
  SI.AngularVelocity w(stateSelect=if exact then StateSelect.default else 
        StateSelect.prefer) 
    "一维转动接口相对于支撑组件的角速度";
  SI.AngularAcceleration a 
    "如果exact为false，则为一维转动接口相对于支撑组件的角加速度，否则为虚拟变量";
  Modelica.Blocks.Interfaces.RealInput w_ref(unit="rad/s") 
    "作为输入信号的一维转动接口相对于支撑组件的参考角速度" 
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));

protected
  parameter SI.AngularFrequency w_crit=2*Modelica.Constants.pi 
      *f_crit "临界频率";
initial equation
  if not exact then
    w = w_ref;
  end if;
equation
  phi = flange.phi - phi_support;
  w = der(phi);
  if exact then
    w = w_ref;
    a = 0;
  else
    // 滤波器: a = w_ref/(1 + (1/w_crit)*s)
    a = der(w);
    a = (w_ref - w)*w_crit;
  end if;
  annotation (
    Documentation(info="<html>
<p>
输入信号<strong>w_ref</strong>定义了[rad/s]单位下的
<strong>参考速度</strong>。
一维转动接口<strong>flange</strong>根据此参考运动相对于一维转动接口支撑组件<strong>强制</strong>转动。
根据参数<strong>exact</strong>(默认为<strong>false</strong>)，
将以以下方式完成：
</p>
<ol>
<li><strong>exact=true</strong><br>
    参考速度被<strong>精确</strong>处理。
    这仅在输入信号由可至少求导一次的解析函数定义时才有可能。
    如果满足这一前提条件，Modelica翻译器将对输入信号进行一次求导，以计算一维转动接口的参考加速度。</li>
<li><strong>exact=false</strong><br>
    参考角度被<strong>滤波</strong>处理，
    并使用滤波后曲线的二阶导数来计算一维转动接口的参考加速度。
    这个二阶导数不是通过数值微分计算得到的，而是通过滤波器的适当实现来计算的。
    对于滤波，使用了一阶滤波器。
    滤波器的临界频率(也称为截止频率)通过参数<strong>f_crit</strong>在[Hz]单位下定义。
    这个值应该选择得足够高，以便它高于信号中的基本低频。</li>
</ol>
<p>
输入信号可以从Modelica.Blocks.Sources块库中的信号发生器块之一提供。
</p>
</html>"), 
       Icon(
    coordinateSystem(preserveAspectRatio=true, 
      extent={{-100.0,-100.0},{100.0,100.0}}), 
      graphics={
    Text(extent={{-140,-60},{-40,-30}}, 
          textColor={128,128,128}, 
          horizontalAlignment=TextAlignment.Right, 
          textString="w_ref"), 
    Text(extent={{30,-60},{150,-30}}, 
      textString="exact="), 
    Text(extent={{30,-90},{150,-60}}, 
      textString="%exact"), 
    Rectangle(lineColor={64,64,64}, 
      fillColor={192,192,192}, 
      fillPattern=FillPattern.HorizontalCylinder, 
      extent={{-100.0,-20.0},{100.0,20.0}}), 
    Line(points={{-30.0,-32.0},{30.0,-32.0}}), 
    Line(points={{0.0,52.0},{0.0,32.0}}), 
    Line(points={{-29.0,32.0},{30.0,32.0}}), 
    Line(points={{0.0,-32.0},{0.0,-100.0}}), 
    Text(textColor={0,0,255}, 
      extent={{-150,60},{150,100}}, 
      textString="%name")}));
end Speed;