within Modelica.Magnetic.FluxTubes.Shapes.Force;
model LeakageAroundPoles 
  "圆柱形或棱柱形磁极周围的漏磁通管"

  extends BaseClasses.Force;
  SI.Length l=s "轴向长度（通量方向）" annotation (Dialog(
        group="Variable geometry", groupImage= 
          "modelica://Modelica/Resources/Images/Magnetic/FluxTubes/Shapes/LeakageAroundPoles.png"));
  parameter SI.Length w=0.1 
    "与通量正交的宽度；圆柱形磁极情况下通量管的平均周长";
  parameter SI.Radius r=0.01 "泄漏场半径";

equation
  //改编自[Ka08]，但已更正
  //([Ka08]中的方程意外地与一个类似元素的方程对调)
  G_m = mu_0*w/pi*Modelica.Math.log(1 + pi*r/l);

  //全长导数:
  //  dGmBydx = mu_0 * w /pi * 1/(1 + pi * r/l) * (-1)*pi*r/l^2  * dlBydx;
  //简化:
  dGmBydx = -mu_0*w*r*dlBydx/(l^2*(1 + pi*r/l));

  annotation (defaultComponentName="force", Documentation(info="<html>
<p>
请参阅所附子包<a href=\"modelica://Modelica.Magnetic.FluxTubes.Shapes. Force\">Force</a>用于此包的所有元素的描述.
</p>

<p>
两极之间的棱柱状或圆柱形气隙周围的泄漏通量可以用该模型来描述。由于泄漏场的半径r是恒定的，所以模型比较简单。而实际上，当气隙长度大于此半径时，泄漏半径近似恒定，当气隙长度小于泄漏半径时，泄漏半径减小。对于较小的气隙，这里忽略这种减少，因为泄漏磁通管的影响与封闭的主气隙(并联连接)相比，随着气隙长度l的减小而减小.
</p>

<p>
请注意，在<a href=\"modelica://Modelica.Magnetic.FluxTubes.UsersGuide.Literature\">[Ka08]</a> G_m的方程被意外地与一个类似元素的方程交换了.
</p>
</html>"));
end LeakageAroundPoles;