within Modelica.Clocked.RealSignals.Periodic;
block StateSpace "离散时间状态空间模块"
  parameter Real A[:, size(A, 1)] "状态空间模型矩阵 A";
  parameter Real B[size(A, 1), :] "状态空间模型矩阵 B";
  parameter Real C[:, size(A, 1)] "状态空间模型矩阵 C";
  parameter Real D[size(C, 1), size(B, 2)]=zeros(size(C, 1), size(B, 2)) 
    "状态空间模型矩阵 D";
  extends Clocked.RealSignals.Interfaces.PartialClockedMIMO(final nin=size(
        B, 2), final nout=size(C, 1));
  output Real x[size(A, 1)](each start=0.0) "状态矢量";

equation
  when Clock() then
    x = A*previous(x) + B*u;
    y = C*previous(x) + D*u;
  end when;
  annotation (
    Documentation(info="<html><p>
该模块定义了离散时间模块的状态空间表示法，其中包含输入向量 u、输出向量 y 和状态向量 x：
</p>
<p>
<br>
</p>
<pre><code >x = A * previous(x) + B * u
y = C * previous(x) + D * u
</code></pre><p>
<br>
</p>
<p>
其中，previous(x) 是上一个时钟刻度处的时钟状态 x 的值。 输入是 nu 的矢量的长度，输出是 ny 的矢量的长度和 nx 是状态数。 因此
</p>
<p>
<br>
</p>
<pre><code >A has the dimension: A(nx,nx),
B has the dimension: B(nx,nu),
C has the dimension: C(ny,nx),
D has the dimension: D(ny,nu)
</code></pre><p>
<br>
</p>
<p>
例如:
</p>
<p>
<br>
</p>
<pre><code >  parameter: A = [0.12, 2;3, 1.5]
  parameter: B = [2, 7;3, 1]
  parameter: C = [0.1, 2]
  parameter: D = zeros(ny,nu)

results in the following equations:
  [x[1]]   [0.12  2.00] [previous(x[1])]   [2.0  7.0] [u[1]]
  [    ] = [          ]*[              ] + [        ]*[    ]
  [x[2]]   [3.00  1.50] [previous(x[2])]   [0.1  2.0] [u[2]]

                        [previous(x[1])]            [u[1]]
  y[1]   = [0.1  2.0] * [              ] + [0  0] * [    ]
                        [previous(x[2])]            [u[2]]
</code></pre><p>
<br>
</p>
<p>
<br>
</p>
</html>",revisions="<html>
<p><strong>Release Notes:</strong></p>
<ul>
<li><em>August 13, 2012</em>
    by <a href=\"http://www.dlr.de/rm/\">Bernhard Thiele</a>:<br>
    Used the code from Blocks.Discrete.StateSpace and converted it into
    the Modelica 3.3 clocked equation style.</li>
</ul>
</html>"), 
Icon(coordinateSystem(
        preserveAspectRatio=true, 
        extent={{-100,-100},{100,100}}), graphics={
        Text(
          extent={{-90,15},{-15,90}}, 
          textString="A", 
          textColor={0,0,127}), 
        Text(
          extent={{15,15},{90,90}}, 
          textString="B", 
          textColor={0,0,127}), 
        Text(
          extent={{-52,28},{54,-20}}, 
          textString="z", 
          textColor={0,0,127}), 
        Text(
          extent={{-90,-15},{-15,-90}}, 
          textString="C", 
          textColor={0,0,127}), 
        Text(
          extent={{15,-15},{90,-90}}, 
          textString="D", 
          textColor={0,0,127})}), 
    Diagram(coordinateSystem(
        preserveAspectRatio=true, 
        extent={{-100,-100},{100,100}}), graphics={
        Rectangle(extent={{-60,60},{60,-60}}, lineColor={0,0,255}), 
        Text(
          extent={{-54,50},{52,-10}}, 
          textString="zx=Ax+Bu"), 
        Text(
          extent={{-56,14},{54,-50}}, 
          textString="  y=Cx+Du"), 
        Line(points={{-102,0},{-60,0}}, color={0,0,255}), 
        Line(points={{60,0},{100,0}}, color={0,0,255})}));
end StateSpace;