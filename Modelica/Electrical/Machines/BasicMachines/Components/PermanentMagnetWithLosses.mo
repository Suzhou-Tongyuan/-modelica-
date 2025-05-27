within Modelica.Electrical.Machines.BasicMachines.Components;
model PermanentMagnetWithLosses "带损耗的永磁体励磁"
  extends Machines.BasicMachines.Components.PermanentMagnet;
  extends Machines.Losses.InductionMachines.PermanentMagnetLosses;
  annotation(defaultComponentName="magnet", Documentation(info="<html>
带有损耗的永磁体励磁模型，由等效励磁电流表征。
</html>"));
end PermanentMagnetWithLosses;