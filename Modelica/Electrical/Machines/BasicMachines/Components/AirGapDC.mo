within Modelica.Electrical.Machines.BasicMachines.Components;
model AirGapDC "直流电机的线性气隙模型"
  extends PartialAirGapDC;
  parameter SI.Inductance Le "Excitation inductance";
equation
  // 励磁磁通：与励磁电流线性相关
  psi_e = Le*ie;
  annotation (
    defaultComponentName="airGap", 
    Documentation(info="<html>
直流机空气隙的线性模型(不考虑饱和效应)，仅使用方程。<br>
感应励磁电压是从der(磁通)计算的，其中磁通由励磁电感乘以励磁电流定义。<br>
感应电枢电压是从磁通乘以角速度计算的。
</html>"));
end AirGapDC;