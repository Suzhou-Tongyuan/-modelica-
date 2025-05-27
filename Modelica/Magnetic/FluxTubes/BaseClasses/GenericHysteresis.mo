within Modelica.Magnetic.FluxTubes.BaseClasses;
partial model GenericHysteresis "部分滞后模型"
  extends BaseClasses.Generic;
  extends Interfaces.ConditionalHeatPort(final T=293.15);

  parameter Boolean includeEddyCurrents = false 
    "= true，如果启用了涡流损耗" 
  annotation(Dialog(tab="Losses and heat", group="Eddy currents"), Evaluate=true, HideResult=true, choices(checkBox=true));

  parameter SI.Conductivity sigma=10e6 "芯材的导电性" annotation (Dialog(tab="Losses and heat", group="Eddy currents", enable=includeEddyCurrents));
  parameter SI.Length d = 0.5e-3 "层压厚度" annotation (Dialog(tab="Losses and heat", group="Eddy currents", enable=includeEddyCurrents));

  output SI.MagneticFieldStrength H(start=0) "磁场强度";
  output SI.MagneticFieldStrength Hstat 
    "磁场强度的静态（铁磁）部分";
  output SI.MagneticFieldStrength Heddy 
    "磁场强度的动态（涡流）部分";
  output SI.MagneticFluxDensity B "磁通密度";
  output Real MagRel(final quantity="Relative magnetization", final unit="1", start=0, min=-1, max=1) 
    "初始化时的相对磁化率 (-1..1)";
  output SI.Power LossPowerStat "铁磁（静态）磁滞损耗";
  output SI.Power LossPowerEddy 
    "涡流损耗（动态磁滞损耗）";
  //output SI.Power LossPower "磁芯总功率损耗（铁磁 + 涡流）"; // defined in ConditionalHeatPort
  Real derHstat(start=0, unit="A/(m.s)")=der(Hstat);

protected
  final parameter Real eddyCurrentFactor(final unit="S.m") = (sigma * d^2)/12;

equation
  der(MagRel)=0;

  H = Hstat + Heddy;
  H = V_m/l;
  Phi = B*A;

  Heddy = if includeEddyCurrents then eddyCurrentFactor* der(B)  else 0;

  LossPowerStat = Hstat * der(B) * V;
  LossPowerEddy = Heddy * der(B) * V;
  LossPower = LossPowerStat + LossPowerEddy;
  annotation (Icon(graphics={Line(
          points={{-30,-20},{-14,-20},{-6,-16},{2,0},{10,16},{18,20},{26,20}}, 
          color={255,128,0}, 
          smooth=Smooth.Bezier), Line(
          points={{-30,-20},{-14,-20},{-6,-16},{2,0},{10,16},{18,20},{26,20}}, 
          color={255,128,0}, 
          smooth=Smooth.Bezier, 
          origin={-4,0}, 
          rotation=180)}));
end GenericHysteresis;