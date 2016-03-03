require 'rails_helper'

describe MoviesController do

    describe "director" do
        context "test if the director workds" do
            before :each do
                @fake_movie = double('Movie', :id => "1", :title => "name")
                allow(Movie).to receive(:find).with("1").and_return(@fake_movie)
            end
        
    
            it "should show a movie" do
                get :show, :id => "1"
                expect(response).to render_template("show")
            end
        end
    end
  
    describe "edit" do
        before :each do
            @fake_movie = double('Movie', :id => "1", :title => "name")
            allow(Movie).to receive(:find).with("1").and_return(@fake_movie)
        end
    
        it "should go to the edit section" do
            get :edit, :id => "1"
            expect(response).to render_template("edit")
        end
    end
  
    describe "make a new movie" do
        it "go to the create movie page" do
            get :new
            expect(response).to render_template("new")
        end
    end
  
    describe 'update' do
        before :each do
            @fake_movie = double('Movie', :title => "name", :id => "1")
            allow(Movie).to receive(:find).with("1").and_return(@fake_movie)
        end
    
        it 'should update and then go to the movie' do
            expect(@fake_movie).to receive(:update_attributes!)
            put :update, { :movie => { :title => "name2"},  :id => "1" }
            expect(response).to redirect_to(movie_path(@fake_movie))
        end
    end
  
    describe 'create' do
        it 'should create a new movie' do
            @fake_movie = double(:title => "name", :director => "director", :id => "1")
            post :create, { :movie => {:id => "1"} }
            expect(response).to redirect_to(movies_path)
        end
    end
    
    describe 'destroy' do
        before :each do
            @fake_movie = double('Movie', :id => "1", :title => "name")
            allow(Movie).to receive(:find).with("1").and_return(@fake_movie)
        end
    
        it 'should erase the movie from the database' do
            expect(@fake_movie).to receive(:destroy)
            delete :destroy, {:id => "1"}
            expect(response).to redirect_to(movies_path)
        end
    end
  
    describe 'director' do
    
        it "should get the sad response" do
            @fake_movie = double('Movie', :id => "1", :title => "name", :director => nil)
            allow(Movie).to receive(:find).with("1").and_return(@fake_movie)
            get :director, {:id => "1"}
            expect(response).to redirect_to(movies_path)
        end
    
        it "should get the similar directors" do
            @fake_movie = double('Movie', :id => "1", :title => "name", :director => "director")
            allow(Movie).to receive(:find).with("1").and_return(@fake_movie)
            expect(Movie).to receive(:where).with(:director => "director")
            get :director, {:id => "1"}
        end
    end

end
