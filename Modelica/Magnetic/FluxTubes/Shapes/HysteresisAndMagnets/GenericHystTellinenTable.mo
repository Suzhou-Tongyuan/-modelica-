within Modelica.Magnetic.FluxTubes.Shapes.HysteresisAndMagnets;
model GenericHystTellinenTable 
  "基于 Tellinen 模型和表格数据的通用铁磁滞后磁通管"

  parameter FluxTubes.Material.HysteresisTableData.BaseData mat= 
    FluxTubes.Material.HysteresisTableData.BaseData() "材料特性" 
    annotation (choicesAllMatching=true, Dialog(group="Hysteresis"));
  parameter Real K = 1 
    "饱和区的滞后斜率 (K*mu_0)" annotation(Dialog(group="Hysteresis"));

  extends BaseClasses.GenericHysteresisTellinen(      mu0=mu_0*K, sigma=mat.sigma);

protected
  constant SI.MagneticFluxDensity unitT=1;
  parameter SI.MagneticFluxDensity eps = unitT*mat.tabris[size(mat.tabris,1),2]/1000;

  Modelica.Blocks.Tables.CombiTable1Dv tabris(
    table=mat.tabris, 
    smoothness=Modelica.Blocks.Types.Smoothness.ContinuousDerivative);

  Modelica.Blocks.Tables.CombiTable1Dv tabfal(
    table=mat.tabfal, 
    smoothness=Modelica.Blocks.Types.Smoothness.ContinuousDerivative);

equation
  tabris.u[1]=Hstat;
  tabfal.u[1]=Hstat;

  hystR = unitT*tabris.y[1]+mu0*Hstat-eps;
  hystF = unitT*tabfal.y[1]+mu0*Hstat+eps;

  annotation (defaultComponentName="core", Icon(graphics={Text(
          extent={{40,0},{40,-30}}, 
          textColor={255,128,0}, 
          textString="TT")}), 
    Documentation(info="<html>

<p>
用于模拟具有铁磁和动态磁滞(涡流)的磁性材料的磁通管元件。铁磁滞回行为是由<a href=\"modelica://Modelica.Magnetic.FluxTubes.UsersGuide.Hysteresis.StaticHysteresis. Tellinen\">Tellinen hysteresis model</a>。极限铁磁磁滞回线的上升支路和下降支路由表格数据指定。因此，几乎任何迟滞形状都是可能的。带有预定义表的库可以在<a href=\"modelica://Modelica.Magnetic.FluxTubes.Material.HysteresisTableData\">FluxTubes.Material.HysteresisTableData</a>找到.
</p>
<p>
概述的所有可用的滞后和永磁元素包<a href=\"modelica://Modelica.Magnetic.FluxTubes.Shapes.HysteresisAndMagnets\">HysteresisAndMagnets</a> <a href=\"modelica://Modelica.Magnetic.FluxTubes.UsersGuide.Hysteresis\">UsersGuide.Hysteresis</a>中找到.
</p>

</html>"));
end GenericHystTellinenTable;