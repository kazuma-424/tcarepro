class TodosController < ApplicationController


  def index
  	 @todos = Todo.all.order(created_at: 'desc')
  	 @q = Company.ransack(params[:q])
  	     @todo = Todo.new
  end
  
  def show
  	@todo = Todo.find(params[:id])
  	@q = Company.ransack(params[:q])
  end
  
 
 def create
    @todo = Todo.new(faq_params)
    if @todo.save
        # redirect
        redirect_to todos_path
    else
        render 'new'
    end
  end
  
  def edit
    @todo = Todo.find(params[:id])
    @q = Company.ransack(params[:q])
  end

 def update
    @todo = Todo.find(params[:id])
     if @todo.update(todo_params)
        redirect_to todos_path
    else
        render 'edit'
    end      
 end
 
 def destroy
    @todo = Todo.find(params[:id])
    @todo.destroy
    redirect_to todos_path
 end

  private
    def todo_params
      params.require(:todo).permit(
      :execution, #実行
      :title, #タイトル
      :select, #選択 
      :deadline, #期限
      :states, #ステータス
      :name, #担当者
      :contents #コンテンツ
      )
    end    


end
