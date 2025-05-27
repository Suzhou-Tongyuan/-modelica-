within Modelica.Magnetic.FluxTubes.Shapes.HysteresisAndMagnets;
model GenericHystPreisachEverett 
  "基于Preisach模型和Everett函数的具有铁磁滞回的通用磁通管[Ya89]"
  import Modelica.Constants.pi;

  parameter FluxTubes.Material.HysteresisEverettParameter.BaseData mat= 
      FluxTubes.Material.HysteresisEverettParameter.BaseData() 
    "Preisach 参数" 
    annotation (Dialog(group="Material"), choicesAllMatching=true);

  parameter Integer Count=100 "历史数组的长度" annotation(Dialog(group="Advanced"));
  parameter SI.MagneticFieldStrength eps=1e-5 
    "Preisach 历史的宽容" annotation(Dialog(group="Advanced"));
  parameter SI.Time t1=1e-6 "初始化时间" annotation(Dialog(group="Advanced"));

  extends BaseClasses.GenericHysteresis(sigma=mat.sigma);

protected
  final parameter Real mu0=mat.K*Modelica.Constants.mu_0;

  SI.MagneticFluxDensity J "极化";
  SI.MagneticFieldStrength hmax(start=0, min=0) "h 的最大值";

  SI.MagneticFieldStrength alpha 
    "埃弗雷特函数 everett(alpha,beta) 的当前 alpha 坐标";
  SI.MagneticFieldStrength beta 
    "埃弗雷特函数的当前贝塔坐标 everett(alpha,beta)";

  Boolean asc(start=true, fixed=true) "=asc without chatter";
  Boolean asc2 "Hstat is ascending der(Hstat)>0";
  Boolean delAsc(start=false) 
    "在升高的 Hstat 上抹去历史顶点";
  Boolean delDesc(start=false) 
    "在 Hstat 下降时抹去历史顶点";
  Boolean del(start=false) "delAsc or delDesc";
  Boolean init(start=false, fixed=true) 
    "如果 init=1 则 J 在初始磁化曲线上运行";
  Boolean evInit(start=false) "Event init=0 -> init=1";
  Boolean evAsc(start=false) "Event asc=0 -> asc=1";
  Boolean evDesc(start=false) "Event asc=1 -> asc=0";

  SI.MagneticFieldStrength aSav[Count] 
    "1xCount 数组的 alpha 历史记录（Preisach 平面上的顶点）";
  SI.MagneticFieldStrength bSav[Count] 
    "1xCount β 历史数组（Preisach 平面上的顶点）";

  SI.MagneticFluxDensity E "Everett 函数";
  SI.MagneticFieldStrength H1 "计算Everett函数的项";
  SI.MagneticFieldStrength H2 "计算Everett函数的项";
  SI.MagneticFieldStrength H3 "计算Everett函数的项";
  SI.MagneticFieldStrength H4 "计算Everett函数的项";
  constant SI.MagneticFluxDensity unitT=1;

  Real v(start=0,  fixed=true, final unit="1");

  Boolean init2(start=false, fixed=true);
  Boolean init3;
  SI.MagneticFieldStrength x(start=0) 
    "Preisach模型的变量初始化";
  discrete Real aSavI(start=0, fixed=true);
  discrete Real bSavI(start=0, fixed=true);
  discrete Real bI(start=0, fixed=true);
  discrete Real hmaxI(start=0, fixed=true);

initial equation
  J = 0.5*(FluxTubes.Utilities.everett(
          H, 
          -mat.Hsat, 
          mat, 
          false)*(1 - MagRel) - FluxTubes.Utilities.everett(
          mat.Hsat, 
          H, 
          mat, 
          false)*(1 + MagRel) + FluxTubes.Utilities.everett(
          mat.Hsat, 
          -mat.Hsat, 
          mat, 
          false)*MagRel);
  J = FluxTubes.Utilities.initPreisach(
          x, 
          H, 
          mat);
  aSav=fill( mat.Hsat,Count);
  bSav=fill(-mat.Hsat,Count);
  beta=alpha;
  hmax=mat.Hsat;

equation
  init2 = time >= 1.5*t1;
  init3 = edge(init2);

  der(x) = 0;
  when init2 then
    hmaxI = abs(Hstat)+abs(x);
    if hmax<eps then
      aSavI = mat.Hsat;
      bSavI = -mat.Hsat;
    elseif asc and x<0 then
      aSavI = mat.Hsat;
      bSavI = -hmax;
    elseif asc and x>0 then
      aSavI = hmax;
      bSavI = alpha;
    elseif not asc and x<0 then
      aSavI = alpha;
      bSavI = -hmax;
    else
      aSavI = hmax;
      bSavI = -mat.Hsat;
    end if;
    bI = if asc then bSav[1] else aSav[1];
  end when;

  alpha = if Hstat<=-mat.Hsat then -mat.Hsat elseif Hstat>=mat.Hsat then mat.Hsat else Hstat;

  asc2 = der(Hstat)>0;
  der(v)= if (asc2 and v<1) then 0.5/t1 elseif (not asc2 and v>0) then -0.5/t1 else 0;
  asc = v>0.5;

  evAsc = (not pre(asc)) and asc;
  evDesc = pre(asc) and (not asc);

  der(beta) = if init then -der(alpha) else 0;

  delAsc = (alpha > pre(aSav[1]));
  delDesc = (alpha < pre(bSav[1]));
  del = delAsc or delDesc or evInit;

  init = (abs(alpha) >= pre(hmax)) and time>=2*t1;

  evInit = init and not pre(init);

  when init3 or (change(asc) and pre(init)) then
    hmax = if init3 then hmaxI else abs(Hstat);
  end when;

  //##### bSav #####
  when {init3, evAsc, del} then
    if init3 then
      bSav=cat(1,{bSavI},fill(-mat.Hsat,Count-1));
    elseif evAsc then
      bSav = if (alpha-eps)>pre(bSav[1]) then cat(1,{alpha},pre(bSav[1:end-1])) else pre(bSav);
    elseif del then
      bSav = cat(1,pre(bSav[2:end]),{-mat.Hsat});
    else
      bSav = pre(bSav);
    end if;
  end when;

  //##### REINIT aSav #####
  when {init3, evDesc, del} then
    if init3 then
      aSav=cat(1,{aSavI},fill(mat.Hsat,Count-1));
    elseif evDesc then
      aSav = if (alpha+eps)<pre(aSav[1]) then cat(1,{alpha},pre(aSav[1:end-1])) else pre(aSav);
    elseif del then
      aSav = cat(1,pre(aSav[2:end]),{mat.Hsat});
    else
      aSav = pre(aSav);
    end if;
  end when;

  // #### beta ####
  when {init3, change(asc), evInit, del} then
    reinit(beta, if init3 then bI elseif change(asc) then alpha elseif evInit then -alpha elseif asc then bSav[1] else aSav[1]);
  end when;

  H1= -beta-mat.Hc;
  H2= alpha-mat.Hc;
  H3= -alpha-mat.Hc;
  H4= beta-mat.Hc;

  E = unitT* 
      ((mat.M*mat.r*(2/pi*atan(mat.q*H1)+1)+(2*mat.M*(1-mat.r))/(1+1/2*(exp(-mat.p1*H1)+exp(-mat.p2*H1))))* 
      (mat.M*mat.r*(2/pi*atan(mat.q*H2)+1)+(2*mat.M*(1-mat.r))/(1+1/2*(exp(-mat.p1*H2)+exp(-mat.p2*H2))))- 
      (mat.M*mat.r*(2/pi*atan(mat.q*H3)+1)+(2*mat.M*(1-mat.r))/(1+1/2*(exp(-mat.p1*H3)+exp(-mat.p2*H3))))* 
      (mat.M*mat.r*(2/pi*atan(mat.q*H4)+1)+(2*mat.M*(1-mat.r))/(1+1/2*(exp(-mat.p1*H4)+exp(-mat.p2*H4)))));

  der(J) = (if init then 0.5 else 1) * der(E);
  B = J + mu0 * Hstat;

  annotation (defaultComponentName="core", Icon(graphics={Text(
          extent={{40,0},{40,-30}}, 
          textColor={255,128,0}, 
          textString="PE")}), 
    Documentation(info="<html>
<p>
用于模拟具有铁磁和动态磁滞(涡流)的磁性材料的磁通管元件。铁磁磁滞特性由
<a href=\"modelica://Modelica.Magnetic.FluxTubes.UsersGuide.Hysteresis.StaticHysteresis. Preisach\">Preisach hysteresis model</a>。极限铁磁磁滞回线的形状由埃弗雷特函数的解析描述来确定。预定义参数集的库可以在<a href=\"modelica://Modelica.Magnetic.FluxTubes.Material.HysteresisEverettParameter\">FluxTubes.Material.HysteresisEverettParameter</a>中找到.
</p>

<p>
概述了所有可用的包的滞后和永磁元素<a href=\"modelica://Modelica.Magnetic.FluxTubes.Shapes. HysteresisAndMagnets\">HysteresisAndMagnets</a>可以在 <a href=\"modelica://Modelica.Magnetic.FluxTubes.UsersGuide.Hysteresis\">UsersGuide.Hysteresis</a>中找到.
</p>

</html>"));
end GenericHystPreisachEverett;