within Modelica.Electrical.Machines.BasicMachines.Components;
partial model PartialAirGapDC "直流电机部分空气隙模型"
  parameter Boolean quasiStatic(start=false) 
    "如果为true，则没有电气瞬态" annotation (Evaluate=true);
  parameter Real turnsRatio 
    "转子匝数与励磁绕组匝数的比值";
  output SI.AngularVelocity w "角速度";
  SI.Voltage vei 
    "励磁电感的电压降";
  SI.Current ie "励磁电流";
  SI.MagneticFlux psi_e "励磁磁通";
  SI.Voltage vai "感应电枢电压";
  SI.Current ia "电枢电流";
  output SI.Torque tauElectrical;
  Modelica.Mechanics.Rotational.Interfaces.Flange_a flange annotation (
      Placement(transformation(extent={{-10,110},{10,90}})));
  Modelica.Mechanics.Rotational.Interfaces.Flange_a support 
    "作用反力的支撑" annotation (
      Placement(transformation(extent={{-10,-110},{10,-90}})));
  Modelica.Electrical.Analog.Interfaces.PositivePin pin_ap annotation (
      Placement(transformation(extent={{-110,110},{-90,90}})));
  Modelica.Electrical.Analog.Interfaces.PositivePin pin_ep annotation (
      Placement(transformation(extent={{90,110},{110,90}})));
  Modelica.Electrical.Analog.Interfaces.NegativePin pin_an annotation (
      Placement(transformation(extent={{-110,-110},{-90,-90}})));
  Modelica.Electrical.Analog.Interfaces.NegativePin pin_en annotation (
      Placement(transformation(extent={{90,-110},{110,-90}})));
equation
  // 电枢引脚
  vai = pin_ap.v - pin_an.v;
  ia = +pin_ap.i;
  ia = -pin_an.i;
  // 励磁引脚
  vei = pin_ep.v - pin_en.v;
  ie = +pin_ep.i;
  ie = -pin_en.i;
  // 励磁电感的感应电压
  vei = if quasiStatic then 0 else der(psi_e);
  // 机械速度
  w = der(flange.phi) - der(support.phi);
  // 感应电枢电压
  vai = turnsRatio*psi_e*w;
  // 电动转矩(ia与磁通垂直)
  tauElectrical = turnsRatio*psi_e*ia;
  flange.tau = -tauElectrical;
  support.tau = tauElectrical;
  annotation (Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100, 
            -100},{100,100}}), graphics={Ellipse(
                extent={{-90,90},{90,-92}}, 
                lineColor={0,0,255}, 
                fillColor={255,255,255}, 
                fillPattern=FillPattern.Solid),Ellipse(
                extent={{-80,80},{80,-80}}, 
                lineColor={0,0,255}, 
                fillColor={255,255,255}, 
                fillPattern=FillPattern.Solid),Rectangle(
                extent={{-10,90},{10,-80}}, 
                fillPattern=FillPattern.VerticalCylinder, 
                fillColor={128,128,128}),Text(
                extent={{0,40},{80,-40}}, 
                textString="E"),Text(
                extent={{-150,-160},{150,-120}}, 
                textColor={0,0,255}, 
                textString="%name"),Text(
                extent={{-80,40},{0,-40}}, 
                textString="A"),Rectangle(
                visible=quasiStatic, 
                extent={{-10,90},{10,-80}}, 
                lineColor={170,213,255}, 
                fillPattern=FillPattern.VerticalCylinder, 
                fillColor={170,213,255})}), Documentation(info="<html>
电气直流机的空气隙(无饱和效应)的线性模型，只使用方程。<br>
励磁电感的感应电压是从der(磁通)计算的，其中磁通由励磁电感乘以励磁电流定义。
如果<code>quasiStatic==false</code>，则忽略电气瞬态，即感应励磁电压为零。<br>
感应电枢电压是从磁通乘以角速度计算的。
</html>"));
end PartialAirGapDC;