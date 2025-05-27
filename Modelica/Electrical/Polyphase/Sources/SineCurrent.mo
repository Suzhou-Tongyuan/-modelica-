within Modelica.Electrical.Polyphase.Sources;
model SineCurrent "多相正弦电流源"
  extends Interfaces.TwoPlug;
  parameter SI.Current I[m](start=fill(1, m)) 
    "正弦波幅值";
  parameter SI.Angle phase[m]=-
      Polyphase.Functions.symmetricOrientation(                    m) 
    "正弦波相位";
  parameter SI.Frequency f[m](start=fill(1, m)) 
    "正弦波频率";
  parameter SI.Current offset[m]=zeros(m) "电流偏移";
  parameter SI.Time startTime[m]=zeros(m) "时间偏移";
  Modelica.Electrical.Analog.Sources.SineCurrent sineCurrent[m](
    final I=I, 
    final phase=phase, 
    final f=f, 
    final offset=offset, 
    final startTime=startTime) annotation (Placement(transformation(extent= 
            {{-10,-10},{10,10}})));
equation
  connect(sineCurrent.p, plug_p.pin) 
    annotation (Line(points={{-10,0},{-100,0}}, color={0,0,255}));
  connect(sineCurrent.n, plug_n.pin) 
    annotation (Line(points={{10,0},{100,0}}, color={0,0,255}));
  annotation (
    Icon(graphics={Line(points={{-90,0},{-50,0}}, color={0,0,255}), 
          Line(points={{50,0},{90,0}}, color={0,0,255}),Ellipse(
              extent={{-50,50},{50,-50}}, 
              lineColor={0,0,255}, 
              fillColor={255,255,255}, 
              fillPattern=FillPattern.Solid),Line(points={{0,50},{0,-50}}, 
          color={0,0,255}),Line(
              points={{-70,0},{-60.2,29.9},{-53.8,46.5},{-48.2,58.1},{-43.3, 
            65.2},{-38.3,69.2},{-33.4,69.8},{-28.5,67},{-23.6,61},{-18.6,52}, 
            {-13,38.6},{-5.98,18.6},{8.79,-26.9},{15.1,-44},{20.8,-56.2},{
            25.7,-64},{30.6,-68.6},{35.5,-70},{40.5,-67.9},{45.4,-62.5},{
            50.3,-54.1},{55.9,-41.3},{63,-21.7},{70,0}}, 
              color={192,192,192}, 
              smooth=Smooth.Bezier), Polygon(
              points={{90,0},{60,10},{60,-10},{90,0}}, 
              lineColor={0,0,255}, 
              fillColor={0,0,255}, 
              fillPattern=FillPattern.Solid), 
                           Text(
              extent={{-150,60},{150,100}}, 
              textString="%name", 
              textColor={0,0,255}), 
        Text(
          extent={{150,-100},{-150,-60}}, 
          textString="m=%m")}), Documentation(info="<html>
<p>
包含m个正弦电流源(Modelica.Electrical.Analog.Sources.SineCurrent)具有由<a href=\"modelica://Modelica.Electrical.Polyphase.Functions.symmetricOrientation\">symmetricOrientation</a>
确定的默认相位移。
</p>
</html>"));
end SineCurrent;