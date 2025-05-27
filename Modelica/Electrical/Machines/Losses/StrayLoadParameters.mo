within Modelica.Electrical.Machines.Losses;
record StrayLoadParameters "漏损损耗的参数记录"
  extends Modelica.Icons.Record;
  parameter SI.Power PRef(min=0) = 0 
    "在IRef和wRef下的参考漏损损耗";
  parameter SI.Current IRef(min=Modelica.Constants.small) 
    "PRef所指的参考有效值电流";
  parameter SI.AngularVelocity wRef(displayUnit="rev/min", min= 
        Modelica.Constants.small) 
    "PRef所指的参考角速度";
  parameter Real power_w(min=Modelica.Constants.small) = 1 
    "漏损扭矩与角速度的指数";
  final parameter SI.Torque tauRef=if (PRef <= 0) then 0 
       else PRef/wRef 
    "参考角速度和参考电流下的参考漏损扭矩";
  annotation (defaultComponentPrefixes="parameter ", Documentation(info="<html>
<p>
用于<a href=\"modelica://Modelica.Electrical.Machines.Losses.InductionMachines.StrayLoad\">三相</a>和<a href=\"modelica://Modelica.Electrical.Machines.Losses.DCMachines.StrayLoad\">直流</a>漏损损耗的参数记录。
</p>
</html>"));
end StrayLoadParameters;