class UploaderController < ApplicationController
  def index
  end

  def form
  end


  def download
      @upload_file = UploadFile.find(params[:id].to_i)
      filepath = @upload_file.file.current_path
      stat = File::stat(filepath)
      send_file(filepath, :filename => @upload_file.file.url.gsub(/.*\//,''), :length => stat.size)
  end
  
  def upload_process
  	#アップロードファイルを取得
  	file = params[:upfile]
  	#ファイルのベース名を取得
  	name = file.original_filename
  	#許可する拡張子を定義
  	perms = [ '.jpg' , '.jpeg' , '.png' , '.pdf' , '.pages' , '.numbers' , '.key' , '.jpeg' , 'docs' , 'pptx', 'xls']
  	#配列permsにアップロードファイルの拡張子に合致するものがあるか
  	if !perms.include?(File.extname(name).downcase)
  		result = 'アップロードできません。'
  	#アップロードファイルが５MB以下であるか
  	elsif file.size > 5.megabyte
  		result = 'ファイルサイズは５MBまでです。'
  	else
  	#/public/docフォルダ配下にアップロードファイルを保存
  	File.open("public/docs/#{name}", 'wb') { |f| f.write(file.read) }
  	end
  	#成功・エラーメッセージを保存
  	render plain: result
  end
end