within Modelica.Mechanics.Rotational.Sources;
model Accelerate 
  "根据加速度信号强制转动一维转动接口的模型"
  extends 
    Modelica.Mechanics.Rotational.Interfaces.PartialElementaryOneFlangeAndSupport2;
  SI.Angle phi(
    start=0, 
    fixed=true, 
    stateSelect=StateSelect.prefer) 
    "一维转动接口相对支撑组件的旋转角度";
  SI.AngularVelocity w(
    start=0, 
    fixed=true, 
    stateSelect=StateSelect.prefer) 
    "一维转动接口相对支撑组件的角速度";
  SI.AngularAcceleration a 
    "一维转动接口相对支撑组件的角加速度";

  Modelica.Blocks.Interfaces.RealInput a_ref(unit="rad/s2") 
    "作为输入信号的一维转动接口相对支撑组件的绝对角加速度" 
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));

equation
  phi = flange.phi - phi_support;
  w = der(phi);
  a = der(w);
  a = a_ref;
  annotation (
    Documentation(info="<html>
<p>
输入信号<strong>a</strong>定义了一个<strong>角加速度</strong>，单位为[rad/s2]。一维转动接口<strong>flange</strong>以该加速度相对于一维转动接口支撑组件<strong>强制转动</strong>。
角速度<strong>w</strong>和旋转角度<strong>phi</strong>通过对加速度进行积分来确定。
</p>
<p>
输入信号可以从Modelica.Blocks.Sources模块库中的信号发生器块中提供。
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
    Line(points={{-30.0,-32.0},{30.0,-32.0}}), 
    Line(points={{0.0,52.0},{0.0,32.0}}), 
    Line(points={{-29.0,32.0},{30.0,32.0}}), 
    Line(points={{0.0,-32.0},{0.0,-100.0}}), 
    Text(textColor={0,0,255}, 
      extent={{-150.0,60.0},{150.0,100.0}}, 
      textString="%name"), 
    Text(extent={{-140,-60},{-40,-30}}, 
          textColor={128,128,128}, 
          horizontalAlignment=TextAlignment.Right, 
          textString="a_ref")}));
end Accelerate;