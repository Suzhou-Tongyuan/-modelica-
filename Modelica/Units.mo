within Modelica;
package Units "类型和单位定义库"
  extends Modelica.Icons.Package;

  package UsersGuide "单位库的用户指南"
    extends Modelica.Icons.Information;

    class HowToUseUnits "如何使用单位"
      extends Modelica.Icons.Information;

      annotation(DocumentationClass = true, Documentation(info = "<html>
<p>
在实现Modelica模型时，每个变量都需要声明。物理变量应该使用单位进行声明。
在Modelica中的基本方法是，变量的单位属性是<strong>equations</strong>中<strong>已经写入</strong>的<strong>单位</strong>，例如：
</p>

<blockquote><pre>
<strong>model</strong> MassOnGround
<strong>parameter</strong> Real m(quantity=\"Mass\", unit=\"kg\") \"Mass\";
<strong>parameter</strong> Real f(quantity=\"Force\", unit=\"N\") \"Driving force\";
Real s(unit=\"m\") \"Position of mass\";
Real v(unit=\"m/s\") \"Velocity of mass\";
<strong>equation</strong>
<strong>der</strong>(s) = v;
m*<strong>der</strong>(v) = f;
<strong>end</strong> MassOnGround;
</pre></blockquote>

<p>
这意味着方程部分的方程只对指定的单位校正。
另一个问题是用户界面，即在图形界面中以哪种单位向用户展示变量，
无论是输入（例如参数菜单）还是输出（例如绘图窗口）。
最好的做法是，Modelica工具应该提供一个单位列表供用户选择，
例如对于\"Length\"量纲可以选择\"m\", \"cm\", \"km\", \"inch\"等。
将值存储为Modelica修饰符时，必须将其转换为声明中定义的单位。
此外，还需要存储在图形用户界面中使用的单位。
为了实现标准化处理，Modelica为Real类型的变量提供了以下三个属性：
</p>

<ul>
<li><strong>quantity</strong>来定义物理量(如\"长度\"或\"能量\")。
</li>
<li><strong>unit</strong>来定义必须使用的单位，以使方程正确(如\"N.m\")。
</li>
<li><strong>displayUnit</strong>用于定义图形用户界面中使用的单位，作为输入和/或输出的默认显示单位。
</li>
</ul>

<p>
请注意，单位(例如\"N.m\")不足以唯一定义物理量，因为\"N.m\"可能是\"torque\"或\"energy\"。
因此，\"quantity\"属性可用于工具选择相应的菜单，用户可从中选择相应变量的单位。
</p>

<p>
例如，在MassOnGround实例的参数菜单中提供\"m\"和\"f\"的值后，工具可能会生成以下代码：
</p>

<blockquote><pre>
MassOnGround myObject(m(displayUnit=\"g\")=2, f=3);
</pre></blockquote>

<p>
这段话的意思是，在方程中使用的值是\"2\"，而在图形用户界面中应该使用值\"2000\"，并且应该使用单位集合\"Mass\"中的单位\"g\"（即量纲名称）。
需要注意的是，根据Modelica规范，工具可能会忽略\"displayUnit\"属性。
</p>

<p>
为了帮助Modelica模型开发者，<code>Modelica.Units</code>库提供了大约450个预定义的类型名称，
包括属性<strong>quantity</strong>、<strong>unit</strong>和有时的<strong>displayUnit</strong>和<strong>min</strong>的值。
unit总是按照ISO标准选择的国际单位制单位。
类型和量名称是ISO标准中使用的量名称。
\"quantity\"和\"unit\"被定义为\"<strong>final</strong>\"，因此它们不能被修改。
然而，属性\"displayUnit\"和\"min\"可以通过修改在模型中进行更改。
因此，上述示例也可以被定义为：
</p>

<blockquote><pre>
<strong>model</strong> MassOnGround
<strong>parameter</strong> Modelica.Units.SI.Mass  m \"Mass\";
<strong>parameter</strong> Modelica.Units.SI.Force f \"Driving force\";
...
<strong>end</strong> MassOnGround;
</pre></blockquote>

<p>
或简记为
</p>

<blockquote><pre>
<strong>model</strong> MassOnGround
<strong>import</strong> Modelica.Units.SI;
<strong>parameter</strong> SI.Mass  m \"Mass\";
<strong>parameter</strong> SI.Force f \"Driving force\";
...
<strong>end</strong> MassOnGround;
</pre></blockquote>

<p>
对于一些经常使用的非SI单位(如小时)，<code>Modelica.Units.NonSI</code>提供了一些额外的类型定义。
如果这些定义是不足够的，用户可以自定义自己的类型，或者像在开始的示例中那样直接在声明中使用这些属性。
</p>

<p>
<strong>Complex units</strong>也包含在<code>Modelica.Units</code>中。复数单位声明为：
</p>
<blockquote><pre>
<strong>model</strong> QuasiStaticMachine
<strong>parameter</strong> Modelica.Units.SI.ComplexPower SNominal = Complex(10000,4400)
   \"Nominal complex power\";
...
<strong>end</strong> QuasiStaticMachine;
</pre></blockquote>
</html>"));

    end HowToUseUnits;

    class Conventions "约定"
      extends Modelica.Icons.Information;

      annotation(DocumentationClass = true, Documentation(info = "<html>
<p>在<code>Modelica.Units.SI</code>包中使用了以下约定：
</p>
<ul>
<li>Modelica物理量名称是根据ISO 31的建议定义的。
其中一些名称相当长，例如\"ThermodynamicTemperature\"。定义了一些更短的别名名称，
例如：\"type Temperature = ThermodynamicTemperature;\"。
</li>
<li>在Modelica中，单位是根据国际单位制(SI)基本单位定义的，不包括倍数(唯一的例外是 \"kg\")。
</li>
<li>对于某些量，工程师更方便使用的单位被定义为\"displayUnit\"，
即用于以显示为目的的默认单位(例如，quantity = \"Angle\"时，displayUnit = \"deg\")。
</li>
<li>按照类型名称的惯例，类型名称与数量名称相同。</li>
<li>所有数量和单位属性都被定义为最终属性，以便它们不能被重新定义为另一个值。</li>
<li>在Modelica中，类似的量，如\"Length, Breadth, Height, Thickness, Radius\"等，
会被定义为同一种量(例如，\"Length\")。
</li>
<li>这个包中类型声明的排序遵循ISO 31标准：</li>
<blockquote><pre>
Chapter  1: <strong>Space and Time</strong>
Chapter  2: <strong>Periodic and Related Phenomena</strong>
Chapter  3: <strong>Mechanics</strong>
Chapter  4: <strong>Heat</strong>
Chapter  5: <strong>Electricity and Magnetism</strong>
Chapter  6: <strong>Light and Related Electromagnetic Radiations</strong>
Chapter  7: <strong>Acoustics</strong>
Chapter  8: <strong>Physical Chemistry</strong>
Chapter  9: <strong>Atomic and Nuclear Physics</strong>
Chapter 10: <strong>Nuclear Reactions and Ionizing Radiations</strong>
Chapter 11: (not defined in ISO 31-1992)
Chapter 12: <strong>Characteristic Numbers</strong>
Chapter 13: <strong>Solid State Physics</strong>
</pre></blockquote>

<li>子包<code>Conversions</code>中提供了国际单位制与其他单位制之间的转换功能。
</li>
</ul>
</html>"));

    end Conventions;

    class Literature "文献"
      extends Modelica.Icons.References;

      annotation(Documentation(info = "<html>
<p>这个包基于以下参考资料
</p>

<dl>
<dt>ISO 31-1992:</dt>
<dd> <strong>General principles concerning
  quantities, units and symbols</strong>.<br>&nbsp;</dd>

<dt>ISO 1000-1992:</dt>
<dd> <strong>SI units and recommendations for the use
  of their multiples and of certain other units</strong>.<br>&nbsp;</dd>

<dt>Cardarelli F.:</dt>
<dd> <strong>Scientific Unit Conversion - A Practical
   Guide to Metrication</strong>. Springer 1997.</dd>
</dl>

</html>"));
    end Literature;

    class Contact "联系"
      extends Modelica.Icons.Contact;

      annotation(Documentation(info = "<html>
<h4>主要作者</h4>

<p>
<a href=\"http://www.robotic.dlr.de/Martin.Otter/\"><strong>Martin Otter</strong></a><br>
德国航空航天中心（DLR）<br>
系统动力学与控制研究所（DLR-SR）<br>
 奥伯法芬霍芬研究中心<br>
D-82234 Wessling<br>
Germany<br>
email: <a href=\"mailto:Martin.Otter@dlr.de\">Martin.Otter@dlr.de</a>
</p>

<h4>致谢</h4>

<p>
感谢Astrid Jaschinski、Hubertus Tummescheit和Christian Schweiger为这个包的实现做出了贡献。
</p>
</html>"));
    end Contact;
    annotation(DocumentationClass = true, Documentation(info = "<html>
<p>
<strong>Units</strong>库是一个<strong>免费</strong>的Modelica包，提供预定义的类型，如<em>Mass</em>、<em>Length</em>和<em>Time</em>。
</p>
</html>"));
  end UsersGuide;

  package SI "国际单位制(SI)单位定义库"
    extends Modelica.Icons.Package;

    // 空间与时间（ISO 31-1992 第 1 章）

    type Angle = Real(
      final quantity = "Angle", 
      final unit = "rad", 
      displayUnit = "deg") "角度" annotation();
    type SolidAngle = Real(final quantity = "SolidAngle", final unit = "sr") "立体角" annotation(Documentation(info="<html><p>
<br>
</p>
</html>"    )) ;
    type Length = Real(final quantity = "Length", final unit = "m") "长度" annotation();
    type PathLength = Length "路径长度" annotation();
    type Position = Length "位置" annotation();
    type Distance = Length(min = 0) "距离" annotation();
    type Breadth = Length(min = 0) "宽度" annotation();
    type Height = Length(min = 0) "高度" annotation();
    type Thickness = Length(min = 0) "厚度" annotation();
    type Radius = Length(min = 0) "半径" annotation();
    type Diameter = Length(min = 0) "直径" annotation();
    type Area = Real(final quantity = "Area", final unit = "m2") "面积" annotation();
    type Volume = Real(final quantity = "Volume", final unit = "m3") "体积" annotation();
    type Time = Real(final quantity = "Time", final unit = "s") "时间" annotation();
    type Duration = Time "持续时间" annotation();
    type AngularVelocity = Real(
      final quantity = "AngularVelocity", 
      final unit = "rad/s") "角速度" annotation();
    type AngularAcceleration = Real(final quantity = "AngularAcceleration", final unit = "rad/s2") "角加速度" annotation();
    type AngularJerk = Real(final quantity = "AngularJerk", final unit = "rad/s3") "角急动度" annotation();
    type Velocity = Real(final quantity = "Velocity", final unit = "m/s") "速度" annotation();
    type Acceleration = Real(final quantity = "Acceleration", final unit = "m/s2") "加速度" annotation();
    type Jerk = Real(final quantity = "Jerk", final unit = "m/s3") "急动度" annotation();
    // Periodic and related phenomens (chapter 2 of ISO 31-1992)
    type Period = Real(final quantity = "Time", final unit = "s") "周期" annotation();
    type Frequency = Real(final quantity = "Frequency", final unit = "Hz") "频率" annotation();
    type AngularFrequency = Real(final quantity = "AngularFrequency", final unit = 
      "rad/s") "角频率" annotation();
    type Wavelength = Real(final quantity = "Wavelength", final unit = "m") "波长" annotation();
    type WaveNumber = Real(final quantity = "WaveNumber", final unit = "m-1") "波数" annotation();
    type CircularWaveNumber = Real(final quantity = "CircularWaveNumber", final unit = 
      "rad/m") "圆波数" annotation();
    type AmplitudeLevelDifference = Real(final quantity = 
      "AmplitudeLevelDifference", final unit = "dB") "振幅级差" annotation();
    type PowerLevelDifference = Real(final quantity = "PowerLevelDifference", 
      final unit = "dB") "功率级差" annotation();
    type DampingCoefficient = Real(final quantity = "DampingCoefficient", final unit = 
      "s-1") "阻尼系数" annotation();
    type LogarithmicDecrement = Real(final quantity = "LogarithmicDecrement", 
      final unit = "1/S") "对数递减" annotation();
    type AttenuationCoefficient = Real(final quantity = "AttenuationCoefficient", 
      final unit = "m-1") "衰减系数" annotation();
    type PhaseCoefficient = Real(final quantity = "PhaseCoefficient", final unit = 
      "m-1") "相位系数" annotation();
    type PropagationCoefficient = Real(final quantity = "PropagationCoefficient", 
      final unit = "m-1") "传播系数" annotation();
    // added to ISO-chapter
    type Damping = DampingCoefficient "阻尼" annotation();
    // Mechanics (chapter 3 of ISO 31-1992)
    type Mass = Real(
      quantity = "Mass", 
      final unit = "kg", 
      min = 0) "质量" annotation();
    type Density = Real(
      final quantity = "Density", 
      final unit = "kg/m3", 
      displayUnit = "g/cm3", 
      min = 0.0) "密度" annotation();
    type RelativeDensity = Real(
      final quantity = "RelativeDensity", 
      final unit = "1", 
      min = 0.0) "相对密度" annotation();
    type SpecificVolume = Real(
      final quantity = "SpecificVolume", 
      final unit = "m3/kg", 
      min = 0.0) "比容" annotation();
    type LinearDensity = Real(
      final quantity = "LinearDensity", 
      final unit = "kg/m", 
      min = 0) "线密度" annotation();
    type SurfaceDensity = Real(
      final quantity = "SurfaceDensity", 
      final unit = "kg/m2", 
      min = 0) "表密度" annotation();
    type Momentum = Real(final quantity = "Momentum", final unit = "kg.m/s") "动量" annotation();
    type Impulse = Real(final quantity = "Impulse", final unit = "N.s") "冲量" annotation();
    type AngularMomentum = Real(final quantity = "AngularMomentum", final unit = 
      "kg.m2/s") "角动量" annotation();
    type AngularImpulse = Real(final quantity = "AngularImpulse", final unit = 
      "N.m.s") "角冲量" annotation();
    type MomentOfInertia = Real(final quantity = "MomentOfInertia", final unit = 
      "kg.m2") "转动惯量" annotation();
    type Inertia = MomentOfInertia "惯性" annotation();
    type Force = Real(final quantity = "Force", final unit = "N") "力" annotation();
    type TranslationalSpringConstant = Real(final quantity = "TranslationalSpringConstant", final unit = "N/m") "平移弹簧常数" annotation();
    type TranslationalDampingConstant = Real(final quantity = "TranslationalDampingConstant", final unit = "N.s/m") "平移阻尼常数" annotation();
    type Weight = Force "重量" annotation();
    type Torque = Real(final quantity = "Torque", final unit = "N.m") "力矩" annotation();
    type ElectricalTorqueConstant = Real(final quantity = "ElectricalTorqueConstant", final unit = "N.m/A") "电扭矩常数" annotation();
    type MomentOfForce = Torque "力矩" annotation();
    type ImpulseFlowRate = Real(final quantity = "ImpulseFlowRate", final unit = "N") "脉冲流量" annotation();
    type AngularImpulseFlowRate = Real(final quantity = "AngularImpulseFlowRate", final unit = "N.m") "角脉冲流量" annotation();
    type RotationalSpringConstant = Real(final quantity = "RotationalSpringConstant", final unit = "N.m/rad") "旋转弹簧常数" annotation();
    type RotationalDampingConstant = Real(final quantity = "RotationalDampingConstant", final unit = "N.m.s/rad") "旋转阻尼常数" annotation();
    type Pressure = Real(
      final quantity = "Pressure", 
      final unit = "Pa", 
      displayUnit = "bar") "压力" annotation();
    type AbsolutePressure = Pressure(min = 0.0, nominal = 1e5) "绝对压力" annotation();
    type PressureDifference = Pressure "压差" annotation();
    type BulkModulus = AbsolutePressure "体积模量" annotation();
    type Stress = Real(final unit = "Pa") "应力" annotation();
    type NormalStress = Stress "法向应力" annotation();
    type ShearStress = Stress "剪切应力" annotation();
    type Strain = Real(final quantity = "Strain", final unit = "1") "应变" annotation();
    type LinearStrain = Strain "线应变" annotation();
    type ShearStrain = Strain "剪切应变" annotation();
    type VolumeStrain = Real(final quantity = "VolumeStrain", final unit = "1") "体积应变" annotation();
    type PoissonNumber = Real(final quantity = "PoissonNumber", final unit = "1") "泊松数" annotation();
    type ModulusOfElasticity = Stress "弹性模量" annotation();
    type ShearModulus = Stress "剪切模量" annotation();
    type SecondMomentOfArea = Real(final quantity = "SecondMomentOfArea", final unit = 
      "m4") "截面惯性矩" annotation();
    type SecondPolarMomentOfArea = SecondMomentOfArea "截面极惯性矩" annotation();
    type SectionModulus = Real(final quantity = "SectionModulus", final unit = "m3") "截面模量" annotation();
    type CoefficientOfFriction = Real(final quantity = "CoefficientOfFriction", 
      final unit = "1") "摩擦系数" annotation();
    type DynamicViscosity = Real(
      final quantity = "DynamicViscosity", 
      final unit = "Pa.s", 
      min = 0) "动力粘度" annotation();
    type KinematicViscosity = Real(
      final quantity = "KinematicViscosity", 
      final unit = "m2/s", 
      min = 0) "运动粘度" annotation();
    type SurfaceTension = Real(final quantity = "SurfaceTension", final unit = "N/m") "表面张力" annotation();
    type Work = Real(final quantity = "Work", final unit = "J") "做功" annotation();
    type Energy = Real(final quantity = "Energy", final unit = "J") "能量" annotation();
    type EnergyDensity = Real(final quantity = "EnergyDensity", final unit = "J/m3") "能量密度" annotation();
    type PotentialEnergy = Energy "势能" annotation();
    type KineticEnergy = Energy "动能" annotation();
    type Power = Real(final quantity = "Power", final unit = "W") "功率" annotation();
    type EnergyFlowRate = Power "能量流率" annotation();
    type EnthalpyFlowRate = Real(final quantity = "EnthalpyFlowRate", final unit = 
      "W") "焓流率" annotation();
    type Efficiency = Real(
      final quantity = "Efficiency", 
      final unit = "1", 
      min = 0) "效率" annotation();
    type MassFlowRate = Real(quantity = "MassFlowRate", final unit = "kg/s") "质量流量" annotation();
    type VolumeFlowRate = Real(final quantity = "VolumeFlowRate", final unit = 
      "m3/s") "体积流量" annotation();
    // added to ISO-chapter 3
    type MomentumFlux = Real(final quantity = "MomentumFlux", final unit = "N") "动量通量" annotation();
    type AngularMomentumFlux = Real(final quantity = "AngularMomentumFlux", final unit = 
      "N.m") "角动量通量" annotation();
    // Heat (chapter 4 of ISO 31-1992)
    type ThermodynamicTemperature = Real(
      final quantity = "ThermodynamicTemperature", 
      final unit = "K", 
      min = 0.0, 
      start = 288.15, 
      nominal = 300, 
      displayUnit = "degC") 
      "热力学温度" annotation(absoluteValue = true);
    type Temperature = ThermodynamicTemperature "温度" annotation();
    type TemperatureDifference = Real(
      final quantity = "ThermodynamicTemperature", 
      final unit = "K") "温差" annotation(absoluteValue = false);
    type TemperatureSlope = Real(final quantity = "TemperatureSlope", 
      final unit = "K/s") "温度梯度" annotation();
    type LinearTemperatureCoefficient = Real(final quantity = "LinearTemperatureCoefficient", final unit = "1/K") "线性温度系数" annotation();
    type QuadraticTemperatureCoefficient = Real(final quantity = "QuadraticTemperatureCoefficient", final unit = "1/K2") "二次温度系数" annotation();
    type LinearExpansionCoefficient = Real(final quantity = 
      "LinearExpansionCoefficient", final unit = "1/K") "线性热膨胀系数" annotation();
    type CubicExpansionCoefficient = Real(final quantity = 
      "CubicExpansionCoefficient", final unit = "1/K") "立方热膨胀系数" annotation();
    type RelativePressureCoefficient = Real(final quantity = 
      "RelativePressureCoefficient", final unit = "1/K") "相对压力系数" annotation();
    type PressureCoefficient = Real(final quantity = "PressureCoefficient", final unit = 
      "Pa/K") "压力系数" annotation();
    type Compressibility = Real(final quantity = "Compressibility", final unit = 
      "1/Pa") "压缩率" annotation();
    type IsothermalCompressibility = Compressibility "等温压缩率" annotation();
    type IsentropicCompressibility = Compressibility "等熵压缩率" annotation();
    type Heat = Real(final quantity = "Energy", final unit = "J") "热量" annotation();
    type HeatFlowRate = Real(final quantity = "Power", final unit = "W") "热流率" annotation();
    type HeatFlux = Real(final quantity = "HeatFlux", final unit = "W/m2") "热流量" annotation();
    type DensityOfHeatFlowRate = Real(final quantity = "DensityOfHeatFlowRate", 
      final unit = "W/m2") "热流密度" annotation();
    type ThermalConductivity = Real(final quantity = "ThermalConductivity", final unit = 
      "W/(m.K)") "热导率" annotation();
    type CoefficientOfHeatTransfer = Real(final quantity = 
      "CoefficientOfHeatTransfer", final unit = "W/(m2.K)") "传热系数" annotation();
    type SurfaceCoefficientOfHeatTransfer = CoefficientOfHeatTransfer "表面传热系数" annotation();
    type ThermalInsulance = Real(final quantity = "ThermalInsulance", final unit = 
      "m2.K/W") "热绝缘系数" annotation();
    type ThermalResistance = Real(final quantity = "ThermalResistance", final unit = 
      "K/W") "热阻系数" annotation();
    type ThermalConductance = Real(final quantity = "ThermalConductance", final unit = 
      "W/K") "导热系数" annotation();
    type ThermalDiffusivity = Real(final quantity = "ThermalDiffusivity", final unit = 
      "m2/s") "热扩散系数" annotation();
    type HeatCapacity = Real(final quantity = "HeatCapacity", final unit = "J/K") "热容量" annotation();
    type SpecificHeatCapacity = Real(final quantity = "SpecificHeatCapacity", 
      final unit = "J/(kg.K)") "比热容" annotation();
    type SpecificHeatCapacityAtConstantPressure = SpecificHeatCapacity "定压比热容" annotation();
    type SpecificHeatCapacityAtConstantVolume = SpecificHeatCapacity "定容比热容" annotation();
    type SpecificHeatCapacityAtSaturation = SpecificHeatCapacity "饱和比热容" annotation();
    type RatioOfSpecificHeatCapacities = Real(final quantity = 
      "RatioOfSpecificHeatCapacities", final unit = "1") "比热容比" annotation();
    type IsentropicExponent = Real(final quantity = "IsentropicExponent", final unit = 
      "1") "等熵指数" annotation();
    type Entropy = Real(final quantity = "Entropy", final unit = "J/K") "熵" annotation();
    type EntropyFlowRate = Real(final quantity = "EntropyFlowRate", final unit = "J/(K.s)") "熵流率" annotation();
    type SpecificEntropy = Real(final quantity = "SpecificEntropy", 
      final unit = "J/(kg.K)") "比熵" annotation();
    type InternalEnergy = Heat "内能" annotation();
    type Enthalpy = Heat "焓" annotation();
    type HelmholtzFreeEnergy = Heat "赫姆霍兹自由能" annotation();
    type GibbsFreeEnergy = Heat "吉布斯自由能" annotation();
    type SpecificEnergy = Real(final quantity = "SpecificEnergy", 
      final unit = "J/kg") "比能" annotation();
    type SpecificInternalEnergy = SpecificEnergy "比内能" annotation();
    type SpecificEnthalpy = SpecificEnergy "比焓" annotation();
    type SpecificHelmholtzFreeEnergy = SpecificEnergy "比赫姆霍兹自由能" annotation();
    type SpecificGibbsFreeEnergy = SpecificEnergy "比吉布斯自由能" annotation();
    type MassieuFunction = Real(final quantity = "MassieuFunction", final unit = 
      "J/K") "马修函数" annotation();
    type PlanckFunction = Real(final quantity = "PlanckFunction", final unit = "J/K") "普朗克函数" annotation();
    // added to ISO-chapter 4
    type DerDensityByEnthalpy = Real(final unit = "kg.s2/m5") "焓对密度的导数" annotation();
    type DerDensityByPressure = Real(final unit = "s2/m2") "压力对密度的导数" annotation();
    type DerDensityByTemperature = Real(final unit = "kg/(m3.K)") "温度对密度的导数" annotation();
    type DerEnthalpyByPressure = Real(final unit = "J.m.s2/kg2") "压力对焓的导数" annotation();
    type DerEnergyByDensity = Real(final unit = "J.m3/kg") "密度对能量的导数" annotation();
    type DerEnergyByPressure = Real(final unit = "J.m.s2/kg") "压力对能量的导数" annotation();
    type DerPressureByDensity = Real(final unit = "Pa.m3/kg") "密度对压力的导数" annotation();
    type DerPressureByTemperature = Real(final unit = "Pa/K") "温度对压力的导数" annotation();
    // Electricity and Magnetism (chapter 5 of ISO 31-1992)
    type ElectricCurrent = Real(final quantity = "ElectricCurrent", final unit = "A") "电流" annotation();
    type Current = ElectricCurrent "电流" annotation();
    type CurrentSlope = Real(final quantity = "CurrentSlope", final unit = "A/s") "电流斜率" annotation();
    type ElectricCharge = Real(final quantity = "ElectricCharge", final unit = "C") "电荷" annotation();
    type Charge = ElectricCharge "电荷" annotation();
    type VolumeDensityOfCharge = Real(
      final quantity = "VolumeDensityOfCharge", 
      final unit = "C/m3", 
      min = 0) "电荷体密度" annotation();
    type SurfaceDensityOfCharge = Real(
      final quantity = "SurfaceDensityOfCharge", 
      final unit = "C/m2", 
      min = 0) "电荷表面密度" annotation();
    type ElectricFieldStrength = Real(final quantity = "ElectricFieldStrength", 
      final unit = "V/m") "电场强度" annotation();
    type ElectricPotential = Real(final quantity = "ElectricPotential", final unit = 
      "V") "电势" annotation();
    type Voltage = ElectricPotential "电压" annotation();
    type PotentialDifference = ElectricPotential "电势差" annotation();
    type ElectromotiveForce = ElectricPotential "电动势" annotation();
    type VoltageSecond = Real(final quantity = "VoltageSecond", final unit = "V.s") 
      "电压秒" annotation();
    type VoltageSlope = Real(final quantity = "VoltageSlope", final unit = "V/s") "电压斜率" annotation();
    type ElectricFluxDensity = Real(final quantity = "ElectricFluxDensity", final unit = 
      "C/m2") "电流量密度" annotation();
    type ElectricFlux = Real(final quantity = "ElectricFlux", final unit = "C") "电通量" annotation();
    type Capacitance = Real(
      final quantity = "Capacitance", 
      final unit = "F", 
      min = 0) "电容" annotation();
    type CapacitancePerArea = 
      Real(final quantity = "CapacitancePerArea", final unit = "F/m2") 
      "单位面积电容" annotation();
    type Permittivity = Real(
      final quantity = "Permittivity", 
      final unit = "F/m", 
      min = 0) "介电常数" annotation();
    type PermittivityOfVacuum = Permittivity "真空介电常数" annotation();
    type RelativePermittivity = Real(final quantity = "RelativePermittivity", 
      final unit = "1") "相对介电常数" annotation();
    type ElectricSusceptibility = Real(final quantity = "ElectricSusceptibility", 
      final unit = "1") "电感率" annotation();
    type ElectricPolarization = Real(final quantity = "ElectricPolarization", 
      final unit = "C/m2") "电极化" annotation();
    type Electrization = Real(final quantity = "Electrization", final unit = "V/m") "电气化" annotation();
    type ElectricDipoleMoment = Real(final quantity = "ElectricDipoleMoment", 
      final unit = "C.m") "电偶极矩" annotation();
    type CurrentDensity = Real(final quantity = "CurrentDensity", final unit = 
      "A/m2") "电流密度" annotation();
    type LinearCurrentDensity = Real(final quantity = "LinearCurrentDensity", 
      final unit = "A/m") "线性电流密度" annotation();
    type MagneticFieldStrength = Real(final quantity = "MagneticFieldStrength", 
      final unit = "A/m") "磁场强度" annotation();
    type MagneticPotential = Real(final quantity = "MagneticPotential", final unit = "A") "磁电势" annotation();
    type MagneticPotentialDifference = Real(final quantity = 
      "MagneticPotential", final unit = "A") "磁电势差" annotation();
    type MagnetomotiveForce = Real(final quantity = "MagnetomotiveForce", final unit = 
      "A") "磁动势" annotation();
    type CurrentLinkage = Real(final quantity = "CurrentLinkage", final unit = "A") "电流链" annotation();
    type MagneticFluxDensity = Real(final quantity = "MagneticFluxDensity", final unit = 
      "T") "磁通量密度" annotation();
    type MagneticFlux = Real(final quantity = "MagneticFlux", final unit = "Wb") "磁通量" annotation();
    type MagneticVectorPotential = Real(final quantity = "MagneticVectorPotential", 
      final unit = "Wb/m") "磁矢势" annotation();
    type Inductance = Real(
      final quantity = "Inductance", 
      final unit = "H") "电感" annotation();
    type SelfInductance = Inductance(min = 0) "自感" annotation();
    type MutualInductance = Inductance "互感" annotation();
    type CouplingCoefficient = Real(final quantity = "CouplingCoefficient", final unit = 
      "1") "耦合系数" annotation();
    type LeakageCoefficient = Real(final quantity = "LeakageCoefficient", final unit = 
      "1") "泄漏系数" annotation();
    type Permeability = Real(final quantity = "Permeability", final unit = "H/m") "磁导率" annotation();
    type PermeabilityOfVacuum = Permeability "真空磁导率" annotation();
    type RelativePermeability = Real(final quantity = "RelativePermeability", 
      final unit = "1") "相对磁导率" annotation();
    type MagneticSusceptibility = Real(final quantity = "MagneticSusceptibility", 
      final unit = "1") "磁感应强度" annotation();
    type ElectromagneticMoment = Real(final quantity = "ElectromagneticMoment", 
      final unit = "A.m2") "电磁矩" annotation();
    type MagneticDipoleMoment = Real(final quantity = "MagneticDipoleMoment", 
      final unit = "Wb.m") "磁偶极矩" annotation();
    type Magnetization = Real(final quantity = "Magnetization", final unit = "A/m") "磁化" annotation();
    type MagneticPolarization = Real(final quantity = "MagneticPolarization", 
      final unit = "T") "磁极化" annotation();
    type ElectromagneticEnergyDensity = Real(final quantity = "EnergyDensity", 
      final unit = "J/m3") "电磁能量密度" annotation();
    type PoyntingVector = Real(final quantity = "PoyntingVector", final unit = 
      "W/m2") "波因廷向量" annotation();
    type Resistance = Real(
      final quantity = "Resistance", 
      final unit = "Ohm") "电阻" annotation();
    type Resistivity = Real(final quantity = "Resistivity", final unit = "Ohm.m") "电阻率" annotation();
    type Conductivity = Real(final quantity = "Conductivity", final unit = "S/m") "电导率" annotation();
    type Reluctance = Real(final quantity = "Reluctance", final unit = "H-1") "磁阻" annotation();
    type Permeance = Real(final quantity = "Permeance", final unit = "H") "磁导率" annotation();
    type PhaseDifference = Real(
      final quantity = "Angle", 
      final unit = "rad", 
      displayUnit = "deg") "相位差" annotation();
    type Impedance = Resistance "阻抗" annotation();
    type ModulusOfImpedance = Resistance "阻抗模量" annotation();
    type Reactance = Resistance "电抗" annotation();
    type QualityFactor = Real(final quantity = "QualityFactor", final unit = "1") "品质因数" annotation();
    type LossAngle = Real(
      final quantity = "Angle", 
      final unit = "rad", 
      displayUnit = "deg") "损耗角" annotation();
    type Conductance = Real(
      final quantity = "Conductance", 
      final unit = "S") "电导率" annotation();
    type Admittance = Conductance "导纳" annotation();
    type ModulusOfAdmittance = Conductance "导纳模量" annotation();
    type Susceptance = Conductance "电感" annotation();
    type InstantaneousPower = Real(final quantity = "Power", final unit = "W") "瞬时功率" annotation();
    type ActivePower = Real(final quantity = "Power", final unit = "W") "有功功率" annotation();
    type ApparentPower = Real(final quantity = "Power", final unit = "V.A") "视在功率" annotation();
    type ReactivePower = Real(final quantity = "Power", final unit = "var") "无功功率" annotation();
    type PowerFactor = Real(final quantity = "PowerFactor", final unit = "1") "功率因数" annotation();
    type LinearTemperatureCoefficientResistance = Real(
      final quantity = "LinearTemperatureCoefficientResistance", 
      final unit = "Ohm/K") "线性温度系数电阻" annotation();
    type QuadraticTemperatureCoefficientResistance = Real(
      final quantity = "QuadraticTemperatureCoefficientResistance", 
      final unit = "Ohm/K2") "二次温度系数电阻" annotation();
    // added to ISO-chapter 5
    type Transconductance = Real(final quantity = "Transconductance", final unit = 
      "A/V2") "跨导" annotation();
    type InversePotential = Real(final quantity = "InversePotential", final unit = 
      "1/V") "逆电位" annotation();
    type ElectricalForceConstant = Real(
      final quantity = "ElectricalForceConstant", 
      final unit = "N/A") "电场力常数" annotation();
    // Light and Related Electromagnetic Radiations (chapter 6 of ISO 31-1992)
    type RadiantEnergy = Real(final quantity = "Energy", final unit = "J") "辐射能" annotation();
    type RadiantEnergyDensity = Real(final quantity = "EnergyDensity", final unit = 
      "J/m3") " 辐射能量密度" annotation();
    type SpectralRadiantEnergyDensity = Real(final quantity = 
      "SpectralRadiantEnergyDensity", final unit = "J/m4") "光谱辐射能量密度" annotation();
    type RadiantPower = Real(final quantity = "Power", final unit = "W") "辐射功率" annotation();
    type RadiantEnergyFluenceRate = Real(final quantity = 
      "RadiantEnergyFluenceRate", final unit = "W/m2") "辐射能流密度" annotation();
    type RadiantIntensity = Real(final quantity = "RadiantIntensity", final unit = 
      "W/sr") "辐射强度" annotation();
    type Radiance = Real(final quantity = "Radiance", final unit = "W/(sr.m2)") "辐射亮度" annotation();
    type RadiantExitance = Real(final quantity = "RadiantExitance", final unit = 
      "W/m2") "辐射出射率" annotation();
    type Irradiance = Real(final quantity = "Irradiance", final unit = "W/m2") "辐照度" annotation();
    type Emissivity = Real(final quantity = "Emissivity", final unit = "1") "发射率" annotation();
    type SpectralEmissivity = Real(final quantity = "SpectralEmissivity", final unit = 
      "1") "光谱发射率" annotation();
    type DirectionalSpectralEmissivity = Real(final quantity = 
      "DirectionalSpectralEmissivity", final unit = "1") "方向性光谱发射率" annotation();
    type LuminousIntensity = Real(final quantity = "LuminousIntensity", final unit = 
      "cd") "发光强度" annotation();
    type LuminousFlux = Real(final quantity = "LuminousFlux", final unit = "lm") "光通量" annotation();
    type QuantityOfLight = Real(final quantity = "QuantityOfLight", final unit = 
      "lm.s") "光量" annotation();
    type Luminance = Real(final quantity = "Luminance", final unit = "cd/m2") "亮度" annotation();
    type LuminousExitance = Real(final quantity = "LuminousExitance", final unit = 
      "lm/m2") "光出射度" annotation();
    type Illuminance = Real(final quantity = "Illuminance", final unit = "lx") "照度" annotation();
    type LightExposure = Real(final quantity = "LightExposure", final unit = "lx.s") "光照" annotation();
    type LuminousEfficacy = Real(final quantity = "LuminousEfficacy", final unit = 
      "lm/W") "光效" annotation();
    type SpectralLuminousEfficacy = Real(final quantity = 
      "SpectralLuminousEfficacy", final unit = "lm/W") "光谱光效" annotation();
    type LuminousEfficiency = Real(final quantity = "LuminousEfficiency", final unit = 
      "1") "光效率" annotation();
    type SpectralLuminousEfficiency = Real(final quantity = 
      "SpectralLuminousEfficiency", final unit = "1") "光谱光效率" annotation();
    type CIESpectralTristimulusValues = Real(final quantity = 
      "CIESpectralTristimulusValues", final unit = "1") "CIE光谱三刺激值" annotation();
    type ChromaticityCoordinates = Real(final quantity = "CromaticityCoordinates", 
      final unit = "1") "色度坐标" annotation();
    type SpectralAbsorptionFactor = Real(final quantity = 
      "SpectralAbsorptionFactor", final unit = "1") "光谱吸收因子" annotation();
    type SpectralReflectionFactor = Real(final quantity = 
      "SpectralReflectionFactor", final unit = "1") "光谱反射因子" annotation();
    type SpectralTransmissionFactor = Real(final quantity = 
      "SpectralTransmissionFactor", final unit = "1") "光谱透射因子" annotation();
    type SpectralRadianceFactor = Real(final quantity = "SpectralRadianceFactor", 
      final unit = "1") "光谱辐射因子" annotation();
    type LinearAttenuationCoefficient = Real(final quantity = 
      "AttenuationCoefficient", final unit = "m-1") "线性衰减系数" annotation();
    type LinearAbsorptionCoefficient = Real(final quantity = 
      "LinearAbsorptionCoefficient", final unit = "m-1") "线性吸收系数" annotation();
    type MolarAbsorptionCoefficient = Real(final quantity = 
      "MolarAbsorptionCoefficient", final unit = "m2/mol") "摩尔吸收系数" annotation();
    type RefractiveIndex = Real(final quantity = "RefractiveIndex", final unit = "1") "折射率" annotation();
    // Acoustics (chapter 7 of ISO 31-1992)
    type StaticPressure = AbsolutePressure "静压" annotation();
    type SoundPressure = StaticPressure "声压" annotation();
    type SoundParticleDisplacement = Real(final quantity = "Length", final unit = 
      "m") "声粒子位移" annotation();
    type SoundParticleVelocity = Real(final quantity = "Velocity", final unit = 
      "m/s") "声粒子速度" annotation();
    type SoundParticleAcceleration = Real(final quantity = "Acceleration", final unit = 
      "m/s2") "声粒子加速度" annotation();
    type VelocityOfSound = Real(final quantity = "Velocity", final unit = "m/s") "声速" annotation();
    type SoundEnergyDensity = Real(final quantity = "EnergyDensity", final unit = 
      "J/m3") "声能量密度" annotation();
    type SoundPower = Real(final quantity = "Power", final unit = "W") "声功率" annotation();
    type SoundIntensity = Real(final quantity = "SoundIntensity", final unit = 
      "W/m2") "声强" annotation();
    type AcousticImpedance = Real(final quantity = "AcousticImpedance", final unit = 
      "Pa.s/m3") "声阻抗" annotation();
    type SpecificAcousticImpedance = Real(final quantity = 
      "SpecificAcousticImpedance", final unit = "Pa.s/m") "特定声阻抗" annotation();
    type MechanicalImpedance = Real(final quantity = "MechanicalImpedance", final unit = 
      "N.s/m") "机械阻抗" annotation();
    type SoundPressureLevel = Real(final quantity = "SoundPressureLevel", final unit = 
      "dB") "声压级" annotation();
    type SoundPowerLevel = Real(final quantity = "SoundPowerLevel", final unit = 
      "dB") "声功率级别" annotation();
    type DissipationCoefficient = Real(final quantity = "DissipationCoefficient", 
      final unit = "1") "耗散系数" annotation();
    type ReflectionCoefficient = Real(final quantity = "ReflectionCoefficient", 
      final unit = "1") "反射系数" annotation();
    type TransmissionCoefficient = Real(final quantity = "TransmissionCoefficient", 
      final unit = "1") "透射系数" annotation();
    type AcousticAbsorptionCoefficient = Real(final quantity = 
      "AcousticAbsorptionCoefficient", final unit = "1") "吸声系数" annotation();
    type SoundReductionIndex = Real(final quantity = "SoundReductionIndex", final unit = "dB") "降噪指数" annotation();
    type EquivalentAbsorptionArea = Real(final quantity = "Area", final unit = "m2") "等效吸收面积" annotation();
    type ReverberationTime = Real(final quantity = "Time", final unit = "s") "混响时间" annotation();
    type LoudnessLevel = Real(final quantity = "LoudnessLevel", final unit = "phon") " 响度级别" annotation();
    type Loudness = Real(final quantity = "Loudness", final unit = "sone") "响度" annotation();
    // Physical chemistry and molecular physics (chapter 8 of ISO 31-1992)
    type RelativeAtomicMass = Real(final quantity = "RelativeAtomicMass", final unit = "1") "相对原子质量" annotation();
    type RelativeMolecularMass = Real(final quantity = "RelativeMolecularMass", 
      final unit = "1") "相对分子质量" annotation();
    type NumberOfMolecules = Real(final quantity = "NumberOfMolecules", final unit = "1") "分子数" annotation();
    type AmountOfSubstance = Real(
      final quantity = "AmountOfSubstance", 
      final unit = "mol", 
      min = 0) "物质的量" annotation();
    type Molality = Real(final quantity = "Molality", final unit = "mol/kg") "摩尔浓度(溶液中溶剂的摩尔数与溶剂的质量之比)" annotation();
    type MolalConcentration = Molality "摩尔浓度" annotation();
    type MolarMass = Real(final quantity = "MolarMass", final unit = "kg/mol", min = 0) "摩尔质量" annotation();
    type MolarVolume = Real(final quantity = "MolarVolume", final unit = "m3/mol", min = 0) "摩尔体积" annotation();
    type MolarDensity = Real(final quantity = "MolarDensity", unit = "mol/m3") "摩尔密度" annotation();
    type Molarity = MolarDensity "摩尔浓度(溶液中溶质的摩尔数与溶液的体积之比)" annotation();
    type MolarConcentration = MolarDensity "摩尔浓度" annotation();
    type MolarEnergy = Real(final quantity = "MolarEnergy", final unit = "J/mol", nominal = 2e4) "摩尔能量 " annotation();
    type MolarInternalEnergy = MolarEnergy "摩尔内能" annotation();
    type MolarHeatCapacity = Real(final quantity = "MolarHeatCapacity", final unit = "J/(mol.K)") "摩尔热容" annotation();
    type MolarEntropy = Real(final quantity = "MolarEntropy", final unit = "J/(mol.K)") "摩尔熵" annotation();
    type MolarEnthalpy = MolarEnergy "摩尔焓" annotation();
    type MolarFlowRate = Real(final quantity = "MolarFlowRate", final unit = "mol/s") "摩尔流量" annotation();
    type NumberDensityOfMolecules = Real(final quantity = 
      "NumberDensityOfMolecules", final unit = "m-3") "分子数密度" annotation();
    type MolecularConcentration = Real(final quantity = "MolecularConcentration", 
      final unit = "m-3") "分子浓度" annotation();
    type MassConcentration = Real(final quantity = "MassConcentration", final unit = 
      "kg/m3") "质量浓度" annotation();
    type MassFraction = Real(final quantity = "MassFraction", final unit = "1", 
      min = 0, max = 1) "质量分数" annotation();
    type Concentration = Real(final quantity = "Concentration", final unit = 
      "mol/m3") "浓度" annotation();
    type VolumeFraction = Real(final quantity = "VolumeFraction", final unit = "1") "体积分数" annotation();
    type MoleFraction = Real(final quantity = "MoleFraction", final unit = "1", 
      min = 0, max = 1) "摩尔分数" annotation();
    type ChemicalPotential = Real(final quantity = "ChemicalPotential", final unit = 
      "J/mol") "化学势" annotation();
    type AbsoluteActivity = Real(final quantity = "AbsoluteActivity", final unit = 
      "1") "绝对活度" annotation();
    type PartialPressure = AbsolutePressure "分压" annotation();
    type Fugacity = Real(final quantity = "Fugacity", final unit = "Pa") "逸度" annotation();
    type StandardAbsoluteActivity = Real(final quantity = 
      "StandardAbsoluteActivity", final unit = "1") "标准绝对活度" annotation();
    type ActivityCoefficient = Real(final quantity = "ActivityCoefficient", final unit = 
      "1") "活度系数" annotation();
    type ActivityOfSolute = Real(final quantity = "ActivityOfSolute", final unit = 
      "1") "溶质活度" annotation();
    type ActivityCoefficientOfSolute = Real(final quantity = 
      "ActivityCoefficientOfSolute", final unit = "1") "溶质活度系数" annotation();
    type StandardAbsoluteActivityOfSolute = Real(final quantity = 
      "StandardAbsoluteActivityOfSolute", final unit = "1") "溶质的标准绝对活度" annotation();
    type ActivityOfSolvent = Real(final quantity = "ActivityOfSolvent", final unit = 
      "1") "溶剂活度" annotation();
    type OsmoticCoefficientOfSolvent = Real(final quantity = 
      "OsmoticCoefficientOfSolvent", final unit = "1") "溶剂的渗透系数" annotation();
    type StandardAbsoluteActivityOfSolvent = Real(final quantity = 
      "StandardAbsoluteActivityOfSolvent", final unit = "1") "溶剂的标准绝对活度" annotation();
    type OsmoticPressure = Real(
      final quantity = "Pressure", 
      final unit = "Pa", 
      displayUnit = "bar", 
      min = 0) "渗透压" annotation();
    type StoichiometricNumber = Real(final quantity = "StoichiometricNumber", 
      final unit = "1") "化学计量数" annotation();
    type Affinity = Real(final quantity = "Affinity", final unit = "J/mol") "亲和性" annotation();
    type MassOfMolecule = Real(final quantity = "Mass", final unit = "kg") "分子质量" annotation();
    type ElectricDipoleMomentOfMolecule = Real(final quantity = 
      "ElectricDipoleMomentOfMolecule", final unit = "C.m") "分子的电偶极矩" annotation();
    type ElectricPolarizabilityOfAMolecule = Real(final quantity = 
      "ElectricPolarizabilityOfAMolecule", final unit = "C.m2/V") "分子的电极化率" annotation();
    type MicrocanonicalPartitionFunction = Real(final quantity = 
      "MicrocanonicalPartitionFunction", final unit = "1") "微正则配分函数" annotation();
    type CanonicalPartitionFunction = Real(final quantity = 
      "CanonicalPartitionFunction", final unit = "1") "正则配分函数" annotation();
    type GrandCanonicalPartitionFunction = Real(final quantity = 
      "GrandCanonicalPartitionFunction", final unit = "1") "巨正则配分函数" annotation();
    type MolecularPartitionFunction = Real(final quantity = 
      "MolecularPartitionFunction", final unit = "1") "分子配分函数" annotation();
    type StatisticalWeight = Real(final quantity = "StatisticalWeight", final unit = 
      "1") "统计权重" annotation();
    type MeanFreePath = Length "平均自由程" annotation();
    type DiffusionCoefficient = Real(final quantity = "DiffusionCoefficient", 
      final unit = "m2/s") "扩散系数" annotation();
    type ThermalDiffusionRatio = Real(final quantity = "ThermalDiffusionRatio", 
      final unit = "1") "热扩散率" annotation();
    type ThermalDiffusionFactor = Real(final quantity = "ThermalDiffusionFactor", 
      final unit = "1") "热扩散因子" annotation();
    type ThermalDiffusionCoefficient = Real(final quantity = 
      "ThermalDiffusionCoefficient", final unit = "m2/s") "热扩散系数" annotation();
    type ElementaryCharge = Real(final quantity = "ElementaryCharge", final unit = 
      "C") "元电荷" annotation();
    type ChargeNumberOfIon = Real(final quantity = "ChargeNumberOfIon", final unit = 
      "1") "离子的电荷数目" annotation();
    type FaradayConstant = Real(final quantity = "FaradayConstant", final unit = 
      "C/mol") "法拉第常数" annotation();
    type IonicStrength = Molality "离子强度" annotation();
    type DegreeOfDissociation = Real(final quantity = "DegreeOfDissociation", 
      final unit = "1") "解离度" annotation();
    type ElectrolyticConductivity = Real(final quantity = 
      "ElectrolyticConductivity", final unit = "S/m") "电解电导率" annotation();
    type MolarConductivity = Real(final quantity = "MolarConductivity", final unit = 
      "S.m2/mol") "摩尔导电率" annotation();
    type TransportNumberOfIonic = Real(final quantity = "TransportNumberOfIonic", 
      final unit = "1") "离子的迁移数" annotation();
    // Atomic and Nuclear Physics (chapter 9 of ISO 31-1992)
    type ProtonNumber = Real(final quantity = "ProtonNumber", final unit = "1") "质子数" annotation();
    type NeutronNumber = Real(final quantity = "NeutronNumber", final unit = "1") "中子数" annotation();
    type NucleonNumber = Real(final quantity = "NucleonNumber", final unit = "1") "核子数" annotation();
    type AtomicMassConstant = Real(final quantity = "Mass", final unit = "kg") "原子质量常数" annotation();
    type MassOfElectron = Real(final quantity = "Mass", final unit = "kg") "电子质量" annotation();
    type MassOfProton = Real(final quantity = "Mass", final unit = "kg") "质子质量" annotation();
    type MassOfNeutron = Real(final quantity = "Mass", final unit = "kg") "中子质量" annotation();
    type HartreeEnergy = Real(final quantity = "Energy", final unit = "J") "哈特里能量" annotation();
    type MagneticMomentOfParticle = Real(final quantity = 
      "MagneticMomentOfParticle", final unit = "A.m2") "粒子磁动势" annotation();
    type BohrMagneton = MagneticMomentOfParticle "玻尔磁子" annotation();
    type NuclearMagneton = MagneticMomentOfParticle "核磁子" annotation();
    type GyromagneticCoefficient = Real(final quantity = "GyromagneticCoefficient", 
      final unit = "A.m2/(J.s)") "回旋磁系数" annotation();
    type GFactorOfAtom = Real(final quantity = "GFactorOfAtom", final unit = "1") "原子的g因子" annotation();
    type GFactorOfNucleus = Real(final quantity = "GFactorOfNucleus", final unit = 
      "1") "核子的g因子" annotation();
    type LarmorAngularFrequency = Real(final quantity = "AngularFrequency", final unit = 
      "s-1") "拉莫尔角频率" annotation();
    type NuclearPrecessionAngularFrequency = Real(final quantity = 
      "AngularFrequency", final unit = "s-1") "核进动角频率" annotation();
    type CyclotronAngularFrequency = Real(final quantity = "AngularFrequency", 
      final unit = "s-1") "回旋加速器角频率" annotation();
    type NuclearQuadrupoleMoment = Real(final quantity = "NuclearQuadrupoleMoment", 
      final unit = "m2") "核四极矩" annotation();
    type NuclearRadius = Real(final quantity = "Length", final unit = "m") "核半径" annotation();
    type ElectronRadius = Real(final quantity = "Length", final unit = "m") "电子半径" annotation();
    type ComptonWavelength = Real(final quantity = "Length", final unit = "m") "康普顿波长" annotation();
    type MassExcess = Real(final quantity = "Mass", final unit = "kg") "质量过剩" annotation();
    type MassDefect = Real(final quantity = "Mass", final unit = "kg") "质量亏损" annotation();
    type RelativeMassExcess = Real(final quantity = "RelativeMassExcess", final unit = 
      "1") "相对质量过剩" annotation();
    type RelativeMassDefect = Real(final quantity = "RelativeMassDefect", final unit = 
      "1") "相对质量亏损" annotation();
    type PackingFraction = Real(final quantity = "PackingFraction", final unit = "1") "填充率" annotation();
    type BindingFraction = Real(final quantity = "BindingFraction", final unit = "1") "敛集率" annotation();
    type MeanLife = Real(final quantity = "Time", final unit = "s") "平均寿命" annotation();
    type LevelWidth = Real(final quantity = "LevelWidth", final unit = "J") "能级宽度" annotation();
    type Activity = Real(final quantity = "Activity", final unit = "Bq") "放射性" annotation();
    type SpecificActivity = Real(final quantity = "SpecificActivity", final unit = 
      "Bq/kg") "比放射性" annotation();
    type DecayConstant = Real(final quantity = "DecayConstant", final unit = "s-1") "衰变常数" annotation();
    type HalfLife = Real(final quantity = "Time", final unit = "s") "半衰期" annotation();
    type AlphaDisintegrationEnergy = Real(final quantity = "Energy", final unit = 
      "J") "α粒子解离能量" annotation();
    type MaximumBetaParticleEnergy = Real(final quantity = "Energy", final unit = 
      "J") "最大β粒子能量" annotation();
    type BetaDisintegrationEnergy = Real(final quantity = "Energy", final unit = "J") "β粒子解离能量" annotation();
    // Nuclear Reactions and Ionizing Radiations (chapter 10 of ISO 31-1992)
    type ReactionEnergy = Real(final quantity = "Energy", final unit = "J") "反应能量" annotation();
    type ResonanceEnergy = Real(final quantity = "Energy", final unit = "J") "共振能量" annotation();
    type CrossSection = Real(final quantity = "Area", final unit = "m2") "横截面" annotation();
    type TotalCrossSection = Real(final quantity = "Area", final unit = "m2") "总横截面" annotation();
    type AngularCrossSection = Real(final quantity = "AngularCrossSection", final unit = 
      "m2/sr") "角横截面" annotation();
    type SpectralCrossSection = Real(final quantity = "SpectralCrossSection", 
      final unit = "m2/J") "光谱截面" annotation();
    type SpectralAngularCrossSection = Real(final quantity = 
      "SpectralAngularCrossSection", final unit = "m2/(sr.J)") "光谱角横截面" annotation();
    type MacroscopicCrossSection = Real(final quantity = "MacroscopicCrossSection", 
      final unit = "m-1") "宏观横截面" annotation();
    type TotalMacroscopicCrossSection = Real(final quantity = 
      "TotalMacroscopicCrossSection", final unit = "m-1") "总宏观横截面" annotation();
    type ParticleFluence = Real(final quantity = "ParticleFluence", final unit = 
      "m-2") "粒子流量密度" annotation();
    type ParticleFluenceRate = Real(final quantity = "ParticleFluenceRate", final unit = 
      "s-1.m2") "粒子注量率" annotation();
    type EnergyFluence = Real(final quantity = "EnergyFluence", final unit = "J/m2") "能注量" annotation();
    type EnergyFluenceRate = Real(final quantity = "EnergyFluenceRate", final unit = 
      "W/m2") "能注量率" annotation();
    type CurrentDensityOfParticles = Real(final quantity = 
      "CurrentDensityOfParticles", final unit = "m-2.s-1")"粒子电流密度" annotation();
    type MassAttenuationCoefficient = Real(final quantity = 
      "MassAttenuationCoefficient", final unit = "m2/kg") "质量衰减系数" annotation();
    type MolarAttenuationCoefficient = Real(final quantity = 
      "MolarAttenuationCoefficient", final unit = "m2/mol") "摩尔衰减系数" annotation();
    type AtomicAttenuationCoefficient = Real(final quantity = 
      "AtomicAttenuationCoefficient", final unit = "m2") "原子衰减系数" annotation();
    type HalfThickness = Real(final quantity = "Length", final unit = "m") "半厚度" annotation();
    type TotalLinearStoppingPower = Real(final quantity = 
      "TotalLinearStoppingPower", final unit = "J/m") "总线性阻止本领" annotation();
    type TotalAtomicStoppingPower = Real(final quantity = 
      "TotalAtomicStoppingPower", final unit = "J.m2") "总原子阻止本领" annotation();
    type TotalMassStoppingPower = Real(final quantity = "TotalMassStoppingPower", 
      final unit = "J.m2/kg") "总质量阻止本领" annotation();
    type MeanLinearRange = Real(final quantity = "Length", final unit = "m") "平均线性范围" annotation();
    type MeanMassRange = Real(final quantity = "MeanMassRange", final unit = "kg/m2") "平均质量范围" annotation();
    type LinearIonization = Real(final quantity = "LinearIonization", final unit = 
      "m-1") "线性电离" annotation();
    type TotalIonization = Real(final quantity = "TotalIonization", final unit = "1") "总电离" annotation();
    type Mobility = Real(final quantity = "Mobility", final unit = "m2/(V.s)") "迁移率" annotation();
    type IonNumberDensity = Real(final quantity = "IonNumberDensity", final unit = 
      "m-3") "离子数密度" annotation();
    type RecombinationCoefficient = Real(final quantity = 
      "RecombinationCoefficient", final unit = "m3/s") "重组系数" annotation();
    type NeutronNumberDensity = Real(final quantity = "NeutronNumberDensity", 
      final unit = "m-3") "中子数密度" annotation();
    type NeutronSpeed = Real(final quantity = "Velocity", final unit = "m/s") "中子速度" annotation();
    type NeutronFluenceRate = Real(final quantity = "NeutronFluenceRate", final unit = 
      "s-1.m-2") "中子辐射率" annotation();
    type TotalNeutronSourceDensity = Real(final quantity = 
      "TotalNeutronSourceDensity", final unit = "s-1.m-3") "总中子源密度" annotation();
    type SlowingDownDensity = Real(final quantity = "SlowingDownDensity", final unit = 
      "s-1.m-3") "慢化密度" annotation();
    type ResonanceEscapeProbability = Real(final quantity = 
      "ResonanceEscapeProbability", final unit = "1") "共振逃逸概率" annotation();
    type Lethargy = Real(final quantity = "Lethargy", final unit = "1") "迟滞度" annotation();
    type SlowingDownArea = Real(final quantity = "Area", final unit = "m2") "慢化面积" annotation();
    type DiffusionArea = Real(final quantity = "Area", final unit = "m2") "扩散面积" annotation();
    type MigrationArea = Real(final quantity = "Area", final unit = "m2") "迁移面积" annotation();
    type SlowingDownLength = Real(final quantity = "SLength", final unit = "m") "慢化长度" annotation();
    type DiffusionLength = Length "扩散长度" annotation();
    type MigrationLength = Length "迁移长度" annotation();
    type NeutronYieldPerFission = Real(final quantity = "NeutronYieldPerFission", 
      final unit = "1") "每次裂变中的中子产额" annotation();
    type NeutronYieldPerAbsorption = Real(final quantity = 
      "NeutronYieldPerAbsorption", final unit = "1") "每次吸收后的中子产额" annotation();
    type FastFissionFactor = Real(final quantity = "FastFissionFactor", final unit = 
      "1") "快裂变因子" annotation();
    type ThermalUtilizationFactor = Real(final quantity = 
      "ThermalUtilizationFactor", final unit = "1") "热利用因子" annotation();
    type NonLeakageProbability = Real(final quantity = "NonLeakageProbability", 
      final unit = "1") "非泄漏概率" annotation();
    type Reactivity = Real(final quantity = "Reactivity", final unit = "1") "反应活性" annotation();
    type ReactorTimeConstant = Real(final quantity = "Time", final unit = "s") "反应堆时间常量" annotation();
    type EnergyImparted = Real(final quantity = "Energy", final unit = "J") "能量传递" annotation();
    type MeanEnergyImparted = Real(final quantity = "Energy", final unit = "J") "平均传递能量" annotation();
    type SpecificEnergyImparted = Real(final quantity = "SpecificEnergy", final unit = 
      "Gy") "单位能量传递" annotation();
    type AbsorbedDose = Real(final quantity = "AbsorbedDose", final unit = "Gy") "吸收量" annotation();
    type DoseEquivalent = Real(final quantity = "DoseEquivalent", final unit = "Sv") "剂量当量" annotation();
    type AbsorbedDoseRate = Real(final quantity = "AbsorbedDoseRate", final unit = 
      "Gy/s") "吸收剂量率" annotation();
    type LinearEnergyTransfer = Real(final quantity = "LinearEnergyTransfer", 
      final unit = "J/m") "线性能量传递" annotation();
    type Kerma = Real(final quantity = "Kerma", final unit = "Gy") "比释动能" annotation();
    type KermaRate = Real(final quantity = "KermaRate", final unit = "Gy/s") "比释动能率" annotation();
    type MassEnergyTransferCoefficient = Real(final quantity = 
      "MassEnergyTransferCoefficient", final unit = "m2/kg") "质能转移系数" annotation();
    type Exposure = Real(final quantity = "Exposure", final unit = "C/kg") "照射量" annotation();
    type ExposureRate = Real(final quantity = "ExposureRate", final unit = 
      "C/(kg.s)") "辐照剂量率" annotation();
    // chapter 11 is not defined in ISO 31-1992

    // Characteristic Numbers (chapter 12 of ISO 31-1992)
    type ReynoldsNumber = Real(final quantity = "ReynoldsNumber", final unit = "1") "雷诺数" annotation();
    type EulerNumber = Real(final quantity = "EulerNumber", final unit = "1") "欧拉数" annotation();
    type FroudeNumber = Real(final quantity = "FroudeNumber", final unit = "1") "弗劳德数" annotation();
    type GrashofNumber = Real(final quantity = "GrashofNumber", final unit = "1") "格拉斯霍夫数" annotation();
    type WeberNumber = Real(final quantity = "WeberNumber", final unit = "1") "韦伯数" annotation();
    type MachNumber = Real(final quantity = "MachNumber", final unit = "1") "马赫数" annotation();
    type KnudsenNumber = Real(final quantity = "KnudsenNumber", final unit = "1") "克努森数" annotation();
    type StrouhalNumber = Real(final quantity = "StrouhalNumber", final unit = "1") "斯特劳哈尔数" annotation();
    type FourierNumber = Real(final quantity = "FourierNumber", final unit = "1") "傅立叶数" annotation();
    type PecletNumber = Real(final quantity = "PecletNumber", final unit = "1") "佩克莱数" annotation();
    type RayleighNumber = Real(final quantity = "RayleighNumber", final unit = "1") "瑞利数" annotation();
    type NusseltNumber = Real(final quantity = "NusseltNumber", final unit = "1") "努塞尔数" annotation();
    type BiotNumber = NusseltNumber "毕奥数" annotation();
    // The Biot number (Bi) is used when
    // the Nusselt number is reserved
    // for convective transport of heat.
    type StantonNumber = Real(final quantity = "StantonNumber", final unit = "1") "斯坦顿数" annotation();
    type FourierNumberOfMassTransfer = Real(final quantity = 
      "FourierNumberOfMassTransfer", final unit = "1") "傅立叶质量传递数" annotation();
    type PecletNumberOfMassTransfer = Real(final quantity = 
      "PecletNumberOfMassTransfer", final unit = "1") "佩克莱质量传递数" annotation();
    type GrashofNumberOfMassTransfer = Real(final quantity = 
      "GrashofNumberOfMassTransfer", final unit = "1") "格拉斯霍夫质量传递数" annotation();
    type NusseltNumberOfMassTransfer = Real(final quantity = 
      "NusseltNumberOfMassTransfer", final unit = "1") "努塞尔质量传递数" annotation();
    type StantonNumberOfMassTransfer = Real(final quantity = 
      "StantonNumberOfMassTransfer", final unit = "1") "斯坦顿质量传递数" annotation();
    type PrandtlNumber = Real(final quantity = "PrandtlNumber", final unit = "1") "普朗特数" annotation();
    type SchmidtNumber = Real(final quantity = "SchmidtNumber", final unit = "1") "施密特数" annotation();
    type LewisNumber = Real(final quantity = "LewisNumber", final unit = "1") " 路易斯数" annotation();
    type MagneticReynoldsNumber = Real(final quantity = "MagneticReynoldsNumber", 
      final unit = "1") "磁雷诺数" annotation();
    type AlfvenNumber = Real(final quantity = "AlfvenNumber", final unit = "1") "阿尔文数" annotation();
    type HartmannNumber = Real(final quantity = "HartmannNumber", final unit = "1") "哈特曼数" annotation();
    type CowlingNumber = Real(final quantity = "CowlingNumber", final unit = "1") "柯林数" annotation();
    // Solid State Physics (chapter 13 of ISO 31-1992)
    type BraggAngle = Angle "布拉格角度" annotation();
    type OrderOfReflexion = Real(final quantity = "OrderOfReflexion", final unit = 
      "1") "反射顺序" annotation();
    type ShortRangeOrderParameter = Real(final quantity = "RangeOrderParameter", 
      final unit = "1") "短程有序参数" annotation();
    type LongRangeOrderParameter = Real(final quantity = "RangeOrderParameter", 
      final unit = "1") "长程有序参数" annotation();
    type DebyeWallerFactor = Real(final quantity = "DebyeWallerFactor", final unit = 
      "1") "德拜沃勒因子" annotation();
    type CircularWavenumber = Real(final quantity = "CircularWavenumber", final unit = 
      "m-1") "圆波数" annotation();
    type FermiCircularWavenumber = Real(final quantity = "FermiCircularWavenumber", 
      final unit = "m-1") "费米圆波数" annotation();
    type DebyeCircularWavenumber = Real(final quantity = "DebyeCircularWavenumber", 
      final unit = "m-1") "德拜圆波数" annotation();
    type DebyeCircularFrequency = Real(final quantity = "AngularFrequency", final unit = 
      "s-1") "德拜圆频率" annotation();
    type DebyeTemperature = ThermodynamicTemperature "德拜温度" annotation();
    type SpectralConcentration = Real(final quantity = "SpectralConcentration", 
      final unit = "s/m3") "频谱浓度" annotation();
    type GrueneisenParameter = Real(final quantity = "GrueneisenParameter", final unit = 
      "1") "格林乃森参量" annotation();
    type MadelungConstant = Real(final quantity = "MadelungConstant", final unit = 
      "1") "马德隆常数" annotation();
    type DensityOfStates = Real(final quantity = "DensityOfStates", final unit = 
      "J-1/m-3") "态密度" annotation();
    type ResidualResistivity = Real(final quantity = "ResidualResistivity", final unit = 
      "Ohm.m") "残余电阻率" annotation();
    type LorenzCoefficient = Real(final quantity = "LorenzCoefficient", final unit = 
      "V2/K2") "洛伦兹系数" annotation();
    type HallCoefficient = Real(final quantity = "HallCoefficient", final unit = 
      "m3/C") "霍尔系数" annotation();
    type ThermoelectromotiveForce = Real(final quantity = 
      "ThermoelectromotiveForce", final unit = "V") "热电动势" annotation();
    type SeebeckCoefficient = Real(final quantity = "SeebeckCoefficient", final unit = 
      "V/K") "塞贝克系数" annotation();
    type PeltierCoefficient = Real(final quantity = "PeltierCoefficient", final unit = 
      "V") "珀尔帖系数" annotation();
    type ThomsonCoefficient = Real(final quantity = "ThomsonCoefficient", final unit = 
      "V/K") "汤姆逊系数" annotation();
    type RichardsonConstant = Real(final quantity = "RichardsonConstant", final unit = 
      "A/(m2.K2)") "理查逊常数" annotation();
    type FermiEnergy = Real(final quantity = "Energy", final unit = "eV") "费米能量" annotation();
    type GapEnergy = Real(final quantity = "Energy", final unit = "eV") "能隙能量" annotation();
    type DonorIonizationEnergy = Real(final quantity = "Energy", final unit = "eV") "施主电离能" annotation();
    type AcceptorIonizationEnergy = Real(final quantity = "Energy", final unit = 
      "eV") "受主电离能" annotation();
    type ActivationEnergy = Real(final quantity = "Energy", final unit = "eV") "活化能" annotation();
    type FermiTemperature = ThermodynamicTemperature "费米温度" annotation();
    type ElectronNumberDensity = Real(final quantity = "ElectronNumberDensity", 
      final unit = "m-3") "电子数密度" annotation();
    type HoleNumberDensity = Real(final quantity = "HoleNumberDensity", final unit = 
      "m-3") "空穴数密度" annotation();
    type IntrinsicNumberDensity = Real(final quantity = "IntrinsicNumberDensity", 
      final unit = "m-3") "本征载流子密度" annotation();
    type DonorNumberDensity = Real(final quantity = "DonorNumberDensity", final unit = 
      "m-3")"施主浓度" annotation();
    type AcceptorNumberDensity = Real(final quantity = "AcceptorNumberDensity", 
      final unit = "m-3") "受主数密度" annotation();
    type EffectiveMass = Mass "有效质量" annotation();
    type MobilityRatio = Real(final quantity = "MobilityRatio", final unit = "1") "迁移率比" annotation();
    type RelaxationTime = Time "反应时间" annotation();
    type CarrierLifeTime = Time "载流子寿命" annotation();
    type ExchangeIntegral = Real(final quantity = "Energy", final unit = "eV") "交换积分" annotation();
    type CurieTemperature = ThermodynamicTemperature "居里温度" annotation();
    type NeelTemperature = ThermodynamicTemperature "尼尔温度" annotation();
    type LondonPenetrationDepth = Length "伦敦穿透深度" annotation();
    type CoherenceLength = Length "相干长度" annotation();
    type LandauGinzburgParameter = Real(final quantity = "LandauGinzburgParameter", 
      final unit = "1") "兰道金斯堡参数" annotation();
    type FluxoidQuantum = Real(final quantity = "FluxoidQuantum", final unit = "Wb") "磁通子量子" annotation();
    type TimeAging = Real(final quantity = "1/Modelica.Units.SI.Time", final unit = "1/s") "时间衰老" annotation();
    type ChargeAging = Real(final quantity = "1/Modelica.Units.SI.ElectricCharge", final unit = "1/(A.s)") "电荷衰老" annotation();
    // Other types not defined in ISO 31-1992
    type PerUnit = Real(unit = "1") "每单位" annotation();
    type DimensionlessRatio = Real(unit = "1") "无量纲比" annotation();
    // Complex types for electrical systems (not defined in ISO 31-1992)
    operator record ComplexCurrent = 
      Complex(redeclare Modelica.Units.SI.Current re "Real part of complex current", redeclare Modelica.Units.SI.Current im "Imaginary part of complex current") 
      "复电流" annotation();
    operator record ComplexCurrentSlope = 
      Complex(redeclare Modelica.Units.SI.CurrentSlope re "Real part of complex current slope", redeclare Modelica.Units.SI.CurrentSlope im "Imaginary part of complex current slope") 
      "复电流斜率" annotation();
    operator record ComplexCurrentDensity = 
      Complex(redeclare Modelica.Units.SI.CurrentDensity re "Real part of complex current density", redeclare Modelica.Units.SI.CurrentDensity im "Imaginary part of complex current density") 
      "复电流密度" annotation();
    operator record ComplexElectricPotential = 
      Complex(redeclare Modelica.Units.SI.ElectricPotential re "Imaginary part of complex electric potential", redeclare Modelica.Units.SI.ElectricPotential im "Real part of complex electric potential") 
      "复电势" annotation();
    operator record ComplexPotentialDifference = 
      Complex(redeclare Modelica.Units.SI.PotentialDifference re "Real part of complex potential difference", redeclare Modelica.Units.SI.PotentialDifference im "Imaginary part of complex potential difference") 
      "复电势差" annotation();
    operator record ComplexVoltage = 
      Complex(redeclare Modelica.Units.SI.Voltage re "Imaginary part of complex voltage", redeclare Modelica.Units.SI.Voltage im "Real part of complex voltage") 
      "复电压" annotation();
    operator record ComplexVoltageSlope = 
      Complex(redeclare Modelica.Units.SI.VoltageSlope re "Real part of complex voltage slope", redeclare Modelica.Units.SI.VoltageSlope im "Imaginary part of complex voltage slope") 
      "复电压斜率" annotation();
    operator record ComplexElectricFieldStrength = 
      Complex(redeclare Modelica.Units.SI.ElectricFieldStrength re "Real part of complex electric field strength", redeclare Modelica.Units.SI.ElectricFieldStrength im "Imaginary part of complex electric field strength") 
      "复电场强度" annotation();
    operator record ComplexElectricFluxDensity = 
      Complex(redeclare Modelica.Units.SI.ElectricFluxDensity re "Real part of complex electric flux density", redeclare Modelica.Units.SI.ElectricFluxDensity im "Imaginary part of complex electric flux density") 
      "复电通量密度" annotation();
    operator record ComplexElectricFlux = 
      Complex(redeclare Modelica.Units.SI.ElectricFlux re "Real part of complex electric flux", redeclare Modelica.Units.SI.ElectricFlux im "Imaginary part of complex electric flux") 
      "复电通量" annotation();
    operator record ComplexMagneticFieldStrength = 
      Complex(redeclare Modelica.Units.SI.MagneticFieldStrength re "Real part of complex magnetic field strength", redeclare Modelica.Units.SI.MagneticFieldStrength im "Imaginary part of complex magnetic field strength") 
      "复磁场强度" annotation();
    operator record ComplexMagneticPotential = 
      Complex(redeclare Modelica.Units.SI.MagneticPotential re "Real part of complex magnetic potential", redeclare Modelica.Units.SI.MagneticPotential im "Imaginary part of complex magnetic potential") 
      "复磁势" annotation();
    operator record ComplexMagneticPotentialDifference = 
      Complex(redeclare Modelica.Units.SI.MagneticPotentialDifference re "Real part of complex magnetic potential difference", redeclare Modelica.Units.SI.MagneticPotentialDifference im "Imaginary part of complex magnetic potential difference") 
      "复磁势差" annotation();
    operator record ComplexMagnetomotiveForce = 
      Complex(redeclare Modelica.Units.SI.MagnetomotiveForce re "Real part of complex magnetomotive force", redeclare Modelica.Units.SI.MagnetomotiveForce im "Imaginary part of complex magnetomotive force") 
      "复磁动势" annotation();
    operator record ComplexMagneticFluxDensity = 
      Complex(redeclare Modelica.Units.SI.MagneticFluxDensity re "Real part of complex magnetic flux density", redeclare Modelica.Units.SI.MagneticFluxDensity im "Imaginary part of complex magnetic flux density") 
      "复磁通密度" annotation();
    operator record ComplexMagneticFlux = 
      Complex(redeclare Modelica.Units.SI.MagneticFlux re "Real part of complex magnetic flux", redeclare Modelica.Units.SI.MagneticFlux im "Imaginary part of complex magnetic flux") 
      "复磁通量" annotation();
    operator record ComplexReluctance = 
      Complex(redeclare Modelica.Units.SI.Reluctance re "Real part of complex reluctance", redeclare Modelica.Units.SI.Reluctance im "Imaginary part of complex reluctance") 
      "复磁阻" 
      annotation(Documentation(info = "<html>
<p>
由于磁性材料的特性如磁阻和磁导率通常是各向异性的，或者具有显著特性，因此需要使用一种特殊的运算符，而不是简单的乘法（比如：张量与向量的比较）。
<a href=\"modelica://Modelica.Magnetic.FundamentalWave\">Modelica.Magnetic.FundamentalWave</a> 
使用一个特殊的记录类型 <a href=\"modelica://Modelica.Magnetic.FundamentalWave.Types.Salient\">Salient</a>，
该记录类型仅在转子固定坐标系中有效。
</p>
<p>
<strong>Note:</strong> 为了避免混淆，磁性材料的属性不应定义为复数单位。
</p>
</html>"));
    operator record ComplexImpedance = 
      Complex(redeclare Resistance re "Real part of complex impedance (resistance)", redeclare Reactance im "Imaginary part of complex impedance (reactance)") 
      "复阻抗" annotation();
    operator record ComplexAdmittance = 
      Complex(redeclare Conductance re "Real part of complex admittance (conductance)", redeclare Susceptance im "Imaginary part of complex admittance (susceptance)") 
      "复导纳" annotation();
    operator record ComplexPower = 
      Complex(redeclare ActivePower re "Real part of complex apparent power (active power)", redeclare ReactivePower im "Imaginary part of complex apparent power (reactive power)") 
      "复视在功率" annotation();
    operator record ComplexPerUnit = 
      Complex(redeclare PerUnit re "Real part of complex per unit quantity", redeclare PerUnit im "Imaginary part of complex per unit quantity") 
      "复每单位" annotation();
    annotation(Icon(graphics = {Text(
      extent = {{-80, 80}, {80, -78}}, 
      textColor = {128, 128, 128}, 
      fillColor = {128, 128, 128}, 
      fillPattern = FillPattern.None, 
      fontName = "serif", 
      textString = "SI", 
      textStyle = {TextStyle.Italic})}), 
      Documentation(info = "<html>
<p>该软件包提供了基于国际单位的预定义类型。
</p>
<p>
有关本软件包中使用的约定的介绍，请参阅：
<a href=\"modelica://Modelica.Units.UsersGuide.Conventions\">Conventions</a>.
</p>
</html>"));
  end SI;

  package NonSI "非SI单位和其他单位的类型定义"

    extends Modelica.Icons.Package;

    type Temperature_degC = Real(final quantity = "ThermodynamicTemperature", 
      final unit = "degC") 
      "绝对温度(摄氏度)(相对温度使用Modelica.Units.SI.TemperatureDifference)" annotation(absoluteValue = true);
    type Temperature_degF = Real(final quantity = "ThermodynamicTemperature", 
      final unit = "degF") 
      "绝对温度(华氏度)(相对温度使用Modelica.Units.SI.TemperatureDifference)" annotation(absoluteValue = true);
    type Temperature_degRk = Real(final quantity = "ThermodynamicTemperature", 
      final unit = "degRk") 
      "绝对温度(兰氏度)(相对温度使用Modelica.Units.SI.TemperatureDifference)" annotation(absoluteValue = true);
    type Angle_deg = Real(final quantity = "Angle", final unit = "deg") 
      "角度(度)" annotation();
    type AngularVelocity_rpm = Real(final quantity = "AngularVelocity", final unit = "rev/min") 
      "以转每分钟为单位的角速度。国际单位制以外的别名单位名称：rpm、r/min、rev/min" annotation();
    type Velocity_kmh = Real(final quantity = "Velocity", final unit = "km/h") 
      "速度(千米每小时)" annotation();
    type Time_day = Real(final quantity = "Time", final unit = "d") 
      "时间(天)" annotation();
    type Time_hour = Real(final quantity = "Time", final unit = "h") 
      "时间(小时)" annotation();
    type Time_minute = Real(final quantity = "Time", final unit = "min") 
      "时间(分钟)" annotation();
    type Volume_litre = Real(final quantity = "Volume", final unit = "l") 
      "体积(升)" annotation();
    type ElectricCharge_Ah = 
      Real(final quantity = "ElectricCharge", final unit = "A.h") 
      "电荷量(安培小时)" annotation();
    type Energy_Wh = 
      Real(final quantity = "Energy", final unit = "W.h") 
      "能量(瓦时)" annotation();
    type Energy_kWh = Real(final quantity = "Energy", final unit = "kW.h") 
      "能量(千瓦时)" annotation();
    type Pressure_bar = Real(final quantity = "Pressure", final unit = "bar") 
      "绝对压力(bar)" annotation();
    type MassFlowRate_gps = Real(final quantity = "MassFlowRate", final unit = "g/s") 
      "质量流量(克/秒)" annotation();

    type Area_cm = Real(final quantity = "Area", final unit = "cm2") 
      "面积(厘米)" annotation();
    type PerArea_cm = Real(final quantity = "PerArea", final unit = "1/cm2") 
      "每单位面积(厘米)" annotation();
    type Area_cmPerVoltageSecond = 
      Real(final quantity = "AreaPerVoltageSecond", final unit = "cm2/(V.s)") 
      "面积(厘米每电压秒)" annotation();

    annotation(Documentation(info = "<html>
<p>
这个软件包提供了预定义的类型，比如 <strong>Angle_deg</strong>（角度，单位为度）、
<strong>AngularVelocity_rpm</strong>（角速度，单位为每分钟转数）或 
<strong>Temperature_degF</strong>（温度，单位为华氏度），
这些类型在日常使用中很常见，但它们并不属于国际标准 ISO 31-1992\"有关数量、单位和符号的一般原则\"
和 \"ISO 1000-1992《国际单位制及其倍数使用的建议》中规定的单位\"。
</p>
<p>
如果可能的话，不应该使用这个软件包中的类型。
相反，应该使用 <code>Modelica.Units.SI</code> 软件包中的类型。
关于单位的更多信息，可以参考 Francois Cardarelli 的著作
<strong>Scientific Unit Conversion - A
Practical Guide to Metrication</strong>（Springer, 1997年版）。
</p>
</html>"), 
      Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}), graphics = {Ellipse(
      extent = {{-10, 10}, {10, -10}}, 
      lineColor = {128, 128, 128}, 
      fillColor = {128, 128, 128}, 
      fillPattern = FillPattern.Solid), Ellipse(
      extent = {{-60, 10}, {-40, -10}}, 
      lineColor = {128, 128, 128}, 
      fillColor = {128, 128, 128}, 
      fillPattern = FillPattern.Solid), Ellipse(
      extent = {{40, 10}, {60, -10}}, 
      lineColor = {128, 128, 128}, 
      fillColor = {128, 128, 128}, 
      fillPattern = FillPattern.Solid)}));
  end NonSI;

  package Conversions "非SI单位的转换函数及非SI单位的类型定义"

    extends Modelica.Icons.Package;

    function to_unit1 "将实数的单位改为unit = \"1\""
      extends Modelica.Units.Icons.Conversion;
      input Real r "实数";
      output Real result(unit = "1") "单位为\"1\"的实数r";
    algorithm
      result := r;
      annotation(Inline = true, Documentation(info = "<html>
<h4>语法</h4>
<blockquote><pre>
Modelica.Units.Conversions.<strong>to_unit1</strong>(r);
</pre></blockquote>
<h4>描述</h4>
<p>
调用函数\"<code>Conversions.<strong>to_unit1</strong>(r)</code>\"返回单位为\"1\"的r。
</p>
<h4>示例</h4>
<blockquote><pre>
Modelica.Units.SI.Velocity v = {3,2,1};
Real direction[3](unit=\"1\") = to_unit1(v);   // Automatically vectorized call of to_unit1
</pre></blockquote>
</html>"), 
        Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 
        100}}), graphics = {Text(
        extent = {{-90, 86}, {32, 50}}, 
        textString = "any", 
        horizontalAlignment = TextAlignment.Left), Text(
        extent = {{-36, -52}, {86, -88}}, 
        horizontalAlignment = TextAlignment.Right, 
        textString = "1")}));
    end to_unit1;

    function to_degC "从开尔文转换为摄氏度"
      extends Modelica.Units.Icons.Conversion;
      input SI.Temperature Kelvin "开尔文值";
      output Modelica.Units.NonSI.Temperature_degC Celsius "摄氏度值";
    algorithm
      Celsius := Kelvin + Modelica.Constants.T_zero;
      annotation(Inline = true, Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, 
        -100}, {100, 100}}), graphics = {Text(
        extent = {{-20, 100}, {-100, 20}}, 
        textString = "K"), Text(
        extent = {{100, -20}, {20, -100}}, 
        textString = "degC")}));
    end to_degC;

    function from_degC "从摄氏度转换为开尔文"
      extends Modelica.Units.Icons.Conversion;
      input Modelica.Units.NonSI.Temperature_degC Celsius "摄氏度值";
      output SI.Temperature Kelvin "开尔文值";
    algorithm
      Kelvin := Celsius - Modelica.Constants.T_zero;
      annotation(Inline = true, Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, 
        -100}, {100, 100}}), graphics = {Text(
        extent = {{-20, 100}, {-100, 20}}, 
        textString = "degC"), Text(
        extent = {{100, -20}, {20, -100}}, 
        textString = "K")}));
    end from_degC;

    function to_degF "从开尔文转换为华氏度"
      extends Modelica.Units.Icons.Conversion;
      input SI.Temperature Kelvin "开尔文值";
      output Modelica.Units.NonSI.Temperature_degF Fahrenheit "华氏度值";
    algorithm
      Fahrenheit := (Kelvin + Modelica.Constants.T_zero) * (9 / 5) + 32;
      annotation(Inline = true, Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, 
        -100}, {100, 100}}), graphics = {Text(
        extent = {{-20, 100}, {-100, 20}}, 
        textString = "K"), Text(
        extent = {{100, -20}, {20, -100}}, 
        textString = "degF")}));
    end to_degF;

    function from_degF "从华氏度转换为开尔文"
      extends Modelica.Units.Icons.Conversion;
      input Modelica.Units.NonSI.Temperature_degF Fahrenheit "华氏度值";
      output SI.Temperature Kelvin "开尔文值";
    algorithm
      Kelvin := (Fahrenheit - 32) * (5 / 9) - Modelica.Constants.T_zero;
      annotation(Inline = true, Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, 
        -100}, {100, 100}}), graphics = {Text(
        extent = {{-20, 100}, {-100, 20}}, 
        textString = "degF"), Text(
        extent = {{100, -20}, {20, -100}}, 
        textString = "K"), Text(
        extent = {{-20, 100}, {-100, 20}}, 
        textString = "degF")}));
    end from_degF;

    function to_degRk "从开尔文转换为兰氏度"
      extends Modelica.Units.Icons.Conversion;
      input SI.Temperature Kelvin "开尔文值";
      output Modelica.Units.NonSI.Temperature_degRk Rankine "兰氏度值";
    algorithm
      Rankine := (9 / 5) * Kelvin;
      annotation(Inline = true, Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, 
        -100}, {100, 100}}), graphics = {Text(
        extent = {{-20, 100}, {-100, 20}}, 
        textString = "K"), Text(
        extent = {{100, -32}, {-18, -100}}, 
        textString = "degRk")}));
    end to_degRk;

    function from_degRk "从兰氏度转换为开尔文"
      extends Modelica.Units.Icons.Conversion;
      input Modelica.Units.NonSI.Temperature_degRk Rankine "兰氏度值";
      output SI.Temperature Kelvin "开尔文值";
    algorithm
      Kelvin := (5 / 9) * Rankine;
      annotation(Inline = true, Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, 
        -100}, {100, 100}}), graphics = {Text(
        extent = {{-8, 100}, {-100, 42}}, 
        textString = "degRk"), Text(
        extent = {{100, -20}, {20, -100}}, 
        textString = "K")}));
    end from_degRk;

    function to_deg "从弧度转换为角度"
      extends Modelica.Units.Icons.Conversion;
      input SI.Angle radian "弧度值";
      output Modelica.Units.NonSI.Angle_deg degree "角度值";
    algorithm
      degree := (180.0 / Modelica.Constants.pi) * radian;
      annotation(Inline = true, Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, 
        -100}, {100, 100}}), graphics = {Text(
        extent = {{10, 100}, {-100, 46}}, 
        textString = "rad"), Text(
        extent = {{100, -44}, {-10, -100}}, 
        textString = "deg")}));
    end to_deg;

    function from_deg "从角度转换为弧度"
      extends Modelica.Units.Icons.Conversion;
      input Modelica.Units.NonSI.Angle_deg degree "角度值";
      output SI.Angle radian "弧度值";
    algorithm
      radian := (Modelica.Constants.pi / 180.0) * degree;
      annotation(Inline = true, Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, 
        -100}, {100, 100}}), graphics = {Text(
        extent = {{4, 100}, {-102, 46}}, 
        textString = "deg"), Text(
        extent = {{100, -32}, {-18, -100}}, 
        textString = "rad")}));
    end from_deg;

    function to_rpm "从弧度每秒转换为转每分钟"
      extends Modelica.Units.Icons.Conversion;
      input SI.AngularVelocity rs "弧度每秒值";
      output Modelica.Units.NonSI.AngularVelocity_rpm rpm "转每分钟值";
    algorithm
      rpm := (30 / Modelica.Constants.pi) * rs;
      annotation(Inline = true, Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, 
        -100}, {100, 100}}), graphics = {Text(
        extent = {{30, 100}, {-100, 50}}, 
        textString = "rad/s"), Text(
        extent = {{100, -52}, {-40, -98}}, 
        textString = "rev/min")}));
    end to_rpm;

    function from_rpm 
      "从转每分钟转换为弧度每秒"
      extends Modelica.Units.Icons.Conversion;
      input Modelica.Units.NonSI.AngularVelocity_rpm rpm "转每分钟值";
      output SI.AngularVelocity rs "弧度每秒值";
    algorithm
      rs := (Modelica.Constants.pi / 30) * rpm;
      annotation(Inline = true, Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, 
        -100}, {100, 100}}), graphics = {Text(
        extent = {{14, 100}, {-102, 56}}, 
        textString = "rev/min"), Text(
        extent = {{100, -56}, {-32, -102}}, 
        textString = "rad/s")}));
    end from_rpm;

    function to_kmh "从米每秒转换为公里每小时"
      extends Modelica.Units.Icons.Conversion;
      input SI.Velocity ms "米每秒值";
      output Modelica.Units.NonSI.Velocity_kmh kmh "公里每小时值";
    algorithm
      kmh := 3.6 * ms;
      annotation(Inline = true, Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, 
        -100}, {100, 100}}), graphics = {Text(
        extent = {{8, 100}, {-100, 58}}, 
        textString = "m/s"), Text(
        extent = {{100, -56}, {-16, -100}}, 
        textString = "km/h")}));
    end to_kmh;

    function from_kmh "从公里每小时转换为米每秒"
      extends Modelica.Units.Icons.Conversion;
      input Modelica.Units.NonSI.Velocity_kmh kmh "公里每小时值";
      output SI.Velocity ms "米每秒值";
    algorithm
      ms := kmh / 3.6;
      annotation(Inline = true, Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, 
        -100}, {100, 100}}), graphics = {Text(
        extent = {{10, 100}, {-100, 56}}, 
        textString = "km/h"), Text(
        extent = {{100, -50}, {-20, -100}}, 
        textString = "m/s")}));
    end from_kmh;

    function to_day "从秒转换为天"
      extends Modelica.Units.Icons.Conversion;
      input SI.Time s "秒值";
      output Modelica.Units.NonSI.Time_day day "天值";
    algorithm
      day := s / 86400;
      annotation(Inline = true, Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, 
        -100}, {100, 100}}), graphics = {Text(
        extent = {{-6, 100}, {-100, 48}}, 
        textString = "s"), Text(
        extent = {{100, -48}, {-10, -98}}, 
        textString = "day")}));
    end to_day;

    function from_day "从天转换为秒"
      extends Modelica.Units.Icons.Conversion;
      input Modelica.Units.NonSI.Time_day day "天值";
      output SI.Time s "秒值";
    algorithm
      s := 86400 * day;
      annotation(Inline = true, Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, 
        -100}, {100, 100}}), graphics = {Text(
        extent = {{10, 100}, {-100, 52}}, 
        textString = "day"), Text(
        extent = {{100, -54}, {20, -100}}, 
        textString = "s")}));
    end from_day;

    function to_hour "从秒转换为小时"
      extends Modelica.Units.Icons.Conversion;
      input SI.Time s "秒值";
      output Modelica.Units.NonSI.Time_hour hour "小时值";
    algorithm
      hour := s / 3600;
      annotation(Inline = true, Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, 
        -100}, {100, 100}}), graphics = {Text(
        extent = {{12, 100}, {-100, 50}}, 
        textString = "s"), Text(
        extent = {{100, -56}, {-20, -100}}, 
        textString = "hour")}));
    end to_hour;

    function from_hour "从小时转换为秒"
      extends Modelica.Units.Icons.Conversion;
      input Modelica.Units.NonSI.Time_hour hour "小时值";
      output SI.Time s "秒值";
    algorithm
      s := 3600 * hour;
      annotation(Inline = true, Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, 
        -100}, {100, 100}}), graphics = {Text(
        extent = {{12, 100}, {-100, 58}}, 
        textString = "hour"), Text(
        extent = {{100, -50}, {16, -100}}, 
        textString = "s")}));
    end from_hour;

    function to_minute "从秒转换为分钟"
      extends Modelica.Units.Icons.Conversion;
      input SI.Time s "秒值";
      output Modelica.Units.NonSI.Time_minute minute "分钟值";
    algorithm
      minute := s / 60;
      annotation(Inline = true, Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, 
        -100}, {100, 100}}), graphics = {Text(
        extent = {{-26, 100}, {-100, 52}}, 
        textString = "s"), Text(
        extent = {{100, -54}, {-20, -100}}, 
        textString = "min")}));
    end to_minute;

    function from_minute "从分钟转换为秒"
      extends Modelica.Units.Icons.Conversion;
      input Modelica.Units.NonSI.Time_minute minute "分钟值";
      output SI.Time s "秒值";
    algorithm
      s := 60 * minute;
      annotation(Inline = true, Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, 
        -100}, {100, 100}}), graphics = {Text(
        extent = {{26, 100}, {-100, 48}}, 
        textString = "min"), Text(
        extent = {{100, -46}, {0, -100}}, 
        textString = "s")}));
    end from_minute;

    function to_litre "从立方米转换为升"
      extends Modelica.Units.Icons.Conversion;
      input SI.Volume m3 "立方米值";
      output Modelica.Units.NonSI.Volume_litre litre "升值";
    algorithm
      litre := 1000 * m3;
      annotation(Inline = true, Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, 
        -100}, {100, 100}}), graphics = {Text(
        extent = {{100, -56}, {0, -100}}, 
        textString = "litre"), Text(
        extent = {{6, 100}, {-100, 56}}, 
        textString = "m3")}));
    end to_litre;

    function from_litre "从升转换为立方米"
      extends Modelica.Units.Icons.Conversion;
      input Modelica.Units.NonSI.Volume_litre litre "升值";
      output SI.Volume m3 "立方米值";
    algorithm
      m3 := litre / 1000;
      annotation(Inline = true, Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, 
        -100}, {100, 100}}), graphics = {Text(
        extent = {{-4, 100}, {-100, 62}}, 
        textString = "litre"), Text(
        extent = {{100, -56}, {-6, -100}}, 
        textString = "m3")}));
    end from_litre;

    function from_Ah "从安培小时转换为库仑"
      extends Modelica.Units.Icons.Conversion;
      input Modelica.Units.NonSI.ElectricCharge_Ah AmpereHour "安培小时值";
      output Modelica.Units.SI.ElectricCharge Coulomb "库仑值";
    algorithm
      Coulomb := AmpereHour * 3600;

      annotation(Icon(graphics = {Text(
        extent = {{-2, 100}, {-100, 48}}, 
        textString = "Ah"), Text(
        extent = {{100, -46}, {0, -100}}, 
        textString = "C")}));
    end from_Ah;

    function to_Ah "从库仑换算成安培小时"
      extends Modelica.Units.Icons.Conversion;
      input Modelica.Units.SI.ElectricCharge Coulomb "库仑值";
      output Modelica.Units.NonSI.ElectricCharge_Ah AmpereHour "安培小时值";
    algorithm
      AmpereHour := Coulomb / 3600;

      annotation(Icon(graphics = {Text(
        extent = {{-18, 100}, {-100, 48}}, 
        textString = "C"), Text(
        extent = {{100, -48}, {2, -100}}, 
        textString = "Ah")}));
    end to_Ah;

    function from_Wh "从瓦时转换为焦耳"
      extends Modelica.Units.Icons.Conversion;
      input Modelica.Units.NonSI.Energy_Wh WattHour "瓦时值";
      output Modelica.Units.SI.Energy Joule "焦耳值";
    algorithm
      Joule := WattHour * 3600;

      annotation(Icon(graphics = {Text(
        extent = {{-20, 100}, {-100, 54}}, 
        textString = "Wh"), Text(
        extent = {{100, -38}, {4, -100}}, 
        textString = "J")}));
    end from_Wh;

    function to_Wh "从焦耳转换为瓦时"
      extends Modelica.Units.Icons.Conversion;
      input Modelica.Units.SI.Energy Joule "焦耳值";
      output Modelica.Units.NonSI.Energy_Wh WattHour "瓦时值";
    algorithm
      WattHour := Joule / 3600;

      annotation(Icon(graphics = {Text(
        extent = {{-30, 100}, {-100, 48}}, 
        textString = "J"), Text(
        extent = {{100, -46}, {-14, -100}}, 
        textString = "Wh")}));
    end to_Wh;

    function to_kWh "从焦耳转换为千瓦时"
      extends Modelica.Units.Icons.Conversion;
      input SI.Energy J "焦耳值";
      output Modelica.Units.NonSI.Energy_kWh kWh "千瓦时值";
    algorithm
      kWh := J / 3.6e6;
      annotation(Inline = true, Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, 
        -100}, {100, 100}}), graphics = {Text(
        extent = {{-20, 100}, {-100, 54}}, 
        textString = "J"), Text(
        extent = {{100, -50}, {-10, -100}}, 
        textString = "kWh")}));
    end to_kWh;

    function from_kWh "从千瓦时转换为焦耳"
      extends Modelica.Units.Icons.Conversion;
      input Modelica.Units.NonSI.Energy_kWh kWh "千瓦时值";
      output SI.Energy J "焦耳值";
    algorithm
      J := 3.6e6 * kWh;
      annotation(Inline = true, Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, 
        -100}, {100, 100}}), graphics = {Text(
        extent = {{12, 100}, {-100, 52}}, 
        textString = "kWh"), Text(
        extent = {{100, -44}, {12, -100}}, 
        textString = "J")}));
    end from_kWh;

    function to_bar "从Pa转换为bar"
      extends Modelica.Units.Icons.Conversion;
      input SI.Pressure Pa "Pascal值";
      output Modelica.Units.NonSI.Pressure_bar bar "bar值";
    algorithm
      bar := Pa / 1e5;
      annotation(Inline = true, Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, 
        -100}, {100, 100}}), graphics = {Text(
        extent = {{-12, 100}, {-100, 56}}, 
        textString = "Pa"), Text(
        extent = {{98, -52}, {-4, -100}}, 
        textString = "bar")}));
    end to_bar;

    function from_bar "从bar转换为Pa"
      extends Modelica.Units.Icons.Conversion;
      input Modelica.Units.NonSI.Pressure_bar bar "bar值";
      output SI.Pressure Pa "Pascal值";
    algorithm
      Pa := 1e5 * bar;
      annotation(Inline = true, Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, 
        -100}, {100, 100}}), graphics = {Text(
        extent = {{100, -56}, {12, -100}}, 
        textString = "Pa"), Text(
        extent = {{2, 100}, {-100, 52}}, 
        textString = "bar")}));
    end from_bar;

    function to_gps "从千克每秒转换为克每秒"
      extends Modelica.Units.Icons.Conversion;
      input SI.MassFlowRate kgps "千克每秒值";
      output Modelica.Units.NonSI.MassFlowRate_gps gps "克每秒值";
    algorithm
      gps := 1000 * kgps;
      annotation(Inline = true, Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, 
        -100}, {100, 100}}), graphics = {Text(
        extent = {{-12, 100}, {-100, 60}}, 
        textString = "kg/s"), Text(
        extent = {{100, -46}, {-6, -100}}, 
        textString = "g/s")}));
    end to_gps;

    function from_gps "从克每秒转换为千克每秒"
      extends Modelica.Units.Icons.Conversion;
      input Modelica.Units.NonSI.MassFlowRate_gps gps "克每秒值";
      output SI.MassFlowRate kgps "千克每秒值";
    algorithm
      kgps := gps / 1000;
      annotation(Inline = true, Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, 
        -100}, {100, 100}}), graphics = {Text(
        extent = {{-8, 100}, {-100, 54}}, 
        textString = "g/s"), Text(
        extent = {{100, -44}, {-10, -100}}, 
        textString = "kg/s")}));
    end from_gps;

    function from_Hz "从Hz转换为rad/s"
      extends Modelica.Units.Icons.Conversion;
      input SI.Frequency f "赫兹值";
      output SI.AngularVelocity w "弧度每秒值";

    algorithm
      w := 2 * Modelica.Constants.pi * f;
      annotation(Inline = true, Icon(graphics = {
        Text(
        extent = {{2, 100}, {-100, 52}}, 
        textString = "Hz"), Text(
        extent = {{100, -56}, {12, -100}}, 
        textString = "1/s")}));
    end from_Hz;

    function to_Hz "从rad/s转换为Hz"
      extends Modelica.Units.Icons.Conversion;
      input SI.AngularVelocity w "弧度每秒值";
      output SI.Frequency f "赫兹值";
    algorithm
      f := w / (2 * Modelica.Constants.pi);
      annotation(Inline = true, Icon(graphics = {
        Text(
        extent = {{100, -52}, {-2, -100}}, 
        textString = "Hz"), Text(
        extent = {{-12, 100}, {-100, 56}}, 
        textString = "1/s")}));
    end to_Hz;

    function to_cm2 "从平方米转换为平方厘米"
      extends Modelica.Units.Icons.Conversion;
      input SI.Area m2 "平方米值";
      output Modelica.Units.NonSI.Area_cm cm2 "平方厘米值";
    algorithm
      cm2 := 10000 * m2;
      annotation(Inline = true, Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, 
        -100}, {100, 100}}), graphics = {Text(
        extent = {{-20, 100}, {-100, 58}}, 
        textString = "m/s"), Text(
        extent = {{100, -50}, {-18, -100}}, 
        textString = "cm2")}));
    end to_cm2;

    function from_cm2 "从平方厘米转换为平方米"
      extends Modelica.Units.Icons.Conversion;
      input Modelica.Units.NonSI.Area_cm cm2 "平方厘米值";
      output SI.Area m2 "平方米值";
    algorithm
      m2 := 0.0001 * cm2;
      annotation(Inline = true, Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, 
        -100}, {100, 100}}), graphics = {Text(
        extent = {{2, 100}, {-100, 58}}, 
        textString = "cm2"), Text(
        extent = {{100, -50}, {-16, -98}}, 
        textString = "m/s")}));
    end from_cm2;
    annotation(Documentation(info = "<html>
<p>
这个包提供了从定义在<code>Modelica.Units.NonSI</code>中的非SI单位转换到定义在<code>Modelica.Units.SI</code>中相应的SI单位，
以及反向转换的函数。建议以以下方式使用这些函数(注意，所有函数都有一个实数输入和一个实数输出参数)：
</p>
<blockquote><pre>
<strong>import</strong> Modelica.Units.SI;
<strong>import</strong> Modelica.Units.Conversions.{from_degC, from_deg, from_rpm};
 ...
<strong>parameter</strong> SI.Temperature     T   = from_degC(25);   // convert 25 degree Celsius to kelvin
<strong>parameter</strong> SI.Angle           phi = from_deg(180);   // convert 180 degree to radian
<strong>parameter</strong> SI.AngularVelocity w   = from_rpm(3600);  // convert 3600 revolutions per minutes
                                                    // to radian per seconds
</pre></blockquote>

</html>"), Icon(graphics = {
      Polygon(
      points = {{80, 0}, {20, 20}, {20, -20}, {80, 0}}, 
      lineColor = {191, 0, 0}, 
      fillColor = {191, 0, 0}, 
      fillPattern = FillPattern.Solid), 
      Line(points = {{-80, 0}, {20, 0}}, color = {191, 0, 0})}));
  end Conversions;

  package Icons "单位库图标"
    extends Modelica.Icons.IconsPackage;

    partial function Conversion "转换函数的基本图标"

      annotation(Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, 
        -100}, {100, 100}}), graphics = {
        Rectangle(
        extent = {{-100, 100}, {100, -100}}, 
        lineColor = {191, 0, 0}, 
        fillColor = {255, 255, 255}, 
        fillPattern = FillPattern.Solid), 
        Line(points = {{-90, 0}, {30, 0}}, color = {191, 0, 0}), 
        Polygon(
        points = {{90, 0}, {30, 20}, {30, -20}, {90, 0}}, 
        lineColor = {191, 0, 0}, 
        fillColor = {191, 0, 0}, 
        fillPattern = FillPattern.Solid), 
        Text(
        extent = {{-115, 155}, {115, 105}}, 
        textString = "%name", 
        textColor = {0, 0, 255})}));
    end Conversion;
    annotation();
  end Icons;

  annotation(Icon(graphics = {
    Polygon(
    fillColor = {128, 128, 128}, 
    pattern = LinePattern.None, 
    fillPattern = FillPattern.Solid, 
    points = {{-80, -40}, {-80, -40}, {-55, 50}, {-52.5, 62.5}, {-65, 60}, {-65, 65}, {-35, 77.5}, {-32.5, 60}, {-50, 0}, {-50, 0}, {-30, 15}, {-20, 27.5}, {-32.5, 27.5}, {-32.5, 27.5}, {-32.5, 32.5}, {-32.5, 32.5}, {2.5, 32.5}, {2.5, 32.5}, {2.5, 27.5}, {2.5, 27.5}, {-7.5, 27.5}, {-30, 7.5}, {-30, 7.5}, {-25, -25}, {-17.5, -28.75}, {-10, -25}, {-5, -26.25}, {-5, -32.5}, {-16.25, -41.25}, {-31.25, -43.75}, {-40, -33.75}, {-45, -5}, {-45, -5}, {-52.5, -10}, {-52.5, -10}, {-60, -40}, {-60, -40}}, 
    smooth = Smooth.Bezier), 
    Polygon(
    fillColor = {128, 128, 128}, 
    pattern = LinePattern.None, 
    fillPattern = FillPattern.Solid, 
    points = {{87.5, 30}, {62.5, 30}, {62.5, 30}, {55, 33.75}, {36.25, 35}, {16.25, 25}, {7.5, 6.25}, {11.25, -7.5}, {22.5, -12.5}, {22.5, -12.5}, {6.25, -22.5}, {6.25, -35}, {16.25, -38.75}, {16.25, -38.75}, {21.25, -41.25}, {21.25, -41.25}, {45, -48.75}, {47.5, -61.25}, {32.5, -70}, {12.5, -65}, {7.5, -51.25}, {21.25, -41.25}, {21.25, -41.25}, {16.25, -38.75}, {16.25, -38.75}, {6.25, -41.25}, {-6.25, -50}, {-3.75, -68.75}, {30, -76.25}, {65, -62.5}, {63.75, -35}, {27.5, -26.25}, {22.5, -20}, {27.5, -15}, {27.5, -15}, {30, -7.5}, {30, -7.5}, {27.5, -2.5}, {28.75, 11.25}, {36.25, 27.5}, {47.5, 30}, {53.75, 22.5}, {51.25, 8.75}, {45, -6.25}, {35, -11.25}, {30, -7.5}, {30, -7.5}, {27.5, -15}, {27.5, -15}, {43.75, -16.25}, {65, -6.25}, {72.5, 10}, {70, 20}, {70, 20}, {80, 20}}, 
    smooth = Smooth.Bezier)}), Documentation(info = "<html>
<p>这个包提供了基于国际标准单位的预定义类型，例如<em>Mass</em>、<em>Angle</em>、<em>Time</em>等。
</p>

<blockquote><pre>
<strong>type</strong> Angle = Real(<strong>final</strong> quantity = \"Angle\",
                  <strong>final</strong> unit     = \"rad\",
                  displayUnit   = \"deg\");
</pre></blockquote>

<p>
其中一些类型是派生的SI单位，Modelica包中使用了这些单位(例如ComplexCurrent，它是一个复数，实部和虚部都是SI单位Ampere(安培))。
</p>

<p>
此外，子包<a href=\"modelica://Modelica.Units.Conversions\">Conversions</a>中还提供从非SI单位到SI单位的转换功能。
</p>

<p>
有关如何在Modelica标准库中使用单位包Units的介绍，请参阅： 
<a href=\"modelica://Modelica.Units.UsersGuide.HowToUseUnits\">How to use Units</a>.
</p>

<p>
版权所有&copy; 1998-2020，Modelica协会和贡献者
</p>
</html>", revisions = "<html>
<ul>
<li><em>May 25, 2011</em> by Stefan Wischhusen:<br>增加了能量和焓的摩尔单位。</li>
<li><em>Jan. 27, 2010</em> by Christian Kral:<br>增加了复单元。</li>
<li><em>Dec. 14, 2005</em> by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>:<br>添加用户指南，删除电阻和电导的\"最小\"值。</li>
<li><em>October 21, 2002</em> by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a> and Christian Schweiger:<br>新增软件包<strong>Conversions</strong>。更正了错字<em>Wavelenght</em>。</li>
<li><em>June 6, 2000</em> by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>:<br>引入了以下新类型<br>
type Temperature = ThermodynamicTemperature;<br>types DerDensityByEnthalpy, DerDensityByPressure, DerDensityByTemperature, DerEnthalpyByPressure, DerEnergyByDensity, DerEnergyByPressure
<br>
从最小值和最大值中移除属性\"final\"，以便仍可更改这些值以缩小允许值范围。
从\"应力\"类型中移除 Quantity=\"应力\"，以便将\"应力\"类型与\"压力\"类型连接起来。</li>
<li><em>Oct. 27, 1999</em> by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>:<br>由电气库产生的新类型： 跨导、反电势、阻尼。</li>
<li><em>Sept. 18, 1999</em> by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>:<br>从 SIunit 更名为 SIunits。扩展了子软件包，即 SIunits 软件包不再包含子软件包。</li>
<li><em>Aug 12, 1999</em> by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>:<br>
将 &quot;Pressure&quot; 类型更名为 &quot;AbsolutePressure&quot;，
并引入了新的 &quot;Pressure&quot; 类型，该类型不包含最小值为 0 的值，
以便于处理相对压力。重新定义 BulkModulus 为 AbsolutePressure 的别名，
而不是 Stress，因为在水力学中需要。
</li>
<li><em>June 29, 1999</em> by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>:<br>
修正错误： 
删除 &quot;Compressibility&quot; 的双重定义，
并在软件包 SolidStatePhysics 中引入适当的 &quot;extends Heat&quot; 条款，
以纳入热力学温度。
</li>
<li><em>April 8, 1998</em> by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a> and Astrid Jaschinski:<br>完成 ISO 31 章。</li>
<li><em>Nov. 15, 1997</em> by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a> and Hubertus Tummescheit:<br>有些章节已经实现。
﻿</li>
</ul>
</html>"));
end Units;