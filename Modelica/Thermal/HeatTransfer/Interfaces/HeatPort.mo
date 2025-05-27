within Modelica.Thermal.HeatTransfer.Interfaces;
partial connector HeatPort "用于一维热传导的热接口"
  SI.Temperature T "接口温度";
  flow SI.HeatFlowRate Q_flow 
    "热流率(如果从外部流入部件，则为正值)";
  annotation (Documentation(info="<html>

</html>"));
end HeatPort;