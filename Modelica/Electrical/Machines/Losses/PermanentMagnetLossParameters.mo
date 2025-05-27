within Modelica.Electrical.Machines.Losses;
record PermanentMagnetLossParameters 
  "永磁体损耗的参数记录"
  extends Modelica.Icons.Record;
  parameter SI.Power PRef(min=0) = 0 
    "在IRef和wRef下的参考永磁体损耗";
  parameter Real c(
    min=0, 
    max=1) = 0 
    "在电流=0时的永磁体损耗的一部分，即独立于电流";
  parameter SI.Current IRef(min=Modelica.Constants.small) 
    "参考定子有效值电流，PRef所指";
  parameter Real power_I(min=Modelica.Constants.small) = 2 
    "永磁体损耗转矩与定子电流的指数";
  parameter SI.AngularVelocity wRef(displayUnit="rev/min", min= 
        Modelica.Constants.small) 
    "PRef所指的参考角速度";
  parameter Real power_w(min=Modelica.Constants.small) = 1 
    "永磁体损耗转矩与角速度的指数";
  final parameter SI.Torque tauRef=if (PRef <= 0) then 0 
       else PRef/wRef 
    "在参考角速度和参考电流下的参考永磁体损耗转矩";
  annotation (defaultComponentPrefixes="parameter ", Documentation(info="<html>
<p>
用于<a href=\"modelica://Modelica.Electrical.Machines.Losses.InductionMachines.PermanentMagnetLosses\">永磁体损耗</a>的参数记录。
</p>
</html>"));
end PermanentMagnetLossParameters;