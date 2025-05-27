within Modelica.Electrical.Machines.BasicMachines.Components;
model AirGapS "定子固定坐标系中的气隙"
  parameter SI.Inductance Lm "主磁场电感";
  extends PartialAirGap;
  SI.Current i_ms[2] 
    "相对于定子固定框架的磁化电流空间矢量";
protected
  parameter SI.Inductance L[2, 2]={{Lm,0},{0,Lm}} 
    "电感矩阵";
equation
  // 相对于定子参考框架的磁化电流
  i_ms = i_ss + i_rs;
  // 相对于定子参考框架的磁通链
  psi_ms = L*i_ms;
  // 相对于转子参考框架的磁通链
  psi_mr = transpose(RotationMatrix)*psi_ms;
  annotation (
    defaultComponentName="airGap", 
    Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
            100,100}}), graphics={Text(
          extent={{-80,40},{0,-40}}, 
          textString="S")}), 
    Documentation(info="<html>
定子固定坐标系中气隙的模型，仅使用方程。
</html>"));
end AirGapS;