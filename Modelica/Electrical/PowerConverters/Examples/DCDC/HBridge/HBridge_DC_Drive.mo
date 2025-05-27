within Modelica.Electrical.PowerConverters.Examples.DCDC.HBridge;
model HBridge_DC_Drive "带驱动直流电机的H桥直流直流变换器"
  extends ExampleTemplates.HBridge(signalPWM(useConstantDutyCycle=false), 
      constantVoltage(V=120));
  extends Modelica.Icons.Example;
  parameter SI.Inductance Ld=3*dcpmData.La 
    "平滑电感";
  final parameter SI.Torque tauNominal=dcpmData.ViNominal 
      *dcpmData.IaNominal/dcpmData.wNominal "额定转矩";
  parameter Real dMin=0.2 "最小占空比";
  parameter Real dMax=1 - dMin "最大占空比";
  Modelica.Electrical.Machines.BasicMachines.DCMachines.DC_PermanentMagnet 
    dcpm(
    VaNominal=dcpmData.VaNominal, 
    IaNominal=dcpmData.IaNominal, 
    wNominal=dcpmData.wNominal, 
    TaNominal=dcpmData.TaNominal, 
    Ra=dcpmData.Ra, 
    TaRef=dcpmData.TaRef, 
    La=dcpmData.La, 
    Jr=dcpmData.Jr, 
    useSupport=false, 
    Js=dcpmData.Js, 
    frictionParameters=dcpmData.frictionParameters, 
    coreParameters=dcpmData.coreParameters, 
    strayLoadParameters=dcpmData.strayLoadParameters, 
    brushParameters=dcpmData.brushParameters, 
    ia(start=0, fixed=true), 
    TaOperational=293.15, 
    alpha20a=dcpmData.alpha20a, 
    phiMechanical(fixed=true, start=0), 
    wMechanical(fixed=true, start=0)) annotation (Placement(
        transformation(extent={{20,-80},{40,-60}})));
  parameter
    Modelica.Electrical.Machines.Utilities.ParameterRecords.DcPermanentMagnetData 
    dcpmData "PM 励磁 DC 机器的数据记录" 
    annotation (Placement(transformation(extent={{-10,-80},{10,-60}})));
  Modelica.Mechanics.Rotational.Sources.Torque torque 
    annotation (Placement(transformation(extent={{70,-80},{50,-60}})));
  Modelica.Blocks.Sources.TimeTable torqueTable(table=[0, 0; 6, 0; 7, -
        tauNominal; 9, -tauNominal; 10, +tauNominal; 15, tauNominal; 16,
        -tauNominal; 18, -tauNominal; 19, 0; 24, 0]) 
    annotation (Placement(transformation(extent={{100,-80},{80,-60}})));
  Modelica.Blocks.Sources.TimeTable dutyCycleTable(table=[0, 0.5; 3,
        0.5; 4, dMax; 12, dMax; 13, dMin; 21, dMin; 22, 0.5; 24, 0.5]) 
    annotation (Placement(transformation(extent={{-100,-70},{-80,-50}})));
  Modelica.Electrical.Analog.Basic.Inductor inductor(L=Ld) annotation (
      Placement(transformation(
        origin={40,30}, 
        extent={{10,-10},{-10,10}}, 
        rotation=90)));
equation
  connect(inductor.n, dcpm.pin_ap) annotation (Line(
      points={{40,20},{40,-60},{36,-60}}, color={0,0,255}));
  connect(dcpm.pin_an, currentSensor.p) annotation (Line(
      points={{24,-60},{24,-6},{0,-6}}, color={0,0,255}));
  connect(dcpm.flange, torque.flange) annotation (Line(
      points={{40,-70},{50,-70}}));
  connect(torque.tau, torqueTable.y) annotation (Line(
      points={{72,-70},{79,-70}}, color={0,0,127}));
  connect(inductor.p, hbridge.dc_p2) annotation (Line(
      points={{40,40},{40,70},{-30,70},{-30,6},{-40,6}}, color={0,0,255}));
  connect(dutyCycleTable.y, signalPWM.dutyCycle) annotation (Line(
      points={{-79,-60},{-62,-60}}, color={0,0,127}));
  annotation (
    experiment(
      StopTime=24, 
      Interval=0.0002, 
      Tolerance=1e-06), 
    Documentation(info="<html>
<p>这个带有 DC 驱动的 H 桥示例演示了 DC 机器在四个象限中的运行。
DC 输出电压等于<code>2 * (dutyCycle - 0.5)</code>乘以输入电压。</p>

<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
  <tr>
    <th><strong>开始时间 (s)</strong></th>
    <th><strong>机器速度</strong></th>
    <th><strong>机器转矩</strong></th>
    <th><strong>模式</strong></th>
  </tr>
  <tr>
    <td>0</td> <td>零</td> <td>零</td> <td></td>
  </tr>
  <tr>
    <td>3</td> <td>正向</td> <td>零</td> <td></td>
  </tr>
  <tr>
    <td>6</td> <td>正向</td> <td>正向</td> <td>电动机</td>
  </tr>
  <tr>
    <td>9.5</td> <td>正向</td> <td>负向</td> <td>发电机</td>
  </tr>
  <tr>
    <td>12.5</td> <td>负向</td> <td>负向</td> <td>电动机</td>
  </tr>
  <tr>
    <td>15.5</td> <td>负向</td> <td>正向</td> <td>发电机</td>
  </tr>
  <tr>
    <td>19</td> <td>负向</td> <td>零</td> <td></td>
  </tr>
  <tr>
    <td>22</td> <td>零</td> <td>零</td> <td></td>
  </tr>
</table>

<p>
绘制机器电流 <code>dcpm.ia</code>、平均电流 <code>meanCurrent.y</code>、机器速度 <code>dcpm.wMechanical</code>、平均机器速度 <code>dcpm.va</code> 和转矩 <code>dcpm.tauElectrical</code>。</p>
</html>"));
end HBridge_DC_Drive;