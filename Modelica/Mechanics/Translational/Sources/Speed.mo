within Modelica.Mechanics.Translational.Sources;
model Speed "根据参考速度强制移动一维平动接口"
  extends 
    Modelica.Mechanics.Translational.Interfaces.PartialElementaryOneFlangeAndSupport2(
     s(
      start=0, 
      fixed=true, 
      stateSelect=StateSelect.prefer));
  parameter Boolean exact=false 
    "是否精确处理/过滤输入信号，true/false分别表示" 
    annotation (Evaluate=true);
  parameter SI.Frequency f_crit=50 
    "如果exact=false，则为过滤输入信号的滤波器的临界频率" 
    annotation (Dialog(enable=not exact));
  SI.Velocity v(stateSelect=if exact then StateSelect.default else 
        StateSelect.prefer) "一维平动接口的绝对速度";
  SI.Acceleration a 
    "如果exact=false，则为一维平动接口的绝对加速度，否则为虚拟值";
  Modelica.Blocks.Interfaces.RealInput v_ref(unit="m/s") 
    "一维平动接口的参考速度作为输入信号" annotation (Placement(
        transformation(extent={{-140,-20},{-100,20}})));

protected
  parameter SI.AngularFrequency w_crit=2*Modelica.Constants.pi 
      *f_crit "临界频率";
initial equation
  if not exact then
    v = v_ref;
  end if;
equation
  v = der(s);
  if exact then
    v = v_ref;
    a = 0;
  else
    // 滤波器: a = v_ref/(1 + (1/w_crit)*s)
    a = der(v);
    a = (v_ref - v)*w_crit;
  end if;

  annotation (
    Documentation(info="<html>
<p>
输入信号 <strong>v_ref</strong> 定义了 [m/s] 中的 <strong>参考速度</strong>。一维平动接口 <strong>flange</strong> 根据此参考运动强制相对于支撑连接器移动。根据参数
<strong>exact</strong>(默认值为 <strong>false</strong>)，处理方式如下:
</p>
<ol>
<li><strong>exact=true</strong><br>
    参考速度被 <strong>精确处理</strong>。只有当输入信号由至少可以一次微分的解析函数定义时才可能。如果满足此先决条件，
    Modelica 翻译器将对输入信号进行一次微分，以计算一维平动接口的参考加速度。</li>
<li><strong>exact=false</strong><br>
    参考速度被<strong>滤波</strong>，并使用滤波曲线的一阶导数来计算一维平动接口的参考加速度。此一阶导数<strong>不</strong>通过数值微分计算，而是通过滤波器的适当实现计算的。为了进行滤波，使用一阶滤波器。
    滤波器的临界频率(也称为截止频率)通过参数 <strong>f_crit</strong> 定义，单位为 [Hz]。此值应该选择为高于信号中的基本低频的值。</li>
</ol>
<p>
输入信号可以来自 Modelica.Blocks.Sources 块库中的信号生成器块之一。
</p>

</html>"), 
    Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,100}}), 
      graphics={
        Line(points={{-30,-32},{30,-32}}, color={0,127,0}), 
        Line(points={{0,-32},{0,-100}}, color={0,127,0}), 
        Rectangle(
          extent={{-100,20},{100,-20}}, 
          lineColor={0,127,0}, 
          fillColor={160,215,160}, 
          fillPattern=FillPattern.Solid), 
        Line(points={{-29,32},{30,32}}, color={0,127,0}), 
        Line(points={{0,52},{0,32}}, color={0,127,0}), 
        Text(
          extent={{150,60},{-150,100}}, 
          textString="%name", 
          textColor={0,0,255}), 
        Text(extent={{-140,-60},{-40,-30}}, 
          textColor={128,128,128}, 
          horizontalAlignment=TextAlignment.Right, 
          textString="v_ref"), 
        Text(extent={{30,-60},{150,-30}}, 
          textString="exact="), 
        Text(extent={{30,-90},{150,-60}}, 
          textString="%exact")}));
end Speed;