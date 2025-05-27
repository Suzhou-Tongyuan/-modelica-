within Modelica.Magnetic.QuasiStatic.FluxTubes.Sensors.Transient;
model Permeability 
"通过磁通和磁位差确定磁导率"

  parameter SI.Area A 
  "被通量穿透的截面面积";
  parameter SI.Length l 
  "与磁电位差有关的长度";

  Modelica.Blocks.Interfaces.RealInput Phi(unit="Wb") "磁通" 
                    annotation (Placement(
        transformation(extent={{-140,40},{-100,80}})));
  Modelica.Blocks.Interfaces.RealInput V_m(unit="A") 
  "磁位差" annotation (
      Placement(transformation(extent={{-140,-80}, 
            {-100,-40}})));
  Modelica.Blocks.Interfaces.RealOutput mu(unit="H/m") "绝对磁导率" 
                   annotation (Placement(
        transformation(extent={{100,50},{120,70}})));
  Modelica.Blocks.Interfaces.RealOutput mur(unit="1") "相对渗透率" 
                            annotation (Placement(
        transformation(extent={{100,-70},{120,-50}})));

equation
  if noEvent(abs(V_m) < Modelica.Constants.eps) then
     mu = 0;
     mur = 0;
  else
     mu =Phi /V_m*l/A;
     mur = mu/Modelica.Constants.mu_0;
  end if;

  annotation ( Icon(
        coordinateSystem(preserveAspectRatio=false), 
        graphics={Rectangle(
          extent={{-100,100},{100,-100}}, 
          lineColor={0,0,127}, 
          fillColor={255,255,255}, 
          fillPattern=FillPattern.Solid), Text(
          extent={{60,-60},{-60,60}}, 
          fillColor={255,170,85}, 
          fillPattern=FillPattern.Solid, 
          textString="μ")}), 
  Documentation(info="<html>
<p>该模型根据两个实际输入确定绝对渗透率和相对渗透率:</p>
<ul>
<li>均方根磁位差,
<img src=\"modelica://Modelica/Resources/Images/Magnetic/QuasiStatic/FluxTubes/realV_m.png\" alt=\"V_m\"></li>
<li>均方根磁通量,
<img src=\"modelica://Modelica/Resources/Images/Magnetic/QuasiStatic/FluxTubes/realPhi.png\" alt=\"Phi\"></li>
</ul>
<p>为了计算渗透率，计算截面面积,
<img src=\"modelica://Modelica/Resources/Images/Magnetic/QuasiStatic/FluxTubes/A.png\" alt=\"l\">,
几何长度,
<img src=\"modelica://Modelica/Resources/Images/Magnetic/QuasiStatic/FluxTubes/l.png\" alt=\"l\">,
必须考虑到磁通路径</p>
<dl><dd>
<img src=\"modelica://Modelica/Resources/Images/Magnetic/QuasiStatic/FluxTubes/permeabilities.png\" alt=\"Permeabilities\">
</dd></dl>
<p>在磁位差接近于零的情况下，磁导率产生:</p>
<dl><dd>
<img src=\"modelica://Modelica/Resources/Images/Magnetic/QuasiStatic/FluxTubes/permeabilities-0.png\" alt=\"Permeabilities=0\">
</dd></dl>
</html>"));
end Permeability;