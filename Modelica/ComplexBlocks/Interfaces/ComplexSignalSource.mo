within Modelica.ComplexBlocks.Interfaces;
partial block ComplexSignalSource "连续信号源基类"
  extends ComplexBlocks.Interfaces.ComplexSO;
  parameter Complex offset = Complex(0) "输出信号的偏移y";
  parameter Modelica.Units.SI.Time startTime = 0 
    "当time < startTime时，输出y = offset";
  annotation(Documentation(info = "<html>
<p>
复数类型信号源的基本模块。
该组件具有一个连续复数类型的输出信号y，
以及两个参数(偏移量offset和起始时间startTime)用于调整生成的信号。
</p>
</html>"));
end ComplexSignalSource;