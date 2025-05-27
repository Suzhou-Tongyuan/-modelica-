within Modelica.Magnetic.FundamentalWave.Interfaces;
model StateSelector 
  "将瞬时值转换为空间相位并选择状态"
  import Modelica.Constants.pi;
  parameter Integer m(min=3) = 3 "阶段数" annotation(Evaluate=true);
  input Real xi[m](each stateSelect=StateSelect.avoid) 
    "瞬时值" annotation (Dialog);
  input SI.Angle gamma "旋转角度" annotation (Dialog);
  parameter StateSelect x0StateSelect=StateSelect.prefer 
    "Priority to use zero systems as states";
  parameter StateSelect xrStateSelect=StateSelect.prefer 
    "优先使用旋转框架的空间相位作为状态";
  Real x0(stateSelect=x0StateSelect) = 1/sqrt(m)*sum(xi) "零点系统";
  Real x00(stateSelect=x0StateSelect) = 1/sqrt(m)*sum({xi[2*l - 1] - xi[2*l] 
    for l in 1:integer(m/2)}) if m == 2*integer(m/2) 
    "第二个零点系统（如果有）（MP 偶数）";
  final parameter Integer np=integer((m - 1)/2) "空间相位数";
  Complex xf[np](each re(stateSelect=StateSelect.avoid), each im(
        stateSelect=StateSelect.avoid)) "Space phasors w.r.t. fixed frame";
  Complex xr[np](each re(stateSelect=xrStateSelect), each im(stateSelect= 
          xrStateSelect)) "Space phasors w.r.t. rotating frame";
equation
  //空间相位变换
  for k in 1:np loop
    xf[k].re = 1/sqrt(m)*sum({cos(k*(l - 1)*2*pi/m)*xi[l] for l in 1:m});
    xf[k].im = 1/sqrt(m)*sum({sin(k*(l - 1)*2*pi/m)*xi[l] for l in 1:m});
    xr[k] = xf[k]*Modelica.ComplexMath.conj(Modelica.ComplexMath.exp(
      Complex(0, gamma)));
  end for;
  annotation (Documentation(info="<html>
<p>
将瞬时值转换为空间相位和零系统电流、
旋转空间相位并设置状态选择修饰符，以便在旋转框架内选择状态、
即导数较小的状态。
</p>
</html>"), 
       Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100}, 
            {100,100}}), graphics={Ellipse(
              extent={{-60,60},{60,-60}}, 
              lineColor={170,213,255}, 
              fillColor={170,213,255}, 
              fillPattern=FillPattern.Solid),Text(
              extent={{-60,60},{60,-60}}, 
              textString="S", 
              textColor={0,0,255}), Text(
              extent={{0,-60},{0,-100}}, 
              textColor={0,0,255}, 
              textString="%name")}));
end StateSelector;