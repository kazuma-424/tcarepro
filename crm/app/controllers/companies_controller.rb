class CompaniesController < ApplicationController
before_action :authenticate_admin!, except: [:new, :progress]


  def index
  	 @q = Company.ransack(params[:q])
  	 @companies = @q.result.page(params[:page]).per(100)
  end

  def show
  	@company = Company.find(params[:id])
  	@q = Company.ransack(params[:q])
  end

  def progress
  	@company = Company.find(params[:id])
  	render :layout => 'user'
  end

  def new
    @company = Company.new
    @q = Company.ransack(params[:q])
    render :layout => 'top'
  end

 def create
    @company = Company.new(company_params)
    if @company.save
        # redirect
        redirect_to companies_path
    else
        render 'new'
    end
  end

  def edit
    @company = Company.find(params[:id])
  	@q = Company.ransack(params[:q])
  end

 def update
    @company = Company.find(params[:id])
    if !@company.update(company_params)
       render 'edit'
       return
    end
    if params[:company][:ajax].present?
      redirect_to company_path(@company)
    else
      redirect_to companies_path
    end
 end

 def destroy
    @company = Company.find(params[:id])
    @company.destroy
    redirect_to companies_path
 end

 def import
    Company.import(params[:file])
    redirect_to companies_url, notice: "CSVデータを追加しました"
end

  def plural_destroy
    items = params[:checked_items].keys
    Company.destroy(items)
    redirect_to :action => 'list'
  end

  private
    def company_params
      params.require(:company).permit(
      :company, #会社名
      :first_name, #苗字
      :last_name, #名前
      :first_kana, #ミョウジ
      :last_kana, #ナマエ
      :tel, #電話番号
      :mobile, #携帯番号
      :fax, #FAX番号
      :e_mail, #メールアドレス
      :postnumber, #郵便番号
      :prefecture, #都道府県
      :city, #市町村
      :town, #市町村以降
      :caption, #資本金
      :labor_number, #労働保険番号
#就業規則
      :employment_number, #雇用保険番号
       :trial_period, #試用期間
       :work_start, #勤務開始
       :break_in, #休憩開始
       :break_out, #休憩終了
       :work_out, #勤務終了
       :holiday, #休日
       :allowance, #手当
       :allowance_contents, #手当詳細
       :closing_on, #締め日
       :payment_on, #支払い日
       :method_payment, #支払方法
       :desuction #控除
)
    end




end