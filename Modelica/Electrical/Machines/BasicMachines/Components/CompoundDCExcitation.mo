within Modelica.Electrical.Machines.BasicMachines.Components;
model CompoundDCExcitation "复合励磁=分接+级联"
  parameter Real excitationTurnsRatio 
    "级联励磁匝数与分接励磁匝数之比";
  SI.Voltage v=pin_p.v - pin_n.v;
  SI.Current i=pin_p.i;
  SI.Voltage ve=pin_ep.v - pin_en.v;
  SI.Current ie=pin_ep.i;
  SI.Voltage vse=pin_sep.v - pin_sen.v;
  SI.Current ise=pin_sep.i;
  Modelica.Electrical.Analog.Interfaces.PositivePin pin_p 
    "空气间的正极引脚" 
    annotation (Placement(transformation(extent={{90,110},{110,90}})));
  Modelica.Electrical.Analog.Interfaces.NegativePin pin_n 
    "空气间的负极引脚" 
    annotation (Placement(transformation(extent={{-110,110},{-90,90}})));
  Modelica.Electrical.Analog.Interfaces.PositivePin pin_ep 
    "分接励磁的正极引脚" 
    annotation (Placement(transformation(extent={{90,-108},{110,-88}})));
  Modelica.Electrical.Analog.Interfaces.NegativePin pin_en 
    "分接励磁的负极引脚" 
    annotation (Placement(transformation(extent={{10,-110},{30,-90}})));
  Modelica.Electrical.Analog.Interfaces.PositivePin pin_sep 
    "级联励磁的正极引脚" 
    annotation (Placement(transformation(extent={{-30,-110},{-10,-90}})));
  Modelica.Electrical.Analog.Interfaces.NegativePin pin_sen 
    "级联励磁的负极引脚" annotation (Placement(
        transformation(extent={{-110,-110},{-90,-90}})));
equation
  //电流平衡
  pin_p.i + pin_n.i = 0;
  pin_ep.i + pin_en.i = 0;
  pin_sep.i + pin_sen.i = 0;
  //复合电流
  -i = ie + excitationTurnsRatio*ise;
  //感应电压
  ve = v;
  vse = v*excitationTurnsRatio;
  annotation (defaultComponentName="excitation", 
    Icon(graphics={Polygon(
                points={{-60,-40},{-40,-40},{0,4},{40,-40},{60,-40},{10, 
            20},{10,60},{20,60},{0,80},{-20,60},{-10,60},{-10,20},{-60,-40}}, 
                lineColor={0,0,255}, 
                fillColor={0,0,255}, 
                fillPattern=FillPattern.Solid),Text(
                extent={{-80,-40},{-40,-80}}, 
                textColor={0,0,255}, 
                textString="S"),Text(
                extent={{40,-40},{80,-80}}, 
                textColor={0,0,255}, 
                textString="E")}), Documentation(info="<html>
模型将分接励磁电流和级联励磁电流复合成总的励磁电流相对于分接励磁。
此模型旨在放置在分接和级联励磁引脚和空气间之间；
空气间的连接必须在一个点接地。
</html>"));
end CompoundDCExcitation;