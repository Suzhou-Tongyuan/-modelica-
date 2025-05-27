within Modelica.Electrical.Machines.BasicMachines.Components;
model IdealCore "具有3个绕组的理想变压器"
  extends PartialCore;
equation
  im = zeros(m);
  v1 = n12*v2;
  v1 = n13*v3;
  annotation (defaultComponentName="core", Documentation(info="<html>
具有3个绕组的理想变压器：无磁化电流。
</html>"));
end IdealCore;