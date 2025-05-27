within Modelica.Mechanics.MultiBody.Visualizers.Advanced.SurfaceCharacteristics;
function pipeWithScalarField 
  "函数定义了管道曲面特性，其中标量场值沿着管道轴线以颜色显示"
  extends Modelica.Mechanics.MultiBody.Interfaces.partialSurfaceCharacteristic(
    final multiColoredSurface=true);
  input SI.Radius rOuter "圆柱体的外半径" annotation(Dialog);
  input SI.Length length "圆柱体的长度" annotation(Dialog);
  input SI.Position xsi[:] 
    "沿着管道的相对位置，其中x[1]=0，x[end]=1" annotation(Dialog);
  input Real T[size(xsi,1)] "位置xsi*length处的标量场值" annotation(Dialog);
  input Real T_min "T<=T_min映射到colorMap[1,:]中" annotation(Dialog);
  input Real T_max "T>=T_max映射到colorMap[end,:]中" annotation(Dialog);
  input Real colorMap[:,3] 
    "将标量T映射到相应颜色的颜色映射" annotation(Dialog);
protected
  Real beta;
  Real xsi_i;
  Real Ti;
  Real Ci[3];
  Integer k;
algorithm
  k:=1;
  for i in 1:nu loop
    // 计算沿圆柱体轴线的实际 xsi 位置
    xsi_i := (i-1)/(nu-1);

    // 在 xsi 和 T 中进行插值，确定 Ti(xsi_i) 的相应值
    (Ti,k) := Modelica.Math.Vectors.interpolate(xsi, T, xsi_i, k);

    // 将标量场值 Ti 映射到颜色值
    Ci := Modelica.Mechanics.MultiBody.Visualizers.Colors.scalarToColor(
      Ti, 
      T_min, 
      T_max, 
      colorMap);

    // 确定输出

    for j in 1:nv loop
      beta := 2*Modelica.Constants.pi*(j-1)/(nv-1);
      X[i,j] := length*xsi_i;
      Y[i,j] := rOuter*Modelica.Math.sin(beta);
      Z[i,j] := rOuter*Modelica.Math.cos(beta);
      C[i,j,:] := Ci;
    end for;
  end for;
  annotation (Documentation(info="<html>
<p>
函数<strong>pipeWithScalarField</strong>计算X、Y、Z和C数组，以便使用模型<a href=\"modelica://Modelica.Mechanics.MultiBody.Visualizers.Advanced.PipeWithScalarField\">PipeWithScalarField</a>可视化管道和沿管道轴线的标量场。
通过将标量场映射到颜色值，并在与相应轴位置相关联的周边使用此颜色来显示后者。
通常，标量场值是温度，但也可能是其他数量。
预定义的颜色映射可通过输入参数\"colorMap\"从<a href=\"modelica://Modelica.Mechanics.MultiBody.Visualizers.Colors.ColorMaps\">MultiBody.Visualizers.Colors.ColorMaps</a>中选择。
可以使用函数<a href=\"modelica://Modelica.Mechanics.MultiBody.Visualizers.Colors.colorMapToSvg\">MultiBody.Visualizers.Colors.colorMapToSvg</a>将具有相应标量场值的颜色映射导出为矢量图形的svg格式。
示例如下图所示：</p>

<blockquote>
<img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/Visualizers/PipeWithScalarField.png\">
</blockquote>

<p>
颜色编码如下图所示。
它是使用<a href=\"modelica://Modelica.Mechanics.MultiBody.Visualizers.Colors.colorMapToSvg\">Mechanics.MultiBody.Visualizers.Colors.colorMapToSvg</a>生成的，调用如下：</p>

<blockquote><pre>
colorMapToSvg(Modelica.Mechanics.MultiBody.Visualizers.Colors.ColorMaps.jet(),
height=50,nScalars=6,T_max=100,heading=\"Temperature in C\");
</pre></blockquote>

<blockquote>
<img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/Visualizers/PipeWithScalarField-ColorMap.png\">
</blockquote>

</html>"));
end pipeWithScalarField;