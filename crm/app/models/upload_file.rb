class UploadFile < ApplicationRecord
	 mount_uploader :file, UploadFileUploader
end
