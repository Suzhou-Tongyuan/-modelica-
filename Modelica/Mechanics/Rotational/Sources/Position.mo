within Modelica.Mechanics.Rotational.Sources;
model Position 
  "根据参考角度信号强制一维转动接口的转动"
  extends Modelica.Mechanics.Rotational.Interfaces.PartialElementaryOneFlangeAndSupport2;
  parameter Boolean exact=false 
    "输入信号是否进行精确处理/滤波，分别为真/假" 
    annotation (Evaluate=true);
  parameter SI.Frequency f_crit=50 
    "如果exact=false，则用于滤波输入信号的临界频率" 
    annotation (Dialog(enable=not exact));
  SI.Angle phi(stateSelect=if exact then StateSelect.default else StateSelect.prefer) 
    "一维转动接口相对于支撑组件的旋转角度";
  SI.AngularVelocity w(start=0, 
    stateSelect=if exact then StateSelect.default else StateSelect.prefer) 
    "如果exact=false，则为一维转动接口相对于支撑组件的角速度，否则为虚拟变量" 
    annotation(Dialog(enable=not exact, showStartAttribute = true));
  SI.AngularAcceleration a(start=0) 
    "如果exact=false，则为一维转动接口相对于支撑组件的角加速度，否则为虚拟变量" 
    annotation(Dialog(enable=not exact, showStartAttribute = true));
  Modelica.Blocks.Interfaces.RealInput phi_ref(
    final quantity="Angle", 
    final unit="rad", 
    displayUnit="deg") 
    "作为输入信号的一维转动接口相对于支撑组件的参考角度" 
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));

protected
  parameter SI.AngularFrequency w_crit=2*Modelica.Constants.pi*f_crit "临界频率";
  constant Real af=1.3617 "Bessel滤波器的s系数";
  constant Real bf=0.6180 "Bessel滤波器的s*s系数";
initial equation
  if not exact then
    phi = phi_ref;
  end if;
equation
  phi = flange.phi - phi_support;
  if exact then
    phi = phi_ref;
    w = 0;
    a = 0;
  else
    // 滤波器：a = phi_ref*s^2/(1 + (af/w_crit)*s + (bf/w_crit^2)*s^2)
    w = der(phi);
    a = der(w);
    a = ((phi_ref - phi)*w_crit - af*w)*(w_crit/bf);
  end if;
  annotation (
    Documentation(info="<html>
<p>
输入信号<strong>phi_ref</strong>定义了<strong>参考角度</strong>（单位为弧度）。
一维转动接口<strong>flange</strong>会根据相对于一维转动接口支撑组件根据参数<strong>exact</strong>（默认为<strong>false</strong>）的参考运动<strong>强制</strong>转动。
具体实现方式如下：
</p>
<ol>
<li><strong>exact=true</strong><br>
    参考角度会被<strong>精确</strong>处理。
    但这仅限于在输入信号可以被至少求两次导的解析函数定义时才可实现。
    如果满足这一前提条件，Modelica编译器将对输入信号求两次导，以计算一维转动接口的参考加速度。</li>
<li><strong>exact=false</strong><br>
    参考角度会被<strong>滤波</strong>处理，并使用滤波后曲线的二阶导数来计算一维转动接口的参考加速度。
    这个二阶导数不是通过数值微分计算得出，而是通过滤波器的适当实现得出。
    滤波时使用了二阶贝塞尔滤波器。
    滤波器的临界频率（也称为截止频率）通过参数<strong>f_crit</strong>（单位为赫兹）定义。
    该值应选取得比信号中的主要低频成分高。</li>
</ol>
<p>
输入信号可以从Modelica.Blocks.Sources库中的信号发生器块之一提供。
</p>
</html>"), 
       Icon(
    coordinateSystem(preserveAspectRatio=true, 
      extent={{-100.0,-100.0},{100.0,100.0}}), 
      graphics={
    Rectangle(lineColor={64,64,64}, 
      fillColor={192,192,192}, 
      fillPattern=FillPattern.HorizontalCylinder, 
      extent={{-100.0,-20.0},{100.0,20.0}}), 
    Line(points={{-30,-32},{30,-32}}), 
    Line(points={{0,52},{0,32}}), 
    Line(points={{-29,32},{30,32}}), 
    Line(points={{0,-32},{0,-100}}), 
    Text(extent={{-150,-60},{-40,-30}}, 
          textColor={128,128,128}, 
          textString="phi_ref", 
          horizontalAlignment=TextAlignment.Right), 
    Text(textColor={0,0,255}, 
      extent={{-150,60},{150,100}}, 
      textString="%name"), 
    Text(extent={{30,-60},{150,-30}}, 
      textString="exact="), 
    Text(extent={{30,-90},{150,-60}}, 
      textString="%exact")}));
end Position;