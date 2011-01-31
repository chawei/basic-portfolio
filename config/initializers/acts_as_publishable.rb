require "active_record"

module ActsAsPublishable
  #def self.included(base)
  #  base.extend(ClassMethods)
  #end
  def acts_as_publishable
    class_eval do
      scope :published, where(:state => 'published')

      state_machine :state, :initial => :hidden do
        event :publish do
          transition [:published, :hidden] => [:published]
        end

        event :hide do
          transition [:published, :hidden] => [:hidden]
        end
      end
      
      def toggle_published
        hidden? ? publish : hide
      end
    end
  end
end

if defined?(ActiveRecord::Base)
  ActiveRecord::Base.extend ActsAsPublishable
end

# TODO: 
# 1. extract 'toggle_published' method from AdminController
# 2. extract routes