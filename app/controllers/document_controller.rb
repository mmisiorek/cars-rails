class DocumentController < ApplicationController
  def show
    document = Document.find(params[:id])
    
    if document.token != params[:token]
      head :forbidden
      return
    end
    
    if params[:width] != nil or params[:height] != nil
      documentManager = ApplicationHelper::DocumentManager.new
      img_data = documentManager.resize_image(document, params[:width], params[:height])
      
      send_data img_data, type: 'image/jpeg', disposition: 'inline', filename: document.original_filename
    else 
      send_file document.path_to_file, type: 'image/png', disposition: 'inline', filename: document.original_filename
    end
  end
end
