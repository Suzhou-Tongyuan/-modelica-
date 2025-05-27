within Modelica.Magnetic.QuasiStatic.FluxTubes.BaseClasses;
partial model Leakage "泄漏磁通管的基本类别，具有与位置无关的磁通，因此不产生力;mu_r = 1"

  extends Interfaces.TwoPort;
  extends Modelica.Magnetic.QuasiStatic.FluxTubes.Icons.Reluctance;

  SI.Reluctance R_m "磁阻";
  SI.Permeance G_m "磁导";

equation
  V_m = Phi*R_m;
  R_m = 1/G_m;

  annotation (Icon(coordinateSystem(
      preserveAspectRatio=false, 
      extent={{-100,-100},{100,100}}), graphics={
      Text(
        extent={{-150,50},{150,90}}, 
        textString="%name", 
        textColor={0,0,255})}), Documentation(info="<html>
<p>
请参考子包的描述
<a href=\"modelica://Modelica.Magnetic.QuasiStatic.FluxTubes.Shapes.Leakage\">Shapes.Leakage</a>
为了利用这个局部模型.
</p>
</html>"));
end Leakage;