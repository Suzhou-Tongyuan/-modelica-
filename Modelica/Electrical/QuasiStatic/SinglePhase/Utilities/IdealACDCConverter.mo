within Modelica.Electrical.QuasiStatic.SinglePhase.Utilities;
model IdealACDCConverter "理想交直流变换器"
  parameter Real conversionFactor "直流电压/准静态有效值电压的比值";
  import Modelica.ComplexMath.real;
  import Modelica.ComplexMath.imag;
  import Modelica.ComplexMath.conj;
  import Modelica.ComplexMath.abs;
  import Modelica.ComplexMath.arg;
  SI.ComplexVoltage vQS=pin_pQS.v - pin_nQS.v "准静态电压";
  SI.ComplexCurrent iQS=pin_pQS.i "准静态电流";
  output SI.Voltage vQSabs=abs(vQS) "准静态电压的幅值";
  output SI.Current iQSabs=abs(iQS) "准静态电流的幅值";
  SI.ComplexPower sQS=vQS*conj(iQS) "准静态视在功率";
  SI.ActivePower pQS=real(sQS) "准静态有功功率";
  SI.ReactivePower qQS=imag(sQS) "准静态无功功率";
  SI.Voltage vDC=pin_pDC.v - pin_nDC.v "直流电压";
  SI.Current iDC=pin_pDC.i "直流电流";
  SI.Power pDC=vDC*iDC "直流功率";
  Interfaces.PositivePin pin_pQS annotation (Placement(transformation(
          extent={{-110,110},{-90,90}}), iconTransformation(extent={{-110, 
            110},{-90,90}})));
  Interfaces.NegativePin pin_nQS annotation (Placement(transformation(
          extent={{-110,-110},{-90,-90}}), iconTransformation(extent={{-110, 
            -110},{-90,-90}})));
  Modelica.Electrical.Analog.Interfaces.PositivePin pin_pDC annotation (
      Placement(transformation(extent={{90,110},{110,90}}), iconTransformation(
          extent={{90,110},{110,90}})));
  Modelica.Electrical.Analog.Interfaces.NegativePin pin_nDC annotation (
      Placement(transformation(extent={{90,-110},{110,-90}}), 
        iconTransformation(extent={{90,-110},{110,-90}})));
equation
  //准静态电路平衡
  Connections.branch(pin_pQS.reference, pin_nQS.reference);
  pin_pQS.reference.gamma = pin_nQS.reference.gamma;
  pin_pQS.i + pin_nQS.i = Complex(0);
  //直流电流平衡
  pin_pDC.i + pin_nDC.i = 0;
  //电压关系
  vDC = abs(vQS)*conversionFactor;
  //功率平衡
  pQS + pDC = 0;
  //定义无功功率
  qQS = 0;
  annotation (defaultComponentName="rectifier", Icon(graphics={
        Line(
          points={{2,40},{70,40},{2,40},{70,-50},{2,-50},{2,40},{2,-50}}, 
          color={0,0,255}), 
        Text(
          extent={{50,30},{100,0}}, 
          textColor={0,0,255}, 
          textString="直流"), 
        Line(
          points={{-2,40},{-2,40},{-70,40},{-2,40},{-70,-50},{-2,-50},{-2,40},{-2,-50}}, 
          color={85,170,255}), 
        Text(
          extent={{-90,30},{-40,0}}, 
          textColor={85,170,255}, 
          textString="准静态"), 
        Text(
          extent={{-150,90},{150,50}}, 
          textColor={0,0,255}, 
          textString="%name"), 
        Text(
          extent={{-150,-50},{150,-90}}, 
          textString="%conversionFactor")}), Documentation(info="<html>
<p>
这是一个理想的交直流变换器，基于准静态电路和直流侧之间的功率平衡。
参数 <em>conversionFactor</em> 定义了平均直流电压和准静态有效值电压之间的比值。
此外，准静态侧的无功功率被设定为零。
</p>
<h4>注意</h4>
<p>
当然，准静态侧和直流侧都没有电压或电流纹波。
在准静态侧，仅考虑了电压和电流的基波。
在直流侧，仅考虑了电压和电流的平均值。
</p>
</html>"));
end IdealACDCConverter;