class User < ActiveRecord::Base
  attr_accessible :email
  VALID_EMAIL = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL }


  #mailchimp
  after_create :add_user_to_mailchimp unless Rails.env.test?
  before_destroy :remove_user_from_mailchimp unless Rails.env.test?

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

  	def remove_user_from_mailchimp
	    unless self.email.include?('@example.com')
	      mailchimp = Hominid::API.new(ENV["MAILCHIMP_API_KEY"])
	      list_id = mailchimp.find_list_id_by_name "prelaunch"
	      result = mailchimp.list_unsubscribe(list_id, self.email, true, false, true)  
	      Rails.logger.info("MAILCHIMP UNSUBSCRIBE: result #{result.inspect} for #{self.email}")
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

