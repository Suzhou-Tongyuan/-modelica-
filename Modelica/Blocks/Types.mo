within Modelica.Blocks;
package Types 
  "常数、外部对象和含选项的类型，特别用于构建菜单的库"
  extends Modelica.Icons.TypesPackage;

  type Smoothness = enumeration(
    LinearSegments "表格点的线性插值", 
    ContinuousDerivative 
    "表格数据点的Akima样条插值(确保一阶导数连续)", 
    ConstantSegments 
    "分段常数插值(返回上一个轴值点的值)", 
    MonotoneContinuousDerivative1 
    "Fritsch-Butland样条插值(确保单调性且一阶导数连续)", 
    MonotoneContinuousDerivative2 
    "Steffen样条插值表数据点(确保单调性且一阶导数连续)", 
    ModifiedContinuousDerivative 
    "改进的Akima样条插值表数据点(确保一阶导数连续并避开原始Akima方法的缺陷)") 
    "枚举定义表格插值的平滑度" annotation();

  type Extrapolation = enumeration(
    HoldLastPoint 
    "保持第一个/最后一个表数据点在表范围之外", 
    LastTwoPoints 
    "使用第一个/最后一个表数据点的导数进行外推", 
    Periodic "周期性地重复表格范围", 
    NoExtrapolation "外推触发错误") 
    "枚举定义表格内插外推法的种类" annotation();

  type TimeEvents = enumeration(
    Always "始终在间隔边界生成时间事件", 
    AtDiscontinuities "在不连续处(由重复采样点定义)生成时间事件", 
    NoTimeEvents "区间边界无时间事件") 
    "枚举定义时间事件处理的时间表插值" annotation();

  type Init = enumeration(
    NoInit 
    "无初始化(在固定值=false时，将起始值用作猜测值)", 
    SteadyState 
    "稳态初始化(状态导数为零)", 
    InitialState "初始状态初始化", 
    InitialOutput 
    "初始输出值初始化(以及可能的稳态初始化)") 
    "枚举定义区模块初始化的类型" annotation(Evaluate = true, 
    Documentation(info = "<html>
<p>初始化选项如下：</p>
<dl>
<dt><code><strong>无初始化</strong></code></dt>
  <dd>无初始化(在<code>固定值=false</code>时，将起始值用作猜测值)</dd>
<dt><code><strong>稳态初始化</strong></code></dt>
  <dd>稳态初始化(状态导数为零)</dd>
<dt><code><strong>初始状态初始化</strong></code></dt>
  <dd>初始状态初始化</dd>
<dt><code><strong>初始输出值初始化</strong></code></dt>
  <dd>初始输出值初始化(以及可能的稳态初始化)</dd>
</dl>
</html>"  ));
  type InitPID = enumeration(
    NoInit 
    "无初始化(在固定值=false时，将起始值用作猜测值)", 
    SteadyState 
    "稳态初始化(状态导数为零)", 
    InitialState "初始状态初始化", 
    InitialOutput 
    "初始输出值初始化(以及可能的稳态初始化)", 
    DoNotUse_InitialIntegratorState 
    "不使用，仅用于向后兼容(仅初始化积分模块状态)") 
    "枚举定义PID和LimPID模块初始化的种类" annotation(
    Evaluate = true, Documentation(info="<html><p>
该初始化类型与 <a href=\"modelica://Modelica.Blocks.Types.Init\" target=\"\">Types.Init</a> 相同，只是多了一个选项<code><strong>DoNotUse_InitialIntegratorState</strong></code>。 引入这个选项是为了使<code>Continuous.PID</code>和<code>Continuous.LimPID</code> 模块的默认初始化向后兼容。 在Modelica2.2中，积分模块已按给定状态初始化， 而D部分尚未初始化。选项<code><strong>DoNotUse_InitialIntegratorState</strong></code> 导致了这种初始化定义。
</p>
<p>
有以下几种初始化方案可供选择：
</p>
<p>
<strong>无初始化</strong>
</p>
<p>
无初始化(在固定值=false时，将起始值用作猜测值)
</p>
<p>
<strong>稳态初始化</strong>
</p>
<p>
稳态初始化(状态导数为零)
</p>
<p>
<strong>初始状态初始化</strong>
</p>
<p>
初始状态初始化
</p>
<p>
<strong>初始输出值初始化</strong>
</p>
<p>
初始输出值初始化(以及可能的稳态初始化)
</p>
<p>
<span style=\"color: rgb(85, 85, 85);\"><strong>不使用初始积分器状态</strong></span>
</p>
<p>
不使用，仅用于向后兼容(仅初始化积分模块状态)
</p>
</html>"));

  type SimpleController = enumeration(
    P "P控制模块", 
    PI "PI控制模块", 
    PD "PD控制模块", 
    PID "PID控制模块") 
    "枚举定义P、PI、PD或PID简单控制模块的类型" annotation(
    Evaluate = true);

  type AnalogFilter = enumeration(
    CriticalDamping "带临界阻尼的滤波器", 
    Bessel "贝塞尔滤波器", 
    Butterworth "巴特沃斯滤波器", 
    ChebyshevI "切比雪夫I型滤波器") 
    "枚举定义滤波方法的种类" annotation(Evaluate = true);

  type FilterType = enumeration(
    LowPass "低通滤波器", 
    HighPass "高通滤波器", 
    BandPass "带通滤波器", 
    BandStop "带阻/陷波滤波器") 
    "枚举模拟滤波器(低、高、带通或带阻滤波器)的种类" 
    annotation(Evaluate = true);

  type Regularization = enumeration(
    Exp "指数正则化(平滑)", 
    Sine "正弦正则化(平滑处理一阶导数)", 
    Linear "线性正则化", 
    Cosine "余弦正则化") 
    "枚举定义零点附近正则化的种类" annotation();

  type LimiterHomotopy = enumeration(
    NoHomotopy "不使用同构", 
    Linear "无限制简化模型", 
    UpperLimit "简化模型的上限固定不变", 
    LowerLimit "简化模型的下限固定不变") 
    "枚举定义限制模块组件中同调的使用方法" annotation(Evaluate = true);

  type VariableLimiterHomotopy = enumeration(
    NoHomotopy "简化模型=实际模型", 
    Linear "简化模型：y=u", 
    Fixed "简化模型：y=ySimplified") 
    "枚举定义可变限幅模块组件中同调的使用方法" annotation(Evaluate = true);

  class ExternalCombiTimeTable 
    "一维表格的外部对象，其中第一列为时间"
    extends ExternalObject;

    function constructor "初始化一维表格，其中第一列为时间"
      extends Modelica.Icons.Function;
      input String tableName "表格名称";
      input String fileName "文件名称";
      input Real table[:,:];
      input SI.Time startTime;
      input Integer columns[:];
      input Modelica.Blocks.Types.Smoothness smoothness;
      input Modelica.Blocks.Types.Extrapolation extrapolation;
      input SI.Time shiftTime = 0.0;
      input Modelica.Blocks.Types.TimeEvents timeEvents = Modelica.Blocks.Types.TimeEvents.Always;
      input Boolean verboseRead = true "=true：打印信息提示；=false：无信息提示";
      output ExternalCombiTimeTable externalCombiTimeTable;
      annotation();
    external "C" externalCombiTimeTable = ModelicaStandardTables_CombiTimeTable_init2(
      fileName, 
      tableName, 
      table, 
      size(table, 1), 
      size(table, 2), 
      startTime, 
      columns, 
      size(columns, 1), 
      smoothness, 
      extrapolation, 
      shiftTime, 
      timeEvents, 
      verboseRead) annotation(IncludeDirectory = "modelica://Modelica/Resources/C-Sources", Include = "#include \"ModelicaStandardTables.h\"", Library = {"ModelicaStandardTables", "ModelicaIO", "ModelicaMatIO", "zlib"});
    end constructor;

    function destructor "一维终止表格，其中第一列为时间"
      extends Modelica.Icons.Function;
      input ExternalCombiTimeTable externalCombiTimeTable;
      annotation();
    external "C" ModelicaStandardTables_CombiTimeTable_close(
      externalCombiTimeTable) annotation(IncludeDirectory = "modelica://Modelica/Resources/C-Sources", Include = "#include \"ModelicaStandardTables.h\"", Library = {"ModelicaStandardTables", "ModelicaIO", "ModelicaMatIO", "zlib"});
    end destructor;
    annotation();

  end ExternalCombiTimeTable;

  class ExternalCombiTable1D 
    "由矩阵定义的一维表格中的外部对象"
    extends ExternalObject;

    function constructor "初始化矩阵定义的一维表格"
      extends Modelica.Icons.Function;
      input String tableName "表格名称";
      input String fileName "文件名称";
      input Real table[:,:];
      input Integer columns[:];
      input Modelica.Blocks.Types.Smoothness smoothness;
      input Modelica.Blocks.Types.Extrapolation extrapolation = Modelica.Blocks.Types.Extrapolation.LastTwoPoints;
      input Boolean verboseRead = true "=true：打印信息提示；=false：无信息提示";
      output ExternalCombiTable1D externalCombiTable1D;
      annotation();
    external "C" externalCombiTable1D = ModelicaStandardTables_CombiTable1D_init2(
      fileName, 
      tableName, 
      table, 
      size(table, 1), 
      size(table, 2), 
      columns, 
      size(columns, 1), 
      smoothness, 
      extrapolation, 
      verboseRead) annotation(IncludeDirectory = "modelica://Modelica/Resources/C-Sources", Include = "#include \"ModelicaStandardTables.h\"", Library = {"ModelicaStandardTables", "ModelicaIO", "ModelicaMatIO", "zlib"});
    end constructor;

    function destructor "终止矩阵定义的一维表格"
      extends Modelica.Icons.Function;
      input ExternalCombiTable1D externalCombiTable1D;
      annotation();
    external "C" ModelicaStandardTables_CombiTable1D_close(externalCombiTable1D) 
      annotation(IncludeDirectory = "modelica://Modelica/Resources/C-Sources", Include = "#include \"ModelicaStandardTables.h\"", Library = {"ModelicaStandardTables", "ModelicaIO", "ModelicaMatIO", "zlib"});
    end destructor;
    annotation();

  end ExternalCombiTable1D;

  class ExternalCombiTable2D 
    "由矩阵定义的二维表格中的外部对象"
    extends ExternalObject;

    function constructor "初始化由矩阵定义的二维表格"
      extends Modelica.Icons.Function;
      input String tableName "表格名称";
      input String fileName "文件名称";
      input Real table[:,:];
      input Modelica.Blocks.Types.Smoothness smoothness;
      input Modelica.Blocks.Types.Extrapolation extrapolation = Modelica.Blocks.Types.Extrapolation.LastTwoPoints;
      input Boolean verboseRead = true "=true：打印信息提示；=false：无信息提示";
      output ExternalCombiTable2D externalCombiTable2D;
      annotation();
    external "C" externalCombiTable2D = ModelicaStandardTables_CombiTable2D_init2(
      fileName, 
      tableName, 
      table, 
      size(table, 1), 
      size(table, 2), 
      smoothness, 
      extrapolation, 
      verboseRead) annotation(IncludeDirectory = "modelica://Modelica/Resources/C-Sources", Include = "#include \"ModelicaStandardTables.h\"", Library = {"ModelicaStandardTables", "ModelicaIO", "ModelicaMatIO", "zlib"});
    end constructor;

    function destructor "终止由矩阵定义的二维表格"
      extends Modelica.Icons.Function;
      input ExternalCombiTable2D externalCombiTable2D;
      annotation();
    external "C" ModelicaStandardTables_CombiTable2D_close(externalCombiTable2D) 
      annotation(IncludeDirectory = "modelica://Modelica/Resources/C-Sources", Include = "#include \"ModelicaStandardTables.h\"", Library = {"ModelicaStandardTables", "ModelicaIO", "ModelicaMatIO", "zlib"});
    end destructor;
    annotation();

  end ExternalCombiTable2D;
  annotation(Documentation(info = "<html>
<p>
在该组件包中，定义了<strong>类型</strong>、<strong>常量</strong>和<strong>外部对象</strong>，
这些都用于Modelica.Blocks库中。
这些类型具有额外的注释选择定义，
当该类型被用作声明中的参数时，这些定义将在图形用户界面中构建菜单。
</p>
</html>"));
end Types;