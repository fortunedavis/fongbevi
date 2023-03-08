class Vote < ApplicationRecord
  belongs_to :clip
  belongs_to :user 
 
  #reflections = Thing.reflections.select do |association_name, reflection| 
   # reflection.macro == :belongs_to
  #end




end
