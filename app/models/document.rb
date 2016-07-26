class Document < ActiveRecord::Base
  validates :real_filename, uniqueness: true

  belongs_to :user
  
  before_create :add_token_before_create
  
  def path_to_file 
    path+"/"+real_filename
  end

  def as_json(options={})

    {
        :id => self.id,
        :token => self.token,
        :originalFilename => self.original_filename
    }

  end
  
  private 
  
  def add_token_before_create
    self.token = (1..26).map { (65+rand(26)).chr }.join
  end
  
end
