require 'rails_helper'

RSpec.describe "Users", type: :request do
  let(:user) {create :user}
  before(:each) do
    sign_in(user)
  end
  describe "GET /users" do
    it "returns status code for index page" do
      get users_path
      expect(response).to have_http_status(200)
    end
  end

  describe "Create user" do
    it 'should render the new user form and then save data' do
      get new_user_path(format: :turbo_stream)
      expect(response).to render_template('users/new')

      post users_path, params: {
        user: user_params,
        format: :turbo_stream
      }
      expect(response.content_type).to eq("text/vnd.turbo-stream.html; charset=utf-8")
      expect(response.media_type).to eq('text/vnd.turbo-stream.html')
      expect(User.count).to eq(2)
      expect(response).to render_template('users/_user')
    end
  end

  describe "Update user" do
    let(:user1) {create :user}
    it 'should render the edit user form and then update data' do
      get edit_user_path(user1, format: :turbo_stream)
      expect(response).to render_template('users/edit')

      patch user_path(user1), params: {
        user: user_params,
        format: :turbo_stream
      }
      expect(response.content_type).to eq("text/vnd.turbo-stream.html; charset=utf-8")
      expect(response.media_type).to eq('text/vnd.turbo-stream.html')
      expect(User.count).to eq(2)
      expect(response).to render_template('users/_user')
      expect(assigns[:user].name).to eq("test name")
    end
  end

  describe "Delete user" do
    let(:user1) {create :user}
    it 'should render the edit user form and then update data' do
      delete user_path(user1, format: :turbo_stream)

      expect(User.count).to eq(1)
      expect(response).to render_template(nil)
    end
  end
end

def user_params
  {
      name: "test name",
      email: Faker::Internet.email,
      password: "password@123",
      contact_number: Faker::PhoneNumber.cell_phone_with_country_code,
      country: User.country_code_list.sample,
      state: "PB",
      city: "Lahore"
  }
end