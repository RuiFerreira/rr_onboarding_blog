class TagsController < ApplicationController
  def index
    @tags = Tag.all
  end

  def show
    @tag = Tag.find(params[:id])
  end

  def new
    @tag = Tag.new
  end

  def create
    @tag = Tag.new(tag_params)
    if @tag.save
      flash[:notice] = 'Tag was successfully created'
      redirect_to @tag
    else
      render 'new'
    end
  end

  def edit; end

  def update; end

  def destroy; end

  private

  def tag_params
    params.require(:tag).permit(:name)
  end

end