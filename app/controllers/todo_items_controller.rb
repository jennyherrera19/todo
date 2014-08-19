class TodoItemsController < ApplicationController
  before_action :set_todo_item, only: [ :update, :destroy]
  before_action :set_todo_list

  def index
    @todo_items = @todo_list.todo_items.all
    @todo_item = @todo_items.new
  end

  def create
    @todo_item = @todo_list.todo_items.new(todo_item_params)
    @todo_items = @todo_list.todo_items.all
    respond_to do |format|
      if @todo_item.save
        format.html { redirect_to todo_list_todo_items_path(@todo_list)}
      else
        format.html { render :index}
        format.json { render json: @todo_item.errors}
      end
    end
  end

  def update
    respond_to do |format|
      if @todo_item.update(todo_item_params)
        format.html { redirect_to todo_list_todo_items_path(@todo_list)}
        format.json { respond_with_bip(@todo_item) }
      else
        format.json { render json: @todo_item.errors, status: :unprocessable_entity }
        format.json { respond_with_bip(@todo_item) }
      end
    end
  end

  def destroy
    @todo_item.destroy
    respond_to do |format|
      format.html { redirect_to todo_list_todo_items_path(@todo_list)}
      format.json { head :no_content }
    end
  end

  private
    def set_todo_item
      @todo_item = TodoItem.find(params[:id])
    end

    def set_todo_list
      @todo_list = TodoList.find(params[:todo_list_id])
    end

    def todo_item_params
      params.require(:todo_item).permit(:name, :todo_list_id, :completed)
    end
end
