within Modelica.Electrical.Batteries.Utilities;
block Impedance "计算复阻抗"
  extends Blocks.Icons.Block;
  import Modelica.Constants.pi;
  import Modelica.ComplexMath.sum;
  parameter Modelica.Electrical.Batteries.ParameterRecords.TransientData.CellData cellData "瞬态电池数据";
  Blocks.Interfaces.RealInput f(unit="Hz") "频率" 
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
  ComplexBlocks.Interfaces.ComplexOutput z(re(unit="Ohm"), im(unit="Ohm")) "复阻抗" 
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));
  Complex temp;
algorithm
  temp := Complex(0, 0);
  for k in 1:cellData.nRC loop
    temp := temp + 1 / Complex(1 / cellData.rcData[k].R, 2 * pi * f * cellData.rcData[k].C);
  end for;
equation
  //z = Complex(cellData.R0, 0) + sum({1 / Complex(1 / cellData.rcData[k].R, 2 * pi * f * cellData.rcData[k].C) for k in 1:cellData.nRC});
  z = Complex(cellData.R0, 0) + temp;
  annotation (Documentation(info="<html>
<p>
从给定的电池数据和频率计算复阻抗。
</p>
</html>"), Icon(graphics={
        Ellipse(
          extent={{-42,60},{78,-60}}, 
          lineColor={0,0,0}, 
          startAngle=0, 
          endAngle=141, 
          closure=EllipseClosure.None), 
        Polygon(
          points={{-82,90},{-90,68},{-74,68},{-82,90}}, 
          lineColor={192,192,192}, 
          fillColor={192,192,192}, 
          fillPattern=FillPattern.Solid), 
        Line(points={{-82,-80},{-82,68}}, 
                                      color={192,192,192}), 
        Line(points={{-82,0},{76,0}}, color={192,192,192}), 
        Polygon(
          points={{98,0},{76,8},{76,-8},{98,0}}, 
          lineColor={192,192,192}, 
          fillColor={192,192,192}, 
          fillPattern=FillPattern.Solid), 
        Ellipse(
          extent={{-82,40},{-2,-40}}, 
          lineColor={0,0,0}, 
          startAngle=70, 
          endAngle=180, 
          closure=EllipseClosure.None)}));
end Impedance;