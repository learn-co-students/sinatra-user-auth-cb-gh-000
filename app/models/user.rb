class User < ActiveRecord::Base
  # TODO what does this do?
  validates_presence_of :name, :email, :password

end
