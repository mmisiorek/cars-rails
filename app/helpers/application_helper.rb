require 'pathname'
require 'fileutils'

module ApplicationHelper
  
def self.generate_random_file_name(extension)
  filename = nil
  loop do 
    filename = "/tmp/"+(1..8).map { (65+rand(25)).chr }.join+"."+extension
    
    break if File.exists? filename
  end
  
  filename
end
  
class DocumentManager 
  def initialize(saved_user)
    @path = File.expand_path("~")+"/rails-pics"
    @saved_user = saved_user
  end
  
  def init_document(uploaded_file)
    new_file_name = nil
    uploaded_file_path = nil
    uploaded_file_original_name = nil

    if uploaded_file.class == ActionDispatch::Http::UploadedFile
      uploaded_file_path = uploaded_file.tempfile.path
      uploaded_file_original_name = uploaded_file.original_filename
    elsif uploaded_file.class <= Hash
      uploaded_file_path = uploaded_file[:file].path
      uploaded_file_original_name = uploaded_file[:original_filename]
    else
      raise Exception.new("Not supported")
    end
    
    loop do 
      path = Pathname.new(uploaded_file_path)
      new_file_name = generate_new_name(path.extname) 
      
      break if not File.exists? @path+"/"+new_file_name
    end

    Dir.mkdir(@path) unless File.directory?(@path)
    
    FileUtils.move(uploaded_file_path, @path+"/"+new_file_name)
    
    Document.new({
        original_filename: uploaded_file_original_name,
        real_filename: new_file_name,
        path: @path,
        user: @saved_user
    })
  end
  
  def resize_image(document, width, height)
    image = MiniMagick::Image.open document.path_to_file
    image.resize width+"x"+height
    image.format "jpg"
    
    data = File.read(image.path)
    FileUtils.rm image.path
    
    data
  end
  
  private 
  
  def generate_new_name(extension)
    (0..8).map { (65+rand(26)).chr }.join+extension
  end
end

end
