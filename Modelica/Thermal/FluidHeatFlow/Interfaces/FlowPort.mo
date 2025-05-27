within Modelica.Thermal.FluidHeatFlow.Interfaces;
connector FlowPort "流体接口连接器"

  parameter FluidHeatFlow.Media.Medium medium "连接器中的介质";
  SI.Pressure p;
  flow SI.MassFlowRate m_flow;
  SI.SpecificEnthalpy h;
  flow SI.EnthalpyFlowRate H_flow;
  annotation(Documentation(info="<html><p>
<br>连接器的基本定义。<br><strong>变量：</strong>
</p>
<li>
压力 p</li>
<li>
流变量 质量流量 m_flow</li>
<li>
比焓 h</li>
<li>
流变量 焓流量 H_flow<br><br>如果连接了不同介质的端口，系统会通过参数检查来确认模拟有效性。<br></li>
</html>"));
end FlowPort;