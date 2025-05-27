within Modelica.Media;
package CompressibleLiquids "可压缩液体模型"
  extends Modelica.Icons.VariantsPackage;
  package Common "可压缩液体的基础类"
    extends Modelica.Icons.Package;
    partial package LinearWater_pT 
      "线性可压缩液态水模型的基类"
      extends Media.Interfaces.PartialLinearFluid(
        constantJacobian=true, 
        reference_d=Modelica.Media.Water.StandardWater.density(state), 
        reference_h=Modelica.Media.Water.StandardWater.specificEnthalpy(state), 
        reference_s=Modelica.Media.Water.StandardWater.specificEntropy(state), 
        cp_const=Modelica.Media.Water.StandardWater.specificHeatCapacityCp(state), 
        beta_const= 
            Modelica.Media.Water.StandardWater.isobaricExpansionCoefficient(state), 
        kappa_const=Modelica.Media.Water.StandardWater.isothermalCompressibility(
            state), 
        MM_const=Modelica.Media.Water.StandardWater.molarMass(state));

      constant Modelica.Media.Water.StandardWater.ThermodynamicState state= 
          Modelica.Media.Water.StandardWater.setState_pT(reference_p, reference_T);
      annotation();
    end LinearWater_pT;
    annotation();
  end Common;

  package LinearColdWater "具有线性可压缩性的冷水模型"
    extends Media.Interfaces.PartialLinearFluid(
      mediumName="Linear cold water", 
      constantJacobian=true, 
      reference_p=101325, 
      reference_T=278.15, 
      reference_d=997.05, 
      reference_h=104929, 
      reference_s=100.0, 
      cp_const=4181.9, 
      beta_const=2.5713e-4, 
      kappa_const=4.5154e-10, 
      MM_const=0.018015268);

  redeclare function extends dynamicViscosity "水的动力黏度"
    annotation();
  algorithm
    eta := 1.5e-3;
  end dynamicViscosity;

  redeclare function extends thermalConductivity 
      "水的导热系数"
    annotation();
  algorithm
    lambda := 0.572;
  end thermalConductivity;
    annotation();

  end LinearColdWater;

  package LinearWater_pT_Ambient 
    "线性可压缩性液态水模型,压力为 1.01325 bar,温度为25摄氏度"
    extends Modelica.Media.CompressibleLiquids.Common.LinearWater_pT(
      mediumName="Liquid linear water", 
      reference_p = 101325, 
      reference_T = 298.15);
  redeclare function extends dynamicViscosity "水的动力黏度"
    annotation();
  algorithm
    eta := 8.9e-4;
  end dynamicViscosity;

  redeclare function extends thermalConductivity 
      "水的导热系数"
    annotation();
  algorithm
    lambda := 0.608;
  end thermalConductivity;
    annotation (Documentation(info="<html>
<h4>环境条件下的水模型，具有线性可压缩性</h4>
</html>"  ));
  end LinearWater_pT_Ambient;

  annotation (Documentation(info="<html><h4>具有线性可压缩性的流体模型，使用PartialLinearFluid作为基类。</h4><p>
此库中包含的线性可压缩性流体模型基于以下假设：
</p>
<ul><li>
在定压比热容（cp）是常数</li>
<li>
等压膨胀系数（beta）是常数</li>
<li>
等温压缩性（kappa）是常数</li>
<li>
压力和温度为状态</li>
</ul><p>
这使得模型仅适用于较小的温度范围，但足以模拟可压缩性和 \"水锤 \"效应等。另一个优点是，只需测量 3 个值即可建立初始模型。液压流体通常可以用这种模型来近似。
</p>
<p>
这意味着密度是温度和压力的线性函数。为了定义完整的模型，需要在压力 p 和温度 T 状态的参考值下计算一些常量参考值。该模型可解释为完全非线性流体模型的线性化（但并非在所有热力学坐标下都是线性的）。参考值需要：
</p>
<ol><li>
密度（reference_d）,</li>
<li>
比焓（reference_h）,</li>
<li>
比熵（reference_s）。</li>
</ol><p>
除此之外，用户还需要定义摩尔质量 MM_const。请注意，使用流体软件库中定义的标准函数计算软件库常量（见 Common, LinearWater_pT 中的示例），可以通过计算完全非线性流体模型的参考值来定义流体。
</p>
</html>"));
end CompressibleLiquids;