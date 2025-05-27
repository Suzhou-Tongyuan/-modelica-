within Modelica.Mechanics.MultiBody.Frames.Internal;
function maxWithoutEvent 
  "输入参数的最大值，无需区分事件和功能"
  extends Modelica.Icons.Function;
  input Real u1;
  input Real u2;
  output Real y;
algorithm
  y := if u1 > u2 then u1 else u2;
  annotation (
    Inline=false, 
    derivative=maxWithoutEvent_d, 
    Documentation(info="<html>
<h4>语法</h4>
<blockquote><pre>
y = Internal.<strong>maxWithoutEvent</strong>(u1, u2)
</pre></blockquote>

<h4>描述</h4>
<p>
函数<strong>maxWithoutEvent</strong>返回其两个输入参数的最大值。 
此函数用于替代Modelica内置函数\"max\"或带有\"noEvent(&hellip;)\"的if语句，
以便可以通过提供第一和第二导数来对函数进行微分的额外函数。 
请注意，从严格的数学角度来看，导数将是错误的，因为在导数中会出现Dirac脉冲。
对于MultiBody库中使用的特殊情况，这是不相关的，因此使用该函数是正确的。
</p>
</html>"));
end maxWithoutEvent;