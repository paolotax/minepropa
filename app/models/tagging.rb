class Tagging < ActiveRecord::Base
  
  before_update :add_tags_to_context
  
  private
    def add_tags_to_context
      self.context == 'tags'
    end
end