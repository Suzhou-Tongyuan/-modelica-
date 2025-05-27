within Modelica.Mechanics.Translational.Sources;
model Position 
  "根据参考位置强制移动一维平动接口"
  extends 
    Modelica.Mechanics.Translational.Interfaces.PartialElementaryOneFlangeAndSupport2(
     s(stateSelect=if exact then StateSelect.default else StateSelect.prefer));
  parameter Boolean exact=false 
    "如果为 true，则对输入信号进行精确处理/过滤；如果为 false，则进行过滤" 
    annotation (Evaluate=true);
  parameter SI.Frequency f_crit=50 
    "如果 exact=false，则为过滤输入信号的关键频率" 
    annotation (Dialog(enable=not exact));
  SI.Velocity v(start=0, 
    stateSelect=if exact then StateSelect.default else StateSelect.prefer) 
    "如果 exact=false，则为一维平动接口的绝对速度；否则为虚拟量" 
    annotation(Dialog(enable=not exact, showStartAttribute = true));
  SI.Acceleration a(start=0) 
    "如果 exact=false，则为一维平动接口的绝对加速度；否则为虚拟量" 
    annotation(Dialog(enable=not exact, showStartAttribute = true));
  Modelica.Blocks.Interfaces.RealInput s_ref(unit="m") 
    "一维平动接口的参考位置作为输入信号" annotation (Placement(
        transformation(extent={{-140,-20},{-100,20}})));
protected
  parameter SI.AngularFrequency w_crit=2*Modelica.Constants.pi*f_crit "关键频率";
  constant Real af=1.3617 "Bessel 过滤器的 s 系数";
  constant Real bf=0.6180 "Bessel 过滤器的 s*s 系数";

initial equation
  if not exact then
    s = s_ref;
  end if;
equation
  if exact then
    s = s_ref;
    v = 0;
    a = 0;
  else
    // 过滤器：a = s_ref*S^2/(1 + (af/w_crit)*S + (bf/w_crit^2)*S^2)
    v = der(s);
    a = der(v);
    a = ((s_ref - s)*w_crit - af*v)*(w_crit/bf);
  end if;

  annotation (
    Documentation(info="<html>
<p>
输入信号 <strong>s_ref</strong> 定义了 <strong>参考位置</strong> [m]。
一维平动接口 <strong>flange</strong> 被 <strong>强制</strong> 相对于支撑连接器按照此参考运动移动。
根据参数 <strong>exact</strong>（默认 = <strong>false</strong>），处理方式如下：
</p>
<ol>
<li><strong>exact=true</strong><br>
    参考位置 <strong>精确</strong> 处理。仅当输入信号由可以至少进行两次微分的解析函数定义时才可能。
    如果满足此先决条件，Modelica 翻译器将对输入信号进行两次微分，
    以计算一维平动接口的参考加速度。</li>
<li><strong>exact=false</strong><br>
    参考位置进行 <strong>过滤</strong>，并使用过滤曲线的二阶导数来计算一维平动接口的参考加速度。
    此二阶导数不是通过数值微分计算的，而是通过适当实现的过滤器计算的。
    使用了二阶 Bessel 过滤器进行过滤。
    过滤器的关键频率（也称为截止频率）通过参数 <strong>f_crit</strong> [Hz] 定义。
    此值应该选择得足够高，以覆盖信号中的重要低频。</li>
</ol>
<p>
输入信号可以来自于 Modelica.Blocks.Sources 块库中的信号发生器块之一。
</p>

</html>"), 
    Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,100}}), 
      graphics={
        Rectangle(
          extent={{-100,20},{100,-20}}, 
          lineColor={0,127,0}, 
          fillColor={160,215,160}, 
          fillPattern=FillPattern.Solid), 
        Text(
          extent={{150,60},{-150,100}}, 
          textString="%name", 
          textColor={0,0,255}), 
        Line(points={{0,52},{0,32}}, color={0,127,0}), 
        Line(points={{-29,32},{30,32}}, color={0,127,0}), 
        Line(points={{-30,-32},{30,-32}}, color={0,127,0}), 
        Line(points={{0,-32},{0,-100}}, color={0,127,0}), 
        Text(extent={{30,-60},{150,-30}}, 
          textString="exact="), 
        Text(extent={{30,-90},{150,-60}}, 
          textString="%exact"), 
        Text(extent={{-140,-60},{-40,-30}}, 
          textColor={128,128,128}, 
          horizontalAlignment=TextAlignment.Right, 
          textString="s_ref")}));
end Position;