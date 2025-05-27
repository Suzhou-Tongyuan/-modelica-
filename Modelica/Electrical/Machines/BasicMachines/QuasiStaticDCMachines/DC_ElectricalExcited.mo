within Modelica.Electrical.Machines.BasicMachines.QuasiStaticDCMachines;
model DC_ElectricalExcited 
  "准静态电励磁并联/分离励磁线性直流电机"
  extends Machines.BasicMachines.DCMachines.DC_ElectricalExcited(final
      quasiStatic=true);
  extends Machines.Icons.QuasiStaticMachine;
  annotation (defaultComponentName="dcee", Documentation(info="<html>
<p><strong>电励磁并联或分离励磁直流电机的准静态模型。</strong></p>
<p>该模型与<a href=\"modelica://Modelica.Electrical.Machines.BasicMachines.DCMachines.DC_ElectricalExcited\">电励磁并联或分离励磁直流电机的瞬态模型</a>完全兼容；唯一的区别是忽略了电气暂态。</p>
</html>"));
end DC_ElectricalExcited;