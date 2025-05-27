within Modelica.Electrical.Machines.SpacePhasors.Blocks;
block ToSpacePhasor 
  "将多相瞬时值转换为空间矢量的转换器"
  extends Modelica.Blocks.Interfaces.MIMO(final nin=m, final nout=2);
  parameter Integer m(min=1) = 3 "相数" annotation(Evaluate=true);
protected
  parameter SI.Angle phi[m]= 
      Modelica.Electrical.Polyphase.Functions.symmetricOrientation(m);
  parameter Real TransformationMatrix[2, m]=2/m*{+cos(+phi),+sin(+phi)};
  parameter Real InverseTransformation[m, 2]={{+cos(-phi[k]),-sin(-phi[k])} 
      for k in 1:m};
public
  Modelica.Blocks.Interfaces.RealOutput zero "零序分量" 
    annotation (Placement(transformation(extent={{100,-70},{120,-90}})));
equation
  m*zero = sum(u);
  y = TransformationMatrix*u;
  //u = fill(zero,m) + InverseTransformation*y;
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
            100,100}}), graphics={Line(points={{0,0},{80,80},{60,72},{72, 
          60},{80,80}}, color={0,0,255}),Line(points={{0,0},{80,-80},{72, 
          -60},{60,-72},{80,-80}}, color={0,0,255}),Line(
                points={{-80,0},{-73.33,10},{-66.67,17.32},{-60,20},{-53.33, 
            17.32},{-46.67,10},{-40,0},{-33.33,-10},{-26.67,-17.32},{-20, 
            -20},{-13.33,-17.32},{-6.67,-10},{0,0}}, 
                color={0,0,255}, 
                smooth=Smooth.Bezier),Line(
                points={{-90,0},{-83.33,10},{-76.67,17.32},{-70,20},{-63.33, 
            17.32},{-56.67,10},{-50,0},{-43.33,-10},{-36.67,-17.32},{-30, 
            -20},{-23.33,-17.32},{-16.67,-10},{-10,0}}, 
                color={0,0,255}, 
                smooth=Smooth.Bezier),Line(
                points={{-70,0},{-63.33,10},{-56.67,17.32},{-50,20},{-43.33, 
            17.32},{-36.67,10},{-30,0},{-23.33,-10},{-16.67,-17.32},{-10, 
            -20},{-3.33,-17.32},{3.33,-10},{10,0}}, 
                color={0,0,255}, 
                smooth=Smooth.Bezier),Text(
                extent={{-12,-74},{64,-86}}, 
                textString="zero")}), 
    Documentation(info="<html>
将多相值(电压或电流)转换为空间矢量和零序值的转换过程。
</html>"));
end ToSpacePhasor;