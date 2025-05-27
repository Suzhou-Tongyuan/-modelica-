within Modelica.Electrical.PowerConverters.ACDC.Control;
model VoltageBridge2mPulse "2*m脉冲桥式整流器的控制"
  import Modelica.Constants.pi;
  extends Icons.Control;
  parameter Integer m(final min=3) = 3 "相数" annotation(Evaluate=true);
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
  parameter SI.Voltage vStart[m]=zeros(m) 
    "滤波器输出的起始电压" 
    annotation(Dialog(tab="Filter", enable=useFilter));
  Modelica.Blocks.Interfaces.RealInput firingAngle(unit="rad") if not 
    useConstantFiringAngle "触发角" annotation(Placement(
        transformation(
        extent={{-20,-20},{20,20}}, 
        rotation=90, 
        origin={0,-120})));
  Signal2mPulse twomPulse(
    final useConstantFiringAngle=useConstantFiringAngle, 
    final f=f, 
    final constantFiringAngle=constantFiringAngle, 
    final firingAngleMax=firingAngleMax, 
    final m=m, 
    useFilter=useFilter, 
    final fCut=fCut, 
    final vStart=vStart) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}}, 
        origin={0,10})));
  Modelica.Electrical.Polyphase.Interfaces.PositivePlug ac(final m=m) 
    annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
  Modelica.Electrical.Polyphase.Basic.MultiDelta delta(final m=m) 
    "Delta connection" annotation (Placement(transformation(
        extent={{10,-10},{-10,10}}, 
        rotation=90, 
        origin={-80,10})));
  Modelica.Electrical.Polyphase.Sensors.VoltageSensor voltageSensor(
      final m=m) "Voltage sensor" annotation (Placement(transformation(
        extent={{10,10},{-10,-10}}, 
        rotation=270, 
        origin={-44,10})));
  Modelica.Blocks.Interfaces.BooleanOutput fire_p[m] annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}}, 
        rotation=90, 
        origin={-60,110})));
  Modelica.Blocks.Interfaces.BooleanOutput fire_n[m] annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}}, 
        rotation=90, 
        origin={60,110})));
equation
  connect(ac, voltageSensor.plug_p) annotation (Line(
      points={{-100,0},{-44,0}}, color={0,0,255}));
  connect(voltageSensor.plug_p, delta.plug_n) annotation (Line(
      points={{-44,0},{-80,0}}, color={0,0,255}));
  connect(delta.plug_p, voltageSensor.plug_n) annotation (Line(
      points={{-80,20},{-44,20}}, color={0,0,255}));
  connect(voltageSensor.v, twomPulse.v) annotation (Line(
      points={{-33,10},{-12,10}}, color={0,0,127}));
  connect(firingAngle, twomPulse.firingAngle) annotation (Line(
      points={{0,-120},{0,-2}}, color={0,0,127}));
  connect(twomPulse.fire_n, fire_n) annotation (Line(
      points={{6,21},{6,80},{60,80},{60,110}}, color={255,0,255}));
  connect(twomPulse.fire_p, fire_p) annotation (Line(
      points={{-6,21},{-6,80},{-60,80},{-60,110}}, color={255,0,255}));
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
                textString="2*%m%")}), 
    Documentation(info="<html>

<p>
控制器的一般信息总结在
<a href=\"modelica://Modelica.Electrical.PowerConverters.ACDC.Control\">Control</a> 中。
</p>

<p>
2*m脉冲桥式整流器的半导体器件中的一半连接到正直流输出引脚（触发信号 <code>fire_p</code>）。另一半半导体器件连接到负直流输出引脚（触发信号 <code>fire_n</code>）。参数 <code>m</code> 表示相数。
</p>
</html>", 
    revisions="<html>
</html>"));
end VoltageBridge2mPulse;