within Modelica.Electrical.Machines.BasicMachines.QuasiStaticDCMachines;
model DC_PermanentMagnet "准静态永磁直流电机"
  extends Machines.BasicMachines.DCMachines.DC_PermanentMagnet(final
      quasiStatic=true);
  extends Machines.Icons.QuasiStaticMachine;
  annotation (defaultComponentName="dcpm", Documentation(info="<html>
<p><strong>准静态永磁直流电机模型。</strong></p>
<p>该模型与<a href=\"modelica://Modelica.Electrical.Machines.BasicMachines.DCMachines.DC_PermanentMagnet\">永磁直流电机的瞬态模型</a>
完全兼容；唯一的区别是忽略了电气暂态。</p>
</html>"));
end DC_PermanentMagnet;