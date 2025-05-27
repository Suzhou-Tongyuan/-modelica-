within Modelica.Magnetic.QuasiStatic.FundamentalWave.Components;
model Permeance "典型的磁导"
  import Modelica.Constants.pi;
  extends Interfaces.TwoPort;
  parameter Magnetic.FundamentalWave.Types.SalientPermeance G_m(d(start=1), q(
        start=1)) "Magnetic permeance in d=re and q=im axis";
equation
  (pi/2)*G_m.d*V_m.re = Phi.re;
  (pi/2)*G_m.q*V_m.im = Phi.im;
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100, 
            -100},{100,100}}), graphics={
                                  Rectangle(
              extent={{-70,30},{70,-30}}, 
              lineColor={255,170,85}, 
              fillColor={255,255,255}, 
              fillPattern=FillPattern.Solid),Line(points={{-96,0},{-70,0}}, 
          color={255,170,85}),Line(points={{70,0},{96,0}}, color={255,170, 
          85}), 
        Text(
          extent={{150,90},{-150,50}}, 
          textColor={0,0,255}, 
          textString="%name")}), 
                  Documentation(info="<html>
<p>
显著磁导率模拟了复磁位差之间的关系
<img src=\"modelica://Modelica/Resources/Images/Magnetic/FundamentalWave/V_m.png\" alt=\"V_m.png\">和复杂磁通量<img src=\"modelica://Modelica/Resources/Images/Magnetic/FundamentalWave/Phi.png\">:
</p>

<blockquote>
<img src=\"modelica://Modelica/Resources/Images/Magnetic/FundamentalWave/Components/permeance.png\"
      alt=\"reluctance.png\">
</blockquote>

</html>"));
end Permeance;