require 'rails_helper'

describe EventNotificationJob do
  subject(:performed_job) { described_class.perform(event) }
  let(:event) { FactoryGirl.create(:event, :requiring_notification) }
  before { FactoryGirl.create(:presentation, event: event) }

  describe '.perform' do
    context 'when there are multiple presentations for an event' do
      before { FactoryGirl.create(:presentation, event: event) }
      it 'sends an email to the presenter of those presentations' do
        expect { performed_job }
          .to change { ActionMailer::Base.deliveries.count }
          .by(event.presentations.length)
      end
    end
    context 'when there are no presentations for an event' do
      before { event.presentations = [] }
      it 'sends zero emails' do
        expect { performed_job }
          .not_to change { ActionMailer::Base.deliveries.count }
      end
    end
  end
end
