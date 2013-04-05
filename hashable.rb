module Dyneasy
  module Hashable
    def to_h
      self.instance_variables.inject({}) do |h,m| 
        strip = m.to_s.gsub(/@/,'')
        h[strip] = self.send(strip) 
        h
      end
    end
  end
end
