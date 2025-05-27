within Modelica.Electrical.Machines.Examples.ControlledDCDrives.Utilities;
partial model PartialControlledDCPM 
  "带H桥从电池控制的部分控制直流永磁电机"
  extends Modelica.Icons.Example;
  replaceable parameter DriveDataDCPM driveData constrainedby 
    ControlledDCDrives.Utilities.DriveDataDCPM "直流机器数据" 
    annotation (Placement(transformation(extent={{20,-80},{40,-60}})));
  Modelica.Mechanics.Rotational.Components.Inertia loadInertia(J=driveData.JL) 
    annotation (Placement(transformation(extent={{50,-50},{70,-30}})));
  Modelica.Mechanics.Rotational.Sensors.SpeedSensor speedSensor annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}}, 
        rotation=270, 
        origin={50,-70})));
  Modelica.Electrical.Machines.BasicMachines.DCMachines.DC_PermanentMagnet dcpm(
    TaOperational=driveData.motorData.TaNominal, 
    VaNominal=driveData.motorData.VaNominal, 
    IaNominal=driveData.motorData.IaNominal, 
    wNominal=driveData.motorData.wNominal, 
    TaNominal=driveData.motorData.TaNominal, 
    Ra=driveData.motorData.Ra, 
    TaRef=driveData.motorData.TaRef, 
    La=driveData.motorData.La, 
    Jr=driveData.motorData.Jr, 
    frictionParameters=driveData.motorData.frictionParameters, 
    phiMechanical(fixed=true), 
    wMechanical(fixed=true), 
    coreParameters=driveData.motorData.coreParameters, 
    strayLoadParameters=driveData.motorData.strayLoadParameters, 
    brushParameters=driveData.motorData.brushParameters, 
    ia(fixed=true), 
    Js=driveData.motorData.Js, 
    alpha20a=driveData.motorData.alpha20a) 
    annotation (Placement(transformation(extent={{20,-50},{40,-30}})));
  DcdcInverter armatureInverter(
    fS=driveData.fS, 
    Td=driveData.Td, 
    Tmf=driveData.Tmf, 
    VMax=driveData.VaMax) 
    annotation (Placement(transformation(extent={{20,-20},{40,0}})));
  Battery source(
    INominal=driveData.motorData.IaNominal, V0=driveData.VBat) 
    annotation (Placement(transformation(
        extent={{10,-10},{-10,10}}, 
        rotation=180, 
        origin={30,80})));
  LimitedPI currentController(
    constantLimits=false, 
    k=driveData.kpI, 
    Ti=driveData.TiI, 
    KFF=driveData.kPhi, 
    initType=Modelica.Blocks.Types.Init.InitialOutput, 
    useFF=true) 
    annotation (Placement(transformation(extent={{-50,-20},{-30,0}})));
  Modelica.Blocks.Math.Gain tau2i(k=1/driveData.kPhi) annotation (Placement(
        transformation(
        extent={{10,-10},{-10,10}}, 
        rotation=180, 
        origin={-70,-10})));
equation
  connect(dcpm.flange, loadInertia.flange_a) 
    annotation (Line(points={{40,-40},{50,-40}}));
  connect(speedSensor.flange, dcpm.flange) 
    annotation (Line(points={{50,-60},{50,-40},{40,-40}}));
  connect(armatureInverter.pin_nMot, dcpm.pin_an) 
    annotation (Line(points={{24,-20},{24,-30},{24,-30}}, 
                                                 color={0,0,255}));
  connect(armatureInverter.pin_pMot, dcpm.pin_ap) 
    annotation (Line(points={{36,-20},{36,-30},{36,-30}}, 
                                                 color={0,0,255}));
  connect(armatureInverter.vDC, currentController.yMaxVar) 
    annotation (Line(points={{19,-4},{-28,-4}}, color={0,0,127}));
  connect(armatureInverter.vRef, currentController.y) 
    annotation (Line(points={{18,-10},{-29,-10}}, color={0,0,127}));
  connect(armatureInverter.iMot, currentController.u_m) annotation (
      Line(points={{19,-16},{-20,-16},{-20,-30},{-46,-30},{-46,-22}}, 
        color={0,0,127}));
  connect(speedSensor.w, currentController.feedForward) annotation (Line(
        points={{50,-81},{50,-90},{-40,-90},{-40,-22}}, 
                                                     color={0,0,127}));
  connect(tau2i.y, currentController.u) 
    annotation (Line(points={{-59,-10},{-52,-10}}, color={0,0,127}));
  connect(source.pin_n, armatureInverter.pin_nBat) annotation (Line(points={{24,70}, 
          {24,70},{24,0}},             color={0,0,255}));
  connect(source.pin_p, armatureInverter.pin_pBat) annotation (Line(points={{36,70}, 
          {36,60},{36,60},{36,0}},     color={0,0,255}));
  annotation (Documentation(info="<html>
  <p>这是一个受控直流永磁电机的部分模型。</p>
<p>
电力从电池(具有内部电阻的恒定电压)中获取，并通过DC-DC变换器馈送到电机。
DC-DC变换器的详细级别可以选择理想平均化或开关。
DC-DC变换器由电流控制器命令。
电流控制器根据绝对最佳值进行参数化。
</p>
<p>
进一步阅读：
<a href=\"modelica://Modelica/Resources/Documentation/Electrical/Machines/DriveControl.pdf\">Modelica Conference 2017上的教程</a>
</p>
</html>"), 
    Diagram(coordinateSystem(extent={{-200,-100},{100,100}})));
end PartialControlledDCPM;