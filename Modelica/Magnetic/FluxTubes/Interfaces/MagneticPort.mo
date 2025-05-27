within Modelica.Magnetic.FluxTubes.Interfaces;
connector MagneticPort "通用磁口"
  SI.MagneticPotential V_m "端口的磁势";
  flow SI.MagneticFlux Phi "流入端口的磁通量";

  annotation (defaultComponentName="mag");
end MagneticPort;