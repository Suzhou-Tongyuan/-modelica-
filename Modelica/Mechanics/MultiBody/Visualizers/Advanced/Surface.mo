within Modelica.Mechanics.MultiBody.Visualizers.Advanced;
model Surface 
  "可视化可移动的、参数化的曲面；曲面特性由一个函数提供"
  extends Modelica.Mechanics.MultiBody.Icons.Surface;
  extends Modelica.Utilities.Internal.PartialModelicaServices.Animation.PartialSurface;
  extends ModelicaServices.Animation.Surface;
  annotation (Icon(graphics={Polygon(
          points={{-102,40},{-98,92},{28,-8},{96,146},{104,-118},{-18,-34},{-52, 
              -130},{-102,40}}, 
          lineColor={0,0,255}, 
          smooth=Smooth.Bezier, 
          fillColor={255,255,255}, 
          fillPattern=FillPattern.Solid), 
        Text(
          extent={{-150,140},{150,100}}, 
          textColor={0,0,255}, 
          textString="%name")}), Documentation(info="<html>
<p>
模型<strong>Surface</strong>定义了三维空间中的可移动、参数化表面，用于动画显示。
该对象由以下内容指定：</p>

<ul>
<li>表面坐标系(定向对象\"R\"和原点\"r_0\")，其中数据被指定。
</li>
<li>一组两个参数，一个在u方向，一个在v方向，定义了控制点。
</li>
<li>每个控制点相对于表面坐标系的时间变化位置。
</li>
</ul>

<p>
参数值(u, v)由相应控制点在u或v方向的序数号给出。
然后，表面由可替换函数\"surfaceCharacteristic\"定义，其接口为<a href=\"modelica://Modelica.Mechanics.MultiBody.Interfaces.partialSurfaceCharacteristic\">partialSurfaceCharacteristic</a>，该接口返回每个控制点的x、y、z坐标，以3个数组X、Y、Z的形式给出，以及一个可选的颜色数组C，如果每个控制点都应具有不同的颜色：</p>

<blockquote><pre>
RealX[nu,nv],Y[nu,nv],Z[nu,nv],C[nu,nv,3];
</pre></blockquote>

<p>
下图显示了带有颜色编码的参数化表面的示例：</p>

<blockquote>
<img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/Visualizers/Advanced/Surface.png\">
</blockquote>

<p>
模型<a href=\"modelica://Modelica.Mechanics.MultiBody.Visualizers.Torus\">Torus</a>,<a href=\"modelica://Modelica.Mechanics.MultiBody.Visualizers.VoluminousWheel\">VoluminousWheel</a>,<a href=\"modelica://Modelica.Mechanics.MultiBody.Visualizers.PipeWithScalarField\">PipeWithScalarField</a>，演示了如何使用Surface模型构建新的可视化对象。
<br>Surface模型的直接使用，以及Torus和VoluminousWheel模型的使用，都在示例<a href=\"modelica://Modelica.Mechanics.MultiBody.Examples.Elementary.Surfaces\">Examples.Elementary.Surfaces</a>中进行了演示。
</p>
</html>"));
end Surface;