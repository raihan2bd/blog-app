require 'rails_helper'

RSpec.describe 'User show page', type: :feature do
  let!(:user) { User.create(name: 'Abu Raihan', bio: 'Graphic Designer', photo: 'raihan.jpg') }
  let!(:post1) { Post.create(title: 'My Post Title 1', text: 'My Post dummy title 1', author: user) }
  let!(:post2) { Post.create(title: 'My Post Title 2', text: 'My Post dummy title 2', author: user) }
  let!(:post3) { Post.create(title: 'My Post Title 3', text: 'My Post dummy title 3', author: user) }
  let!(:post4) { Post.create(title: 'My Post Title 4', text: 'My Post dummy title 4', author: user) }

  before do
    visit user_path(user)
  end

  describe 'Page content' do
    it "should display user's profile picture" do
      expect(page).to have_css("img[src='#{user.photo}']")
    end

    it "should display user's name" do
      expect(page).to have_content(user.name)
    end

    it 'should display number of posts' do
      expect(page).to have_content("Posts: #{user.post_counter}")
    end

    it "should display user's bio" do
      expect(page).to have_content(user.bio)
    end

    it "should display user's recent 3 posts" do
      expect(page).to have_content(post2.title)
      expect(page).to have_content(post3.title)
      expect(page).to have_content(post4.title)
    end

    it 'should display a button to view all posts' do
      expect(page).to have_link('See All Posts', href: user_posts_path(user))
    end
  end

  describe 'Clicking a post' do
    it 'should redirect to show page for correct post' do
      click_link post3.title
      expect(current_path).to eq user_post_path(user, post3)
    end
  end

  describe 'Clicking to see all posts' do
    it "should redirect to user's post's index page" do
      click_link 'See All Posts'
      expect(current_path).to eq user_posts_path(user)
    end
  end
end