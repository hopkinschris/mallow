class Feedback
  include Mongoid::Document
  include Mongoid::Timestamps

  field :email
  field :note

  attr_accessible :email, 
                  :note

  validates_presence_of :email, :note
end
