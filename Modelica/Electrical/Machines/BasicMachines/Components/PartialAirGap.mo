within Modelica.Electrical.Machines.BasicMachines.Components;
partial model PartialAirGap "部分气隙模型"
  parameter Integer m=3 "相数" annotation(Evaluate=true);
  parameter Integer p(min=1) "极对数";
  output SI.Torque tauElectrical;
  SI.Angle gamma "转子位移角";
  SI.Current i_ss[2] 
    "相对于定子固定框架的定子电流空间矢量";
  SI.Current i_sr[2] 
    "相对于转子固定框架的定子电流空间矢量";
  SI.Current i_rs[2] 
    "相对于定子固定框架的转子电流空间矢量";
  SI.Current i_rr[2] 
    "相对于转子固定框架的转子电流空间矢量";
  SI.MagneticFlux psi_ms[2] 
    "相对于定子固定框架的磁通矢量";
  SI.MagneticFlux psi_mr[2] 
    "相对于转子固定框架的磁通矢量";
  Real RotationMatrix[2, 2] "从转子到定子的旋转矩阵";
public
  Modelica.Mechanics.Rotational.Interfaces.Flange_a flange annotation (
      Placement(transformation(extent={{-10,110},{10,90}})));
  Modelica.Mechanics.Rotational.Interfaces.Flange_a support 
    "作用反扭矩的支撑点" annotation (
      Placement(transformation(extent={{-10,-110},{10,-90}})));
  Machines.Interfaces.SpacePhasor spacePhasor_s 
    annotation (Placement(transformation(extent={{-110,90},{-90,110}})));
  Machines.Interfaces.SpacePhasor spacePhasor_r 
    annotation (Placement(transformation(extent={{90,90},{110,110}})));
  /*
  SI.AngularVelocity omegaPsi_ms
    "主磁通相对于定子固定框架的角速度";
  SI.AngularVelocity omegaPsi_mr
    "主磁通相对于转子固定框架的角速度";
  SI.Current i_sm[2]
    "相对于主磁通固定框架的定子电流空间矢量";
  SI.Current i_rm[2]
    "相对于主磁通固定框架的转子电流空间矢量";
protected
  SI.MagneticFlux psi_msAbs "主磁通矢量的长度";
  SI.Angle psi_msArg
    "相对于定子固定框架的主磁通矢量的(包裹的)角度";
  SI.Angle psi_mrArg
    "相对于转子固定框架的主磁通矢量的(包裹的)角度";
initial equation
  i_sm = Machines.SpacePhasors.Functions.Rotator(i_ss, psi_msArg);
  i_rm = Machines.SpacePhasors.Functions.Rotator(i_rr, psi_mrArg);
equation
  // 主磁通矢量的角速度
  (psi_msAbs, psi_msArg) = Machines.SpacePhasors.Functions.ToPolar(psi_ms);
  psi_mrArg = psi_msArg - gamma;
  omegaPsi_ms = if noEvent(psi_msAbs<Modelica.Constants.small) then 0 else
    (spacePhasor_s.v_[2]*cos(psi_msArg) - spacePhasor_s.v_[1]*sin(psi_msArg))/psi_msAbs;
  omegaPsi_mr = omegaPsi_ms - der(gamma);
  // 相对于主磁通固定框架的定子和转子电流
  der(i_sm) = Machines.SpacePhasors.Functions.Rotator(
    {der(i_ss[1]) + omegaPsi_ms*i_ss[2], der(i_ss[2]) - omegaPsi_ms*i_ss[1]}, psi_msArg);
  der(i_rm) = Machines.SpacePhasors.Functions.Rotator(
    {der(i_rr[1]) + omegaPsi_mr*i_rr[2], der(i_rr[2]) - omegaPsi_mr*i_rr[1]}, psi_mrArg);
*/
equation
  // 等效2极机的转子的机械角度
  gamma = p*(flange.phi - support.phi);
  RotationMatrix = {{+cos(gamma),-sin(gamma)},{+sin(gamma),+cos(gamma)}};
  i_ss = spacePhasor_s.i_;
  i_ss = RotationMatrix*i_sr;
  i_rr = spacePhasor_r.i_;
  i_rs = RotationMatrix*i_rr;
  // 定子电压感应
  spacePhasor_s.v_ = der(psi_ms);
  // 转子电压感应
  spacePhasor_r.v_ = der(psi_mr);
  // 电机机械转矩（电流和磁通空间矢量的叉积）
  tauElectrical = m/2*p*(spacePhasor_s.i_[2]*psi_ms[1] - spacePhasor_s.i_[
    1]*psi_ms[2]);
  flange.tau = -tauElectrical;
  support.tau = tauElectrical;
  annotation (Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100, 
            -100},{100,100}}), graphics={
        Ellipse(
          extent={{-90,90},{90,-92}}, 
          lineColor={0,0,255}, 
          fillColor={255,255,255}, 
          fillPattern=FillPattern.Solid), 
        Ellipse(extent={{-80,80},{80,-80}}, lineColor={0,0,255}), 
        Rectangle(
          extent={{-10,90},{10,-80}}, 
          fillPattern=FillPattern.VerticalCylinder, 
          fillColor={128,128,128}), 
        Text(
          extent={{-150,-110},{150,-150}}, 
          textColor={0,0,255}, 
          textString="%name")}), Documentation(info="<html>
气隙的部分模型，仅使用方程。
</html>"));
end PartialAirGap;