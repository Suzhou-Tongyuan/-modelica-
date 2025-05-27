within Modelica.Electrical.PowerConverters.Types;
type SoftStarterModeOfOperation = enumeration(
    Off "v = 0", 
    Up "v = 0 -> 1", 
    On "v = 1", 
    Down "v = 1 -> 0") 
  "定义软启动控制器的内部操作模式" annotation();