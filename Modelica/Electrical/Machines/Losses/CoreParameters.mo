within Modelica.Electrical.Machines.Losses;
record CoreParameters "核心损耗的参数记录"
  extends Modelica.Icons.Record;
  parameter Integer m 
    "相数(DC为1相，感应电机为3相)";
  parameter SI.Power PRef(min=0) = 0 
    "在参考内部电压VRef下的参考核心损耗";
  parameter SI.Voltage VRef(min=Modelica.Constants.small) 
    "参考内部有效值电压，参考核心损耗PRef所指";
  parameter SI.AngularVelocity wRef(min=Modelica.Constants.small) 
    "参考角速度，参考核心损耗PRef所指";
  // 在当前实现中，ratioHysteresis=0，因为尚未实现磁滞损耗
  final parameter Real ratioHysteresis(
    min=0, 
    max=1, 
    start=0.775) = 0 
    "磁滞损耗与VRef和fRef下总核心损耗的比率";
  final parameter SI.Conductance GcRef=if (PRef <= 0) then 0 
       else PRef/VRef^2/m 
    "参考频率和电压下的参考导纳";
  final parameter SI.AngularVelocity wMin=1e-6*wRef "角速度下限";
  annotation (defaultComponentPrefixes="parameter ", Documentation(info="<html>
<p>
用于<a href=\"modelica://Modelica.Electrical.Machines.Losses.InductionMachines.Core\">感应电机</a>和<a href=\"modelica://Modelica.Electrical.Machines.Losses.DCMachines.Core\">直流电机</a>核心损耗的参数记录。
</p>
</html>"));
end CoreParameters;