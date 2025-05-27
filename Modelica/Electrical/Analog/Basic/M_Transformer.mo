within Modelica.Electrical.Analog.Basic;
model M_Transformer "通用变压器(可自由选择电感器数量)"

  parameter Integer N(final min = 1) = 3 "线圈的数量";
protected
  parameter Integer dimL = div(N * (N + 1), 2);
public
  parameter SI.Inductance L[dimL] = {1, 0.1, 0.2, 2, 0.3, 3} 
    "电感与耦合电感";
  Modelica.Electrical.Analog.Interfaces.PositivePin p[N] "正极" 
    annotation(Placement(transformation(extent = {{-110, -70}, {-90, 70}})));
  Modelica.Electrical.Analog.Interfaces.NegativePin n[N] "负极" 
    annotation(Placement(transformation(extent = {{90, -70}, {110, 70}})));

  SI.Voltage v[N] "电感元件上的电压降";
  SI.Current i[N](each start = 0, each fixed = true) 
    "电感元件上的电流降";
  parameter SI.Inductance Lm[N,N](each final fixed = false) 
    "完全对称的电感矩阵(内部计算)";

initial equation
  for s in 1:N loop
    Lm[s,s] = L[(s - 1) * N - div((s - 1) * s, 2) + s];
    for z in s + 1:N loop
      Lm[s,z] = L[(s - 1) * N - div((s - 1) * s, 2) + z];
      Lm[z,s] = L[(s - 1) * N - div((s - 1) * s, 2) + z];
    end for;
  end for;

equation
  for j in 1:N loop
    v[j] = p[j].v - n[j].v;
    0 = p[j].i + n[j].i;
    i[j] = p[j].i;
  end for;

  v = Lm * der(i);

  annotation(defaultComponentName = "transformer", Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, 
    {100, 100}}), graphics = {
    Text(
    extent = {{-150, 120}, {150, 80}}, 
    textString = "%name", 
    textColor = {0, 0, 255}), 
    Text(extent = {{-150, -80}, {150, -120}}, textString = "N=%N"), 
    Line(points = {{60, -50}, {90, -50}}, 
    color = {0, 0, 255}), 
    Line(points = {{-90, -50}, {-60, -50}}, 
    color = {0, 0, 255}), 
    Line(
    points = {{-60, -50}, {-59, -44}, {-52, -36}, {-38, -36}, {-31, -44}, {-30, -50}}, 
    color = {0, 0, 255}, 
    smooth = Smooth.Bezier), 
    Line(
    points = {{-30, -50}, {-29, -44}, {-22, -36}, {-8, -36}, {-1, -44}, {0, -50}}, 
    color = {0, 0, 255}, 
    smooth = Smooth.Bezier), 
    Line(
    points = {{0, -50}, {1, -44}, {8, -36}, {22, -36}, {29, -44}, {30, -50}}, 
    color = {0, 0, 255}, 
    smooth = Smooth.Bezier), 
    Line(
    points = {{30, -50}, {31, -44}, {38, -36}, {52, -36}, {59, -44}, {60, -50}}, 
    color = {0, 0, 255}, 
    smooth = Smooth.Bezier), 
    Line(points = {{60, 20}, {90, 20}}, 
    color = {0, 0, 255}), 
    Line(points = {{-90, 20}, {-60, 20}}, 
    color = {0, 0, 255}), 
    Line(
    points = {{-60, 20}, {-59, 26}, {-52, 34}, {-38, 34}, {-31, 26}, {-30, 20}}, 
    color = {0, 0, 255}, 
    smooth = Smooth.Bezier), 
    Line(
    points = {{-30, 20}, {-29, 26}, {-22, 34}, {-8, 34}, {-1, 26}, {0, 20}}, 
    color = {0, 0, 255}, 
    smooth = Smooth.Bezier), 
    Line(
    points = {{0, 20}, {1, 26}, {8, 34}, {22, 34}, {29, 26}, {30, 20}}, 
    color = {0, 0, 255}, 
    smooth = Smooth.Bezier), 
    Line(
    points = {{30, 20}, {31, 26}, {38, 34}, {52, 34}, {59, 26}, {60, 20}}, 
    color = {0, 0, 255}, 
    smooth = Smooth.Bezier), 
    Line(points = {{60, 50}, {90, 50}}, 
    color = {0, 0, 255}), 
    Line(points = {{-90, 50}, {-60, 50}}, 
    color = {0, 0, 255}), 
    Line(
    points = {{-60, 50}, {-59, 56}, {-52, 64}, {-38, 64}, {-31, 56}, {-30, 50}}, 
    color = {0, 0, 255}, 
    smooth = Smooth.Bezier), 
    Line(
    points = {{-30, 50}, {-29, 56}, {-22, 64}, {-8, 64}, {-1, 56}, {0, 50}}, 
    color = {0, 0, 255}, 
    smooth = Smooth.Bezier), 
    Line(
    points = {{0, 50}, {1, 56}, {8, 64}, {22, 64}, {29, 56}, {30, 50}}, 
    color = {0, 0, 255}, 
    smooth = Smooth.Bezier), 
    Line(
    points = {{30, 50}, {31, 56}, {38, 64}, {52, 64}, {59, 56}, {60, 50}}, 
    color = {0, 0, 255}, 
    smooth = Smooth.Bezier), 
    Ellipse(
    extent = {{-2, 6}, {2, 2}}, 
    lineColor = {0, 0, 255}, 
    fillColor = {0, 0, 255}, 
    fillPattern = FillPattern.Solid), 
    Ellipse(
    extent = {{-2, -22}, {2, -26}}, 
    lineColor = {0, 0, 255}, 
    fillColor = {0, 0, 255}, 
    fillPattern = FillPattern.Solid), 
    Ellipse(
    extent = {{-2, -8}, {2, -12}}, 
    lineColor = {0, 0, 255}, 
    fillColor = {0, 0, 255}, 
    fillPattern = FillPattern.Solid)}), 
    Documentation(info = "<html>
<p>该模型<em>M_Transformer</em>是一个变压器模型，具有选择电感器数量的功能。在模型内部，基于用户提供的参数向量构建了一个电感矩阵，该参数向量包括电感器的电感和电感器之间的耦合电感。

<p>举个例子说明用户的使用方法：<br>
用户选择了一个包含三个电感器的模型，这意味着参数<em><strong>N</strong></em>必须是strong>3</strong>。然后，用户必须指定三个电感器的电感和三个耦合电感。耦合电感不是真实存在的器件，而是发生在两个电感器之间的效应。电感(电感矩阵的主对角线)和耦合电感必须在参数向量L中指定。参数向量的长度<em>dimL</em>计算如下：<em><strong>dimL=(N*(N+1))/2</strong></em>。

<p>下面的例子展示了如何使用参数向量填充电感矩阵。要指定一个包含三个电感器的变压器的电感矩阵(<em>N=3</em>)：</p>

<div>
<img
 src=\"modelica://Modelica/Resources/Images/Electrical/Analog/Basic/M_Transformer-eq.png\"
 alt=\"L_m\">
</div>

<p>用户必须分配参数向量<em>L[6]</em>，因为<em>Nv=(N*(N+1))/2=(3*(3+1))/2=6</em>。用户必须按照以下方式填充参数向量：<em>L=[1,0.1,0.2,2,0.3,3]</em>。</p>
<p>在模型内部，使用了两个循环来填充电感矩阵，以确保它被填充的方式是对称的。</p>
</html>", 
    revisions = "<html>
<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
    <tr>
      <th>Version</th>
      <th>Revision</th>
      <th>Date</th>
      <th>Author</th>
      <th>Comment</th>
    </tr>
   <tr>
      <td></td>
      <td>4163</td>
      <td>2010-09-11</td>
      <td>Dietmar Winkler</td>
      <td>Documentation corrected according to documentation guidelines.</td>
    </tr>
    <tr>
      <td></td>
      <td></td>
      <td>2008-11-24</td>
      <td>Kristin Majetta</td>
      <td>Documentation added.</td>
    </tr>
    <tr>
      <td></td>
      <td></td>
      <td>2008-11-16</td>
      <td>Kristin Majetta</td>
      <td>Initially implemented</td>
    </tr>
</table>
</html>"));
end M_Transformer;