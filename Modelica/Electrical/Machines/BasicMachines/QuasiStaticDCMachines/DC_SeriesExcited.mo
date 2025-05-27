within Modelica.Electrical.Machines.BasicMachines.QuasiStaticDCMachines;
model DC_SeriesExcited "准静态串励线性直流电机"
  extends Machines.BasicMachines.DCMachines.DC_SeriesExcited(final quasiStatic= 
        true);
  extends Machines.Icons.QuasiStaticMachine;
  annotation (defaultComponentName="dcse", Documentation(info="<html>
<p><strong>串励直流电机的准静态模型。</strong></p>
<p>该模型与<a href=\"modelica://Modelica.Electrical.Machines.BasicMachines.DCMachines.DC_SeriesExcited\">串励直流电机的瞬态模型</a>完全兼容；
唯一的区别是忽略了电气暂态。</p>
</html>"));
end DC_SeriesExcited;