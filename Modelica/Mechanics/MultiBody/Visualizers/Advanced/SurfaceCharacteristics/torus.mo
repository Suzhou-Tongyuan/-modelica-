within Modelica.Mechanics.MultiBody.Visualizers.Advanced.SurfaceCharacteristics;
function torus "定义环面曲面特性的函数"
  extends Modelica.Mechanics.MultiBody.Interfaces.partialSurfaceCharacteristic(
    final multiColoredSurface=false);
  input SI.Length R=1 "主半径(从环面中心到管道中心的距离)" annotation(Dialog);
  input SI.Length r=0.2 "次半径(管道半径)" annotation(Dialog);
  input SI.Angle opening=0 "环面的开口角度" annotation(Dialog);
  input SI.Angle startAngle= -Modelica.Constants.pi 
    "环面切片的起始角度" annotation(Dialog);
  input SI.Angle stopAngle= Modelica.Constants.pi 
    "环面切片的结束角度" annotation(Dialog);
protected
  SI.Angle alpha;
  SI.Angle beta;
  SI.Angle phi_start;
  SI.Angle phi_stop;
algorithm
  phi_start :=-Modelica.Constants.pi + opening;
  phi_stop  :=Modelica.Constants.pi - opening;
  for i in 1:nu loop
    alpha := startAngle + (stopAngle-startAngle)*(i-1)/(nu-1);
    for j in 1:nv loop
      beta := phi_start + (phi_stop-phi_start)*(j-1)/(nv-1);
      X[i,j] := (R + r*Modelica.Math.cos(beta))*Modelica.Math.sin(alpha);
      Y[i,j] := r*Modelica.Math.sin(beta);
      Z[i,j] := (R + r*Modelica.Math.cos(beta))*Modelica.Math.cos(alpha);
    end for;
  end for;

  annotation (Documentation(info="<html>
<p>
函数<strong>torus</strong>计算X、Y和Z数组，以可视化具有模型<a href=\"modelica://Modelica.Mechanics.MultiBody.Visualizers.Torus\">Torus</a>的环面。
下图左侧显示了主半径为<var>R</var>&nbsp;=&nbsp;0.5&nbsp;m和次半径为<var>r</var>&nbsp;=&nbsp;0.2&nbsp;m的环面。
下图右侧显示了具有额外参数设置的环面：</p>
<blockquote><pre>
opening=45度
startAngle=-135度
stopAngle=135度
</pre></blockquote>

<blockquote>
<img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/Visualizers/Torus.png\">
</blockquote>
</html>"));
end torus;