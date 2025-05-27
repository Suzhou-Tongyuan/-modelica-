within Modelica.ComplexBlocks.ComplexMath;
block TransferFunction "复数传递函数"
  extends Modelica.ComplexBlocks.Interfaces.ComplexSISO;
  import Modelica.ComplexMath.j;
  parameter Real b[:]={1} 
    "传递函数的分母系数（例如，2*s+3 指定为 {2,3})";
  parameter Real a[:]={1} 
    "传递函数的分母系数（例如，5*s+6 指定为 {5,6})";
  Modelica.Blocks.Interfaces.RealInput w(unit="rad/s") "角频率输入" annotation (Placement(transformation(
        extent={{-20,-20},{20,20}}, 
        rotation=90, 
        origin={0,-120})));
protected
  Complex bw[size(b,1)];
  Complex aw[size(a,1)];
  Complex bSum;
  Complex aSum;
equation
  bw = {b[i]*(j*w)^(i-1) for i in 1:size(b,1)};
  aw = {a[i]*(j*w)^(i-1) for i in 1:size(a,1)};
  bSum = Complex(sum(bw.re), sum(bw.im));
  aSum = Complex(sum(aw.re), sum(aw.im));
  y = u*bSum/aSum;
  annotation (Icon(graphics={
      Text(
        textColor={85,170,255}, 
        extent={{-90,10},{90,90}}, 
          textString="b(jw)"), 
        Line(points={{-80,0},{80,0}}, 
          color={85,170,255}), 
      Text(
        textColor={85,170,255}, 
        extent={{-90,-90},{90,-10}}, 
          textString="a(jw)")}), Documentation(info="<html>
<p>
复数输入u与复数传递函数(取决于角频率输入ω)相乘，得到复数输出 y (nb 是 b 的维度，na 是 a 的维度):
</p>
<blockquote><pre>
        b[1]*(jw)^[nb-1] + b[2]*(jw)^[nb-2] + ... + b[nb]
y(jw) = ------------------------------------------------- * u(jw)
        a[1]*(jw)^[na-1] + a[2]*(jw)^[na-2] + ... + a[na]
</pre></blockquote>
</html>"));
end TransferFunction;