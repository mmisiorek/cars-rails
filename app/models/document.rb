class Document < ActiveRecord::Base
  validates :real_filename, uniqueness: true
  
  before_create :add_token_before_create
  
  def path_to_file 
    path+"/"+real_filename
  end
  
  private 
  
  def add_token_before_create
    self.token = (1..26).map { (65+rand(26)).chr }.join
  end
  
end
