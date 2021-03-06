class RecipesController < ApplicationController
  def index
    # Make all recipe objects (from DB) available in the index action.
    @recipes = Recipe.all
  end
  
  def new
    @recipe = Recipe.new
  end
  
  def create
    # Takes the new object created and uses the
    # recipe_params function defined below in
    # private section to mass assign/create new
    # recipes based on recipe_params which
    # whitelists all submitted data from the form.
    @recipe = Recipe.new(recipe_params)
    
    # A recipe must be associated with a chef. For
    # now, we will assign every recipe to user 2 
    # (Abhishek Gupta).
    # NOTE: This line is for testing purposes and
    # must NOT be deleted. Will be commented out 
    # in final release.
    @recipe.chef = Chef.find(1)
    
    # If the recipe was successfully saved to the
    # database, ...
    if @recipe.save
      # then let the user know that via a flash notification
      flash[:success] = "Success! Your recipe went live!"
      
      # and then redirect the user to the recipes page.
      redirect_to recipes_path
    else
      # However, if there was a failure to save to
      # the database, redirect user to the new page.
      render :new
    end
  end  
  
  def edit
    @recipe = Recipe.find(params[:id])
  end
  
  def show
    @recipe = Recipe.find(params[:id])
  end
  
  def update
    @recipe = Recipe.find(params[:id])
    if @recipe.update(recipe_params)
      flash[:success] = "Your recipe was updated."
      redirect_to recipe_path(@recipe)
    else
      render :edit
      flash[:danger] = "Something went wrong. The recipe was not updated."
    end
  end
  
  def destroy
    
  end
  
  private
    
    def recipe_params
      # Whitelist all relevant parameters to pass through from form 
      # submission.
      params.require(:recipe).permit(:name, :summary, :description, :picture)
    end
end