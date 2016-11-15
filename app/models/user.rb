# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  email           :string           not null
#  password_digest :string           not null
#  first_name      :string
#  last_name       :string
#  display_name    :string
#  avatar_url      :string
#

class User < ActiveRecord::Base
  has_secure_password
  after_initialize :set_display_name

  def as_json(options = {})
    super(options).except(:password_digest)
  end

  private
  def set_display_name
    self.display_name ||= if first_name && last_name
      "#{first_name} #{last_name}"
    elsif first_name
      first_name
    elsif last_name
      last_name
    else
      "<User #{id}>"
    end
  end
end
