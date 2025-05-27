within Modelica.Electrical.Polyphase.Interfaces;
partial model TwoPort 
  "具有两个多相电气端口的元件，包括电流"
  extends FourPlug;
equation
  plug_p1.pin.i + plug_n1.pin.i = zeros(m);
  plug_p2.pin.i + plug_n2.pin.i = zeros(m);
  annotation (Documentation(info="<html>
<p>
具有<strong>四个</strong>电气插头的元件的超类。
假定流入plug_p1的电流与流出plug_n1的电流相同，
以及流入plug_p2的电流与流出plug_n2的电流相同。
</p>
</html>"));
end TwoPort;