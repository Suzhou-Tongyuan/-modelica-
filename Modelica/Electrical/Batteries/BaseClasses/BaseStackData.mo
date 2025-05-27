within Modelica.Electrical.Batteries.BaseClasses;
record BaseStackData "堆栈参数，包括退化"
  extends Modelica.Electrical.Batteries.Icons.BaseStackRecord;
  import Modelica.Math.BooleanVectors.anyTrue;
  parameter Integer Ns(final min=1) "串联电池数量";
  parameter Integer Np(final min=1) "并联电池数量";
  parameter Integer kDegraded[:,2]={{0,0}} "退化电池的索引 [串联索引, 并联索引]";
  replaceable parameter Modelica.Electrical.Batteries.ParameterRecords.CellData cellDataOriginal 
    "原始电池数据" 
    annotation (Placement(transformation(extent={{-40,-10},{-20,10}})));
  replaceable parameter Modelica.Electrical.Batteries.ParameterRecords.CellData cellDataDegraded "退化电池数据" 
    annotation(Placement(transformation(extent={{20,-10},{40,10}})));
  replaceable parameter Modelica.Electrical.Batteries.ParameterRecords.CellData cellData[Ns, Np]= 
    {{if anyTrue({ks==kDegraded[i,1] and kp==kDegraded[i,2] for i in 1:size(kDegraded,1)}) then 
      cellDataDegraded else cellDataOriginal for kp in 1:Np} for ks in 1:Ns} 
    "电池数据矩阵" 
    annotation(Dialog(group="Result", enable=false), Placement(transformation(extent={{-10,-30},{10,-10}})));
  annotation(defaultComponentPrefixes="parameter", Documentation(info="<html>
  <p>这个记录包含了原始电池数据和退化电池数据的基本定义。</p>
</html>"));
end BaseStackData;