within Modelica.Electrical.Machines.Thermal;
type LinearTemperatureCoefficient20 = 
    SI.LinearTemperatureCoefficient 
  "具有选择项的线性温度系数" annotation (choices(
    choice=Modelica.Electrical.Machines.Thermal.Constants.alpha20Zero 
      "不受温度影响", 
    choice=Modelica.Electrical.Machines.Thermal.Constants.alpha20Aluminium 
      "铝", 
    choice=Modelica.Electrical.Machines.Thermal.Constants.alpha20Brass "黄铜", 
    choice=Modelica.Electrical.Machines.Thermal.Constants.alpha20Bronze "青铜", 
    choice=Modelica.Electrical.Machines.Thermal.Constants.alpha20Copper "铜"));