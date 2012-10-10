class User < ActiveRecord::Base
  attr_accessible :email
  VALID_EMAIL = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL }


  #mailchimp
  after_create :add_user_to_mailchimp unless Rails.env.test?


  private
  	def add_user_to_mailchimp
  		unless self.email.include?('@example.com')
	      gb = Gibbon.new
	      list_id = gb.lists({:list_name => "PreLaunch"})["data"].first["id"]
	      gb.list_subscribe(:id => list_id, :email_address => self.email, 
	      	:merge_vars => {'fname' => '', 'lname' => '' }, 
	      	:email_type => "html",  :double_optin => false, :send_welcome => true)
	    end
  	end
end
# == Schema Information
#
# Table name: users
#
#  id         :integer         not null, primary key
#  email      :string(255)
#  created_at :datetime        not null
#  updated_at :datetime        not null
#

