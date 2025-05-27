within Modelica.Magnetic.FluxTubes.Basic;
model LeakageWithCoefficient 
  "泄漏磁阻相对于有用磁通路径的磁阻(不用于执行器的动态仿真)"
  extends BaseClasses.Leakage;
  import Modelica.Constants.eps;
  parameter SI.CouplingCoefficient c_usefulFlux(final min=eps, final max=1-eps, start=0.7) 
    "有效通量/(泄漏通量+有效通量)=有效通量/总通量" 
    annotation (Dialog(groupImage= 
          "modelica://Modelica/Resources/Images/Magnetic/FluxTubes/Basic/LeakageWithCoefficient.png"));
  Blocks.Interfaces.RealInput R_mUsefulTot(quantity="Reluctance", unit="H-1") 
    annotation (Placement(transformation(
        extent={{-20,-20},{20,20}}, 
        rotation=270, 
        origin={0,120})));
equation
  (1 - c_usefulFlux)*R_m = c_usefulFlux*R_mUsefulTot;
  // 广义基尔霍夫电流定律
  annotation (defaultComponentName="leakage", Documentation(info="<html>
<p>
不同于磁通管元件的封装<a href=\"modelica://Modelica.Magnetic.FluxTubes.Shapes.Leakage\">Shapes.Leakage</a>
这是从它们的几何形状计算出来的，泄漏磁阻是根据有用磁通路径的总磁阻计算出来的。请参考<strong>参数</strong>一节，了解由此产生的磁网的说明。利用<em>Kirchhoff</em>广义电流定律，利用耦合系数c_usefulFlux计算漏磁.
</p>
<div>
<img src=\"modelica://Modelica/Resources/Images/Magnetic/FluxTubes/Basic/LeakageWithCoefficient.png\" alt=\"Leakage with coefficient\">
</div>

<h4>注意事项</h4>

<p>
该元件必须<strong>不能</strong>用于</strong>电磁-机械<strong>致动器</strong>的动态模拟，其中至少有一个磁通管元件的形状在有用的磁通路径中产生磁阻力随电枢运动而变化(例如，气隙)。这种变化导致这些元件的磁导率G_m对电枢位置x的非零导数dG_m/dx，这反过来又会导致泄漏磁导率对电枢位置的非零导数。这将在泄漏元件中产生不适当的磁阻力。<a href=\"modelica://Modelica.Magnetic.FluxTubes.Shapes.Force.LeakageAroundPoles\">Shapes.Force. LeakageAroundPoles</a>提供了一个简单的泄漏磁阻与力的产生.
</p>
</html>"));
end LeakageWithCoefficient;