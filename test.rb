require 'awesome_print'
require 'json'

require_relative 'lib/data-set'
require_relative 'lib/condition-decision-define'


def test_disease
  # http://blog.csdn.net/wodedipang_/article/details/49132397

  ap "读取 disease 数据样本"
  ds = RoughSet::DataSet.from_json File.read("data/disease.json")
  ap "共 #{ds.items_count} 个条目"
  ap "共 #{ds.attrs_count} 个属性"

  uid = '病人'

  p (indsc0 = ds.group_by ['头痛']).values_map_by(uid)
  p (indsc1 = ds.group_by ['胸口痛']).values_map_by(uid)
  p (indsc2 = ds.group_by ['体温']).values_map_by(uid)

  p (indsc3 = ds.group_by ['头痛', '胸口痛']).values_map_by(uid)
  p (indsc4 = ds.group_by ['头痛', '体温']).values_map_by(uid)
  p (indsc5 = ds.group_by ['胸口痛', '体温']).values_map_by(uid)

  p (indsc6 = ds.group_by ['头痛', '胸口痛', '体温']).values_map_by(uid)

  # p (indsd = ds.group_by ['流感']).values_map_by(uid)

  p '------'

  # p indsc6.pos_of_another(indsd).map_by(uid)
  # p indsc5.pos_of_another(indsd).map_by(uid)
  # p indsc4.pos_of_another(indsd).map_by(uid)
  # p indsc3.pos_of_another(indsd).map_by(uid)
  # p indsc2.pos_of_another(indsd).map_by(uid)
  # p indsc1.pos_of_another(indsd).map_by(uid)
  # p indsc0.pos_of_another(indsd).map_by(uid)

  p (ds1 = ds.select {|x| '是' == x['流感']}).map_by(uid)
  print ['头痛', '胸口痛', '体温'], "=>"
  p indsc6.pos(ds1).map_by(uid)
  print ['胸口痛', '体温'], "=>"
  p indsc5.pos(ds1).map_by(uid)
  print ['头痛', '体温'], "=>"
  p indsc4.pos(ds1).map_by(uid)
  print ['头痛', '胸口痛'], "=>"
  p indsc3.pos(ds1).map_by(uid)
  print ['体温'], "=>"
  p indsc2.pos(ds1).map_by(uid)
  print ['胸口痛'], "=>"
  p indsc1.pos(ds1).map_by(uid)
  print ['头痛'], "=>"
  p indsc0.pos(ds1).map_by(uid)
end

def test_airplanes
  ap "读取 disease 数据样本"
  ds = RoughSet::DataSet.from_json File.read("data/airplanes.json")
  ap "共 #{ds.items_count} 个条目"
  ap "共 #{ds.attrs_count} 个属性"

  inds = ds.group_by(['发动机', '是否隐身'])
  ds1 = ds.select {|x| ['A', 'B', 'C'].include? x['机型']}

  uid = '机型'

  print 'rough set: '
  p ds1.map_by(uid)
  print 'inds: '
  p inds.values_map_by(uid)
  print 'low set: '
  p inds.low_set_of(ds1).map_by(uid)
  print 'high set: '
  p inds.high_set_of(ds1).map_by(uid)
  print 'pos: '
  p inds.pos(ds1).map_by(uid)
  print 'neg: '
  p inds.neg(ds1, ds).map_by(uid)
  print 'bn: '
  p inds.bn(ds1).map_by(uid)
  print 'precise value: '
  p inds.precise_value(ds1)
end

test_disease
# test_airplanes
