within Modelica.Electrical.PowerConverters.ACDC.Control;
model VoltageBridge2Pulse "2脉冲桥式整流器的控制"
  import Modelica.Constants.pi;
  extends Icons.Control;
  parameter SI.Frequency f=50 "频率";
  parameter Boolean useConstantFiringAngle=true 
    "使用恒定触发角而不是信号输入";
  parameter SI.Angle constantFiringAngle=0 "触发角" 
    annotation(Dialog(enable=useConstantFiringAngle));
  parameter SI.Angle firingAngleMax(
    final min=0, 
    final max=Modelica.Constants.pi) = Modelica.Constants.pi 
    "最大触发角";
  parameter Boolean useFilter=true "启用滤波器使用" 
    annotation(Dialog(tab="Filter"));
  parameter SI.Frequency fCut=2*f 
    "滤波器截止频率" 
    annotation(Dialog(tab="Filter", enable=useFilter));
  parameter SI.Voltage vStart=0 
    "滤波器输出的起始电压" 
    annotation(Dialog(tab="Filter", enable=useFilter));
  Modelica.Blocks.Interfaces.RealInput firingAngle(unit="rad") if not 
    useConstantFiringAngle "触发角" annotation(Placement(
        transformation(
        extent={{-20,-20},{20,20}}, 
        rotation=90, 
        origin={0,-120})));
  Signal2mPulse twoPulse(
    final useConstantFiringAngle=useConstantFiringAngle, 
    final f=f, 
    final constantFiringAngle=constantFiringAngle, 
    final firingAngleMax=firingAngleMax, 
    final m=1, 
    final useFilter=useFilter, 
    final fCut=fCut, 
    final vStart=fill(vStart, 1)) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}})));
  Modelica.Electrical.Analog.Interfaces.PositivePin ac_p 
    annotation (Placement(transformation(extent={{-110,50},{-90,70}})));
  Modelica.Electrical.Analog.Interfaces.NegativePin ac_n 
    annotation (Placement(transformation(extent={{-110,-70},{-90,-50}})));
  Modelica.Electrical.Analog.Sensors.VoltageSensor voltageSensor 
    annotation (Placement(transformation(
        extent={{-10,10},{10,-10}}, 
        rotation=270, 
        origin={-80,0})));
  Modelica.Blocks.Interfaces.BooleanOutput fire_p annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}}, 
        rotation=90, 
        origin={-60,110})));
  Modelica.Blocks.Interfaces.BooleanOutput fire_n annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}}, 
        rotation=90, 
        origin={60,110})));
equation
  connect(voltageSensor.v, twoPulse.v[1]) annotation (Line(
      points={{-69,0},{-12,0}}, 
               color={0,0,127}));
  connect(voltageSensor.p, ac_p) annotation (Line(
      points={{-80,10},{-80,60},{-100,60}}, color={0,0,255}));
  connect(voltageSensor.n, ac_n) annotation (Line(
      points={{-80,-10},{-80,-60},{-100,-60}}, color={0,0,255}));
  connect(firingAngle, twoPulse.firingAngle) annotation (Line(
      points={{0,-120},{0,-12}}, color={0,0,127}));
  connect(twoPulse.fire_n[1], fire_n) annotation (Line(
      points={{6,11},{6,80},{60,80},{60,110}}, color={255,0,255}));
  connect(twoPulse.fire_p[1], fire_p) annotation (Line(
      points={{-6,11},{-6,80},{-60,80},{-60,110}}, color={255,0,255}));
  annotation (defaultComponentName="adaptor", 
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100}, 
            {100,100}}),graphics={Line(
                points={{-40,-20},{-40,-24},{-20,-24},{-20,-40},{-40,-40}, 
            {-40,-60}}, 
                color={255,0,255}),Line(
                points={{20,-20},{20,-44},{40,-44},{40,-60},{20,-60},{20, 
            -60}}, 
                color={255,0,255}),Text(
                extent={{-40,60},{40,0}}, 
                textColor={255,0,255}, 
                textString="2")}), 
    Documentation(revisions="<html>
</html>", 
    info="<html>

<p>
有关控制器的一般信息总结在
<a href=\"modelica://Modelica.Electrical.PowerConverters.ACDC.Control\">Control</a> 中。
</p>

<p>
此模型为 Graetz 桥式晶闸管和半桥整流器提供两个触发信号。布尔
信号 <code>fire_p</code> 分配给与正直流输出引脚连接的晶闸管。
布尔
信号 <code>fire_n</code> 分配给与负直流输出引脚连接的晶闸管。
</p>
</html>"));
end VoltageBridge2Pulse;