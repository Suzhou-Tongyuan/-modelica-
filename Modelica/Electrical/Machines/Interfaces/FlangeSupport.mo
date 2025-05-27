within Modelica.Electrical.Machines.Interfaces;
partial model FlangeSupport "轴和支撑"
  Modelica.Mechanics.Rotational.Interfaces.Flange_a flange "轴端" 
    annotation (Placement(transformation(extent={{-10,110},{10,90}})));
  Modelica.Mechanics.Rotational.Interfaces.Flange_a support 
    "外壳和支撑" annotation (Placement(transformation(extent={{-10, 
            -110},{10,-90}})));
  SI.Angle phi "轴和支撑之间的角度";
  SI.Torque tau "扭矩";
  SI.AngularVelocity w 
    "轴端和支撑的相对角速度";
equation
  phi = flange.phi - support.phi;
  w = der(phi);
  tau = -flange.tau;
  tau = support.tau;
  annotation (Documentation(info="<html>
<p>
该部分模型定义了用于损耗模型的轴和外壳连接器。
正扭矩 <code>tau</code> 作为制动扭矩作用。
</p>
</html>"), 
       Icon(graphics={Rectangle(
          extent={{-20,-80},{20,-120}}, 
          lineColor={192,192,192}, 
          fillColor={192,192,192}, 
          fillPattern=FillPattern.Solid)}));
end FlangeSupport;