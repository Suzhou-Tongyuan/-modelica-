within Modelica.Magnetic.FluxTubes.Basic;
model ConstantPermeance "恒定磁导"
  extends Interfaces.TwoPort;
  extends Modelica.Magnetic.FluxTubes.Icons.Reluctance;

  parameter SI.Permeance G_m=1 "磁导";

equation
  G_m * V_m = Phi;

  annotation (defaultComponentName="permeance", Icon(coordinateSystem(
      preserveAspectRatio=false, 
      extent={{-100,-100},{100,100}}), graphics={
        Text(
          extent={{-150,-40},{150,-80}}, 
          textColor={0,0,0}, 
          textString="G_m=%G_m")}), 
                                Documentation(info="<html>
<p>
这个恒定的磁导率是为测试目的和简单的磁网络模型提供的。磁通率不是根据磁通管的几何形状和磁通率计算的，而是作为参数提供的.
</p>
</html>", 
      revisions="<html>
<h5>Version 3.2.2, 2014-01-15 (Christian Kral)</h5>
<ul>
<li>增加了恒渗透模型</li>
</ul>

</html>"));
end ConstantPermeance;