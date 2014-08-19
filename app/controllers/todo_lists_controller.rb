class TodoListsController < ApplicationController
  before_action :set_todo_list, only: [ :update, :destroy]

  def index
    @todo_lists = TodoList.all
    @todo_list = TodoList.new
  end

  def create
    @todo_list = TodoList.new(todo_list_params)
    @todo_lists = TodoList.all
    respond_to do |format|
      if @todo_list.save
        format.html { redirect_to todo_lists_path}
      else
        format.html { render :index }
        format.json { render json: @todo_list.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @todo_list.update(todo_list_params)
        format.html { redirect_to todo_lists_path}
        format.json { respond_with_bip(@todo_list) }
      else
        format.json { render json: @todo_list.errors, status: :unprocessable_entity }
        format.json { respond_with_bip(@todo_list) }
      end
    end
  end

  def destroy
    @todo_list.destroy
    respond_to do |format|
      format.html { redirect_to todo_lists_url}
      format.json { head :no_content }
    end
  end

  private
    def set_todo_list
      @todo_list = TodoList.find(params[:id])
    end

    def todo_list_params
      params.require(:todo_list).permit(:name)
    end
end
