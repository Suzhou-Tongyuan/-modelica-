within Modelica.Magnetic.QuasiStatic.FluxTubes.Basic;
model Short "捷径分支"
  extends Interfaces.TwoPort;
equation
  V_m = Complex(0,0);
annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100, 
            -100},{100,100}}), graphics={
        Line(points={{-100,0},{100,0}}, color={255,170,85}), 
      Text(
        extent={{-150,50},{150,90}}, 
        textString="%name", 
        textColor={0,0,255})}), Documentation(
        info="<html>
<p>
这是一条简单的捷径。这个分量的磁电压等于零.
</p></html>", 
          revisions="<html>
</html>"));
end Short;