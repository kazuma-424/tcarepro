# == Schema Information
#
# Table name: companies
#
#  id                 :integer          not null, primary key
#  user_id            :integer
#  worker_id          :integer
#  company            :string
#  first_name         :string
#  last_name          :string
#  first_kana         :string
#  last_kana          :string
#  tel                :string
#  mobile             :string
#  fax                :string
#  e_mail             :string
#  postnumber         :string
#  prefecture         :string
#  city               :string
#  town               :string
#  caption            :string
#  labor_number       :string
#  employment_number  :string
#  trial_period       :string
#  work_start         :string
#  break_in           :string
#  break_out          :string
#  work_out           :string
#  holiday            :string
#  allowance          :string
#  allowance_contents :string
#  closing_on         :string
#  payment_on         :string
#  method_payment     :string
#  desuction          :string
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#

class Company < ApplicationRecord
    has_many :comments, dependent: :destroy
    has_many :invoices    
    
	
  def self.import(file)
    CSV.foreach(file.path, headers: true) do |row|
      # IDが見つかれば、レコードを呼び出し、見つかれなければ、新しく作成
      company = find_by(id: row["id"]) || new
      # CSVからデータを取得し、設定する
      company.attributes = row.to_hash.slice(*updatable_attributes)
      # 保存する
      company.save!
    end
  end

  def self.updatable_attributes
  		["company"]
  end
  

  def self.search(search) #self.でクラスメソッドとしている
    if search # Controllerから渡されたパラメータが!= nilの場合は、titleカラムを部分一致検索
      Company.where(['company LIKE ?', "%#{company}%"])
    else
      Company.all #全て表示。
    end
  end
  
end