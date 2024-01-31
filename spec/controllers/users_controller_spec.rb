require 'rails_helper'

RSpec.describe UsersController do
    let(:user) {create :user}
    before(:each) do
        sign_in(user)
    end
    describe 'GET index' do

        it 'assigns @users' do
            get :index
            expect(assigns(:users)).to eq([user])
            expect(response).to render_template('index')
            expect(response).to have_http_status(:ok)
        end

        it 'renders the index template' do
            get :index
            expect(response).to render_template('index')
        end

        it 'get https ok status code' do 
            get :index
            expect(response).to have_http_status(:ok)
        end
    end

    describe 'POST create' do

        it 'should accepts the params with html format' do
            post :create, params: {
                user: user_params
            }
            expect(response.content_type).to eq("text/html; charset=utf-8")
            expect(response.media_type).to eq('text/html')
        end

        it 'should accepts the params with turbo stream format' do
            post :create, params: {
                user: user_params,
                format: :turbo_stream
            }
            expect(response.content_type).to eq("text/vnd.turbo-stream.html; charset=utf-8")
            expect(response.media_type).to eq('text/vnd.turbo-stream.html')
        end

        it 'should redirect the user to user page' do
            post :create, params: {
                user: user_params
            }
            expect(subject).to redirect_to(assigns(:user))
        end

        it 'should render the user partial with turbo stream format' do
            post :create, params: {
                user: user_params,
                format: :turbo_stream
            }
            expect(response).to render_template('users/_user')
        end

        it 'should renders the validation error into form' do
            post :create, params: {
                user: {
                    name: nil,
                    email: nil,
                    password: "password@123",
                    contact_number: Faker::PhoneNumber.cell_phone_with_country_code,
                    country: User.country_code_list.sample,
                    state: "PB",
                    city: "Lahore"
                },
                format: :turbo_stream
            }
            expect(assigns(:user).valid?).to_not eq(true)
            expect(response).to render_template('users/_modal')
        end

        it 'should includes the error messages for empty attributes' do
            post :create, params: {
                user: {
                    name: nil,
                    email: nil,
                    password: "password@123",
                    contact_number: Faker::PhoneNumber.cell_phone_with_country_code,
                    country: User.country_code_list.sample,
                    state: "PB",
                    city: "Lahore"
                },
                format: :turbo_stream
            }
            expect(assigns(:user).valid?).to_not eq(true)
            expect(response).to render_template('users/_modal')
            expect(assigns(:user).errors.full_messages).to include("Email can't be blank", "Name can't be blank")
        end
        
        it 'should includes the uniqueness error in the the form' do
            post :create, params: {
                user: {
                    name: Faker::Name.name_with_middle,
                    email: user.email,
                    password: "password@123",
                    contact_number: Faker::PhoneNumber.cell_phone_with_country_code,
                    country: User.country_code_list.sample,
                    state: "PB",
                    city: "Lahore"
                },
                format: :turbo_stream
            }
            expect(assigns(:user).valid?).to_not eq(true)
            expect(response).to render_template('users/_modal')
            expect(assigns(:user).errors.full_messages).to include("Email has already been taken")
            
        end

    end

    describe 'PATCH update' do
        let(:user1) {create :user}

        it 'should accepts the params with html format' do
            patch :update, params: {
                user: user_params,
                id: user1.id
            }
            expect(response.content_type).to eq("text/html; charset=utf-8")
            expect(response.media_type).to eq('text/html')
        end

        it 'should accepts the params with turbo stream format' do
            patch :update, params: {
                user: user_params,
                id: user1.id,
                format: :turbo_stream
            }
            expect(response.content_type).to eq("text/vnd.turbo-stream.html; charset=utf-8")
            expect(response.media_type).to eq('text/vnd.turbo-stream.html')
        end

        it 'should redirect the user to user page' do
            patch :update, params: {
                user: user_params,
                id: user1.id
            }
            expect(subject).to redirect_to(assigns(:user))
        end

        it 'should render the user partial with turbo stream format' do
            patch :update, params: {
                user: user_params,
                id: user1.id,
                format: :turbo_stream
            }
            expect(response).to render_template('users/_user')
        end

        it 'should renders the validation error into form' do
            patch :update, params: {
                user: {
                    name: nil,
                    email: nil,
                    password: "password@123",
                    contact_number: Faker::PhoneNumber.cell_phone_with_country_code,
                    country: User.country_code_list.sample,
                    state: "PB",
                    city: "Lahore"
                },
                id: user1.id,
                format: :turbo_stream
            }
            expect(assigns(:user).valid?).to_not eq(true)
            expect(response).to render_template('users/_modal')
        end

        it 'should includes the error messages for empty attributes' do
            patch :update, params: {
                user: {
                    name: nil,
                    email: nil,
                    password: "password@123",
                    contact_number: Faker::PhoneNumber.cell_phone_with_country_code,
                    country: User.country_code_list.sample,
                    state: "PB",
                    city: "Lahore"
                },
                id: user1.id,
                format: :turbo_stream
            }
            expect(assigns(:user).valid?).to_not eq(true)
            expect(response).to render_template('users/_modal')
            expect(assigns(:user).errors.full_messages).to include("Email can't be blank", "Name can't be blank")
        end
        
        it 'should includes the uniqueness error in the the form' do
            patch :update, params: {
                user: {
                    name: Faker::Name.name_with_middle,
                    email: user.email,
                    password: "password@123",
                    contact_number: Faker::PhoneNumber.cell_phone_with_country_code,
                    country: User.country_code_list.sample,
                    state: "PB",
                    city: "Lahore"
                },
                id: user1.id,
                format: :turbo_stream
            }
            expect(assigns(:user).valid?).to_not eq(true)
            expect(response).to render_template('users/_modal')
            expect(assigns(:user).errors.full_messages).to include("Email has already been taken")
            
        end
    end

    describe 'DELETE destroy' do
        let(:user1) {create :user}

        it 'should reduce the user count by 1' do
            delete :destroy, params: {
                id: user1.id,
                format: :turbo_stream
            }
            expect(User.count).to eq(1)
        end

        it 'should not render any template with turbo stream format' do
            delete :destroy, params: {
                id: user1.id,
                format: :turbo_stream
            }
            expect(response).to render_template(nil)
        end

        it 'should redirect to users index page after deleting user' do
            delete :destroy, params: {
                id: user1.id,
            }
            expect(subject).to redirect_to(users_path)
        end
    end

    describe 'GET show' do
        let(:user1) {create :user}

        it 'should render the show template of user' do
            get :show, params: {
                id: user1.id,
                format: :turbo_stream
            }
            expect(response).to render_template('users/show')
            expect(response.content_type).to eq("text/vnd.turbo-stream.html; charset=utf-8")
            expect(response.media_type).to eq('text/vnd.turbo-stream.html')
        end
    end

    describe 'GET edit' do
        let(:user1) {create :user}

        it 'should render the show template of user' do
            get :edit, params: {
                id: user1.id,
                format: :turbo_stream
            }
            expect(response).to render_template('users/edit')
            expect(response.content_type).to eq("text/vnd.turbo-stream.html; charset=utf-8")
            expect(response.media_type).to eq('text/vnd.turbo-stream.html')
        end
    end

    describe 'GET new' do
        let(:user1) {create :user}

        it 'should render the show template of user' do
            get :new, params: {
                format: :turbo_stream
            }
            expect(response).to render_template('users/new')
            expect(response.content_type).to eq("text/vnd.turbo-stream.html; charset=utf-8")
            expect(response.media_type).to eq('text/vnd.turbo-stream.html')
        end
    end

    describe 'GET fetch_country_states' do

        it 'should return states as nil with invalid country code' do
            get :fetch_country_states, params: {
                country_code: 'abc',
                format: :turbo_stream
            }

            expect(assigns[:states]).to eq(nil)
        end

        it 'should return states count with valid country code' do
            get :fetch_country_states, params: {
                country_code: 'PK',
                format: :turbo_stream
            }

            expect(assigns[:states].count).to eq(7)
        end

        it 'should include the given state of valid country' do
            get :fetch_country_states, params: {
                country_code: 'PK',
                format: :turbo_stream
            }
            expect(assigns[:states]).to include(["PB", "Punjab"])
        end
    end
end

def user_params
    {
        name: Faker::Name.name_with_middle,
        email: Faker::Internet.email,
        password: "password@123",
        contact_number: Faker::PhoneNumber.cell_phone_with_country_code,
        country: User.country_code_list.sample,
        state: "PB",
        city: "Lahore"
    }
end