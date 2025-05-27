within Modelica.Magnetic.FluxTubes.BaseClasses;
partial model Leakage "漏磁通管的基类，其磁导率与位置无关，因此不会产生力；mu_r=1"

  extends Interfaces.TwoPort;
  extends Modelica.Magnetic.FluxTubes.Icons.Reluctance;

  SI.Reluctance R_m "磁阻";
  SI.Permeance G_m "磁导率";

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
请参考<a href=\"modelica://Modelica.Magnetic.FluxTubes.Shapes.Leakage\">Shapes.Leakage</a>子包的描述来使用这个部分模型。.
</p>
</html>"));
end Leakage;