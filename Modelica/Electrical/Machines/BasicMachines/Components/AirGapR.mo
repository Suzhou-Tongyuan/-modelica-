within Modelica.Electrical.Machines.BasicMachines.Components;
model AirGapR "转子固定坐标系中的气隙"
  parameter SI.Inductance Lmd 
    "主磁场电感d轴";
  parameter SI.Inductance Lmq 
    "主磁场电感q轴";
  extends PartialAirGap;
  SI.Current i_mr[2] 
    "相对于转子固定框架的磁化电流空间矢量";
protected
  parameter SI.Inductance L[2, 2]={{Lmd,0},{0,Lmq}} 
    "电感矩阵";
equation
  // 相对于转子参考框架的磁化电流
  i_mr = i_sr + i_rr;
  // 相对于转子参考框架的主磁通链
  psi_mr = L*i_mr;
  // 相对于定子参考框架的主磁通链
  psi_ms = RotationMatrix*psi_mr;
  annotation (
    defaultComponentName="airGap", 
    Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
            100,100}}), graphics={Text(
          extent={{0,40},{80,-40}}, 
          textString="R")}), 
    Documentation(info="<html>
转子固定坐标系中的气隙模型，仅使用方程。
</html>"));
end AirGapR;