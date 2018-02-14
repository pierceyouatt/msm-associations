require "rails_helper"

describe "/actors" do
  it "displays each actor's name and dob", points: 5 do
    leo = create(:actor, name: "Leonardo DiCaprio", dob: "November 11, 1974")
    jack = create(:actor, name: "Jack Nicholson", dob: "April 22, 1937")
    bob = create(:actor, name: "Robert De Niro", dob: "August 17, 1943")

    visit "/actors"

    actors = Actor.all
    actors.each do |actor|
      expect(page).to have_content(actor.name)
      expect(page).to have_content(actor.dob)
    end
  end
end

describe "/actors/[ACTOR ID]" do
  it "displays a functional delete link for each actor", points: 5 do
    leo = create(:actor, name: "Leonardo DiCaprio", dob: "November 11, 1974")
    jack = create(:actor, name: "Jack Nicholson", dob: "April 22, 1937")
    bob = create(:actor, name: "Robert De Niro", dob: "August 17, 1943")

    actors = Actor.all
    actors.each do |actor|
      visit "/actors/#{actor.id}"
      count_of_actors = Actor.count
      click_link 'Delete', match: :first
      expect(Actor.count).to eq(count_of_actors - 1)
    end
  end
end

describe "/actors/[ACTOR ID]" do
  it "displays a count of the actor's characters", points: 5 do
    scorsese = create(:director, name: "Martin Scorsese", dob: "November 17, 1942")
    departed = create(:movie, title: "The Departed", year: 2006, duration: 151, director_id: scorsese.id)
    goodfellas = create(:movie, title: "Goodfellas", year: 1990, duration: 146, director_id: scorsese.id)

    nolan = create(:director, name: "Christopher Nolan", dob: "July 30, 1970")
    dark_knight = create(:movie, title: "The Dark Knight", year: 2008, duration: 152, director_id: nolan.id)
    inception = create(:movie, title: "Inception", year: 2010, duration: 148, director_id: nolan.id)

    leo = create(:actor, name: "Leonardo DiCaprio", dob: "November 11, 1974")
    create(:character, name: 'Cobb', movie_id: inception.id, actor_id: leo.id)
    create(:character, name: 'Billy Costigan', movie_id: departed.id, actor_id: leo.id)

    jack = create(:actor, name: "Jack Nicholson", dob: "April 22, 1937")
    create(:character, name: 'Frank Costello', movie_id: departed.id, actor_id: jack.id)

    bob = create(:actor, name: "Robert De Niro", dob: "August 17, 1943")
    create(:character, name: 'James Conway', movie_id: goodfellas.id, actor_id: bob.id)

    actors = Actor.all
    actors.each do |actor|
      visit "/actors/#{actor.id}"
      count_of_characters = Character.where(actor_id: actor.id).count
      expect(page).to have_content(count_of_characters)
    end
  end
end

describe "/actors/[ACTOR ID]" do
  it "displays a list of the actor's movies (filmography)", points: 5 do
    scorsese = create(:director, name: "Martin Scorsese", dob: "November 17, 1942")
    departed = create(:movie, title: "The Departed", year: 2006, duration: 151, director_id: scorsese.id)
    goodfellas = create(:movie, title: "Goodfellas", year: 1990, duration: 146, director_id: scorsese.id)

    nolan = create(:director, name: "Christopher Nolan", dob: "July 30, 1970")
    dark_knight = create(:movie, title: "The Dark Knight", year: 2008, duration: 152, director_id: nolan.id)
    inception = create(:movie, title: "Inception", year: 2010, duration: 148, director_id: nolan.id)

    leo = create(:actor, name: "Leonardo DiCaprio", dob: "November 11, 1974")
    create(:character, name: 'Cobb', movie_id: inception.id, actor_id: leo.id)
    create(:character, name: 'Billy Costigan', movie_id: departed.id, actor_id: leo.id)

    jack = create(:actor, name: "Jack Nicholson", dob: "April 22, 1937")
    create(:character, name: 'Frank Costello', movie_id: departed.id, actor_id: jack.id)

    bob = create(:actor, name: "Robert De Niro", dob: "August 17, 1943")
    create(:character, name: 'James Conway', movie_id: goodfellas.id, actor_id: bob.id)

    actors = Actor.all
    actors.each do |actor|
      visit "/actors/#{actor.id}"
      characters = Character.where(actor_id: actor.id)
      actor.characters.each do |character|
        movie = Movie.find_by(id: character.movie_id)
        expect(page).to have_content(movie.title)
      end
    end
  end
end

describe "/actors/[ACTOR ID]" do
  it "displays a form to add a new character", points: 2 do
    actors = Actor.all
    actors.each do |actor|
      visit "/actors/#{actor.id}"
      expect(page).to have_selector("form", count: 1)
    end
  end
end

describe "/actors/[ACTOR ID]" do
  it "creates a new character for the actor after submitting the form", points: 10 do
    nolan = create(:director, name: "Christopher Nolan", dob: "July 30, 1970")
    dark_knight = create(:movie, title: "The Dark Knight", year: 2008, duration: 152, director_id: nolan.id)
    inception = create(:movie, title: "Inception", year: 2010, duration: 148, director_id: nolan.id)

    hardy = create(:actor, name: "Tom Hardy", dob: "September 15, 1977")

    visit "/actors/#{hardy.id}"
    expect(page).to have_selector("form")

    count_of_characters = Character.where(actor_id: hardy.id).count
    fill_in 'Name', with: 'Eames'
    select 'Inception'
    click_button 'Create character'
    expect(Character.where(actor_id: hardy.id).count).to eq(count_of_characters + 1)
  end
end

describe "/actors/[ACTOR ID]" do
  it "displays a hidden input field to associate a new character to the actor", points: 10 do
    scorsese = create(:director, name: "Martin Scorsese", dob: "November 17, 1942")
    departed = create(:movie, title: "The Departed", year: 2006, duration: 151, director_id: scorsese.id)
    goodfellas = create(:movie, title: "Goodfellas", year: 1990, duration: 146, director_id: scorsese.id)

    nolan = create(:director, name: "Christopher Nolan", dob: "July 30, 1970")
    dark_knight = create(:movie, title: "The Dark Knight", year: 2008, duration: 152, director_id: nolan.id)
    inception = create(:movie, title: "Inception", year: 2010, duration: 148, director_id: nolan.id)

    leo = create(:actor, name: "Leonardo DiCaprio", dob: "November 11, 1974")
    create(:character, name: 'Cobb', movie_id: inception.id, actor_id: leo.id)
    create(:character, name: 'Billy Costigan', movie_id: departed.id, actor_id: leo.id)

    jack = create(:actor, name: "Jack Nicholson", dob: "April 22, 1937")
    create(:character, name: 'Frank Costello', movie_id: departed.id, actor_id: jack.id)

    bob = create(:actor, name: "Robert De Niro", dob: "August 17, 1943")
    create(:character, name: 'James Conway', movie_id: goodfellas.id, actor_id: bob.id)

    actors = Actor.all
    actors.each do |actor|
      visit "/actors/#{actor.id}"
      expect(page).to have_selector("input[value='#{actor.id}']", visible: false),
        "expected to find a hidden input field with the actor's id as the value"
    end
  end
end

describe "/actors/new" do
  it 'creates a new actor after submitting the form', points: 5 do
    visit "/actors/new"
    expect(page).to have_selector("form")

    count_of_actors = Actor.count
    fill_in 'Name', with: 'Joseph Gordon-Levitt'
    fill_in 'Dob', with: 'February 17, 1981'
    click_button 'Create actor'
    new_count_of_actors = count_of_actors + 1
    expect(Actor.count).to eq(new_count_of_actors)
  end
end

describe "/actors/[ACTOR ID]/edit" do
  it "updates an actor's data after submitting the form", points: 5 do
    bella = create(:actor, name: "Bella Ramsey", dob: "unknown")
    expect(bella.bio).to be_nil

    visit "/actors/#{bella.id}/edit"

    bio = 'Bella Ramsey (born 2003 or 2004) is a British child actress. She made her professional acting debut as the young noblewoman Lyanna Mormont in the HBO fantasy television series Game of Thrones.'
    fill_in 'Dob', with: '2003'
    fill_in 'Bio', with: bio
    click_button 'Update actor'

    bella.reload
    expect(bella.dob).to eq('2003')
    expect(bella.bio).to eq(bio)
  end
end
