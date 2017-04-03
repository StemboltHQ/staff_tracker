require 'rails_helper'

RSpec.describe Admin::PeopleController, type: :controller do
  before { mock_pundit_user_as(admin) }
  let(:admin) { FactoryGirl.create(:person, :admin) }

  describe 'inheritance' do
    it 'inherits from the admin controller' do
      expect(described_class).to be < AdminController
    end
  end

  describe 'GET index' do
    subject { get :index }
    before { mock_pundit_user_as(admin) }

    it { is_expected.to render_template :index }
    it { is_expected.to be_successful }
  end

  describe 'PUT batch_update' do
    let(:non_admin) { FactoryGirl.create(:person) }
    let(:admin_role) { admin.roles.where(name: 'admin').first }
    subject { put :batch_update, params: params }
    context 'the user is attemping to swap all users roles' do
      let(:params) do
        {
          people: {
            person: {
              admin.id.to_s => {
                role_ids: ['']
              },
              non_admin.id.to_s => {
                role_ids: [admin_role.id]
              }
            }
          }
        }
      end

      it 'toggles the admin to non admin' do
        expect { subject }.to change { admin.reload.admin? }
          .from(true)
          .to(false)
      end
      it 'toggles the non admin to admin' do
        expect { subject }.to change { non_admin.reload.admin? }
          .from(false)
          .to(true)
      end
      it 'redirects to /admin/people' do
        expect(subject).to redirect_to(admin_people_path)
      end
    end

    context 'the user is attemping to swap one user role' do
      let(:params) do
        {
          people: {
            person: {
              admin.id.to_s => {
                role_ids: [admin_role.id]
              },
              non_admin.id.to_s => {
                role_ids: [admin_role.id]
              }
            }
          }
        }
      end

      it 'toggles the requested persons admin status' do
        expect { subject }.to change { non_admin.reload.admin? }
          .from(false)
          .to(true)
      end
      it 'doesnt toggle the admin status of any unintended people' do
        expect { subject }.not_to change { admin.reload.admin? }
          .from(true)
      end
      it 'redirects to /admin/people' do
        expect(subject).to redirect_to(admin_people_path)
      end
    end

    context 'the user submitted the form without changes' do
      let(:params) do
        {
          people: {
            person: {
              admin.id.to_s => {
                role_ids: [admin_role.id]
              },
              non_admin.id.to_s => {
                role_ids: ['']
              }
            }
          }
        }
      end

      it 'doesnt toggle the admin status of the current admin' do
        expect { subject }.not_to change { admin.reload.admin? }
          .from(true)
      end
      it 'doesnt toggle the non admin status of non admin people' do
        expect { subject }.not_to change { non_admin.reload.admin? }
          .from(false)
      end
      it 'redirects to /admin/people' do
        expect(subject).to redirect_to(admin_people_path)
      end
    end
  end
end
