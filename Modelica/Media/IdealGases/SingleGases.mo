within Modelica.Media.IdealGases;
package SingleGases "来自NASA的理想气体的介质模型"
  extends Modelica.Icons.VariantsPackage;

  package Ar "理想气体 \"Ar\" ，来自 NASA Glenn 系数"
    extends Common.SingleGasNasa(
      mediumName = "Argon", 
      data = Common.SingleGasesData.Ar, 
      fluidConstants = {Common.FluidData.Ar});
    annotation(Documentation(info = "<html><div>
      <img src=\"modelica://Modelica/Resources/Images/Media/IdealGases/SingleGases/Ar.png\"></div></html>"));
  end Ar;

  package CH4 "理想气体 \"CH4\" ，来自 NASA Glenn 系数"
    extends Common.SingleGasNasa(
      mediumName = "Methane", 
      data = Common.SingleGasesData.CH4, 
      fluidConstants = {Common.FluidData.CH4});
    annotation(Documentation(info = "<html><div>
      <img src=\"modelica://Modelica/Resources/Images/Media/IdealGases/SingleGases/CH4.png\"></div></html>"));
  end CH4;

  package CH3OH "理想气体 \"CH3OH\" ，来自 NASA Glenn 系数"
    extends Common.SingleGasNasa(
      mediumName = "Methanol", 
      data = Common.SingleGasesData.CH3OH, 
      fluidConstants = {Common.FluidData.CH3OH});
    annotation(Documentation(info = "<html><div>
      <img src=\"modelica://Modelica/Resources/Images/Media/IdealGases/SingleGases/CH3OH.png\"></div></html>"));
  end CH3OH;

  package CO "理想气体 \"CO\" ，来自 NASA Glenn 系数"
    extends Common.SingleGasNasa(
      mediumName = "Carbon Monoxide", 
      data = Common.SingleGasesData.CO, 
      fluidConstants = {Common.FluidData.CO});
    annotation(Documentation(info = "<html><div>
      <img src=\"modelica://Modelica/Resources/Images/Media/IdealGases/SingleGases/CO.png\"></div></html>"));
  end CO;

  package CO2 "理想气体 \"CO2\" ，来自 NASA Glenn 系数"
    extends Common.SingleGasNasa(
      mediumName = "Carbon Dioxide", 
      data = Common.SingleGasesData.CO2, 
      fluidConstants = {Common.FluidData.CO2});
    annotation(Documentation(info = "<html><div>
      <img src=\"modelica://Modelica/Resources/Images/Media/IdealGases/SingleGases/CO2.png\"></div></html>"));
  end CO2;

  package C2H2_vinylidene 
    "理想气体 \"C2H2_vinylidene\" ，来自 NASA Glenn 系数"
    extends Common.SingleGasNasa(
      mediumName = "Acetylene", 
      data = Common.SingleGasesData.C2H2_vinylidene, 
      fluidConstants = {Common.FluidData.C2H2_vinylidene});
    annotation(Documentation(info = "<html><div>
      <img src=\"modelica://Modelica/Resources/Images/Media/IdealGases/SingleGases/C2H2_vinylidene.png\"></div></html>"));
  end C2H2_vinylidene;

  package C2H4 "理想气体 \"C2H4\" ，来自 NASA Glenn 系数"
    extends Common.SingleGasNasa(
      mediumName = "Ethylene", 
      data = Common.SingleGasesData.C2H4, 
      fluidConstants = {Common.FluidData.C2H4});
    annotation(Documentation(info = "<html><div>
      <img src=\"modelica://Modelica/Resources/Images/Media/IdealGases/SingleGases/C2H4.png\"></div></html>"));
  end C2H4;

  package C2H5OH "理想气体 \"C2H5OH\" ，来自 NASA Glenn 系数"
    extends Common.SingleGasNasa(
      mediumName = "Ethanol", 
      data = Common.SingleGasesData.C2H5OH, 
      fluidConstants = {Common.FluidData.C2H5OH});
    annotation(Documentation(info = "<html><div>
      <img src=\"modelica://Modelica/Resources/Images/Media/IdealGases/SingleGases/C2H5OH.png\"></div></html>"));
  end C2H5OH;

  package C2H6 "理想气体 \"C2H6\" ，来自 NASA Glenn 系数"
    extends Common.SingleGasNasa(
      mediumName = "Ethane", 
      data = Common.SingleGasesData.C2H6, 
      fluidConstants = {Common.FluidData.C2H6});
    annotation(Documentation(info = "<html><div>
      <img src=\"modelica://Modelica/Resources/Images/Media/IdealGases/SingleGases/C2H6.png\"></div></html>"));
  end C2H6;

  package C3H6_propylene 
    "理想气体 \"C3H6_propylene\" ，来自 NASA Glenn 系数"
    extends Common.SingleGasNasa(
      mediumName = "Propylene", 
      data = Common.SingleGasesData.C3H6_propylene, 
      fluidConstants = {Common.FluidData.C3H6_propylene});
    annotation(Documentation(info = "<html><div>
      <img src=\"modelica://Modelica/Resources/Images/Media/IdealGases/SingleGases/C3H6_propylene.png\"></div></html>"));
  end C3H6_propylene;

  package C3H8 "理想气体 \"C3H8\" ，来自 NASA Glenn 系数"
    extends Common.SingleGasNasa(
      mediumName = "Propane", 
      data = Common.SingleGasesData.C3H8, 
      fluidConstants = {Common.FluidData.C3H8});
    annotation(Documentation(info = "<html><div>
      <img src=\"modelica://Modelica/Resources/Images/Media/IdealGases/SingleGases/C3H8.png\"></div></html>"));
  end C3H8;

  package C3H8O_1propanol 
    "理想气体 \"C3H8O_1propanol\" ，来自 NASA Glenn 系数"
    extends Common.SingleGasNasa(
      mediumName = "1-Propanol", 
      data = Common.SingleGasesData.C3H8O_1propanol, 
      fluidConstants = {Common.FluidData.C3H7OH});
    annotation(Documentation(info = "<html><div>
      <img src=\"modelica://Modelica/Resources/Images/Media/IdealGases/SingleGases/C3H8O_1propanol.png\"></div></html>"));
  end C3H8O_1propanol;

  package C4H8_1_butene 
    "理想气体 \"C4H8_1_butene\" ，来自 NASA Glenn 系数"
    extends Common.SingleGasNasa(
      mediumName = "1-Butene", 
      data = Common.SingleGasesData.C4H8_1_butene, 
      fluidConstants = {Common.FluidData.C4H8_1_butene});
    annotation(Documentation(info = "<html><div>
      <img src=\"modelica://Modelica/Resources/Images/Media/IdealGases/SingleGases/C4H8_1_butene.png\"></div></html>"));
  end C4H8_1_butene;

  package C4H10_n_butane 
    "理想气体 \"C4H10_n_butane\" ，来自 NASA Glenn 系数"
    extends Common.SingleGasNasa(
      mediumName = "N-Butane", 
      data = Common.SingleGasesData.C4H10_n_butane, 
      fluidConstants = {Common.FluidData.C4H10_n_butane});
    annotation(Documentation(info = "<html><div>
      <img src=\"modelica://Modelica/Resources/Images/Media/IdealGases/SingleGases/C4H10_n_butane.png\"></div></html>"));
  end C4H10_n_butane;

  package C5H10_1_pentene 
    "理想气体 \"C5H10_1_pentene\" ，来自 NASA Glenn 系数"
    extends Common.SingleGasNasa(
      mediumName = "1-Pentene", 
      data = Common.SingleGasesData.C5H10_1_pentene, 
      fluidConstants = {Common.FluidData.C5H10_1_pentene});
    annotation(Documentation(info = "<html><div>
      <img src=\"modelica://Modelica/Resources/Images/Media/IdealGases/SingleGases/C5H10_1_pentene.png\"></div></html>"));
  end C5H10_1_pentene;

  package C5H12_n_pentane 
    "理想气体 \"C5H12_n_pentane\" ，来自 NASA Glenn 系数"
    extends Common.SingleGasNasa(
      mediumName = "N-Pentane", 
      data = Common.SingleGasesData.C5H12_n_pentane, 
      fluidConstants = {Common.FluidData.C5H12_n_pentane});
    annotation(Documentation(info = "<html><div>
      <img src=\"modelica://Modelica/Resources/Images/Media/IdealGases/SingleGases/C5H12_n_pentane.png\"></div></html>"));
  end C5H12_n_pentane;

  package C6H6 "理想气体 \"C6H6\" ，来自 NASA Glenn 系数"
    extends Common.SingleGasNasa(
      mediumName = "Benzene", 
      data = Common.SingleGasesData.C6H6, 
      fluidConstants = {Common.FluidData.C6H6});
    annotation(Documentation(info = "<html><div>
      <img src=\"modelica://Modelica/Resources/Images/Media/IdealGases/SingleGases/C6H6.png\"></div></html>"));
  end C6H6;

  package C6H12_1_hexene 
    "理想气体 \"C6H12_1_hexene\" ，来自 NASA Glenn 系数"
    extends Common.SingleGasNasa(
      mediumName = "1-Hexene", 
      data = Common.SingleGasesData.C6H12_1_hexene, 
      fluidConstants = {Common.FluidData.C6H12_1_hexene});
    annotation(Documentation(info = "<html><div>
      <img src=\"modelica://Modelica/Resources/Images/Media/IdealGases/SingleGases/C6H12_1_hexene.png\"></div></html>"));
  end C6H12_1_hexene;

  package C6H14_n_hexane 
    "理想气体 \"C6H14_n_hexane\" ，来自 NASA Glenn 系数"
    extends Common.SingleGasNasa(
      mediumName = "N-Hexane", 
      data = Common.SingleGasesData.C6H14_n_hexane, 
      fluidConstants = {Common.FluidData.C6H14_n_hexane});
    annotation(Documentation(info = "<html><div>
      <img src=\"modelica://Modelica/Resources/Images/Media/IdealGases/SingleGases/C6H14_n_hexane.png\"></div></html>"));
  end C6H14_n_hexane;

  package C7H14_1_heptene 
    "理想气体 \"C7H14_1_heptene\" ，来自 NASA Glenn 系数"
    extends Common.SingleGasNasa(
      mediumName = "1-Heptene", 
      data = Common.SingleGasesData.C7H14_1_heptene, 
      fluidConstants = {Common.FluidData.C7H14_1_heptene});
    annotation(Documentation(info = "<html><div>
      <img src=\"modelica://Modelica/Resources/Images/Media/IdealGases/SingleGases/C7H14_1_heptene.png\"></div></html>"));
  end C7H14_1_heptene;

  package C7H16_n_heptane 
    "理想气体 \"C7H16_n_heptane\" ，来自 NASA Glenn 系数"
    extends Common.SingleGasNasa(
      mediumName = "N-Heptane", 
      data = Common.SingleGasesData.C7H16_n_heptane, 
      fluidConstants = {Common.FluidData.C7H16_n_heptane});
    annotation(Documentation(info = "<html><div>
      <img src=\"modelica://Modelica/Resources/Images/Media/IdealGases/SingleGases/C7H16_n_heptane.png\"></div></html>"));
  end C7H16_n_heptane;

  package C8H10_ethylbenz 
    "理想气体 \"C8H10_ethylbenz\" ，来自 NASA Glenn 系数"
    extends Common.SingleGasNasa(
      mediumName = "Ethylbenzene", 
      data = Common.SingleGasesData.C8H10_ethylbenz, 
      fluidConstants = {Common.FluidData.C8H10_ethylbenz});
    annotation(Documentation(info = "<html><div>
      <img src=\"modelica://Modelica/Resources/Images/Media/IdealGases/SingleGases/C8H10_ethylbenz.png\"></div></html>"));
  end C8H10_ethylbenz;

  package C8H18_n_octane 
    "理想气体 \"C8H18_n_octane\" ，来自 NASA Glenn 系数"
    extends Common.SingleGasNasa(
      mediumName = "N-Octane", 
      data = Common.SingleGasesData.C8H18_n_octane, 
      fluidConstants = {Common.FluidData.C8H18_n_octane});
    annotation(Documentation(info = "<html><div>
      <img src=\"modelica://Modelica/Resources/Images/Media/IdealGases/SingleGases/C8H18_n_octane.png\"></div></html>"));
  end C8H18_n_octane;

  package CL2 "理想气体 \"Cl2\" ，来自 NASA Glenn 系数"
    extends Common.SingleGasNasa(
      mediumName = "Chlorine", 
      data = Common.SingleGasesData.CL2, 
      fluidConstants = {Common.FluidData.CL2});
    annotation(Documentation(info = "<html><div>
      <img src=\"modelica://Modelica/Resources/Images/Media/IdealGases/SingleGases/CL2.png\"></div></html>"));
  end CL2;

  package F2 "理想气体 \"F2\" ，来自 NASA Glenn 系数"
    extends Common.SingleGasNasa(
      mediumName = "Fluorine", 
      data = Common.SingleGasesData.F2, 
      fluidConstants = {Common.FluidData.F2});
    annotation(Documentation(info = "<html><div>
      <img src=\"modelica://Modelica/Resources/Images/Media/IdealGases/SingleGases/F2.png\"></div></html>"));
  end F2;

  package H2 "理想气体 \"H2\" ，来自 NASA Glenn 系数"
    extends Common.SingleGasNasa(
      mediumName = "Hydrogen", 
      data = Common.SingleGasesData.H2, 
      fluidConstants = {Common.FluidData.H2});
    annotation(Documentation(info = "<html><div>
      <img src=\"modelica://Modelica/Resources/Images/Media/IdealGases/SingleGases/H2.png\"></div></html>"));
  end H2;

  package H2O "理想气体 \"H2O\" ，来自 NASA Glenn 系数"
    extends Common.SingleGasNasa(
      mediumName = "IdealGasSteam", 
      data = Common.SingleGasesData.H2O, 
      fluidConstants = {Common.FluidData.H2O});
    annotation(Documentation(info = "<html><div>
      <img src=\"modelica://Modelica/Resources/Images/Media/IdealGases/SingleGases/H2O.png\"></div></html>"));
  end H2O;

  package He "理想气体 \"He\" ，来自 NASA Glenn 系数"
    extends Common.SingleGasNasa(
      mediumName = "Helium", 
      data = Common.SingleGasesData.He, 
      fluidConstants = {Common.FluidData.He});
    annotation(Documentation(info = "<html><div>
      <img src=\"modelica://Modelica/Resources/Images/Media/IdealGases/SingleGases/He.png\"></div></html>"));
  end He;

  package NH3 "理想气体 \"NH3\" ，来自 NASA Glenn 系数"
    extends Common.SingleGasNasa(
      mediumName = "IdealGasAmmonia", 
      data = Common.SingleGasesData.NH3, 
      fluidConstants = {Common.FluidData.NH3});
    annotation(Documentation(info = "<html><div>
      <img src=\"modelica://Modelica/Resources/Images/Media/IdealGases/SingleGases/NH3.png\"></div></html>"));
  end NH3;

  package NO "理想气体 \"NO\" ，来自 NASA Glenn 系数"
    extends Common.SingleGasNasa(
      mediumName = "Nitric Oxide", 
      data = Common.SingleGasesData.NO, 
      fluidConstants = {Common.FluidData.NO});
    annotation(Documentation(info = "<html><div>
      <img src=\"modelica://Modelica/Resources/Images/Media/IdealGases/SingleGases/NO.png\"></div></html>"));
  end NO;

  package NO2 "理想气体 \"NO2\" ，来自 NASA Glenn 系数"
    extends Common.SingleGasNasa(
      mediumName = "Nitrogen Dioxide", 
      data = Common.SingleGasesData.NO2, 
      fluidConstants = {Common.FluidData.NO2});
    annotation(Documentation(info = "<html><div>
      <img src=\"modelica://Modelica/Resources/Images/Media/IdealGases/SingleGases/NO2.png\"></div></html>"));
  end NO2;

  package N2 "理想气体 \"N2\" ，来自 NASA Glenn 系数"
    extends Common.SingleGasNasa(
      mediumName = "Nitrogen", 
      data = Common.SingleGasesData.N2, 
      fluidConstants = {Common.FluidData.N2});
    annotation(Documentation(info = "<html><div>
      <img src=\"modelica://Modelica/Resources/Images/Media/IdealGases/SingleGases/N2.png\"></div></html>"));
  end N2;

  package N2O "理想气体 \"N2O\" ，来自 NASA Glenn 系数"
    extends Common.SingleGasNasa(
      mediumName = "Nitrous Oxide", 
      data = Common.SingleGasesData.N2O, 
      fluidConstants = {Common.FluidData.N2O});
    annotation(Documentation(info = "<html><div>
      <img src=\"modelica://Modelica/Resources/Images/Media/IdealGases/SingleGases/N2O.png\"></div></html>"));
  end N2O;

  package Ne "理想气体 \"Ne\" ，来自 NASA Glenn 系数"
    extends Common.SingleGasNasa(
      mediumName = "Neon", 
      data = Common.SingleGasesData.Ne, 
      fluidConstants = {Common.FluidData.Ne});
    annotation(Documentation(info = "<html><div>
      <img src=\"modelica://Modelica/Resources/Images/Media/IdealGases/SingleGases/Ne.png\"></div></html>"));
  end Ne;

  package O2 "理想气体 \"O2\" ，来自 NASA Glenn 系数"
    extends Common.SingleGasNasa(
      mediumName = "Oxygen", 
      data = Common.SingleGasesData.O2, 
      fluidConstants = {Common.FluidData.O2});
    annotation(Documentation(info = "<html><div>
      <img src=\"modelica://Modelica/Resources/Images/Media/IdealGases/SingleGases/O2.png\"></div></html>"));
  end O2;

  package SO2 "理想气体 \"SO2\" ，来自 NASA Glenn 系数"
    extends Common.SingleGasNasa(
      mediumName = "Sulfur Dioxide", 
      data = Common.SingleGasesData.SO2, 
      fluidConstants = {Common.FluidData.SO2});
    annotation(Documentation(info = "<html><div>
      <img src=\"modelica://Modelica/Resources/Images/Media/IdealGases/SingleGases/SO2.png\"></div></html>"));
  end SO2;

  package SO3 "理想气体 \"SO3\" ，来自 NASA Glenn 系数"
    extends Common.SingleGasNasa(
      mediumName = "Sulfur Trioxide", 
      data = Common.SingleGasesData.SO3, 
      fluidConstants = {Common.FluidData.SO3});
    annotation(Documentation(info = "<html><div>
      <img src=\"modelica://Modelica/Resources/Images/Media/IdealGases/SingleGases/SO3.png\"></div></html>"));
  end SO3;

  annotation(Documentation(info="<html><p>
此库包含以下 37 种气体的介质模型（另请参阅 <a href=\"modelica://Modelica.Media.IdealGases\" target=\"\">Modelica.Media.IdealGases</a> 中的描述）：
</p>
<pre><code >Argon             Methane          Methanol       Carbon Monoxide  Carbon Dioxide
Acetylene         Ethylene         Ethanol        Ethane           Propylene
Propane           1-Propanol       1-Butene       N-Butane         1-Pentene
N-Pentane         Benzene          1-Hexene       N-Hexane         1-Heptane
N-Heptane         Ethylbenzene     N-Octane       Chlorine         Fluorine
Hydrogen          Steam            Helium         Ammonia          Nitric Oxide
Nitrogen Dioxide  Nitrogen         Nitrous        Oxide            Neon Oxygen
Sulfur Dioxide    Sulfur Trioxide
</code></pre><p>
<br>
</p>
</html>"));
end SingleGases;