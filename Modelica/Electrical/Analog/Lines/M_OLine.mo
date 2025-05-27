within Modelica.Electrical.Analog.Lines;
model M_OLine "复合有损传输线"

  parameter SI.Length length(final min = Modelica.Constants.small) = 
    0.1 "线路长度";
  parameter Integer N(final min = 2) = 5 "簇段的数量";
  parameter Integer lines(final min = 2) = 4 "线路数量";
protected
  parameter Integer dim_vector_lgc = div(lines * (lines + 1), 2);
public
  parameter Real r[lines](
    each final min = Modelica.Constants.small, 
    each unit = "Ohm/m") = {4.76e5, 1.72e5, 1.72e5, 1.72e5} "单位电阻";

  parameter Real l[dim_vector_lgc](
    each final min = Modelica.Constants.small, 
    each unit = "H/m") = {5.98e-7, 4.44e-7, 4.39e-7, 3.99e-7, 5.81e-7, 4.09e-7, 
    4.23e-7, 5.96e-7, 4.71e-7, 6.06e-7} "自感电抗(每米)";

  parameter Real g[dim_vector_lgc](
    each final min = Modelica.Constants.small, 
    each unit = "S/m") = {8.05e-6, 3.42e-5, 2.91e-5, 1.76e-6, 9.16e-6, 7.12e-6, 
    2.43e-5, 5.93e-6, 4.19e-5, 6.64e-6} "单位电导";

  parameter Real c[dim_vector_lgc](
    each final min = Modelica.Constants.small, 
    each unit = "F/m") = {2.38e-11, 1.01e-10, 8.56e-11, 5.09e-12, 2.71e-11, 2.09e-11, 
    7.16e-11, 1.83e-11, 1.23e-10, 2.07e-11} "单位电容";
  parameter SI.LinearTemperatureCoefficient alpha_R = 0 
    "电阻的温度因数(R_actual = R*(1 + alpha*(heatPort.T - T_ref))";
  parameter SI.LinearTemperatureCoefficient alpha_G = 0 
    "导电率的温度系数(G_actual = G/(1 + alpha*(heatPort.T - T_ref))";
  parameter Boolean useHeatPort = false "= true, if heatPort is enabled" 
    annotation(
    Evaluate = true, 
    HideResult = true, 
    choices(checkBox = true));
  parameter SI.Temperature T = 293.15 
    "修正后温度(当useHeatPort=false)" 
    annotation(Dialog(enable = not useHeatPort));
  parameter SI.Temperature T_ref = 300.15 "参考温度";
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatPort if useHeatPort 
    annotation(Placement(transformation(extent = {{-110, -110}, {-90, -90}}), 
    iconTransformation(extent = {{-110, -110}, {-90, -90}})));
  model segment "多线段模型"

    parameter Integer lines(final min = 1) = 3 "线的数量";
    parameter Integer dim_vector_lgc = div(lines * (lines + 1), 2) 
      "l,g,c向量的长度";
    Modelica.Electrical.Analog.Interfaces.PositivePin p[lines] "Positive pin" 
      annotation(Placement(transformation(extent = {{-110, -10}, {-90, 10}}), iconTransformation(extent = {{-110, -10}, {-90, 10}})));
    Modelica.Electrical.Analog.Interfaces.NegativePin n[lines] "Negative pin" 
      annotation(Placement(transformation(extent = {{90, -10}, {110, 10}}), iconTransformation(extent = {{90, -10}, {110, 10}})));

    parameter Real Cl[dim_vector_lgc] = fill(1, dim_vector_lgc) 
      "电容矩阵";
    parameter Real Rl[lines] = fill(7, lines) "电阻矩阵";
    parameter Real Ll[dim_vector_lgc] = fill(2, dim_vector_lgc) 
      "电感矩阵";
    parameter Real Gl[dim_vector_lgc] = fill(1, dim_vector_lgc) 
      "电导矩阵";
    parameter SI.LinearTemperatureCoefficient alpha_R 
      "电阻的温度因数(R_actual=R*(1+alpha*(heatPort.T-T_ref))";
    parameter SI.LinearTemperatureCoefficient alpha_G 
      "电导的温度因数(G_actual=G/(1+alpha*(heatPort.T-T_ref))";
    parameter Boolean useHeatPort = false "=true,如果heatPort状态为enabled" 
      annotation(
      Evaluate = true, 
      HideResult = true, 
      choices(checkBox = true));
    parameter SI.Temperature T = 293.15 
      "修正设备电压(当useHeatPort=false)" 
      annotation(Dialog(enable = not useHeatPort));
    parameter SI.Temperature T_ref;

    Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatPort if 
      useHeatPort annotation(Placement(transformation(extent = {{-10, -110}, {10, 
      -90}}), iconTransformation(extent = {{-110, -110}, {-90, -90}})));

    Modelica.Electrical.Analog.Basic.Capacitor C[dim_vector_lgc](C = Cl);
    Modelica.Electrical.Analog.Basic.Resistor R[lines](
      R = Rl, 
      T_ref = fill(T_ref, lines), 
      alpha = fill(alpha_R, lines), 
      useHeatPort = fill(useHeatPort, lines), 
      T = fill(T, lines));
    Modelica.Electrical.Analog.Basic.Conductor G[dim_vector_lgc](
      G = Gl, 
      T_ref = fill(T_ref, dim_vector_lgc), 
      alpha = fill(alpha_G, dim_vector_lgc), 
      useHeatPort = fill(useHeatPort, dim_vector_lgc), 
      T = fill(T, dim_vector_lgc));
    Modelica.Electrical.Analog.Basic.M_Transformer inductance(N = lines, L = Ll);
    Modelica.Electrical.Analog.Basic.Ground M;

  equation
    for j in 1:lines - 1 loop

      connect(R[j].p, p[j]);
      connect(R[j].n, inductance.p[j]);
      connect(inductance.n[j], n[j]);
      connect(inductance.n[j], C[((1 + (j - 1) * lines) - div(((j - 2) * (j - 1)), 
        2))].p);
      connect(C[((1 + (j - 1) * lines) - div(((j - 2) * (j - 1)), 2))].n, M.p);
      connect(inductance.n[j], G[((1 + (j - 1) * lines) - div(((j - 2) * (j - 1)), 
        2))].p);
      connect(G[((1 + (j - 1) * lines) - div(((j - 2) * (j - 1)), 2))].n, M.p);

      for i in j + 1:lines loop
        connect(inductance.n[j], C[((1 + (j - 1) * lines) - div(((j - 2) * (j - 1)), 
          2)) + 1 + i - (j + 1)].p);
        connect(C[((1 + (j - 1) * lines) - div(((j - 2) * (j - 1)), 2)) + 1 + i 
          - (j + 1)].n, inductance.n[i]);
        connect(inductance.n[j], G[((1 + (j - 1) * lines) - div(((j - 2) * (j - 1)), 
          2)) + 1 + i - (j + 1)].p);
        connect(G[((1 + (j - 1) * lines) - div(((j - 2) * (j - 1)), 2)) + 1 + i 
          - (j + 1)].n, inductance.n[i]);

      end for;
    end for;
    connect(R[lines].p, p[lines]);
    connect(R[lines].n, inductance.p[lines]);
    connect(inductance.n[lines], n[lines]);
    connect(inductance.n[lines], C[dim_vector_lgc].p);
    connect(C[dim_vector_lgc].n, M.p);
    connect(inductance.n[lines], G[dim_vector_lgc].p);
    connect(G[dim_vector_lgc].n, M.p);

    if useHeatPort then

      for j in 1:lines - 1 loop
        connect(heatPort, R[j].heatPort);
        connect(heatPort, G[((1 + (j - 1) * lines) - div(((j - 2) * (j - 1)), 2))].heatPort);
        for i in j + 1:lines loop
          connect(heatPort, G[((1 + (j - 1) * lines) - div(((j - 2) * (j - 1)), 2)) 
            + 1 + i - (j + 1)].heatPort);
        end for;
      end for;
      connect(heatPort, R[lines].heatPort);
      connect(heatPort, G[dim_vector_lgc].heatPort);
    end if;

    annotation(defaultComponentName = "segment", Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-100, 
      -100}, {100, 100}}), graphics = {Rectangle(extent = {{40, -40}, {-40, 40}}, 
      lineColor = {0, 0, 255}), 
      Text(
      extent = {{-150, 90}, {150, 50}}, 
      textString = "%name", 
      textColor = {0, 0, 255})}), Documentation(info = "<html>
<p>线段模型是多条线路模型的一部分，它描述了M_OLine描述中提到的一条线路段。通过Modelica的环路功能，可以将各个组件连接起来，组件的数量取决于线路的数量。</p>
</html>"  ));
  end segment;

  model segment_last "多线路末端线段模型"

    Modelica.Electrical.Analog.Interfaces.PositivePin p[lines] "Positive pin" 
      annotation(Placement(transformation(extent = {{-110, -10}, {-90, 10}}), iconTransformation(extent = {{-110, -10}, {-90, 10}})));
    Modelica.Electrical.Analog.Interfaces.NegativePin n[lines] "Negative pin" 
      annotation(Placement(transformation(extent = {{90, -10}, {110, 10}}), iconTransformation(extent = {{90, -10}, {110, 10}})));
    parameter Integer lines(final min = 1) = 3 "线的数量";
    parameter Integer dim_vector_lgc = div(lines * (lines + 1), 2) 
      "l,g,c向量的长度";
    parameter Real Rl[lines] = fill(1, lines) "电阻矩阵";
    parameter Real Ll[dim_vector_lgc] = fill(1, dim_vector_lgc) 
      "电感矩阵";
    parameter SI.LinearTemperatureCoefficient alpha_R 
      "电阻的温度因数(R_actual=R*(1+alpha*(heatPort.T-T_ref))";
    parameter Boolean useHeatPort = false "=true, 当HeatPort=enabled" 
      annotation(
      Evaluate = true, 
      HideResult = true, 
      choices(checkBox = true));
    parameter SI.Temperature T = 293.15 
      "修正设备温度，当useHeatPort=false" 
      annotation(Dialog(enable = not useHeatPort));
    parameter SI.Temperature T_ref;
    Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatPort if 
      useHeatPort annotation(Placement(transformation(extent = {{-10, -110}, {10, 
      -90}}), iconTransformation(extent = {{-110, -110}, {-90, -90}})));
    Modelica.Electrical.Analog.Basic.Resistor R[lines](
      R = Rl, 
      T_ref = fill(T_ref, lines), 
      useHeatPort = fill(useHeatPort, lines), 
      T = fill(T, lines));
    Modelica.Electrical.Analog.Basic.M_Transformer inductance(N = lines, L = Ll);
    Modelica.Electrical.Analog.Basic.Ground M;

  equation
    for j in 1:lines - 1 loop

      connect(p[j], inductance.p[j]);
      connect(inductance.n[j], R[j].p);
      connect(R[j].n, n[j]);

    end for;
    connect(p[lines], inductance.p[lines]);
    connect(inductance.n[lines], R[lines].p);
    connect(R[lines].n, n[lines]);

    if useHeatPort then
      for j in 1:lines - 1 loop
        connect(heatPort, R[j].heatPort);
      end for;
      connect(heatPort, R[lines].heatPort);
    end if;
    annotation(defaultComponentName = "segment", Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-100, 
      -100}, {100, 100}}), graphics = {Rectangle(extent = {{20, -40}, {-20, 40}}, 
      lineColor = {0, 0, 255}), 
      Text(
      extent = {{-150, 90}, {150, 50}}, 
      textString = "%name", 
      textColor = {0, 0, 255})}), Documentation(info = "<html><p>
segment_last 模型是Modelica中multiple line model的一部分，用于描述实现电路或线路对称所需的特殊线段。根据 M_OLine 的描述，可以使用 Modelica 中的环路模型来实现，通过连接一定数量的组件来表示。具体而言，segment_last模型的数量取决于线路的数量。
</p>
</html>"  ));
  end segment_last;

  segment s[N - 1](
    lines = fill(lines, N - 1), 
    dim_vector_lgc = fill(dim_vector_lgc, N - 1), 
    Rl = fill(r * length / N, N - 1), 
    Ll = fill(l * length / N, N - 1), 
    Cl = fill(c * length / N, N - 1), 
    Gl = fill(g * length / N, N - 1), 
    alpha_R = fill(alpha_R, N - 1), 
    alpha_G = fill(alpha_G, N - 1), 
    T_ref = fill(T_ref, N - 1), 
    useHeatPort = fill(useHeatPort, N - 1), 
    T = fill(T, N - 1));
  segment s_first(
    lines = lines, 
    dim_vector_lgc = dim_vector_lgc, 
    Rl = r * length / (2 * N), 
    Cl = c * length / (N), 
    Ll = l * length / (2 * N), 
    Gl = g * length / (N), 
    alpha_R = alpha_R, 
    alpha_G = alpha_G, 
    T_ref = T_ref, 
    useHeatPort = useHeatPort, 
    T = T);
  segment_last s_last(
    lines = lines, 
    Rl = r * length / (2 * N), 
    Ll = l * length / (2 * N), 
    alpha_R = alpha_R, 
    T_ref = T_ref, 
    useHeatPort = useHeatPort, 
    T = T);
  Modelica.Electrical.Analog.Interfaces.PositivePin p[lines] "正引脚" 
    annotation(Placement(transformation(extent = {{-110, -60}, {-90, 60}})));
  Modelica.Electrical.Analog.Interfaces.NegativePin n[lines] "负引脚" 
    annotation(Placement(transformation(extent = {{90, -60}, {110, 60}})));

equation
  connect(p, s_first.p);
  connect(s_first.n, s[1].p);
  for i in 1:N - 2 loop
    connect(s[i].n, s[i + 1].p);
  end for;
  connect(s[N - 1].n, s_last.p);
  connect(s_last.n, n);
  if useHeatPort then
    connect(heatPort, s_first.heatPort);
    for i in 1:N - 1 loop
      connect(heatPort, s[i].heatPort);
    end for;
    connect(heatPort, s_last.heatPort);
  end if;

  annotation(defaultComponentName = "line", Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-100, 
    -100}, {100, 100}}), graphics = {
    Rectangle(
    extent = {{80, 80}, {-80, -80}}, 
    lineColor = {0, 0, 255}, 
    fillPattern = FillPattern.Solid, 
    fillColor = {255, 255, 255}), 
    Line(points = {{40, 60}, {40, 40}}), 
    Line(points = {{40, 50}, {-40, 50}}), 
    Line(points = {{-40, 60}, {-40, 40}}), 
    Line(points = {{40, -40}, {40, -60}}), 
    Line(points = {{40, -50}, {-40, -50}}), 
    Line(points = {{-40, -40}, {-40, -60}}), 
    Line(points = {{40, 30}, {40, 10}}), 
    Line(points = {{40, 20}, {-40, 20}}), 
    Line(points = {{-40, 30}, {-40, 10}}), 
    Line(
    points = {{0, 6}, {0, -34}}, 
    color = {0, 0, 255}, 
    pattern = LinePattern.Dot), 
    Text(
    extent = {{-150, 130}, {150, 90}}, 
    textString = "%name", 
    textColor = {0, 0, 255})}), Documentation(info = "<html>
<p>M_OLine 是一个多线模型，由多个段和多条单线组成。每个段包括连在一起的电阻和电感，每条单线包括连接在一起的电容和导体，这些导体分别连接在线之间和接地。电感彼此成对出现，就像 M_Transformer模型中那样。下图显示了一个四条线(lines=4)的段的电路示意图。</p>

<blockquote>
<img src=\"modelica://Modelica/Resources/Images/Electrical/Analog/segment.png\"
     alt=\"segment.png\">
</blockquote>

<p>整个多线模型由N个段和一个辅助段组成</p>
<p align=\"center\"><code>-- segment_1 -- segment_2 -- ... -- segment_N -- segment_last --</code></p>
<p>在图片中可以看到，单个段是不对称的。将这样的不对称段连接成一个系列也会形成一个不对称的多线路。为了获得一个对称的模型，这对于耦合是有用的，并且保证相同的引脚特性，在segment_1中只使用了一半数值的电阻和电感。剩余的电阻和电感位于线路的另一端，在辅助段segment_last中。对于具有4条线的示例，segment_last的原理图如下：
</p>

<blockquote>
<img src=\"modelica://Modelica/Resources/Images/Electrical/Analog/segment_last.png\"
     alt=\"segment_last.png\">
</blockquote>

<p>电容器和导体的数量取决于使用的单根导线数量，因为每根导线通过电容器和导体与其他每根导线相连。一根导线至少由两个段组成。在模型M_OLine中使用了模型段。该模型表示按照上述描述构建的一个段。为了建模电感及其相互耦合，使用了模型M_Transformer。为填充电阻向量，需要与导线数量相同的电阻值，例如，如果有四根导线，则需要四个电阻值。例如，对于长度为0.1米的微电子导线，一个合理的电阻向量将是R=[4.76e5, 1.72e5, 1.72e5, 1.72e5]。
电容器和导体的数量取决于使用的单线的数量，因为每条线都通过一个电容器和一个导体与所有其他线相连。一条线<strong>至少由两个段</strong>组成。在模型M_OLine中，使用了模型段。该模型代表一个按照上述描述构建的段。为了模拟电感及其互耦，使用了模型 M_Transformer。为了填充电阻向量，需要与线数一样多的电阻值，例如，如果有四条线，则需要四个电阻。例如，对于长度为0.1米的微电子线路，一个合理的电阻向量可能是R=[4.76e5, 1.72e5, 1.72e5, 1.72e5]。
</p>
<p>填充电感矩阵、电容矩阵和导电矩阵的过程更为复杂，因为这些元件不仅存在于单条线上(如同电阻)，还存在于两条线之间的互连。矩阵的元素由用户以向量形式提供。向量的长度dim_vector_lgc由<strong>dim_vector_lgc=lines*(lines+1)/2</strong>计算得出，其中lines是线的数量。在模型中，用户提供的向量元素被用来构建一个对称的电感矩阵、一个对称的电容矩阵和一个对称的导电矩阵。每种矩阵的构建方式相同，所以我们将通过一个例子来展示填充其中一个矩阵的方法：
</p>
<p>假设线的数量为四。为了构建矩阵，模型需要从主对角线和位于主对角线下面的位置获取值。为了获得以下矩阵，请执行以下操作：
</p>

<blockquote>
<img src=\"modelica://Modelica/Resources/Images/Electrical/Analog/Lines/M_OLine-eqMatrix.png\" alt=\"Matrix\"/>
</blockquote>

<p>dim_vector_lgc=4*5/2=10必须以以下方式出现vector=[<strong>1</strong>, 0.1, 0.2, 0.4, <strong>2</strong>, 0.3 0.5, <strong>3</strong>, 0.6, <strong>4</strong>]</p>

<p>对于长度为0.1m的微电子线路，作为M_OLine模型的默认示例，模型合理的电感矩阵应该为：
</p>

<blockquote>
<img src=\"modelica://Modelica/Resources/Images/Electrical/Analog/Lines/M_OLine-eqL.png\" alt=\"L\"/>
</blockquote>

<p>对于长度为0.1米的微电子线路，该线路作为M_OLine模型的默认示例，模型合理的电容矩阵应该为：
</p>

<blockquote>
<img src=\"modelica://Modelica/Resources/Images/Electrical/Analog/Lines/M_OLine-eqC.png\" alt=\"C\"/>
</blockquote>

<p>对于长度为0.1米的微电子线路，该线路作为M_OLine模型的默认示例，模型合理的电导矩阵应该为：
</p>

<blockquote>
<img src=\"modelica://Modelica/Resources/Images/Electrical/Analog/Lines/M_OLine-eqG.png\" alt=\"G\"/>
</blockquote>

<p>用户可以选择启用一个条件式的热端口。如果这样做，M_OLine可以连接到一个热网络。当参数alpha设置为大于零的值时，由于其电阻器的电阻会根据公式R_actual=R*(1+alpha*(heatPort.T-T_ref))计算，而导体则根据公式G_actual = G/(1+alpha*(heatPort.T-T_ref))计算。请注意，M_OLine会变得对温度的变化及时响应。
</p>

</html>", 
    revisions = "<html>
<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
      <tr>
      <th>版本</th>
      <th>修订</th>
      <th>日期</th>
      <th>作者</th>
      <th>注释</th>
    </tr>
   <tr>
      <td></td>
      <td>4163</td>
      <td>2010-09-11</td>
      <td>Dietmar Winkler</td>
      <td>根据文档规范更正文档。</td>
    </tr>
    <tr>
      <td></td>
      <td></td>
      <td>2008-11-24</td>
      <td>Kristin Majetta</td>
      <td>添加文档。</td>
    </tr>
    <tr>
      <td></td>
      <td></td>
      <td>2007-02-26</td>
      <td>Kristin Majetta</td>
      <td>创建</td>
    </tr>
</table>

</html>"));
end M_OLine;