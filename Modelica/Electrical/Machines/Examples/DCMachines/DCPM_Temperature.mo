within Modelica.Electrical.Machines.Examples.DCMachines;
model DCPM_Temperature 
  "测试示例：测试DCPM电机的温度依赖性"
  extends Modelica.Icons.Example;
  parameter SI.Voltage Va=100 "实际电枢电压";
  parameter SI.Voltage Ve=100 "实际励磁电压";
  parameter SI.AngularVelocity w0= 
      Modelica.Units.Conversions.from_rpm(1500) "空载转速";
  parameter SI.Torque TLoad=63.66 "额定负载转矩";
  parameter SI.Inertia JLoad=0.15 
    "负载的转动惯量";
  Machines.BasicMachines.DCMachines.DC_PermanentMagnet dcpm(
    wMechanical(start=w0, fixed=true), 
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
    phiMechanical(fixed=true), 
    ia(fixed=true), 
    TaOperational=293.15, 
    alpha20a=dcpmData.alpha20a, 
    useThermalPort=true) 
    annotation (Placement(transformation(extent={{-20,-10},{0,10}})));
  Modelica.Electrical.Analog.Sources.ConstantVoltage armatureVoltage(V=Va) 
    annotation (Placement(transformation(
        extent={{10,-10},{-10,10}}, 
        rotation=90, 
        origin={-80,70})));
  Modelica.Electrical.Analog.Basic.Ground groundArmature annotation (
      Placement(transformation(
        origin={-80,40}, 
        extent={{-10,-10},{10,10}})));
  Modelica.Mechanics.Rotational.Components.Inertia loadInertia(J=JLoad) 
    annotation (Placement(transformation(extent={{10,-10},{30,10}})));
  Modelica.Mechanics.Rotational.Sources.TorqueStep loadTorque(
    useSupport=false, 
    stepTorque=-TLoad, 
    offsetTorque=0, 
    startTime=0.1) annotation (Placement(transformation(extent={{60,-10}, 
            {40,10}})));
  Machines.Thermal.DCMachines.ThermalAmbientDCPM thermalAmbientDCPM(
    useTemperatureInputs=true, 
    Ta=293.15, 
    Tpm=293.15) 
    annotation (Placement(transformation(extent={{-20,-40},{0,-20}})));
  Modelica.Blocks.Sources.Exponentials exponential(
    offset=293.15, 
    outMax=60, 
    riseTime=3600, 
    riseTimeConst=0.5, 
    fallTimeConst=0.5, 
    startTime=0.1) 
    annotation (Placement(transformation(extent={{-60,-60},{-40,-40}})));
  Modelica.Blocks.Sources.Constant const(k=293.15) 
    annotation (Placement(transformation(extent={{40,-60},{20,-40}})));
  parameter Utilities.ParameterRecords.DcPermanentMagnetData dcpmData(
    alpha20a(displayUnit="1/K")=Modelica.Electrical.Machines.Thermal.Constants.alpha20Copper, 
    TaNominal=353.15, 
    TaRef=353.15) "DC机器数据" 
    annotation (Placement(transformation(extent={{-20,-80},{0,-60}})));

equation
  connect(loadInertia.flange_b, loadTorque.flange) 
    annotation (Line(points={{30,0},{30,0},{40,0}}));
  connect(dcpm.flange, loadInertia.flange_a) annotation (Line(
      points={{0,0},{10,0}}));
  connect(armatureVoltage.n, groundArmature.p) annotation (Line(
      points={{-80,60},{-80,50}}, color={0,0,255}));
  connect(armatureVoltage.p, dcpm.pin_ap) annotation (Line(
      points={{-80,80},{-4,80},{-4,10}}, color={0,0,255}));
  connect(armatureVoltage.n, dcpm.pin_an) annotation (Line(
      points={{-80,60},{-16,60},{-16,10}}, color={0,0,255}));
  connect(exponential.y, thermalAmbientDCPM.TArmature) annotation (Line(
      points={{-39,-50},{-20,-50},{-20,-42}}, color={0,0,127}));
  connect(const.y, thermalAmbientDCPM.TPermanentMagnet) annotation (Line(
      points={{19,-50},{-10,-50},{-10,-42}}, color={0,0,127}));
  connect(dcpm.thermalPort, thermalAmbientDCPM.thermalPort) annotation (
      Line(points={{-10,-10},{-10,-15},{-10,-20}}, color={191,0,0}));
  annotation (experiment(StopTime=3.0, Interval=1E-4, Tolerance=1E-6), Documentation(
        info="<html>
<p>调查DCPM电机的电枢温度对其影响</p>
<p>电机以空载转速启动，然后施加负载步进。
从负载步进开始，电枢温度呈指数增长，从20°C增加到80°C。</p>
<p>该示例的仿真时长为3秒，用户可以在特定界面通过勾选绘制以下结果变量的图像(相对于时间)：
<ul>
<li>dcpm.ia：电枢电流</li>
<li>dcpm.wMechanical：电机转速</li>
<li>dcpm.tauElectrical：电机转矩</li>
<li>thermalAmbientDCPM.Q_flow_a：电机电枢损耗</li>
</ul>
使用默认机械参数，但：
<ul>
<li>电枢绕组材料设置为铜。</li>
<li>电枢参考温度设置为80°C。</li>
<li>额定电枢温度设置为80°C。</li>
</ul>
因此，该电机开始时处于冷态，结束时处于暖态（与未修改的电机具有相同的电枢电阻）。
</html>"));
end DCPM_Temperature;