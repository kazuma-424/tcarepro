class FaqsController < ApplicationController


  def index
  	 @faqs = Faq.all.order(created_at: 'desc')
  end
  
  def show
  	@faq = Faq.find(params[:id])
  end
  
  def new
    @faq = Faq.new
  end
 
 def create
    @faq = Faq.new(faq_params)
    if @faq.save
        # redirect
        redirect_to faqs_path
    else
        render 'new'
    end
  end
  
  def edit
    @faq = Faq.find(params[:id])
  end

 def update
    @faq = Faq.find(params[:id])
     if @faq.update(faq_params)
        redirect_to faqs_path
    else
        render 'edit'
    end      
 end
 
 def destroy
    @faq = Faq.find(params[:id])
    @faq.destroy
    redirect_to faqs_path
 end

  private
    def faq_params
      params.require(:faq).permit(
      :title,
      :select,
      :contents)
    end    




end
