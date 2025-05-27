within Modelica.Thermal.HeatTransfer.Interfaces;
partial model Element1D 
  "传热元件基类(带两个HeatPort连接器且不存储能量)"

  SI.HeatFlowRate Q_flow 
    "从端口a -> 端口b的热流量";
  SI.TemperatureDifference dT "port_a.T - port_b.T";
public
  HeatPort_a port_a annotation (Placement(transformation(extent={{-110,-10}, 
            {-90,10}})));
  HeatPort_b port_b annotation (Placement(transformation(extent={{90,-10},{
            110,10}})));
equation
  dT = port_a.T - port_b.T;
  port_a.Q_flow = Q_flow;
  port_b.Q_flow = -Q_flow;
  annotation (Documentation(info="<html><p style=\"text-align: start;\">该局部模型包含用于构建<strong>不存储能量</strong>的传热模型的基础连接器与变量。该模型定义并包含了流经该元件的温度降<strong>dT</strong>，以及从port.a到port.b流经该元件的热流率<strong>Q_flow</strong>的方程。
</p>
<p style=\"text-align: start;\">通过扩展此模型，可为多种类型的热传递组件编写简单的本构方程。
</p>
</html>"));
end Element1D;