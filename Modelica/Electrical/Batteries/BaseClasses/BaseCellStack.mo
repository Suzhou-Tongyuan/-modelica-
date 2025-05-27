within Modelica.Electrical.Batteries.BaseClasses;
partial model BaseCellStack 
  "依赖于开路电压、自放电和内阻的电池模型"
  extends Modelica.Electrical.Batteries.Icons.BatteryIcon(final displaySOC=SOC);
  parameter Integer Ns(final min=1)=1 "串联电池数";
  parameter Integer Np(final min=1)=1 "并联电池数";
  replaceable parameter ParameterRecords.CellData cellData "电池参数" 
    annotation (Placement(transformation(extent={{-10,60},{10,80}})));
  parameter Real SOCtolerance=1e-9 "用于检测电池耗尽或过充的容差" 
    annotation(Dialog(tab="高级"));
  extends Modelica.Electrical.Analog.Interfaces.TwoPin;
  SI.Current i = p.i "电池充电电流";
  SI.Power power = v*i "电池功率";
  output Real SOC(start=cellData.SOCmax) = limIntegrator.y "电池充电状态" 
    annotation (Dialog(showStartAttribute=true));
  Modelica.Electrical.Analog.Sensors.CurrentSensor currentSensor 
    annotation (Placement(transformation(extent={{-90,10},{-70,-10}})));
  Blocks.Continuous.LimIntegrator limIntegrator(
    final k=1/(Np*cellData.Qnom), 
    outMax=1 - SOCtolerance, 
    outMin=SOCtolerance, 
    final initType=Modelica.Blocks.Types.Init.NoInit) annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}}, 
        rotation=90, 
        origin={-80,30})));
  Modelica.Blocks.Tables.CombiTable1Ds ocv_soc(
    final table=cellData.OCV_SOC_internal, 
    final smoothness=cellData.smoothness, 
    extrapolation=Modelica.Blocks.Types.Extrapolation.HoldLastPoint) 
    annotation (Placement(transformation(extent={{-70,40},{-50,60}})));
  Modelica.Blocks.Math.Gain gainV(final k=Ns*cellData.OCVmax) annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}}, 
        rotation=270, 
        origin={-40,30})));
  Modelica.Electrical.Analog.Sources.SignalVoltage ocv 
    annotation (Placement(transformation(extent={{-50,-10},{-30,10}})));
  Modelica.Electrical.Analog.Basic.Conductor selfDischarge(
    final G=Np*cellData.Idis/(Ns*cellData.OCVmax), 
    T_ref=293.15, 
    final useHeatPort=true) 
    annotation (Placement(transformation(extent={{-70,-30},{-50,-10}})));
  Modelica.Electrical.Analog.Basic.Resistor r0(
    final T_ref=cellData.T_ref, 
    final alpha=cellData.alpha, 
    final useHeatPort=true) 
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  extends Modelica.Electrical.Analog.Interfaces.PartialConditionalHeatPort;
equation
  assert(cellData.OCVmax > cellData.OCVmin, "请指定 0 <= OCVmin < OCVmax");
  assert(cellData.SOCmax > cellData.SOCmin, "请指定 0 <= SOCmin < SOCmax <= 1");
  assert(cellData.OCV_SOC[1, 1] >= 0, "请使用最小 SOC >= 0 的 OCV(SOC) 表");
  assert(cellData.OCV_SOC[end, 1] <= 1,  "请使用最大 SOC <= 1 的 OCV(SOC) 表");
  assert(cellData.OCV_SOC[1, 2] >= 0, "请使用最小 OCV/OCVmax >= 0 的 OCV(SOC) 表");
  assert(cellData.OCV_SOC[end, 2] <= 1, "请使用最大 OCV/OCVmax <= 1 的 OCV(SOC) 表");
  assert(SOC < cellData.SOCmax + SOCtolerance, "电池过充！");
  assert(SOC > cellData.SOCmin - SOCtolerance, "电池耗尽！");
  connect(gainV.y, ocv.v) 
    annotation (Line(points={{-40,19},{-40,12}}, color={0,0,127}));
  connect(ocv_soc.y[1], gainV.u) 
    annotation (Line(points={{-49,50},{-40,50},{-40,42}}, 
                                                      color={0,0,127}));
  connect(limIntegrator.y, ocv_soc.u) 
    annotation (Line(points={{-80,41},{-80,50},{-72,50}}, color={0,0,127}));
  connect(currentSensor.n, ocv.p) 
    annotation (Line(points={{-70,0},{-50,0}}, color={0,0,255}));
  connect(limIntegrator.u, currentSensor.i) 
    annotation (Line(points={{-80,18},{-80,11}}, color={0,0,127}));
  connect(p, currentSensor.p) 
    annotation (Line(points={{-100,0},{-90,0}}, color={0,0,255}));
  connect(ocv.n, r0.p) 
    annotation (Line(points={{-30,0},{-10,0}}, color={0,0,255}));
  connect(currentSensor.p, selfDischarge.p) annotation (Line(points={{-90,0},{-90, 
          -20},{-70,-20}},           color={0,0,255}));
  connect(ocv.n, selfDischarge.n) 
    annotation (Line(points={{-30,0},{-30,-20},{-50,-20}}, color={0,0,255}));
  connect(selfDischarge.heatPort, internalHeatPort) annotation (Line(points={{-60,-30}, 
          {-60,-40},{0,-40},{0,-80}},      color={191,0,0}));
  connect(internalHeatPort, r0.heatPort) annotation (Line(points={{0,-80},{
          0,-10}},              color={191,0,0}));
  annotation (
    Documentation(info="<html>
<p>
电池的开路电压(OCV)取决于充电状态(SOC)、自放电组分和内阻。<br>
参数收集在参数记录<a href=\"modelica://Modelica.Electrical.Batteries.ParameterRecords.CellData\">cellData</a>中。<br>
所有损耗都通过可选的<code>heatPort</code> 放散。
</p>
<p>
详情请参阅<a href=\"modelica://Modelica.Electrical.Batteries.UsersGuide.Concept\">概念</a>和<a href=\"modelica://Modelica.Electrical.Batteries.UsersGuide.Parameterization\">参数化</a>。
</p>
<h4>注意</h4>
<p>
SOC>SOCmax或SOC<SOCmin会触发错误。
</p>
</html>"));
end BaseCellStack;