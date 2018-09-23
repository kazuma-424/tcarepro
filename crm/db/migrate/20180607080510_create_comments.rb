class CreateComments < ActiveRecord::Migration[5.1]
  def change
    create_table :comments do |t|
#コメント情報
      t.string :body #コメント本文
      
      
#画像貼り付け
     t.string :picture #その他
     t.string :approval_data #認定書控え
     t.string :ahead_data #提出控え
     t.string :term_data #有期雇用契約書
     t.string :regular_data #正規雇用契約書
     t.string :attendance_data #出勤簿
     t.string :wage_data #賃金台帳
     t.string :labor_data #就業規則
      
#申請者情報
#有期実習型訓練
      t.string :limited_progress #進捗
      t.string :limited_start  #制度開始日
      t.string :limited_each_name #申込者
      t.string :limited_each_start  #開始日
      t.string :limited_each_curriculum #カリキュラム
      t.string :limited_offjt_time #OFF-JT
      t.string :limited_ojt_time #OJT
      t.string :limited_supply #支給申請開始日
      t.string :limited_comment #コメント

# キャリアアップ助成金　正社員化コース
      t.string :carriaup_progress #進捗
      t.string :carriaup_start #制度開始日
      t.string :carriaup_each_name #申込者
      t.string :carriaup_each_limited_start #入社日
      t.string :carriaup_each_regular #転換日
      t.string :carriaup_each_supply #支給申請開始日
      t.string :carriaup_comment #コメント
      
      
      t.string :system_progress #進捗
      t.string :system_start #制度開始日
      t.string :system_subsidyname #助成金
      t.string :system_each_name #制度
      t.string :system_implementation #実施日
      t.string :system_supply #支給申請開始日
　   t.string :system_comment #コメント
      
      t.references :company, foreign_key: true

      t.timestamps
    end
  end
end
