class Feedback
  include Mongoid::Document
  include Mongoid::Timestamps

  field :email
  field :note

  attr_accessible :email, 
                  :note

  validates_presence_of :email, :note

  validates_format_of :email,
                      :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i
end
