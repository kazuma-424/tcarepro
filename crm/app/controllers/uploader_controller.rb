class UploaderController < ApplicationController
  def index
  @q = Company.ransack(params[:q])
  end

  def form
  @q = Company.ransack(params[:q])
  end

  def upload
    @upload_file = UploadFile.new( params.require(:upload_file).permit(:name, :file) )
    @upload_file.save
    redirect_to action: 'index'
    @q = Company.ransack(params[:q])
  end

  def download
      @upload_file = UploadFile.find(params[:id].to_i)
      filepath = @upload_file.file.current_path
      stat = File::stat(filepath)
      send_file(filepath, :filename => @upload_file.file.url.gsub(/.*\//,''), :length => stat.size)
     @q = Company.ransack(params[:q])
  end
end
