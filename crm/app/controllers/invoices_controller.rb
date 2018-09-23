class InvoicesController < ApplicationController

  def index
  	 @invoices = Invoice.all.order(created_at: 'desc')
  	 @q = Company.ransack(params[:q])
  end
  
  def show
  	@invoice = Invoice.find(params[:id])
  	@q = Company.ransack(params[:q])
  end
  
  def new
    @invoice = Invoice.new
    @q = Company.ransack(params[:q])
  end
 
 def create
    @invoice = Invoice.new(invoice_params)
    if @invoice.save
        # redirect
        redirect_to invoices_path
    else
        render 'new'
    end
  end
  
  def edit
    @invoice = Invoice.find(params[:id])
  end

 def update
    @invoice = Invoice.find(params[:id])
     if @invoice.update(invoice_params)
        redirect_to invoices_path
    else
        render 'edit'
    end      
 end
 
 def destroy
    @invoice = Invoice.find(params[:id])
    @invoice.destroy
    redirect_to invoices_path
 end
 


  # 帳票出力処理
  def report
    report = Thinreports::Report.new layout: "app/reports/layouts/invoices.tlf"
    report.start_new_page
    report.page.values(
    created_at: @invoice.try(:id)
    )
    send_data(report.generate, filename: "#{@invoice}.pdf", type: "application/pdf")
  end



  private
    def invoice_params
      params.require(:invoice).permit(
        :status, #ステータス
        :deadline, #期限
        :payment,#入金日
        :subject, #件名
        :product, #商品名
        :price, #販売価格
        :quantity #数量
        )
    end    



end
