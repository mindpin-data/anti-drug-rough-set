# 条件 / 决策属性定义

class ConditionDecisionDefine
  def initialize(dataset, condition_attrs, decision_attrs)
    @dataset = dataset
    @condition_attrs = condition_attrs
    @decision_attrs = decision_attrs
  end

  # 条件属性的指定个数组合
  def condition_combination(n)
    @condition_attrs.combination(n).to_a
  end

  # 应按集合划分，贝尔数的方式进行条件属性分组
  # 计算量太大！
end