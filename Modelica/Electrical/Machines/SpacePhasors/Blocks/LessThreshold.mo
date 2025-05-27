within Modelica.Electrical.Machines.SpacePhasors.Blocks;
block LessThreshold "当长度低于阈值时将角度设为零"
  extends Modelica.Blocks.Interfaces.MISO(final nin=2);
  parameter Real threshold(final min=0) "阈值";
  annotation();
equation
  y = if noEvent(u[1]<threshold) then 0 else u[2];
end LessThreshold;