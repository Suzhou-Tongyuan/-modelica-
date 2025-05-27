within Modelica.Electrical.Machines.Examples.Transformers;
model AsymmetricalLoad "非对称负载"
  extends Modelica.Icons.Example;
  parameter SI.Resistance RL=1 "负载电阻";
  Modelica.Electrical.Polyphase.Sources.SineVoltage source(f=fill(
        50, 3), V=fill(sqrt(2/3)*100, 3)) annotation (Placement(
        transformation(
        origin={-90,-10}, 
        extent={{-10,10},{10,-10}}, 
        rotation=270)));
  Modelica.Electrical.Polyphase.Basic.Star starS annotation (Placement(
        transformation(
        origin={-90,-40}, 
        extent={{-10,-10},{10,10}}, 
        rotation=270)));
  Modelica.Electrical.Analog.Basic.Ground groundS annotation (Placement(
        transformation(extent={{-100,-80},{-80,-60}})));
  Modelica.Electrical.Polyphase.Sensors.CurrentSensor currentSensorS 
    annotation (Placement(transformation(extent={{-60,20},{-40,0}})));
  Modelica.Electrical.Analog.Basic.Ground groundL annotation (Placement(
        transformation(extent={{0,-80},{20,-60}})));
  parameter Machines.Utilities.TransformerData transformerData(
    C1=Modelica.Utilities.Strings.substring(
        transformer.VectorGroup, 
        1, 
        1), 
    C2=Modelica.Utilities.Strings.substring(
        transformer.VectorGroup, 
        2, 
        2), 
    f=50, 
    V1=100, 
    V2=100, 
    SNominal=30E3, 
    v_sc=0.05, 
    P_sc=300) "变压器数据" 
    annotation (Placement(transformation(extent={{-10,40},{10,60}})));
  BasicMachines.Transformers.Dy.Dy01 transformer(
    n=transformerData.n, 
    R1=transformerData.R1, 
    L1sigma=transformerData.L1sigma, 
    R2=transformerData.R2, 
    L2sigma=transformerData.L2sigma, 
    T1Ref=293.15, 
    alpha20_1(displayUnit="1/K")=Modelica.Electrical.Machines.Thermal.Constants.alpha20Zero, 
    T2Ref=293.15, 
    alpha20_2(displayUnit="1/K")=Modelica.Electrical.Machines.Thermal.Constants.alpha20Zero, 
    T1Operational=293.15, 
    T2Operational=293.15) annotation (Placement(transformation(extent={{-20, 
            -10},{20,30}})));

  Modelica.Electrical.Polyphase.Basic.PlugToPin_n plugToPin_n(k=1) 
    annotation (Placement(transformation(extent={{20,0},{40,20}})));
  Analog.Basic.Resistor load(R=RL) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}}, 
        rotation=270, 
        origin={50,0})));
  Analog.Basic.Resistor earth(R=1e6) annotation (Placement(transformation(
        origin={-10,-40}, 
        extent={{-10,10},{10,-10}}, 
        rotation=270)));
  Analog.Basic.Ground groundT annotation (Placement(transformation(extent= 
           {{-20,-80},{0,-60}})));
initial equation
  transformer.i2[1] = 0;
equation
  connect(starS.pin_n, groundS.p) 
    annotation (Line(points={{-90,-50},{-90,-60}}, color={0,0,255}));
  connect(source.plug_n, starS.plug_p) 
    annotation (Line(points={{-90,-20},{-90,-30}}, color={0,0,255}));
  connect(currentSensorS.plug_n, transformer.plug1) annotation (Line(
      points={{-40,10},{-20,10}}, color={0,0,255}));
  connect(transformer.plug2, plugToPin_n.plug_n) annotation (Line(
      points={{20,10},{28,10}}, color={0,0,255}));
  connect(transformer.starpoint2, groundL.p) annotation (Line(
      points={{10,-10},{10,-60}}, color={0,0,255}));
  connect(load.p, plugToPin_n.pin_n) annotation (Line(
      points={{50,10},{32,10}}, color={0,0,255}));
  connect(transformer.starpoint2, load.n) annotation (Line(
      points={{10,-10},{50,-10}}, color={0,0,255}));
  connect(source.plug_p, currentSensorS.plug_p) annotation (Line(
      points={{-90,0},{-90,10},{-60,10}}, color={0,0,255}));
  connect(earth.n, groundT.p) annotation (Line(points={{-10,-50},{-10,-50}, 
          {-10,-60}}, color={0,0,255}));
  annotation (Documentation(info="<html>
<h4>非对称(单相)负载</h4>
<p>
您可以选择不同的连接方式。
</p>
<p>
<strong>请注意</strong>正确接地整个电路的主要部分和次要部分。<br>
如果连接不是△(D或d)，则主要和次要星点可用作连接器。
</p>
<p>
在某些情况下，即使源或负载的星点接地，也有必要接地变压器的星点：
</p>
<ul>
<li>Yy，主星点连接到源星点：只有一个相的主电流</li>
<li>Yy，主星点未连接到源星点：次电压中断</li>
<li>Yz ... 需要用合理高的接地电阻接地变压器的主要星点。</li>
<li>Dy ... 两个主要相的负载电流。</li>
<li>Dz ... 三个主要相的负载电流。</li>
</ul>
</html>"), 
     experiment(StopTime=0.1, Interval=1E-4, Tolerance=1E-6));
end AsymmetricalLoad;