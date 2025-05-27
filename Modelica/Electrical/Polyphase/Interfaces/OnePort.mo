within Modelica.Electrical.Polyphase.Interfaces;
partial model OnePort 
  "具有两个电气插头和从plug_p到plug_n的电流的元件"

  extends TwoPlug;
equation
  plug_p.pin.i + plug_n.pin.i = zeros(m);
  annotation (Documentation(info="<html>
<p>
具有<strong>两个</strong>电气插头的元件的超类：
正多相插头连接器<em>plug_p</em>和负多相插头连接器<em>plug_n</em>。
流入plug_p的电流作为电流i[m]明确提供。
假定流入plug_p的电流与从plug_n流出的电流相同。
</p>
</html>"));
end OnePort;