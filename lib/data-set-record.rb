class DataSetRecord
  include Mongoid::Document

  store_in collection: "disease"

  field :data
end