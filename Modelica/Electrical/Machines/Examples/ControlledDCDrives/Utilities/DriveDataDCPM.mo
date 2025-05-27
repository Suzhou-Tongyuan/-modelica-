within Modelica.Electrical.Machines.Examples.ControlledDCDrives.Utilities;
record DriveDataDCPM 
  "受控直流永磁电机的参数"
  extends Modelica.Icons.Record;
  import Modelica.Electrical.Machines.Thermal.convertResistance;
//电机
  parameter
    Modelica.Electrical.Machines.Utilities.ParameterRecords.DcPermanentMagnetData 
    motorData "电机数据" annotation (Dialog(group="电机"), Placement(
        transformation(extent={{-10,-10},{10,10}})));
  parameter SI.Resistance Ra=convertResistance(motorData.Ra, 
      motorData.TaRef,motorData.alpha20a,motorData.TaNominal) 
    "额定温度下的电枢电阻" 
    annotation(Dialog(group="电机", enable=false));
  parameter SI.Time Ta=motorData.La/Ra "电枢时间常数" 
    annotation(Dialog(group="电机", enable=false));
  parameter SI.Power PNominal=motorData.ViNominal*motorData.IaNominal 
    -motorData.frictionParameters.PRef -motorData.coreParameters.PRef -motorData.strayLoadParameters.PRef 
    "额定机械输出" 
    annotation(Dialog(group="电机", enable=false));
  parameter SI.Torque tauNominal=PNominal/motorData.wNominal 
    "额定转矩" 
    annotation(Dialog(group="电机", enable=false));
  parameter SI.ElectricalTorqueConstant kPhi=tauNominal/motorData.IaNominal 
    "转矩常数" 
    annotation(Dialog(group="电机", enable=false));
  parameter SI.AngularVelocity w0=motorData.wNominal*motorData.VaNominal/motorData.ViNominal 
    "空载转速" 
  annotation(Dialog(group="电机", enable=false));
//逆变器
  parameter SI.Frequency fS=2e3 "开关频率" 
    annotation(Dialog(tab="逆变器", group="电枢逆变器"));
  parameter SI.Voltage VBat=VaMax "直流空载电压" 
    annotation(Dialog(tab="逆变器", group="电枢逆变器"));
  parameter SI.Time Td=0.5/fS "逆变器死区时间" 
    annotation(Dialog(tab="逆变器", group="电枢逆变器", enable=false));
  parameter SI.Time Tmf=4*Td "测量滤波器时间常数" 
    annotation(Dialog(tab="逆变器", group="电枢逆变器", enable=false));
  parameter SI.Time Tsigma=Td + Tmf "小时间常数之和" 
    annotation(Dialog(tab="逆变器", group="电枢逆变器", enable=false));
//负载
  parameter SI.Inertia JL=motorData.Jr "负载惯量" 
    annotation(Dialog(group="负载"));
//限制
  parameter SI.Voltage VaMax=1.2*motorData.VaNominal "最大电压" 
    annotation(Dialog(tab="控制器", group="限制"));
  parameter SI.Current IaMax=1.5*motorData.IaNominal "最大电流" 
    annotation(Dialog(tab="控制器", group="限制"));
  parameter SI.Torque tauMax=kPhi*IaMax "最大转矩" 
    annotation(Dialog(tab="控制器", group="限制", enable=false));
  parameter SI.AngularVelocity wMax=motorData.wNominal*motorData.VaNominal/motorData.ViNominal 
    "最大转速" 
    annotation(Dialog(tab="控制器", group="限制"));
  parameter SI.AngularAcceleration aMax=tauMax/(JL +motorData.Jr) 
    "最大加速度" 
    annotation(Dialog(tab="控制器", group="限制", enable=false));
//电流控制器：绝对最佳
  parameter Real kpI=motorData.La/(2*Tsigma) "比例增益" annotation (
      Dialog(
      tab="控制器", 
      group="电流控制器", 
      enable=false));
  parameter SI.Time TiI=Ta "积分时间常数" 
    annotation(Dialog(tab="控制器", group="电流控制器", enable=false));
  parameter SI.Time Tsub=2*Tsigma "替代时间常数" 
    annotation(Dialog(tab="控制器", group="电流控制器", enable=false));
//速度控制器：对称最佳
  parameter Real kpw=(JL + motorData.Jr)/(2*Tsub) "比例增益" 
    annotation (Dialog(
      tab="控制器", 
      group="速度控制器", 
      enable=false));
  parameter SI.Time Tiw=4*Tsub "积分时间常数" 
    annotation(Dialog(tab="控制器", group="速度控制器", enable=false));
  parameter SI.Time Tfw=Tiw "滤波器时间常数" 
    annotation(Dialog(tab="控制器", group="速度控制器", enable=false));
//位置控制器
  parameter Real kpP=1/(16*Tsub) "比例增益" 
    annotation(Dialog(tab="控制器", group="位置控制器", enable=false));
  annotation (
    defaultComponentName="dcpmDriveData", 
    defaultComponentPrefixes="parameter", 
    Documentation(info="<html>
<p>
计算直流永磁电机的控制器参数：
电流控制器按绝对最佳值，速度控制器按对称最佳值。
</p>
</html>"));
end DriveDataDCPM;