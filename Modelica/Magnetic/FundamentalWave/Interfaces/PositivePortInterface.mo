within Modelica.Magnetic.FundamentalWave.Interfaces;
model PositivePortInterface "通向 FluxTubes 的正端口接口"

  Magnetic.FundamentalWave.Interfaces.PositiveMagneticPort port 
    "基波机的磁端口" 
    annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
  Magnetic.FluxTubes.Interfaces.PositiveMagneticPort port_re 
    "磁性端口，实际部件" 
    annotation (Placement(transformation(extent={{90,90},{110,110}})));
  Magnetic.FluxTubes.Interfaces.PositiveMagneticPort port_im 
    "磁端口，虚部" 
    annotation (Placement(transformation(extent={{90,-108},{110,-88}})));
equation
  port.V_m.re = port_re.V_m;
  port.V_m.im = port_im.V_m;
  port.Phi.re + port_re.Phi = 0;
  port.Phi.im + port_im.Phi = 0;

  annotation (
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
            100,100}}), graphics={Line(
              points={{-100,0},{0,0},{100,100}}, 
              color={255,128,0}),Line(
              points={{0,0},{100,-100}}, 
              color={255,128,0}),Text(
              extent={{80,80},{120,40}}, 
              textColor={255,128,0}, 
              textString="re"),Text(
              extent={{80,-40},{120,-80}}, 
              textColor={255,128,0}, 
              textString="im")}), 
    Documentation(info="<html>
<p>连接基波端口与实部和虚部 FluxTube 端口.</p>
</html>"));
end PositivePortInterface;