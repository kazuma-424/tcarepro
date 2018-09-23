class CreateInvoices < ActiveRecord::Migration[5.1]
  def change
    create_table :invoices do |t|
        t.string :company #会社名
        t.string :status #ステータス
        t.string :deadline #期限
        t.string :payment #入金日
        t.string :subject #件名
        t.string :product #商品名
        t.string :price #販売価格
        t.string :quantity #数量
        
      t.timestamps
    end
  end
end
