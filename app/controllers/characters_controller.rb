class CharactersController < ApplicationController
  def index
    @characters = Character.all

    render("character_templates/index.html.erb")
  end

  def show
    @character = Character.find(params.fetch("id_to_display"))

    render("character_templates/show.html.erb")
  end

  def new_form
    render("character_templates/new_form.html.erb")
  end

  def create_row
    @character = Character.new

    @character.movie_id = params.fetch("movie_id")
    @character.actor_id = params.fetch("actor_id")
    @character.name = params.fetch("name")

    if @character.valid?
      @character.save

      redirect_to("/characters", :notice => "Character created successfully.")
    else
      render("character_templates/new_form.html.erb")
    end
  end

  def edit_form
    @character = Character.find(params.fetch("prefill_with_id"))

    render("character_templates/edit_form.html.erb")
  end

  def update_row
    @character = Character.find(params.fetch("id_to_modify"))

    @character.movie_id = params.fetch("movie_id")
    @character.actor_id = params.fetch("actor_id")
    @character.name = params.fetch("name")

    if @character.valid?
      @character.save

      redirect_to("/characters/#{@character.id}", :notice => "Character updated successfully.")
    else
      render("character_templates/edit_form.html.erb")
    end
  end

  def destroy_row
    @character = Character.find(params.fetch("id_to_remove"))

    @character.destroy

    redirect_to("/characters", :notice => "Character deleted successfully.")
  end
end
