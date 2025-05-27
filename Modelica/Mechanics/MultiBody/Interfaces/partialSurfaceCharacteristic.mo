within Modelica.Mechanics.MultiBody.Interfaces;
partial function partialSurfaceCharacteristic "返回表面特征的函数接口"
  extends Modelica.Icons.Function;
  input Integer nu "u方向上的点的个数";
  input Integer nv "v方向上的点的个数";
  input Boolean multiColoredSurface = false 
    "= true: 每个表面点都定义了颜色";
  output SI.Position X[nu,nv] 
    "[nu,nv]，点的x方向上的位置，在表面坐标系中解析";
  output SI.Position Y[nu,nv] 
    "[nu,nv]，点的y方向上的位置，在表面坐标系中解析";
  output SI.Position Z[nu,nv] 
    "[nu,nv]，点的z方向上的位置，在表面坐标系中解析";
  output Real C[if multiColoredSurface then nu else 0,
                if multiColoredSurface then nv else 0,3] 
    "[nu,nv,3]，颜色数组，定义了每个表面点的颜色";
  annotation(Documentation(info = "<html>
<p>此部分函数定义了返回对象可视化的表面特性的函数接口，参见
<a href=\"modelica://Modelica.Mechanics.MultiBody.Visualizers.Advanced.SurfaceCharacteristics.torus\">Visualizers.Advanced.SurfaceCharacteristics.torus</a>。
</p>
</html>"));
end partialSurfaceCharacteristic;