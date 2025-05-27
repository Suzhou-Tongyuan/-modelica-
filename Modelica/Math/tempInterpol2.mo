function tempInterpol2 
  "矢量化线性插值的临时函数"
  extends Modelica.Icons.Function;

  input Real u "输入值(表格第一列)";
  input Real table[:, :] "要插值的表格";
  input Integer icol[:] "要插值表格的列";
  output Real y[1, size(icol, 1)] "内插输入值(表格的icol列)";

protected
  Integer i;
  Integer n "表格的行数";
  Real u1;
  Real u2;
  Real y1[1, size(icol, 1)];
  Real y2[1, size(icol, 1)];
algorithm
  n := size(table, 1);

  if n <= 1 then
    y := transpose([table[1, icol]]);

  else
    // 搜索间隔

    if u <= table[1, 1] then
      i := 1;

    else
      i := 2;
      // 支持重复表[i, 1]值
      // 在内部允许有不连续性。
      // 内部意味着
      // 如果表[i, 1] = 表[i+1, 1]，我们要求 i>1 和 i+1<n

      while i < n and u >= table[i, 1] loop
        i := i + 1;

      end while;
      i := i - 1;

    end if;

    // 获取插值数据
    u1 := table[i, 1];
    u2 := table[i + 1, 1];
    y1 := transpose([table[i, icol]]);
    y2 := transpose([table[i + 1, icol]]);

    assert(u2 > u1, "表格索引必须递增");
    // 内插法
    y := y1 + (y2 - y1)*(u - u1)/(u2 - u1);

  end if;

  annotation (Documentation(info="<html>

</html>"), 
  obsolete = "过时的功能");
end tempInterpol2;