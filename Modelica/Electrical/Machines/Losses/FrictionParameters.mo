within Modelica.Electrical.Machines.Losses;
record FrictionParameters "摩擦损耗的参数记录"
  extends Modelica.Icons.Record;
  parameter SI.Power PRef(min=0) = 0 
    "wRef处的参考摩擦损耗";
  parameter SI.AngularVelocity wRef(displayUnit="rev/min", min= 
        Modelica.Constants.small) 
    "PRef所指代的参考角速度";
  parameter Real power_w(min=Modelica.Constants.small) = 2 
    "角速度对摩擦扭矩的指数";
  final parameter SI.Torque tauRef=if (PRef <= 0) then 0 
       else PRef/wRef 
    "参考角速度处的参考摩擦扭矩";
  final parameter Real linear=0.001 
    "相对于参考角速度的线性角速度范围";
  final parameter SI.AngularVelocity wLinear=linear*wRef 
    "线性角速度范围";
  final parameter SI.Torque tauLinear=if (PRef <= 0) then 0 
       else tauRef*(wLinear/wRef)^power_w 
    "与线性角速度范围对应的扭矩";
  annotation (defaultComponentPrefixes="parameter ", Documentation(info="<html>
<p>
用于<a href=\"modelica://Modelica.Electrical.Machines.Losses.Friction\">摩擦</a>损耗的参数记录。
</p>
</html>"));
end FrictionParameters;