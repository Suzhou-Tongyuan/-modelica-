within Modelica.Electrical.Analog.Semiconductors;
model SimpleTriac "简单三极管模型，基于简单晶闸管模型"
  parameter SI.Voltage VDRM(final min=0) = 100 
    "正向击穿电压";
  parameter SI.Voltage VRRM(final min=0) = 100 
    "反向击穿电压";
  parameter SI.Current IDRM=0.1 "饱和电流";
  parameter SI.Voltage VTM= 1.7 "导通电压";
  parameter SI.Current IH=6e-3 "保持电流";
  parameter SI.Current ITM= 25 "导通电流";

  parameter SI.Voltage VGT= 0.7 "门触发电压";
  parameter SI.Current IGT= 5e-3 "门触发电流";

  parameter SI.Time TON = 1e-6 "开关打开时间";
  parameter SI.Time TOFF = 15e-6 "开关闭合时间";
  parameter SI.Voltage Vt=0.04 
    "等效温度电压(kT/qn)";
  parameter Real Nbv=0.74 "反向穿透发射系数";

  Modelica.Electrical.Analog.Interfaces.NegativePin n "阴极" 
    annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
  Modelica.Electrical.Analog.Interfaces.PositivePin p "阳极" 
    annotation (Placement(transformation(extent={{90,-10},{110,10}})));
  Modelica.Electrical.Analog.Interfaces.PositivePin g "门极" 
    annotation (Placement(transformation(extent={{-110,-110},{-90,-90}})));
  Modelica.Electrical.Analog.Semiconductors.Thyristor thyristor(VDRM=VDRM, VRRM=VRRM, IDRM=IDRM, VTM=VTM, IH=IH, ITM=ITM, VGT=VGT, IGT=IGT, TON=TON, TOFF=TOFF, Vt=Vt, Nbv=Nbv, useHeatPort=useHeatPort, T=T) 
    annotation (Placement(transformation(extent={{-20,30},{0,50}})));
  Modelica.Electrical.Analog.Semiconductors.Thyristor thyristor1(VDRM=VDRM, VRRM=VRRM, IDRM=IDRM, VTM=VTM, IH=IH, ITM=ITM, VGT=VGT, IGT=IGT, TON=TON, TOFF=TOFF, Vt=Vt, Nbv=Nbv, useHeatPort=useHeatPort, T=T) 
                       annotation (Placement(transformation(
        extent={{-10,-10},{10,10}}, 
        rotation=180, 
        origin={-10,-40})));
  Modelica.Electrical.Analog.Ideal.IdealDiode idealDiode(Vknee=0) 
    annotation (Placement(transformation(extent={{-50,50},{-30,70}})));
  Modelica.Electrical.Analog.Ideal.IdealDiode idealDiode1(Vknee=0) annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}}, 
        origin={-40,-60})));
  extends Modelica.Electrical.Analog.Interfaces.ConditionalHeatPort;
equation
  if useHeatPort then
   connect(heatPort, thyristor.heatPort);
   connect(heatPort, thyristor1.heatPort);
 end if;
  connect(thyristor.Anode, n) annotation (Line(
      points={{-20,40},{-30,40},{-30,0},{-100,0}}, color={0,0,255}));
  connect(thyristor1.Anode, p) annotation (Line(
      points={{0,-40},{10,-40},{10,0},{100,0}}, color={0,0,255}));
  connect(thyristor1.Anode, thyristor.Cathode) annotation (Line(
      points={{0,-40},{10,-40},{10,40},{0,40}}, color={0,0,255}));
  connect(thyristor1.Cathode, thyristor.Anode) annotation (Line(
      points={{-20,-40},{-30,-40},{-30,40},{-20,40}}, color={0,0,255}));
  connect(thyristor.Gate, idealDiode.n) annotation (Line(
      points={{0,50},{0,60},{-30,60}}, color={0,0,255}));
  connect(idealDiode.p, g) annotation (Line(
      points={{-50,60},{-60,60},{-60,-100},{-100,-100}}, color={0,0,255}));
  connect(idealDiode1.n, thyristor1.Gate) annotation (Line(
      points={{-30,-60},{-20,-60},{-20,-50}}, color={0,0,255}));
  connect(idealDiode1.p, g) annotation (Line(
      points={{-50,-60},{-60,-60},{-60,-100},{-100,-100}}, color={0,0,255}));
  LossPower = p.i*p.v + n.i*n.v + g.i*g.v;
  annotation (defaultComponentName="triac", 
    Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,100}}), 
      graphics={
        Text(
          extent={{-150,120},{150,80}}, 
          textString="%name", 
          textColor={0,0,255}), 
        Line(points={{-40,-70},{-40,70}}, color={0,0,255}), 
        Line(points={{40,-72},{40,70}}, color={0,0,255}), 
        Polygon(points={{-40,-70},{40,-30},{-40,10},{-40,-70}}, 
                                                             lineColor={0,0, 
              255}, 
          fillColor={255,255,255}, 
          fillPattern=FillPattern.Solid), 
        Polygon(points={{40,-10},{-40,30},{40,70},{40,-10}}, lineColor={0,0, 
              255}, 
          fillColor={255,255,255}, 
          fillPattern=FillPattern.Solid), 
        Line(points={{-40,0},{-90,0}}, color={0,0,255}), 
        Line(points={{90,0},{40,0}}, color={0,0,255}), 
        Line(points={{-100,-100},{-100,-60},{-40,-30}}, 
                                                    color={0,0,255})}), 
    Documentation(info="<html>

<p>这是一个基于扩展晶闸管模型Modelica.Electrical.Analog.Semiconductors.Thyristor的简单TRIAC模型。
<br>两个晶闸管相反地并联连接，而每个晶闸管又与一个二极管相连。
<br>有关电子元件TRIAC的进一步信息可以在理想TRIAC模型的文档中查找到。
<br>作为附加信息：该模型基于Modelica.Electrical.Analog.Semiconductors.Thyristor搭建。

<p><strong>请注意：</strong> 
这个模型对某些参数的选择(例如VDRM、VRRM)似乎非常敏感，这是由thyristor模型本身造成的。因此，进一步的研究是必要的。
</p>
</html>", 
   revisions="<html>
<ul>
<li><em>November 25, 2009   </em><br>
       by Susann Wolf<br><br>
       </li>
</ul>
</html>"));
end SimpleTriac;