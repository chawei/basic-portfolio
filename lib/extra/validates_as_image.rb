module ValidatesAsImage
  def self.included receiver
    receiver.extend ClassMethods
  end

  module ClassMethods
    def validates_as_image fields

      validates_each fields do |record, attr, value|
        #debugger
        #if !value.queued_for_write.empty? and value.path
        #  `identify "#{value.path}"`
        #  record.errors.add attr, 'is not a valid image' unless $? == 0
        #end
      end
         
    end
  end
  
end