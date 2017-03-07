require 'rails_helper'

describe EventNotificationJob do
  subject(:performed_job) { described_class.perform(event) }

  describe '.perform' do
    context 'when there are multiple presentations for an event' do
      let(:event) do
        FactoryGirl.create(
          :event,
          :requiring_notification,
          presentations: build_list(:presentation, 2)
        )
      end
      it 'sends an email to the presenter of those presentations' do
        expect { performed_job }
          .to change { ActionMailer::Base.deliveries.count }
          .by(2)
      end
    end
    context 'when there are no presentations for an event' do
      let(:event) do
        FactoryGirl.create(
          :event,
          :requiring_notification,
          presentations: []
        )
      end
      it 'sends zero emails' do
        expect { performed_job }
          .not_to change { ActionMailer::Base.deliveries.count }
      end
    end
  end
end
