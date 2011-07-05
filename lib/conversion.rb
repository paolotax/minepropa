module Conversion
  KM_PER_MILE = 1.609344

  def self.m2km(miles)
    miles.to_f * KM_PER_MILE
  end
end