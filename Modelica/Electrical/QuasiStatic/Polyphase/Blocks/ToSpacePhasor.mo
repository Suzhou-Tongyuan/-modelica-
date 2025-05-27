within Modelica.Electrical.QuasiStatic.Polyphase.Blocks;
block ToSpacePhasor "转换：m相->空间矢量"
  extends Modelica.Blocks.Icons.Block;
  // import Modelica.ComplexMath.j;
  // import Modelica.ComplexMath.exp;
  // import Modelica.ComplexMath.sum;
  // 导入sum与原始复数方程一起使用：
  // c = sqrt(2)/m*sum({u[k]*exp(j*phi[k]) for k in 1:m});
  parameter Integer m(min=1) = 3 "相数" annotation(Evaluate=true);
  Modelica.ComplexBlocks.Interfaces.ComplexInput u[m] 
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
  Modelica.Blocks.Interfaces.RealOutput y[2] 
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));
protected
  parameter SI.Angle phi[m]= 
      Modelica.Electrical.Polyphase.Functions.symmetricOrientation(m);
  Complex c;
equation
  // c = sqrt(2)/m*sum({u[k]*exp(j*phi[k]) for k in 1:m});
  // 由于 https://trac.openmodelica.org/OpenModelica/ticket/4496 的替代实现
  c.re = sqrt(2)/m*sum(u[k].re*cos(phi[k])-u[k].im*sin(phi[k]) for k in 1:m);
  c.im = sqrt(2)/m*sum(u[k].re*sin(phi[k])+u[k].im*cos(phi[k]) for k in 1:m);
  y = {c.re,c.im};
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
            100,100}}), graphics={
        Line(points={{0,0},{80,80},{60,72},{72,60},{80,80}}, color={85,170,255}), 
        Line(points={{0,0},{80,-80},{72,-60},{60,-72},{80,-80}}, color={85,170,255}), 
        Line(
          points={{-80,0},{-73.33,10},{-66.67,17.32},{-60,20},{-53.33,17.32}, 
              {-46.67,10},{-40,0},{-33.33,-10},{-26.67,-17.32},{-20,-20},{-13.33, 
              -17.32},{-6.67,-10},{0,0}}, 
          color={85,170,255}, 
          smooth=Smooth.Bezier), 
        Line(
          points={{-90,0},{-83.33,10},{-76.67,17.32},{-70,20},{-63.33,17.32}, 
              {-56.67,10},{-50,0},{-43.33,-10},{-36.67,-17.32},{-30,-20},{-23.33, 
              -17.32},{-16.67,-10},{-10,0}}, 
          color={85,170,255}, 
          smooth=Smooth.Bezier), 
        Line(
          points={{-70,0},{-63.33,10},{-56.67,17.32},{-50,20},{-43.33,17.32}, 
              {-36.67,10},{-30,0},{-23.33,-10},{-16.67,-17.32},{-10,-20},{-3.33, 
              -17.32},{3.33,-10},{10,0}}, 
          color={85,170,255}, 
          smooth=Smooth.Bezier), 
        Text(
          extent={{-12,-74},{64,-86}}, 
          textString="零点")}), 
    Documentation(info="<html>
<p>
将m相值（电压或电流）转换为空间矢量。
</p>
</html>"));
end ToSpacePhasor;