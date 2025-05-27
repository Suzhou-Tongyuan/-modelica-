within Modelica.Electrical.QuasiStatic.SinglePhase.Utilities;
model GraetzRectifier "格雷茨整流桥"
  SI.Voltage vAC=pin_pAC.v - pin_nAC.v "交流电压";
  SI.Current iAC=pin_pAC.i "交流电流";
  SI.ActivePower pAC=vAC*iAC "交流功率";
  SI.Voltage vDC=pin_pDC.v - pin_nDC.v "直流电压";
  SI.Current iDC=pin_pDC.i "直流电流";
  SI.Power pDC=vDC*iDC "直流功率";
  Modelica.Electrical.Analog.Interfaces.PositivePin pin_pAC annotation (
      Placement(transformation(extent={{-110,110},{-90,90}}), 
        iconTransformation(extent={{-110,110},{-90,90}})));
  Modelica.Electrical.Analog.Interfaces.NegativePin pin_nAC annotation (
      Placement(transformation(extent={{-110,-110},{-90,-90}}), 
        iconTransformation(extent={{-110,-110},{-90,-90}})));
  Modelica.Electrical.Analog.Interfaces.PositivePin pin_pDC annotation (
      Placement(transformation(extent={{90,110},{110,90}}), iconTransformation(
          extent={{90,110},{110,90}})));
  Modelica.Electrical.Analog.Interfaces.NegativePin pin_nDC annotation (
      Placement(transformation(extent={{90,-110},{110,-90}}), 
        iconTransformation(extent={{90,-110},{110,-90}})));
  Modelica.Electrical.Analog.Ideal.IdealDiode idealDiode1(Vknee=0) annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}}, 
        rotation=90, 
        origin={-40,30})));
  Modelica.Electrical.Analog.Ideal.IdealDiode idealDiode2(Vknee=0) annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}}, 
        rotation=90, 
        origin={40,30})));
  Modelica.Electrical.Analog.Ideal.IdealDiode idealDiode3(Vknee=0) annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}}, 
        rotation=90, 
        origin={-40,-30})));
  Modelica.Electrical.Analog.Ideal.IdealDiode idealDiode4(Vknee=0) annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}}, 
        rotation=90, 
        origin={40,-30})));
equation
  connect(idealDiode1.p, idealDiode3.n) annotation (Line(
      points={{-40,20},{-40,-20}}, color={0,0,255}));
  connect(idealDiode2.p, idealDiode4.n) annotation (Line(
      points={{40,20},{40,-20}}, color={0,0,255}));
  connect(idealDiode3.p, idealDiode4.p) annotation (Line(
      points={{-40,-40},{40,-40}}, color={0,0,255}));
  connect(idealDiode1.n, idealDiode2.n) annotation (Line(
      points={{-40,40},{40,40}}, color={0,0,255}));
  connect(pin_pAC, idealDiode1.p) annotation (Line(
      points={{-100,100},{-100,10},{-40,10},{-40,20}}, color={0,0,255}));
  connect(pin_nAC, idealDiode4.n) annotation (Line(
      points={{-100,-100},{-100,-10},{40,-10},{40,-20}}, color={0,0,255}));
  connect(idealDiode2.n, pin_pDC) annotation (Line(
      points={{40,40},{40,100},{100,100}}, color={0,0,255}));
  connect(idealDiode4.p, pin_nDC) annotation (Line(
      points={{40,-40},{40,-100},{100,-100}}, color={0,0,255}));
  annotation (defaultComponentName="rectifier", Icon(graphics={
        Text(
          extent={{50,30},{100,0}}, 
          textColor={0,0,255}, 
          textString="直流"), 
        Text(
          extent={{-100,30},{-50,0}}, 
          textColor={0,0,255}, 
          textString="交流"), 
        Text(
          extent={{-150,90},{150,50}}, 
          textColor={0,0,255}, 
          textString="%name"), 
        Line(
          points={{-2,40},{-2,40},{-70,40},{-2,40},{-70,-50},{-2,-50},{-2,40},{-2,-50}}, 
          color={0,0,255}), 
        Line(
          points={{2,40},{70,40},{2,40},{70,-50},{2,-50},{2,40},{2,-50}}, 
          color={0,0,255})}), Documentation(info="<html>
<p>
这是一个所谓的格雷茨桥，由4个二极管构成的单相整流器。
</p>
</html>"));
end GraetzRectifier;