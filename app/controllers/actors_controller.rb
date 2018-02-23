class ActorsController < ApplicationController
  def index
    @actors = Actor.all

    render("actor_templates/index.html.erb")
  end

  def show
    @actor = Actor.find(params.fetch("id_to_display"))

    render("actor_templates/show.html.erb")
  end

  def new_form
    render("actor_templates/new_form.html.erb")
  end

  def create_row
    @actor = Actor.new


    @actor.name = params.fetch("name")

    @actor.dob = params.fetch("dob")

    @actor.bio = params.fetch("bio")

    @actor.image_url = params.fetch("image_url")



    if @actor.valid?
      @actor.save

      redirect_to("/actors", :notice => "Actor created successfully.")
    else
      render("actor_templates/new_form.html.erb")
    end

  end

  def edit_form
    @actor = Actor.find(params.fetch("prefill_with_id"))

    render("actor_templates/edit_form.html.erb")
  end

  def update_row
    @actor = Actor.find(params.fetch("id_to_modify"))


    @actor.name = params.fetch("name")

    @actor.dob = params.fetch("dob")

    @actor.bio = params.fetch("bio")

    @actor.image_url = params.fetch("image_url")



    if @actor.valid?
      @actor.save

      redirect_to("/actors/#{@actor.id}", :notice => "Actor updated successfully.")
    else
      render("actor_templates/edit_form.html.erb")
    end

  end

  def destroy_row
    @actor = Actor.find(params.fetch("id_to_remove"))

    @actor.destroy


    redirect_to("/actors", :notice => "Actor deleted successfully.")

  end
end
