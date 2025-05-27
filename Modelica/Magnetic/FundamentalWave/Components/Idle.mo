within Modelica.Magnetic.FundamentalWave.Components;
model Idle "开路分支"
  extends Magnetic.FundamentalWave.Interfaces.TwoPort;
  equation
  Phi = Complex(0, 0);
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
            100,100}}), graphics={           Line(points={{-100,0},{-40,0}}, 
          color={255,128,0}),Line(points={{40,0},{100,0}}, color={255,128,0}), 
          Text(
              extent={{-150,20},{150,60}}, 
              textColor={0,0,255}, 
              textString="%name")}), 
    Documentation(info="<html>
<p>
这是一个开路分支.
</p>

<h4>另见</h4>
<p>
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.Components.Short\">Short</a>,
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.Components.Crossing\">Crossing</a>
</p>

</html>"));
end Idle;